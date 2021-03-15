import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/screens/home2.dart';
import 'package:flutterphone/screens/welcome.dart';
import 'package:flutterphone/constants.dart';
import 'package:flutterphone/screens/welcome_screen.dart';
import 'dart:io';

import 'Map.dart';
import 'button.dart';

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
       primaryColor: MY_YELLOW,
       visualDensity: VisualDensity.adaptivePlatformDensity,
       // scaffoldBackgroundColor: Colors.white,
      ),
          // home: MyApp4(),
         home: WelcomeScreen(),
    );
  }
}
