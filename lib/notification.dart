import 'package:flutter/material.dart';

class DestinationScreen extends StatelessWidget {

  String payload;

  DestinationScreen({this.payload});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Padding(padding: EdgeInsets.all(25),child: Text(payload, textAlign: TextAlign.center, style: TextStyle(color:Colors.red,fontWeight: FontWeight.bold, fontSize: 30,))),
        )
    );
  }
}