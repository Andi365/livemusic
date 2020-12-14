import 'package:flutter/material.dart';

import '../model/colors.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {this.icon,
      this.hint,
      this.obsecure = false,
      this.validator,
      this.onSaved});
  final FormFieldSetter<String> onSaved;
  final Icon icon;
  final String hint;
  final bool obsecure;
  final FormFieldValidator<String> validator;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 60, right: 60),
      child: TextFormField(
        onSaved: onSaved,
        validator: validator,
        autofocus: false,
        obscureText: obsecure,
        style: TextStyle(
          fontSize: 12,
        ),
        decoration: InputDecoration(
            fillColor: primaryWhiteColor,
            filled: true,
            hintStyle: TextStyle(fontSize: 12, color: primaryColor),
            hintText: hint,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: primaryWhiteColor,
                width: 1.5,
              ),
            ),
            prefixIcon: Padding(
              child: IconTheme(
                data: IconThemeData(color: primaryColor),
                child: icon,
              ),
              padding: EdgeInsets.only(left: 15, right: 10),
            )),
      ),
    );
  }
}
