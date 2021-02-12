
import 'package:flutterphone/screens/Login/components/background.dart';
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
import 'package:flutterphone/components/Custom_Rodio_Button.dart';
import 'package:flutterphone/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/services/authservice.dart';
import 'package:flutterphone/constants.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Sign_Worker extends StatefulWidget {
  @override

  _Sign_Worker createState() => _Sign_Worker();
}

class _Sign_Worker extends State<Sign_Worker> {

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
  bool _showPassword = false;
  bool Feild1 = true;
  bool Feild2 = true;
  bool Feild3 = true;
  String pass="";
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
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


      return Scaffold(
        body: new Form(key: formKey,
        child: SingleChildScrollView(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),),
        Row(children: <Widget>[
          Container(
            child: new InkWell(// this is the one you are looking for..........
              onTap: () { },
              child: new Container(
                margin:EdgeInsets.fromLTRB(20, 10, 10, 10),
                padding: const EdgeInsets.all(15.0),//I used some padding without fixed width and height
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,// You can use like this way or like the below line
                  color: step3?kPrimaryColor:kPrimaryLightColor,
                ),
                child: new Text('3', style: new TextStyle(color: Colors.white, fontSize: 20.0,fontFamily: 'Changa',)),// You can add a Icon instead of text also, like below.
              ),//............
            ),),
          Expanded(
            child: new Container(
                margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Divider(
                  thickness: 2.0,
                  color: Colors.grey,
                )),
          ),
          Container(
            child: new InkWell(// this is the one you are looking for..........
              onTap: () { },
              child: new Container(
                margin:EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(15.0),//I used some padding without fixed width and height
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,// You can use like this way or like the below line
                  color: step2?kPrimaryColor:kPrimaryLightColor,
                ),
                child: new Text('2', style: new TextStyle(color: Colors.white, fontSize: 20.0,fontFamily: 'Changa',)),// You can add a Icon instead of text also, like below.
              ),//............
            ),),
          Expanded(
            child: new Container(
                margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Divider(
                  thickness: 2.0,
                  color: Colors.grey,
                )),
          ),
          Container(
            child: new InkWell(// this is the one you are looking for..........
              onTap: () { },
              child: new Container(
                margin:EdgeInsets.fromLTRB(10, 10, 20, 10),
                padding: const EdgeInsets.all(15.0),//I used some padding without fixed width and height
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,// You can use like this way or like the below line
                  color: step1?kPrimaryColor:kPrimaryLightColor,
                ),
                child: new Text('1', style: new TextStyle(color: Colors.white, fontSize: 20.0,fontFamily: 'Changa',)),// You can add a Icon instead of text also, like below.
              ),//............
            ),),
        ],),
          step1? Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: size.height * 0.0),
                      Container(margin: EdgeInsets.fromLTRB(0, 10, 0, 0),),
                      image_profile(),
                      Container(
                        margin: EdgeInsets.fromLTRB(0,50,0,0),
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

                      SizedBox(height: size.height * 0.0),
                      Container(
                          margin: EdgeInsets.fromLTRB(0,10,0,0),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            color: kPrimaryLightColor,
                            borderRadius: BorderRadius.circular(29),
                          ),
                          child: TextFormField(
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
                              hintText: 'رقم الهاتف',
                              suffixIcon: Icon(Icons.phone,color: kPrimaryColor,),
                              fillColor: kPrimaryColor,
                              border: InputBorder.none,),
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
                      Phone ? Container(): Container(
                        margin: EdgeInsets.fromLTRB(180, 0, 0, 1),
                        child: Text('!هذا الحقل مطلوب',textAlign:TextAlign.end,
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
                      Container(
                        margin: EdgeInsets.fromLTRB(0,10,0,0),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          color: kPrimaryLightColor,
                          borderRadius: BorderRadius.circular(29),

                        ),
                        child: TextFormField(
                          validator: (value) {
                            pass=value;
                            if (value.isEmpty) {
                              Pass_Null=false;
                              return null;
                            } else if (value.length < 8) {
                              Pass_S=false;
                              return null;
                            }
                            Pass_Null=true;
                            Pass_S=true;
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
                      Pass_Null ? Container(): Container(
                        margin: EdgeInsets.fromLTRB(180, 0, 0, 1),
                        child: Text('!هذا الحقل مطلوب',textAlign:TextAlign.end,
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Changa',
                            color: Colors.red,

                          ),),
                      ),
                      Pass_S ? Container(): Container(
                        margin: EdgeInsets.fromLTRB(70, 0, 0, 1),
                        child: Text('يجب أن تحتوي كلمة السر 8 أحرف على الأقل',textAlign:TextAlign.end,
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Changa',
                            color: Colors.red,

                          ),),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0,10,0,0),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          color: kPrimaryLightColor,
                          borderRadius: BorderRadius.circular(29),

                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value==pass) {
                              Pass_Mismatch=true;
                              return null;
                            } else {
                              Pass_Mismatch=false;
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
                            hintText: ('تأكيد كلمة السر'),
                            border:InputBorder.none,
                          ),

                        ),
                      ),

                      Pass_Mismatch ? Container(): Container(
                        margin: EdgeInsets.fromLTRB(150, 0,0, 1),
                        child: Text('كلمة السر غير متطابقة',textAlign:TextAlign.end,
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Changa',
                            color: Colors.red,

                          ),),
                      ),

                      codeSent? Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child:PinEntryTextField(
                            fields: 6,
                            onSubmit: (String pin){

                              setState((){
                                this.smsCode=pin;
                                print('$smsCode');
                              },
                              );
                            },
                          )): Container(),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 25, 0, 5),
                          width: size.width * 0.8,
                          child: ClipRRect(borderRadius: BorderRadius.circular(29),
                              child: RaisedButton(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                                child: Center(child: codeSent ? Text('اضغط للاستمرار',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'Changa',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),):Text('إضغط لإرسال رمز التأكيد',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: 'Changa',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ))),
                                onPressed: () {
                                  codeSent ? AuthService().signInWithOTP(smsCode, verificationId):verifyPhone(phoneNo);
                                  setState(() {
                                   Name_Null=true;
                                   Pass_Null=true;
                                   Pass_Mismatch=true;
                                   Phone=true;
                                   Pass_S=true;
                                   });
                                   if (formKey.currentState.validate()) {print('validate');}
                                   else{print('not validate');}

                                },
                                color: kPrimaryColor,
                              ))
                      ),
                      !codeSent ? Container(
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
                      ):Container(),
                    ],
                  ),
                ),
              ],
            ),
          ) :Container(),
          step2?Container(
           child: Column(
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
             ],
           ),
          ),],
           ),
          ):Container(),

          Row(mainAxisAlignment:MainAxisAlignment.spaceAround,children:<Widget>[
            FlatButton(
              onPressed:() {
                setState(() {
                  if(current_step<2){
                    print(current_step);
                    current_step=current_step+1;
                    if(current_step==0){step1=true;step2=false;step3=false;}
                    if(current_step==1){step1=false;step2=true;step3=false;}
                    if(current_step==2){step1=false;step2=false;step3=true;}
                  }
                });
              },
              color: Colors.white,
              textColor: kPrimaryColor,
              child: Row(
                children: <Widget>[
                  Icon(Icons.chevron_left,size: 20),
                  Text('التالي',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Changa',
                      fontWeight: FontWeight.bold,
                    ),),
                ],
              ),
            ),
            FlatButton(
              onPressed:() {
                setState(() {
                  if(current_step>0){
                    print(current_step);
                    current_step=current_step-1;
                    if(current_step==0){step1=true;step2=false;step3=false;}
                    if(current_step==1){step1=false;step2=true;step3=false;}
                    if(current_step==2){step1=false;step2=false;step3=true;}
                  }
                });
              },
              color: Colors.white,
              textColor: kPrimaryColor,

              child: Row(
                children: <Widget>[
                  Text('السابق',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Changa',
                fontWeight: FontWeight.bold,
              ),),
                  Icon(Icons.chevron_right,size: 20,),
                ],),
            ),],),
    ],),),),);
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
          backgroundImage: image_file==null? AssetImage('assets/icons/cat.png'):FileImage(File(image_file.path)),
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
      image_file=file;
    });
  }
}
