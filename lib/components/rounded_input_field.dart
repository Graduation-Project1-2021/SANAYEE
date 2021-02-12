import 'package:flutter/material.dart';
import 'package:flutterphone/components/text_field_container.dart';
import 'package:flutterphone/constants.dart';

final _formKey = GlobalKey<FormState>();
class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController textEditingController;

  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: Form(key:_formKey,
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        controller: textEditingController,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        textAlign: TextAlign.right,

        style: TextStyle(
          fontSize: 18.0,
         fontFamily: 'Changa',

        ),
        decoration: InputDecoration(
          errorText: 'vfggggggggg',
         suffixIcon: Icon(
            icon,

            color: kPrimaryColor,
          ),

          hintText: hintText,
          border: InputBorder.none,
        ),
      ),),
    );
  }
}
