import 'package:flutterphone/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/Screens/Login/components/background.dart';
import 'package:flutterphone/screens/Signup/signup_screen.dart';
import 'package:flutterphone/components/already_have_an_account_acheck.dart';
import 'package:flutterphone/components/rounded_button.dart';
import 'package:flutterphone/components/rounded_input_field.dart';
import 'package:flutterphone/components/rounded_password_field.dart';
import 'package:flutterphone/Inside_the_app/inside.dart';
import 'package:flutterphone/screens/Signup/sign_phone.dart';
import 'package:flutterphone/components/text_field_container.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterphone/screens/Signup/signup_screen.dart';
import 'dart:convert';
import 'package:flutterphone/services/authservice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;


class Body extends StatefulWidget {
@override

_Body createState() => _Body();
}

class _Body extends State<Body> {
  final _formKey = GlobalKey<FormState>();


  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  var massage;
   bool Name_Null=true;
   bool Pass_Null=true;
  bool Pass_Mismatch=true;


  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

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
    return Form(key:_formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child:Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 60),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: size.width * 0.8,
              decoration: BoxDecoration(
                color: kPrimaryLightColor,
                borderRadius: BorderRadius.circular(29),

              ),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    Name_Null=false;
                    return null;
                  } else if (value.length < 8) {

                    return null;
                  }
                  Name_Null=true;
                  return null;
                },
                cursorColor: kPrimaryColor,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Changa',
                ),
                decoration: InputDecoration(suffixIcon: Icon(Icons.person,color: kPrimaryColor),
                  hintText: ('الاسم'),
                  border:InputBorder.none,
                ),

              ),
            ),
            Name_Null ? Container(): Container(
              margin: EdgeInsets.fromLTRB(180, 0, 0, 1),
              child: Text('!هذا الحقل مطلوب',textAlign:TextAlign.end,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Changa',
                  color: Colors.red,

                ),),
            ),

            Container(
              margin: EdgeInsets.fromLTRB(0,5,0,0),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: size.width * 0.8,
              decoration: BoxDecoration(
                color: kPrimaryLightColor,
                borderRadius: BorderRadius.circular(29),

              ),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    Pass_Null=false;
                    return null;
                  } else if (value.length < 8) {

                    return null;
                  }
                  Pass_Null=true;
                  return null;
                },
                obscureText: !_showPassword,
                cursorColor: kPrimaryColor,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Changa',
                ),
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.lock,
                    color: kPrimaryColor,

                  ),
                  icon: GestureDetector(
                    onTap: () {
                      _togglevisibility();
                    },
                    child: Icon(
                      _showPassword ? Icons.visibility : Icons
                          .visibility_off, color: kPrimaryColor,),
                  ),
                  hintText: ('كلمة السر'),
                  border:InputBorder.none,
                ),

              ),
            ),
            Pass_Null ? Container(
              child: Text('',textAlign:TextAlign.end,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Changa',
                  color: Colors.red,

                ),),): Container(
              margin: EdgeInsets.fromLTRB(180, 0, 0, 1),
              child: Text('!هذا الحقل مطلوب',textAlign:TextAlign.end,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Changa',
                  color: Colors.red,

                ),),
            ),
            RoundedButton(
              text: "تسجيل الدخول",
              press: () {
                senddata();
                print(nameController.text);
                print(passController.text);
                setState(() {
                  Name_Null=true;
                  Pass_Null=true;
                });
                if (_formKey.currentState.validate()) {print('validate');}
                else{print('not validate');}
                },
            ),
            SizedBox(height: size.height * 0.0),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
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
