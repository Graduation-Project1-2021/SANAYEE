import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/services/authservice.dart';
import 'package:flutterphone/constants.dart';


class Verfy extends StatefulWidget {
  @override
  _Verfy createState() => _Verfy();
}

class _Verfy extends State<Verfy> {
  final formKey = new GlobalKey<FormState>();

  String phoneNo, verificationId, smsCode;

  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              codeSent ? Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: 'Enter OTP'),
                    onChanged: (val) {
                      setState(() {
                        this.smsCode = val;
                      });
                    },
                  )) :
              Container(
                margin: EdgeInsets.symmetric(vertical: 1),
                width: size.width * 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: FlatButton(
                  child: codeSent ? Text('Login'):Text('أرسل رمز التأكيد',
                      style: TextStyle(
                          color: kPrimaryLightColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          fontFamily: 'Changa',
                          ),
                          ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    color: kPrimaryColor,
                    onPressed: () {
                    codeSent ? AuthService().signInWithOTP(smsCode, verificationId):verifyPhone(phoneNo);
                    }

                    ),
                  ),
                ),
            ],
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