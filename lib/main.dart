import 'package:flutter/material.dart';
import 'package:flutterphone/screens/Home.dart';
import 'package:flutterphone/screens/images.dart';
import 'package:flutterphone/services/authservice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/screens/welcome_screen.dart';
import 'package:flutterphone/constants.dart';
import 'dart:io';
import 'package:flutterphone/screens/slider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Worker/GET_IMG.dart';
import 'Worker/Gallery.dart';
import 'Worker/SHOW.dart';
import 'Worker/Show_IMG.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
@override
void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
       // home: Get_Images(),
      home: WelcomeScreen(),
    );
  }
}
