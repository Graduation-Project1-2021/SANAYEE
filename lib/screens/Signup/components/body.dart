
import 'package:flutterphone/Inside_the_app/inside.dart';
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
import '../signup_screen.dart';
import 'pin.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

class Body extends StatefulWidget {
  @override

  _Body createState() => _Body();
}

class _Body extends State<Body> {

  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phone_Num = TextEditingController();

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
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  String radioItem = '';
  PickedFile image_file;
  File _file;
  final ImagePicker image_picker =ImagePicker();
  Widget build(BuildContext context) {


    Size size = MediaQuery.of(context).size;
    bool _value1 = false;
    bool _value2 = false;
    String code = "";
    String pass="";


    return new Form(key: formKey,
      child: SingleChildScrollView(
           child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: size.height * 0.0),
                      Container(margin: EdgeInsets.fromLTRB(0, 70, 0, 0),),
                      image_profile(),
                      Container(
                        margin: EdgeInsets.fromLTRB(0,70,0,0),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          color: kPrimaryLightColor,
                          borderRadius: BorderRadius.circular(29),

                        ),
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
                  controller: passController,
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
                margin: EdgeInsets.fromLTRB(100, 0, 0, 1),
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
                          setState(() {
                          // Name_Null=true;
                          // Pass_Null=true;
                          // Pass_Mismatch=true;
                          // Phone=true;
                          // Pass_S=true;
                          });
                          if(Name_Null &&  Pass_Null &&  Pass_Mismatch &&  Phone &&  Pass_S &&  Invaled_Phone){
                            codeSent ? signInWithOTP(smsCode, verificationId):verifyPhone(phoneNo);
                          }
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
              Container(
                child: RaisedButton(
                  child: Text('Uplode'),
                  onPressed: (){
                    uplode();
                  },
                ),
              ),
              ],
    ),
    ),);
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
  Widget buildCodeNumberBox(String codeNumber) {
    margin: EdgeInsets.symmetric(vertical: 8);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: 30,
        height: 30,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF6F5FA),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 25.0,
                  spreadRadius: 1,
                  offset: Offset(0.0, 0.75)
              )
            ],
          ),
          child: Center(
            child: Text(
              codeNumber,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: kPrimaryLightColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget image_profile(){
    return Center(
      child:Stack (children: <Widget>[
        CircleAvatar(
          backgroundImage: image_file==null? AssetImage('assets/icons/signup.png'):FileImage(File(image_file.path)),
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
  //SignIn
  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            // FirebaseAuth.instance.signOut();
            print(snapshot.data.toString());
            senddata();
            return InsideAPP();
          } else {
            return SignUpScreen();
          }
        });
  }
  Future senddata()async{
    var url='https://192.168.1.8/testlocalhost/signup.php';
    var ressponse=await http.post(url,body: {
      "name": nameController.text,
      "pass":passController.text,
      "phone":phone_Num.text,
    });
  }

  Future uplode()async{
     _file=File(image_file.path);
     print(image_file.path);
    if(_file==Null){return;}
     String base64=base64Encode(_file.readAsBytesSync());
     String imagename=_file.path.split('/').last;
     print(imagename);
     var url='https://192.168.1.8/testlocalhost/signup.php';
     var ressponse=await http.post(url,body: {
       "name":nameController.text,
       "pass":passController.text,
       "phone":phone_Num.text,
       "imagename": imagename,
       "image64":base64,
     });


  }

  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
  }
}

