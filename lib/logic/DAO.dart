import 'package:mailbot_app/logic/User.dart';
import 'package:mailbot_app/logic/mysql.dart';
import 'package:mailbot_app/models/camerahistory.dart';
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
            time: element.fields['Arrival_time'],
            status: element.fields['delivery_status']));
      });
    });
    return result;
  }

  Future<List<CameraHisModel>> getCameraHistory(String email) async {
    List<CameraHisModel> result = [];
    var ddb = await db.getConnection();
    await ddb.query("select * from user_rec where email = ?", [email]).then(
        (results) {
      results.forEach((element) async {
        result.add(CameraHisModel(
          recDate: element.fields['rec_date'],
          recTime: element.fields['rec_time'],
          orderNum: element.fields['orderNum'],
          recordingID: element.fields['recording_ID'],
          url: element.fields['URL'],
        ));
      });
    });
    return result;
  }

  Future<String> insertItem(int userID, int orderNum, int moneyPocket,
      int autoEmpty, String title) async {
    String result = '';
    var ddb = await db.getConnection();
    await ddb.query(
        "INSERT INTO Delivery (orderNum, money_pocket, auto_empty, Title) VALUES (?, ?, ?, ?)",
        [orderNum, moneyPocket, autoEmpty, title]);
    // await ddb.query("INSERT INTO has_delivery (userID, orderNum) VALUES (?, ?)", [userID, orderNum]);
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

  Future<UserModel> login(String serialNum, String configCode) async {
    var user = UserModel();
    var ddb = await db.getConnection();
    var check = false;
    await ddb.query(
        "SELECT * FROM `Mailbot` WHERE `serial_num` = ? AND `config_code` = ?",
        [serialNum, configCode]).then((results) {
      if (results.length == 1) {
        check = true;
      }
    });
    if (check) {
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
    }
    return user;
  }

  Future<String> loginC(String password, String email) async {
    var ddb = await db.getConnection();
    var check = true;
    var serial = "false";
    print(password + ":" + email);
    await ddb.query(
        "SELECT 'mailbot_serialNum' FROM `User` WHERE `login_pw` = ? AND `email` = ?",
        [password, email]).then((results) {
      if (results.length == 1) {
        check = true;
      }
    });
    if (check) {
      await ddb.query("SELECT mailbot_serialNum FROM `User` WHERE email = ?",
          [email]).then((results) {
        if (results.length == 1) {
          results.forEach((element) async {
            serial = element.fields['mailbot_serialNum'].toString();
          });
        }
      });
    }
    return serial;
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

  Future<String> editPass(
      String serialNum, String oldPassword, String newPassword) async {
    String ret = '';
    bool re = false;
    var ddb = await db.getConnection();
    await ddb.query("SELECT login_pw FROM User WHERE mailbot_serialNum = ?",
        [serialNum]).then((results) {
      re = results.isNotEmpty;
      if (re) {
        results.forEach((element) async {
          if (element.fields['login_pw'] == oldPassword) {
            await ddb.query(
                "UPDATE User SET login_pw = ?  WHERE mailbot_serialNum =?",
                [newPassword, serialNum]);
          } else {
            ret = 'Check old password';
          }
        });
      }
    });

    if (re) {
      await ddb.query(
          "SELECT `login_pw` FROM `User` WHERE `mailbot_serialNum` = ?",
          [serialNum]).then((results) {
        results.forEach((element) {
          if (element.fields['login_pw'].toString() == newPassword) {
            ret = 'password changed';
          } else {
            ret = 'password not changed';
          }
        });
      });
    }
    return ret;
  }
}
