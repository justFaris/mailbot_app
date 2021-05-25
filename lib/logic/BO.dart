/// BO == Bussiness Objects
/// Here we got what we want our business to do (Functions, widgets...)
import 'package:flutter/material.dart';


bool isNullOrEmpty(String str) {
  if (str.isEmpty || str == null || str.length == 0) {
    return true;
  } else {
    return false;
  }
}



Widget textfield(
    String labeltext, TextEditingController controller, bool obscureText,
    {bool validate, bool outlineBorder = false}) {
  InputDecoration inputDecoration;
  if (validate != null && outlineBorder == false) {
    inputDecoration = InputDecoration(
      labelText: labeltext,
      errorText: validate ? null : 'Field can\'t be empty',
    );
  } else if (validate != null && outlineBorder == true) {
    inputDecoration = InputDecoration(
      labelText: labeltext,
      border: OutlineInputBorder(),
      errorText: validate ? null : 'Field can\'t be empty',
    );
  } else if (validate == null && outlineBorder == false) {
    inputDecoration = InputDecoration(
      labelText: labeltext,
    );
  } else {
    inputDecoration = InputDecoration(
      labelText: labeltext,
      border: OutlineInputBorder(),
    );
  }
  return TextField(
    obscureText: obscureText,
    decoration: inputDecoration,
    controller: controller,
  );
}

Widget passwordTextBox(TextEditingController controller, bool hidePassword, Function onPressed) {
  return TextField(
      obscureText: hidePassword,
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Password',
          suffixIcon: IconButton(
              icon:
                  Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
              onPressed: onPressed)));
}
