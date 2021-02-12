import 'package:flutter/material.dart';
import 'package:flutterphone/components/text_field_container.dart';
import 'package:flutterphone/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController textEditingController;
  final text;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.textEditingController,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        controller: textEditingController,
        cursorColor: kPrimaryColor,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 18.0,
          fontFamily: 'Changa',
        ),
        decoration: InputDecoration(
          errorText: 'vfggggggggg',
          hintText: text,
          suffixIcon: Icon(
            Icons.lock,
            color: kPrimaryColor,

          ),
          icon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),

      ),
    );
  }
}
