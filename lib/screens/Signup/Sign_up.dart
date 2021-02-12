import 'package:flutter/material.dart';
import 'package:flutterphone/Screens/Signup/components/body.dart';
import 'package:flutterphone/services/authservice.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: AuthService().handleAuth(),
    );

  }
}
