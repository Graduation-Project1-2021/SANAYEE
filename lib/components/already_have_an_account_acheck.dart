import 'package:flutter/material.dart';
import 'package:flutterphone/constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "إنشاء حساب جديد               " : "تسجيل الدخول               ",
            textAlign: TextAlign.right,
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.w700,
                fontSize: 17.0,
                fontFamily: 'Changa',
            ),
          ),
        ),
        Text(

          login ? "ليس لديك حساب ؟   " : "  لديك حساب بالفعل ؟",
          textAlign: TextAlign.right,
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
            fontFamily: 'Changa',),
        ),

      ],
    );
  }
}
