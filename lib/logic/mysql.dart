import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host = '194.195.112.120',
      user = 'justoneb_asiasr06',
      password = '2py7JV7-zese',
      db = 'justoneb_mailbot_db';
  static int port = 3306;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings = new ConnectionSettings(
        host: host, port: port, user: user, password: password, db: db);
    return await MySqlConnection.connect(settings);
  }
}
