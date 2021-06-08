import 'package:mailbot_app/logic/User.dart';
import 'package:mailbot_app/logic/mysql.dart';
import 'package:mailbot_app/models/dileveryitemmodel.dart';
import 'package:mailbot_app/models/usermodel.dart';

/// DAO == Data Access Object
/// Here we got the connection between the app and the database

class DAO {
  Mysql db = new Mysql();

  DAO();

  Future<List<User>> getUsers() async {
    List<User> result = [];
    db.getConnection().then((conn) {
      String sql = 'select * from User';
      conn.query(sql).then((results) {
        for (var row in results) {
          result.add(new User.db(row[1], row[2], row[3]));
        }
      }, onError: (error) {
        print('$error');
      }).whenComplete(() {
        conn.close();
      });
    });
    return result;
  }

  Future<List<DItem>> getItems() async {
    List<DItem> result = [];
    var ddb = await db.getConnection();
    await ddb.query("select * from Delivery").then((results) {
      results.forEach((element) async {
        result.add(DItem(
            id: element.fields['orderNum'].toString(),
            title: element.fields['Title'],
            time: element.fields['Arrival_time']));
      });
    });
    return result;
  }

  Future<String> insertUser(User user) async {
    String ret = '';
    var ddb = await db.getConnection();
    await ddb.query("select * from User where email = ?", [user.mail]).then(
        (results) {
      results.forEach((element) async {
        if (element.fields['email'] == user.mail) {
          ret = 'email exists';
        }
      });
    });
    if (ret != 'email exists') {
      await ddb.query('insert into User (login_pw, email) values(?, ?)',
          [user.hash, user.mail]).then((value) {
        print(value);
        ret = 'Inserted user succesfullly';
      }).onError((error, stackTrace) {
        ret = error.toString();
      });
    }
    return ret;
  }

  Future<UserModel> login(String serialNum) async {
    var user = UserModel();
    var ddb = await db.getConnection();
    await ddb.query("SELECT * FROM `User` WHERE mailbot_serialNum = ?",
        [serialNum]).then((results) {
      if (results.length == 1) {
        results.forEach((element) async {
          user = UserModel(
              userID: element.fields['userID'],
              email: element.fields['email'],
              serialNum: element.fields['mailbot_serialNum']);
        });
      }
    });

    return user;
  }

  Future<String> editEmail(String oldEmail, String newEmail) async {
    String ret = '';
    bool re = false;
    bool notUsed = false;
    var ddb = await db.getConnection();
    await ddb.query("select * from User where email = ?", [newEmail]).then(
        (results) {
      notUsed = results.isEmpty;
    });
    if (notUsed) {
      await ddb.query("select * from User where email = ?", [oldEmail]).then(
          (results) {
        re = results.isNotEmpty;
        if (re) {
          results.forEach((element) async {
            await ddb.query("update User set email = ? where userID = ?",
                [newEmail, element.fields['userID']]);
          });
        }
      });
    } else {
      ret = 'email exists';
    }
    if (re) {
      await ddb.query("select * from User where email = ?", [newEmail]).then(
          (results) {
        results.forEach((element) {
          if (element.fields['email'].toString() == newEmail) {
            ret = 'email changed';
          } else {
            ret = 'error';
          }
        });
      });
    }
    return ret;
  }
}
