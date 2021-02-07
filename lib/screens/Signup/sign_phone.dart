import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/services/authservice.dart';
import 'package:flutterphone/constants.dart';

class SignUPhone extends StatefulWidget {
  @override
  _SignUPhone createState() => _SignUPhone();
}

class _SignUPhone extends State<SignUPhone> {
  final formKey = new GlobalKey<FormState>();

  String phoneNo, verificationId, smsCode;

  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        hintText: 'رقم الهاتف',
                      suffixIcon: Icon(Icons.phone),
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
              codeSent ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: 'أدخل رمز التأكيد'),
                    onChanged: (val) {
                      setState(() {
                        this.smsCode = val;
                      });
                    },
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Changa',

                    ),
                  )) : Container(),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  width: size.width * 0.8,
                  child: ClipRRect(borderRadius: BorderRadius.circular(29),
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      child: Center(child: codeSent ? Text('اضغط للاستمرار',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Changa',
                        ),):Text('إضغط لإرسال رمز التأكيد',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Changa',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ))),
                      onPressed: () {
                        codeSent ? AuthService().signInWithOTP(smsCode, verificationId):verifyPhone(phoneNo);
                      },
                    color: kPrimaryColor,
                      ))
              ),
            ],
          )),
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
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
}
