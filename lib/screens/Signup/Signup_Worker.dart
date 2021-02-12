import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterphone/Screens/Signup/components/body.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/Screens/Login/login_screen.dart';
import 'package:flutterphone/Screens/Signup/components/background.dart';
import 'package:flutterphone/components/already_have_an_account_acheck.dart';
import 'package:flutterphone/components/rounded_button.dart';
import 'package:flutterphone/components/rounded_input_field.dart';
import 'package:flutterphone/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterphone/components/Custom_Rodio_Button.dart';
import 'package:flutterphone/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/services/authservice.dart';
import 'package:flutterphone/constants.dart';
import 'components/pin.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

TextEditingController nameController = TextEditingController();
TextEditingController passController = TextEditingController();
class SignUpWorker extends StatefulWidget {
  @override

  _SignUpWorker createState() => _SignUpWorker();
}

class _SignUpWorker extends State<SignUpWorker> {
  String phoneNo, verificationId, smsCode;

  bool codeSent = false;
  @override
  bool selected = true;

  bool Feild1 = true;
  bool Feild2 = true;
  bool Feild3 = true;
  bool Phone = true;
  bool Pass_S = true;
  bool _showPassword = false;
  String pass = "";

  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  PickedFile image_file;
  final ImagePicker image_picker = ImagePicker();
  int current_step = 0;
  bool step1 = true;
  bool step2 = false;
  bool step3 = false;
  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(

        appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(''),
          backgroundColor: kPrimaryColor,
          toolbarHeight: 40.0,

         ),
        body: new Form(key: formKey,
        child: SingleChildScrollView(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Container(margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),),

          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.0),
                Container(
                  margin: EdgeInsets.fromLTRB(40,30,0, 0),
                  child: Text('الخدمةالتي سوف تقدمها ',textAlign:TextAlign.end,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Changa',
                      color: Colors.red,

                    ),),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0,5,0,0),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical:2),
                  width: size.width * 0.8,
                  height: 80,
                  decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        Feild1=false;
                        return null;
                      }
                      Feild1=true;
                      return null;
                    },
                    maxLines: null,
                    cursorColor: kPrimaryColor,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Changa',
                    ),
                    decoration: InputDecoration(
                      border:InputBorder.none,
                    ),

                  ),
                ),
                Feild1 ? Container(): Container(
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
                  margin: EdgeInsets.fromLTRB(180,30,0,0),
                  child: Text('أخبرنا عنك ',textAlign:TextAlign.end,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Changa',
                      color: Colors.red,

                    ),),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0,5,0,0),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical:2),
                  width: size.width * 0.8,
                  height: 150,
                  decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        Feild2=false;
                        return null;
                      }
                      Feild2=true;
                      return null;
                    },
                    maxLines: null,
                    cursorColor: kPrimaryColor,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Changa',
                    ),
                    decoration: InputDecoration(
                      border:InputBorder.none,
                    ),

                  ),
                ),
                Feild2 ? Container(): Container(
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
                  margin: EdgeInsets.fromLTRB(70,30, 0, 0),
                  child: Text('خبراتك وتجاربك السابقة',textAlign:TextAlign.end,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Changa',
                      color: Colors.red,

                    ),),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0,5,0,0),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical:2),
                  width: size.width * 0.8,
                  height: 180,
                  decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        Feild3=false;
                        return null;
                      }
                      Feild3=true;
                      return null;
                    },
                    maxLines: null,
                    cursorColor: kPrimaryColor,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Changa',
                    ),
                    decoration: InputDecoration(
                      border:InputBorder.none,
                    ),

                  ),
                ),
                Feild3 ? Container(): Container(
                  margin: EdgeInsets.fromLTRB(180, 0, 0, 1),
                  child: Text('!هذا الحقل مطلوب',textAlign:TextAlign.end,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Changa',
                      color: Colors.red,

                    ),),
                ),
              ],),
            ),
              ],),
        ),
    ),);
  }
}