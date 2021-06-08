import 'package:password/password.dart';

class User {
  int id;
  String mail, serialNum, hash; // user email mailbot serial number
  PBKDF2 algorithm;

  User({this.mail, this.serialNum, String password}) {
    algorithm = new PBKDF2();
    hash = Password.hash(password, algorithm);
  }

  User.db(this.mail, this.serialNum, this.hash) {
    algorithm = new PBKDF2();
  }

  User.def() {
    id = null;
    serialNum = '';
    mail = '';
    hash = '';
    algorithm = new PBKDF2();
  }

  bool passwordVerify(String password) {
    return Password.verify(password, hash);
  }
}
