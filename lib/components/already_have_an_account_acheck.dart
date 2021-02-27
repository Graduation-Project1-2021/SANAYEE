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
            login ? " ليس لديك حساب ؟ إنشاء حساب جديد                     " : "  لديك حساب بالفعل ؟ تسجيل الدخول                    ",
            textAlign: TextAlign.right,
            style: TextStyle(
              color: login? Color(0xFF1C1C1C):Colors.grey[600],
              fontWeight: FontWeight.w700,
                fontSize: 15.0,
                fontFamily: 'Changa',
            ),
          ),
        ),
      ],
    );
  }
}
