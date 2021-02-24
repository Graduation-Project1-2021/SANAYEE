
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterphone/screens/login_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class InsideAPP extends StatelessWidget {
  const InsideAPP({
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:new Form(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN IS SUCSSEFLY",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/login.svg",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),

              Container(
                child:IconButton(
                  icon: Icon(Icons.logout),
                onPressed: ()async{
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                          (route) => false);
                },
                )
              )
            ],
          ),
        ),
      ),);
  }


}