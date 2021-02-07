import 'package:http/http.dart' as http;
import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/Screens/Login/login_screen.dart';
import 'package:flutterphone/Screens/Signup/components/background.dart';
import 'package:flutterphone/components/already_have_an_account_acheck.dart';
import 'package:flutterphone/components/rounded_button.dart';
import 'package:flutterphone/components/rounded_input_field.dart';
import 'package:flutterphone/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';


class Body extends StatefulWidget {
  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {

  @override
  bool selected=true ;
  String radioItem = '';
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool _value1 = false;
    bool _value2 = false;
    //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax
    return Background(
      child: SingleChildScrollView(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage('assets/icons/cat.png'),
                radius: 60.0,

              ),
            RadioListTile(
              groupValue: radioItem,
              title: Text('مستخدم عادي'),
              value: 'Item 1',
              onChanged: (val) {
                setState(() {
                  radioItem = val;
                });
              },
            ),

            RadioListTile(
              groupValue: radioItem,
              title: Text('مقدم خدمة'),
              value: 'Item 2',
              onChanged: (val) {
                setState(() {
                  radioItem = val;
                });
              },
            ),
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),

            RoundedInputField(
              hintText: "الاسم",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              text: 'كلمة السر ',
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              text: 'تأكيد كلمة السر',
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "إنشاء حساب",
              press: () {},
            ),
            SizedBox(height: size.height * 0.0),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

              ],
            )
          ],
        ),
      ),
    );
  }
}
