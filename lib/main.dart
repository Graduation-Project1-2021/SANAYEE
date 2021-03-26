import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/screens/welcome.dart';
import 'package:flutterphone/constants.dart';
import 'package:flutterphone/screens/welcome_screen.dart';
import 'dart:io';

import 'Localnotification.dart';
import 'USER/Search.dart';
import 'USER/xc.dart';
import 'USER/Setting_user.dart';
import 'notificationscreen.dart';

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
  DateTime _selectedDay = DateTime.now();
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
       primaryColor: MY_YELLOW,
       visualDensity: VisualDensity.adaptivePlatformDensity,
       // scaffoldBackgroundColor: Colors.white,
      ),
        // home: My_SLot(phoneworker: '+970595320479',phone:'+97055',tokenworker:'lkk',time: _selectedDay,),
        // home: not_conferm__order(time: _selectedDay,phone: '+970595320479'),
          home: WelcomeScreen(),
        //   home: Search_user(work:'نجار',),
    );
  }
}
