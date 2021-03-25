import 'dart:math';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutterphone/USER/user_Profile.dart';
import 'package:flutterphone/Inside_the_app/user_order.dart';
import 'package:flutterphone/screens/signuser_screen.dart';
import 'package:flutterphone/screens/signworker_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutterphone/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'dart:convert';

import 'Comment.dart';
import 'WORKER_PROFILE.dart';

String IP4="192.168.1.8";

String _verificationCode;
String radioItem = '';
PickedFile image_file;
File _file;
bool choose=false;
final ImagePicker image_picker =ImagePicker();
String smscode ;
FocusNode myFocusNode = new FocusNode();
String country_choose;
class settiing extends StatefulWidget {
  final work;
  final name_Me;
  final namefirst_Me;
  final nameLast_Me;
  final phone_Me;
  final image_Me;
  final token_Me;
  final location;
  settiing({this.token_Me,this.image_Me,this.namefirst_Me,this.nameLast_Me,this.phone_Me,this.work,this.name_Me,this.location});
  @override
  _Body createState() => _Body();
}

class _Body extends State<settiing> {


  double roundDouble(double value, int places){
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
  @override
  final formKey = new GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        body:Form(
        child:Column(
          children: [

            Stack(
              children: [
                Container(
                  color:D,
                  height: 200,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);},
                  child:  Container(
                    margin: EdgeInsets.only(top: 60,right: 10),
                    child:Icon(Icons.keyboard_backspace_sharp,color: Colors.black54,size: 25,),
                  ),
                ),
                Container(margin:EdgeInsets.only(top:70),child: image_profile(),),

                Container(
                  margin:EdgeInsets.only(top:250,right:20),
                  child: Column(
                    children:[
                     GestureDetector(
                        child:Container(
                          child:Row(
                            children: [
                              Icon(Icons.home),
                              SizedBox(width: 10,),
                              Text('الصفحة الرئيسية',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Changa',
                                ),),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 25,),
                      GestureDetector(
                        child:Container(
                          child:Row(
                            children: [
                              Icon(Icons.favorite),
                              SizedBox(width: 10,),
                              Text('المفضلة',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Changa',
                                ),),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 25,),
                      GestureDetector(
                        child:Container(
                          child:Row(
                            children: [
                              Icon(Icons.settings),
                              SizedBox(width: 10,),
                              Text('الإعدادات',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Changa',
                                ),),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 40,),
                      // Container(
                      //   width: 500,
                      //   child: Divider(
                      //     thickness: 1.0,
                      //     color: Colors.black54.withOpacity(0.2),
                      //   ),
                      // ),
                      GestureDetector(
                        child:Container(
                          child:Row(
                            children: [
                              Icon(Icons.logout),
                              SizedBox(width: 10,),
                              Text('تسجيل الخروج',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Changa',
                                ),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

          ],),
      ),),);
  }
  Widget image_profile(){
    return Center(
      child:Stack (children: <Widget>[
        CircleAvatar(
          backgroundImage: image_file==null? AssetImage('assets/icons/signup.jpg'):FileImage(File(image_file.path)),
          radius: 50.0,
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
      height: 50.0,
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
      if(file==Null){image_file=Image.asset("assets/icons/signup.png") as PickedFile;}
      else{image_file=file;}
    });
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      //this means the user must tap a button to exit the Alert Dialog
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.only(right: 20,left: 30,top: 15),
          actions: <Widget>[
            Directionality(textDirection: ui.TextDirection.rtl,
              child: Container(
                width: 300,
                alignment: Alignment.topRight,
                padding:EdgeInsets.only(top:50,left: 10,right: 30),
                //margin: EdgeInsets.only(top:50,left: 50,right: 10),
                child:Text('!ذا قمت باختيار منطقة أخرى غير منطقتك فإن  الوقت لتلبية طلبك قد يتأخر لأن الحرفي من مدينة أخرى ومن الممكن أن يلغى طلبك هل أنت متأكد ؟',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontFamily: 'Changa',
                  ),),
              ),),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10,bottom: 20,right:10,top: 30),
                  child:FlatButton(
                    child: Text('إلغاء',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                        fontFamily: 'Changa',
                      ),),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),),
                Container(
                  margin: EdgeInsets.only(left: 20,right:90,bottom: 20,top: 30),
                  child:FlatButton(
                    child: Text('حسنا',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                        fontFamily: 'Changa',
                      ),),
                    onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>settiing(work:widget.work,location:country_choose,name_Me: widget.name_Me,)));
                    },
                  ),),
              ],
            ),

          ],
        );
      },
    );
  }
}

