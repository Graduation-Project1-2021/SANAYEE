import 'dart:convert';

import 'package:firebase_cloud_messaging/firebase_cloud_messaging.dart';
import 'package:flutterphone/Inside_the_app/inside.dart';
import 'package:flutterphone/screens/signuser_screen.dart';
import 'package:flutterphone/screens/welcome_screen.dart';
import 'package:http/http.dart' as http;
import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/components/already_have_an_account_acheck.dart';
import 'package:flutterphone/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/services/authservice.dart';
import 'package:flutterphone/constants.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'login_screen.dart';

class SignWorker extends StatefulWidget {
  @override

  _Sign_Worker createState() => _Sign_Worker();
}

class _Sign_Worker extends State<SignWorker> {

  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passController2 = TextEditingController();
  TextEditingController phone_Num = TextEditingController();
  TextEditingController Work = TextEditingController();
  TextEditingController Information = TextEditingController();
  TextEditingController Experiance = TextEditingController();

  var mytoken ;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final formKey = new GlobalKey<FormState>();

  String phoneNo, verificationId, smsCode;

  bool codeSent = false;
  @override
  bool selected=true ;
  bool Name_Null=true;
  bool Pass_Null=true;
  bool Pass_Mismatch=true;
  bool Phone=true;
  bool Pass_S=true;
  bool Invaled_Phone=true;
  bool _showPassword1 = false;
  bool _showPassword2 = false;
  bool Feild1 = true;
  bool Feild2 = true;
  bool Feild3 = true;
  bool card1=true;
  bool card2=false;
  bool card3=false;
  bool Work_Null=true;
  bool Info_Null=true;
  bool EXp_Null=true;
  String pass="";
  File _file;
  bool uploading = false;
  double val = 0;
  File uploadimage;
  // File _file;
  List<File> _image = []; //هاي هي
  int counter = 0;
  final picker = ImagePicker();
  @override
  void initState() {

    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        mytoken = token ;
      });
      print(mytoken);
    });

    super.initState();
  }
  void _togglevisibility1() {
    setState(() {
      _showPassword1 = !_showPassword1;
    });
  }
  void _togglevisibility2() {
    setState(() {
      _showPassword2 = !_showPassword2;
    });
  }
  PickedFile image_file;
  final ImagePicker image_picker =ImagePicker();
  int current_step=0;
  bool step1=true;bool step2=false;bool step3=false;
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool _value1 = false;
    bool _value2 = false;
    String code = "";
    String pass="";
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body:Form(key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Stack(
                      children: [

                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/icons/ho.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.fromLTRB(100, 40, 1, 1),
                          child: IconButton(
                            alignment: Alignment.topRight,
                            onPressed: () {
                              if(card1){
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>WelcomeScreen()));}
                              if(card2) {
                                card1 = true;
                                card2 = false;
                              }
                              if(card3){
                                card2=true;
                                card3=false;
                              }
                                setState(() {
                                });

                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 30.0,
                            ),
                          ),
                        ),

                        card1? Container(
                          height: 600,
                          margin: EdgeInsets.fromLTRB(20, 130, 20, 0),
                          child: SingleChildScrollView(
                            child:Card(
                              elevation: 5,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),),
                              shadowColor: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0,100,0,0),
                                    padding: EdgeInsets.symmetric(horizontal: 0,),
                                    width: size.width * 0.8,
                                    child: TextFormField(
                                      controller: nameController,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          Name_Null=false;
                                          return null;
                                        } else {

                                          Name_Null=true;
                                          return null;
                                        }
                                      },
                                      cursorColor: kPrimaryColor,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Changa',
                                      ),
                                      decoration: InputDecoration(prefixIcon: Icon(Icons.person,color: Colors.grey[600]),
                                        border: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.grey),
                                            borderRadius: const BorderRadius.all(const Radius.circular(30))
                                        ),
                                        focusedBorder:OutlineInputBorder(
                                          borderSide: const BorderSide(color: Camone),
                                          borderRadius: BorderRadius.all(Radius.circular(30)),
                                        ),
                                        labelText: ('الاسم'),
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        labelStyle: TextStyle(fontSize: 22.0,fontFamily: 'Changa',color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],),
                                      ),
                                    ),
                                  ),
                                  Name_Null ? Container(margin: EdgeInsets.fromLTRB(180, 0, 0, 0),
                                    child: Text('',textAlign:TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Changa',
                                        color: Colors.red,

                                      ),),): Container(
                                    margin: EdgeInsets.fromLTRB(180, 0, 0, 0),
                                    child: Text('هذا الحقل مطلوب !',textAlign:TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Changa',
                                        color: Colors.red,

                                      ),),
                                  ),

                                  Container(height: 10,),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0,10,0,0),
                                    padding: EdgeInsets.symmetric(horizontal:0,),
                                    width: size.width * 0.8,
                                    child: TextFormField(
                                      controller: passController,
                                      validator: (value) {
                                        pass=value;
                                        if (value.isEmpty) {
                                          Pass_Null=false;
                                          Pass_S=true;
                                          return null;
                                        } else if (value.length < 8) {
                                          Pass_S=false;
                                          Pass_Null=true;
                                          return null;
                                        }
                                        Pass_Null=true;
                                        Pass_S=true;
                                        return null;
                                      },
                                      obscureText: !_showPassword1,
                                      cursorColor: kPrimaryColor,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Changa',
                                      ),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.lock, color: Colors.grey[600],),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            _togglevisibility1();
                                          },
                                          child: Icon(
                                            _showPassword1 ? Icons.visibility : Icons
                                                .visibility_off, color: Colors.grey[600],),
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.grey),
                                            borderRadius: const BorderRadius.all(const Radius.circular(30))
                                        ),
                                        focusedBorder:OutlineInputBorder(
                                          borderSide: const BorderSide(color: Camone),
                                          borderRadius: BorderRadius.all(Radius.circular(30)),
                                        ),
                                        labelText: ('كلمة السر'),
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        labelStyle: TextStyle(fontSize: 22.0,fontFamily: 'Changa',color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],),
                                      ),

                                    ),
                                  ),
                                  Pass_Null ? Container(
                                    margin: EdgeInsets.fromLTRB(180, 0, 0, 0),
                                    child: Text('',textAlign:TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Changa',
                                        color: Colors.red,

                                      ),),
                                  ): Container(
                                    margin: EdgeInsets.fromLTRB(180, 0, 0, 0),
                                    child: Text('هذا الحقل مطلوب !',textAlign:TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Changa',
                                        color: Colors.red,

                                      ),),
                                  ),
                                  Container(height: 10,),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0,10,0,0),
                                    padding: EdgeInsets.symmetric(horizontal:0,),
                                    width: size.width * 0.8,
                                    child: TextFormField(
                                      validator: (value) {
                                        if(passController.text.isEmpty){
                                          return null;
                                        }
                                        if(value==pass) {
                                          Pass_Mismatch=true;
                                          return null;
                                        }
                                        Pass_Mismatch=false;
                                        return null;
                                      },
                                      obscureText: !_showPassword2,
                                      cursorColor: kPrimaryColor,
                                      textAlign: TextAlign.right,
                                      controller: passController2,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Changa',
                                      ),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.lock, color: Colors.grey[600],),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            _togglevisibility2();
                                          },
                                          child: Icon(
                                            _showPassword2 ? Icons.visibility : Icons
                                                .visibility_off, color: Colors.grey[600],),
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.grey),
                                            borderRadius: const BorderRadius.all(const Radius.circular(30))
                                        ),
                                        focusedBorder:OutlineInputBorder(
                                          borderSide: const BorderSide(color: Camone),
                                          borderRadius: BorderRadius.all(Radius.circular(30)),
                                        ),
                                        labelText: ('تأكيد كلمة السر'),
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        labelStyle: TextStyle(fontSize: 22.0,fontFamily: 'Changa',color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],),
                                      ),
                                    ),
                                  ),
                                  Container(height: 10,),
                                  Pass_Mismatch ? Container(
                                    margin: EdgeInsets.fromLTRB(150, 0,0, 0),
                                    child: Text('',textAlign:TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Changa',
                                        color: Colors.red,

                                      ),),
                                  ): Container(
                                    margin: EdgeInsets.fromLTRB(170, 0,0, 0),
                                    child: Text(' * كلمة السر غير متطابقة',textAlign:TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Changa',
                                        color: Colors.red,

                                      ),),
                                  ),
                                  Pass_S ? Container(
                                    margin: EdgeInsets.fromLTRB(150, 0,0, 0),
                                    child: Text('',textAlign:TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Changa',
                                        color: Colors.red,

                                      ),),
                                  ): Container(
                                    margin: EdgeInsets.fromLTRB(70, 0, 0, 0),
                                    child: Text(' * يجب أن تحتوي كلمة السر 8 أحرف على الأقل',textAlign:TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Changa',
                                        color: Colors.red,

                                      ),),
                                  ),
                                  Container(height: 12,),
                                  Container(
                                    child:AlreadyHaveAnAccountCheck(
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
                                  ),
                                  Container(height: 70,),
                                ],
                              ),
                            ),
                          ),
                        ):Container(),

                        //card2===============================================================================================================================================================================

                        card2? Container(
                          height: 600,
                          margin: EdgeInsets.fromLTRB(20, 130, 20, 0),
                          child: SingleChildScrollView(
                            child:Card(
                              elevation: 5,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),),
                              shadowColor: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0,100,0,0),
                                    padding: EdgeInsets.symmetric(horizontal: 0,),
                                    width: size.width * 0.8,
                                    child: TextFormField(
                                      controller: Work,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          Work_Null=false;
                                          return null;
                                        } else {
                                          Work_Null=true;
                                          return null;
                                        }
                                      },
                                      cursorColor: Colors.grey[600],
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Changa',
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.grey),
                                            borderRadius: const BorderRadius.all(const Radius.circular(30))
                                        ),
                                        focusedBorder:OutlineInputBorder(
                                          borderSide: const BorderSide(color: Camone),
                                          borderRadius: BorderRadius.all(Radius.circular(30)),
                                        ),
                                        labelText: ('المهنة'),
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        labelStyle: TextStyle(fontSize: 22.0,fontFamily: 'Changa',color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],),
                                      ),
                                    ),
                                  ),
                                  Work_Null ? Container(margin: EdgeInsets.fromLTRB(180, 0, 0, 0),
                                    child: Text('',textAlign:TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Changa',
                                        color: Colors.red,

                                      ),),): Container(
                                    margin: EdgeInsets.fromLTRB(180, 0, 0, 0),
                                    child: Text('هذا الحقل مطلوب !',textAlign:TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Changa',
                                        color: Colors.red,

                                      ),),
                                  ),

                                  Container(height: 10,),
                                  Container(
                                    height: 110,
                                    margin: EdgeInsets.fromLTRB(0,10,0,0),
                                    padding: EdgeInsets.symmetric(horizontal:0,),
                                    width: size.width * 0.8,
                                    child: TextFormField(
                                      controller: Information,
                                      maxLines: 20,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          Info_Null=false;
                                          return null;
                                        } else {
                                          Info_Null=true;
                                          return null;
                                        }
                                      },
                                      cursorColor: Colors.grey[600],
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Changa',
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.grey),
                                            borderRadius: const BorderRadius.all(const Radius.circular(30))
                                        ),
                                        focusedBorder:OutlineInputBorder(
                                          borderSide: const BorderSide(color: Camone),
                                          borderRadius: BorderRadius.all(Radius.circular(30)),
                                        ),
                                        labelText: ('المعلومات'),
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        labelStyle: TextStyle(fontSize: 22.0,fontFamily: 'Changa',color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],),
                                      ),
                                    ),
                                  ),
                                  Info_Null ? Container(
                                    margin: EdgeInsets.fromLTRB(180, 0, 0, 0),
                                    child: Text('',textAlign:TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Changa',
                                        color: Colors.red,

                                      ),),
                                  ): Container(
                                    margin: EdgeInsets.fromLTRB(180, 0, 0, 0),
                                    child: Text('هذا الحقل مطلوب !',textAlign:TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Changa',
                                        color: Colors.red,

                                      ),),
                                  ),
                                  Container(height: 10,),
                                  Container(
                                    height: 120,
                                    margin: EdgeInsets.fromLTRB(0,10,0,0),
                                    padding: EdgeInsets.symmetric(horizontal:0,),
                                    width: size.width * 0.8,
                                    child: TextFormField(
                                      maxLines: 20,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          EXp_Null=false;
                                          return null;
                                        } else {
                                          EXp_Null=true;
                                          return null;
                                        }
                                      },
                                      cursorColor: Colors.grey[600],
                                      textAlign: TextAlign.right,
                                      controller: Experiance,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Changa',
                                      ),
                                      decoration: InputDecoration(
                                        // prefixIcon: Icon(Icons.lock, color: Colors.grey[600],),
                                        border: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.grey),
                                            borderRadius: const BorderRadius.all(const Radius.circular(30))
                                        ),
                                        focusedBorder:OutlineInputBorder(
                                          borderSide: const BorderSide(color: Camone),
                                          borderRadius: BorderRadius.all(Radius.circular(30)),
                                        ),
                                        labelText: ('خبرة وتجارب سابقة'),
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        labelStyle: TextStyle(fontSize: 22.0,fontFamily: 'Changa',color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],),
                                      ),
                                    ),
                                  ),
                                    EXp_Null ? Container(
                                    margin: EdgeInsets.fromLTRB(150, 0,0, 0),
                                    child: Text('',textAlign:TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Changa',
                                        color: Colors.red,

                                      ),),
                                  ): Container(
                                    margin: EdgeInsets.fromLTRB(170, 0,0, 0),
                                    child: Text('هذا الحقل مطلوب !',textAlign:TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Changa',
                                        color: Colors.red,

                                      ),),
                                  ),
                                  Container(height: 50,),
                                ],
                              ),
                            ),
                          ),
                        ):Container(),
                        card3?Container(
                          height: 600,
                          margin: EdgeInsets.fromLTRB(20, 130, 20, 0),
                          child: SingleChildScrollView(
                            child:Card(
                              elevation: 5,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),),
                              shadowColor: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[

                                  Container(
                                      margin: EdgeInsets.fromLTRB(0,100,0,0),
                                      padding: EdgeInsets.symmetric(),
                                      width: size.width * 0.8,
                                      child: TextFormField(
                                        controller: phone_Num,
                                        keyboardType: TextInputType.phone,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            Phone=false;
                                            return null;
                                          } else {
                                            Phone=true;
                                            return null;
                                          }

                                        },
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.phone),
                                          border: OutlineInputBorder(
                                              borderSide: const BorderSide(color: Colors.grey),
                                              borderRadius: const BorderRadius.all(const Radius.circular(30))
                                          ),
                                          focusedBorder:OutlineInputBorder(
                                            borderSide: const BorderSide(color: Camone),
                                            borderRadius: BorderRadius.all(Radius.circular(30)),
                                          ),
                                          labelText: ('رقم الهاتف'),
                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                          labelStyle: TextStyle(fontSize: 22.0,fontFamily: 'Changa',color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],),
                                        ),
                                        onChanged: (val) {
                                          setState(() {
                                            this.phoneNo = val;
                                          });
                                        },
                                        cursorColor: kPrimaryColor,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: 'Changa',

                                        ),
                                      )),
                                  Phone ? Container(
                                    margin: EdgeInsets.fromLTRB(180, 0, 0, 1),
                                    child: Text('',textAlign:TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Changa',
                                        color: Colors.red,

                                      ),),
                                  ): Container(
                                    margin: EdgeInsets.fromLTRB(180, 0, 0, 1),
                                    child: Text('هذا الحقل مطلوب !',textAlign:TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Changa',
                                        color: Colors.red,

                                      ),),
                                  ),
                                  Invaled_Phone ? Container(): Container(
                                    margin: EdgeInsets.fromLTRB(20, 0,0, 1),
                                    child: Text('يجب أن يكون رقم الهاتف على الصورة +9702417151 ',textAlign:TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Changa',
                                        color: Colors.red,

                                      ),),
                                  ),
                                  codeSent?Container(
                                    margin: EdgeInsets.only(top: 20),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(29),
                                      child: FlatButton(
                                          padding: EdgeInsets.symmetric(vertical: 9, horizontal: 50),
                                          color: Colors.white,
                                          child:Text("إعادة إرسال الكود",
                                            style:TextStyle(
                                              fontSize: 21.0,
                                              fontFamily: 'Changa',
                                              color: Camone,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                          onPressed: (){
                                            if (formKey.currentState.validate()) {print('validate');}
                                            else{print('not validate');}
                                            if(Phone){
                                              verifyPhone(phoneNo);
                                              setState(() {

                                              });
                                            }}
                                      ),
                                    ),

                                  ):Container(
                                    margin: EdgeInsets.only(top: 20),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(29),
                                      child: FlatButton(
                                          padding: EdgeInsets.symmetric(vertical: 9, horizontal: 50),
                                          color: Colors.white,
                                          child:Text("اضغط لإرسال الكود",
                                            style:TextStyle(
                                              fontSize: 21.0,
                                              fontFamily: 'Changa',
                                              color: Camone,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                          onPressed: (){
                                            if (formKey.currentState.validate()) {print('validate');}
                                            else{print('not validate');}
                                            if(Phone){
                                              verifyPhone(phoneNo);
                                              setState(() {

                                              });
                                            }}
                                      ),
                                    ),
                                  ),
                                  // Container(
                                  //   child: RaisedButton(
                                  //     //child:Text("jH;d] الكود"),
                                  //     onPressed: (){
                                  //       if(codeSent){
                                  //         print("send");
                                  //         signInWithOTP(smsCode, verificationId);
                                  //       }
                                  //     },
                                  //   ),
                                  // ),
                                  codeSent?Container(
                                    margin: EdgeInsets.only(top:40,bottom: 2),
                                    padding: EdgeInsets.only(top:0.05),
                                    child: PinEntryTextField(
                                      fields: 6,
                                      fontSize: 12.0,
                                      fieldWidth: 40.0,
                                      showFieldAsBox: true,
                                      onSubmit: (String pin){

                                        setState((){
                                          this.smsCode=pin;
                                          print('$smsCode');
                                        },
                                        );
                                      },
                                    ), //
                                  ):Container(height: 100,),
                                  Container(height: 180,),

                                ],
                              ),
                            ),
                          ),
                        ):Container(),
                        Container(margin:EdgeInsets.only(top:80),child: image_profile(),),
                        Container(
                          width: 150,
                          // margin: card1?EdgeInsets.only(top:655,left: 145,right: 145):EdgeInsets.only(top:655,left: 120,right: 60),
                          margin: EdgeInsets.only(top:655,left: 145,right: 145),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(29),
                            child: FlatButton(
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                              color: Camone,
                              onPressed: (){
                                if (formKey.currentState.validate()) {print('validate');}
                                else{print('not validate');}
                                if(card1){
                                  if(Name_Null && Pass_Null && Pass_Mismatch &&  Pass_S && !nameController.text.isEmpty && !passController.text.isEmpty && !passController2.text.isEmpty){
                                    card1=false;
                                    card2=true;
                                    print(!passController.text.isEmpty);
                                  }}
                                else if(card2){
                                  if(Work_Null && Info_Null && EXp_Null){
                                  card2=false;card3=true;
                                }}
                                else{
                                  if(Phone){
                                     codeSent ? AuthService().signInWithOTP(smsCode, verificationId):verifyPhone(phoneNo);
                                  }
                                }
                                // if(Name_Null &&  Pass_Null &&  Pass_Mismatch &&  Phone &&  Pass_S){
                                //   // codeSent ? signInWithOTP(smsCode, verificationId):verifyPhone(phoneNo);
                                // }
                                setState(() {
                                });
                                //else{card1=true;}
                                // if(Name_Null &&  Pass_Null &&  Pass_Mismatch &&  Phone &&  Pass_S){
                                //   // codeSent ? signInWithOTP(smsCode, verificationId):verifyPhone(phoneNo);
                                // }
                              },
                              child: Center(child: card3 ? Text('تأكيد',
                                style: TextStyle(
                                  fontSize: 21.0,
                                  fontFamily: 'Changa',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),):Text('استمرار',
                                  style: TextStyle(
                                    fontSize: 21.0,
                                    fontFamily: 'Changa',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),


          ),
        ),
    );

  }
  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
      String c=authException.code;
      if(c=='invalid-phone-number'){setState(() {Invaled_Phone=false;});}
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
  Widget image_profile(){
    return Center(
      child:Stack (children: <Widget>[
        CircleAvatar(
          backgroundImage: image_file==null? AssetImage('assets/icons/signup.jpg'):FileImage(File(image_file.path)),
          radius: 60.0,
        ),
        Positioned(
          bottom:10.0,
          right:3.0,
          child: InkWell(
            onTap:(){
              showModalBottomSheet(context: context, builder: (builder) => buttom_camera(),);
            },
            child:Icon(Icons.camera_alt,color: Colors.grey,size: 35.0,),),),
      ],
      ),);
  }
  Widget buttom_camera(){
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
      child: Column(children: <Widget>[
        Text('Choose Profile Photo'),
        SizedBox(height: 20.0,),
        Row(mainAxisAlignment:MainAxisAlignment.center,children: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.camera_alt),
            onPressed: (){
              takePhoto(ImageSource.camera);
            },
            label: Text("Camera"),),
          FlatButton.icon(
            icon: Icon(Icons.image),
            onPressed: (){
              takePhoto(ImageSource.gallery);
            },
            label: Text("Gallery"),),
        ],),
      ],),
    );
  }
  void takePhoto(ImageSource source)async{
    final file =await image_picker.getImage(
      source:source,
    );
    setState(() {
      if(file==Null){image_file=Image.asset("assets/icons/signup.png") as PickedFile;}
      else{image_file=file;}
    });
  }
  //SignIn
  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            // FirebaseAuth.instance.signOut();
            print(snapshot.data.toString());
            return InsideAPP();
          } else {
            return SignuserScreen();
          }
        });
  }

  Future senddata()async {
    String base64;
    String imagename;
    _file = File(image_file.path);
    base64 = base64Encode(_file.readAsBytesSync());
    imagename = _file.path
        .split('/')
        .last;
    var url = 'https://192.168.1.8/testlocalhost/signup.php';
    var ressponse = await http.post(url, body: {
      "name": nameController.text,
      "pass": passController.text,
      "phone": phone_Num.text,
      "imagename": imagename,
      "image64": base64,
      "mytoken": mytoken,
    });

    // else{
    //   String name="signup.png";
    //   base64="A";
    //   var url = 'https://192.168.1.8/testlocalhost/signup.php';
    //   var ressponse = await http.post(url, body: {
    //     "name": nameController.text,
    //     "pass": passController.text,
    //     "phone": phone_Num.text,
    //     "imagename": name,
    //     "image64": base64,
    //   });
    // }
  }


    signInWithOTP(smsCode, verId) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
  }



}

