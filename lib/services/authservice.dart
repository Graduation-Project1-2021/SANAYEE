import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/Inside_the_app/inside.dart';
import 'package:flutterphone/screens/signuser_screen.dart';

class AuthService {
  User user;
  //Handles Auth
  handleAuth() {
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
  //Sign out
  void delete()async
  {
    FirebaseUser user = await FirebaseAuth.instance.currentUser;
    user.delete();
  }
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //SignIn
  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
  }
}

