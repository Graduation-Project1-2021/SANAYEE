import 'package:flutter/material.dart';
import 'package:flutterphone/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/services/authservice.dart';

class RoudedPhone extends StatefulWidget {
  @override
  _RoudedPhone createState() => _RoudedPhone();
}

class _RoudedPhone extends State<RoudedPhone> {
  final formKey = new GlobalKey<FormState>();

  String phoneNo, verificationId, smsCode;

  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          width: size.width * 0.8,
          decoration: BoxDecoration(
            color: kPrimaryLightColor,
            borderRadius: BorderRadius.circular(29),
          ),
          child: TextField(
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.phone),
              fillColor: kPrimaryColor,
              hintText: 'قم الهاتف',
              border: InputBorder.none,
            ),
            keyboardType: TextInputType.phone,

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
          ),
        ),
        Column(
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
                )): Container(
              margin: EdgeInsets.symmetric(vertical: 1),
              width: size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: RaisedButton(
                    child: Center(child: codeSent ? Text('Login'):Text('Verify')),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    color: kPrimaryColor,
                    onPressed: () {
                      codeSent ? AuthService().signInWithOTP(smsCode, verificationId):verifyPhone(phoneNo);
                    }

                ),
              ),
            ),

          ],
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
