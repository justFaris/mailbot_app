import 'package:mailbot_app/logic/User.dart';
import 'package:mailbot_app/logic/mysql.dart';

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

  Future<String> insertUser(User user) async {
    String ret = '';
    var ddb = await db.getConnection();
    var checkEmail = await ddb.query(
        "select * from User where email = ?", [user.mail]).then((results) {
      results.forEach((element) async {
        if (element.fields['email'] == user.mail) {
          ret = 'email exists';
        }
      });
    });
    if (ret != 'email exists') {
      var reg = await ddb.query(
          'insert into User (login_pw, email) values(?, ?)',
          [user.hash, user.mail]).then((value) {
        print(value);
        ret = 'Inserted user succesfullly';
      }).onError((error, stackTrace) {
        ret = error.toString();
      });
    }
    print(ret);
    return ret;
  }
}
