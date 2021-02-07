
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/Screens/Login/components/background.dart';
import 'package:flutterphone/Screens/Signup/signup_screen.dart';
import 'package:flutterphone/components/already_have_an_account_acheck.dart';
import 'package:flutterphone/components/rounded_button.dart';
import 'package:flutterphone/components/rounded_input_field.dart';
import 'package:flutterphone/components/rounded_password_field.dart';
import 'package:flutterphone/Inside_the_app/inside.dart';
import 'package:flutterphone/screens/Signup/sign_phone.dart';
import 'package:flutterphone/components/text_field_container.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'package:flutterphone/services/authservice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;

TextEditingController nameController = TextEditingController();
TextEditingController passController = TextEditingController();
var massage;
class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);



  Future getdata()async{
    var url='https://192.168.1.8/testlocalhost/login.php';
    var ressponse=await http.get(url);
    return json.decode(ressponse.body);
  }
  @override
  Widget build(BuildContext context) {

    Future senddata()async{
      var url='https://192.168.1.8/testlocalhost/login.php';
      var ressponse=await http.post(url,body: {
        "name": nameController.text,
        "pass":passController.text,
      });
      massage= json.decode(ressponse.body);
      if(massage=='login'){
        print('login is sucssefully');
         Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return InsideAPP();
          },
        ),
      );
      }

    }
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),

            SizedBox(height: size.height * 0.03),

            RoundedInputField(
              hintText: "الاسم",
              textEditingController: nameController,
              onChanged: (value) {
              },
            ),
            RoundedPasswordField(
              text: 'كلمة السر ',
              textEditingController: passController,
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "تسجيل الدخول",
              press: () {
                senddata();
                print(nameController.text);
                print(passController.text);
                },
            ),
            SizedBox(height: size.height * 0.0),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                        return MaterialApp(
                          debugShowCheckedModeBanner: false,
                          home: SignUpScreen(),
                        );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }


}
