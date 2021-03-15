import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutterphone/Inside_the_app/user_Profile.dart';
import 'package:flutterphone/Inside_the_app/user_order.dart';
import 'package:flutterphone/screens/signuser_screen.dart';
import 'package:flutterphone/screens/signworker_screen.dart';
import 'package:flutterphone/screens/welcome_screen.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_cloud_messaging/firebase_cloud_messaging.dart';
import 'package:flutterphone/Inside_the_app/inside.dart';
import 'package:flutterphone/components/already_have_an_account_acheck.dart';
import 'package:flutterphone/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/components/pin_entry_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'dart:convert';

import 'WORKER_PROFILE.dart';
String IP4="192.168.1.8";

String _verificationCode;
String smscode ;
FocusNode myFocusNode = new FocusNode();
String country_choose;
class List_Worker extends StatefulWidget {
  final work;
  final name_Me;
  final location;
  List_Worker({this.work,this.name_Me,this.location});
  @override
  _Body createState() => _Body();
}

class _Body extends State<List_Worker> {


  @override
  final formKey = new GlobalKey<FormState>();
  bool login=true;

  String country_id;
  String hint="اختيار المنطقة";
  List<String>country=["جنين","نابلس","طولكرم","رام الله","طوباس","حيفا","يافا","عكا","الخليل","قلقيلية","جميع المناطق"];

  Future getSearch()async{
    var url='https://'+IP4+'/testlocalhost/groupsearch.php';
    var ressponse=await http.post(url,body: {
      "Work":widget.work,
      "country":widget.location,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  @override
  void initState() {
    country_id=widget.location;
    super.initState();
  }
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor:L_ORANGE.withOpacity(0.75),
          leading:   IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>U_PROFILE(name_Me: widget.name_Me,)));

            // Navigator.pop(context);
          }),
        ),
      body:Column(
        children: [
          Container(
          color: L_ORANGE.withOpacity(0.75),
          child:Row(children:[
            Container(
              margin: EdgeInsets.only(top:10,right: 30),
              height: 80,
              child: Text(widget.work,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontFamily: 'Changa',
                  fontWeight: FontWeight.bold,),),
            ),
            Container(
                margin: EdgeInsets.only(right: 170,top:1),
                padding: EdgeInsets.fromLTRB(8,10,10,10),
                width: 145,
                height: 50,
                decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                child:DropdownButton(
                  isExpanded: true,
                  elevation: 3,
                  itemHeight: 50,
                  icon: Icon(Icons.pin_drop,color: Colors.white,),
                  iconSize:30.0,
                  value: country_id,
                  dropdownColor: Colors.white,
                  onChanged: (value){
                    setState(() {
                      _showMyDialog();
                      country_choose=value;
                      value=value;
                      print(country_id);
                      // Country=true;
                    });
                  },

                  underline: Container(color: Colors.transparent),
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Changa',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  items:country.map((value){
                    return DropdownMenuItem(
                      child: Container(
                        height: 50,
                        width: 240.0,
                        margin: EdgeInsets.only(top:0),
                        child: Text(value, textAlign: TextAlign.right),
                      ),
                      value: value,
                    );
                  }).toList(),

                )
            ),
            // GestureDetector(
            //   child:Container(
            //     decoration: BoxDecoration(
            //       border: Border.all(
            //         color: Color(0xFF1C1C1C),
            //       ),
            //     ),
            //   child: Row(children: [
            //     Container(
            //       margin: EdgeInsets.only(left: 10,top:0,right: 200),
            //       height: 80,
            //       child: Text(widget.location,
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 25.0,
            //           fontFamily: 'Changa',
            //           fontWeight: FontWeight.bold,),),
            //     ),
            //     Icon(Icons.location_on),
            //
            //   ],),
            // ),),
          ],),),
          Container(
            color: Colors.white,
            height: 580,
            padding: EdgeInsets.only(top:1),
            //  color:  Color(0xFF1C1C1C),
            child:FutureBuilder(
              future: getSearch(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Group(name_Me:widget.name_Me,name:snapshot.data[index]['name'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],phone:snapshot.data[index]['phone'],image:snapshot.data[index]['image'],Work:snapshot.data[index]['Work'],Experiance:snapshot.data[index]['Experiance'],Information:snapshot.data[index]['Information'],token:snapshot.data[index]['token']);
                    },
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),),

        ],),
     ),);
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
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>List_Worker(work:widget.work,location:country_choose,name_Me: widget.name_Me,)));
                    },
                  ),),
              ],
            ),

          ],
        );
      },
    );
  }
}class Group  extends StatefulWidget {
  final name_Me;
  final  name;
  final  namefirst;
  final  namelast;
  final  phone;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;

  Group({this.name_Me,this.name,this.namefirst,this.namelast, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token});

  @override
  _Group createState() => _Group();
}

class _Group extends State<Group> {
  @override
  void initState() {
    super.initState();
  }

  Future getImages() async {
    var url = 'https://' + IP4 + '/testlocalhost/Show_EXP.php';
    var ressponse = await http.post(url, body: {
      "phone": widget.phone,
    });
    // ignore: deprecated_member_use
    // var responsebody = json.decode(ressponse.body);
    // print(responsebody);
    return json.decode(ressponse.body);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 150,
        width: 200,
        decoration: BoxDecoration(
          //color:Colors.white,
          color: Colors.white,
          // borderRadius: BorderRadius.circular(20),
          // boxShadow: [
          //   BoxShadow(
          //     offset: Offset(0, 1),
          //     blurRadius: 20,
          //     color: Color(0xFFECCB45),
          //   ),
          // ],
        ),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),

        child: Column(
          children: <Widget>[
            Stack(children: [
              Container(
                margin: EdgeInsets.only(top: 30, right: 10),
                child: CircleAvatar(backgroundImage: NetworkImage(
                    'https://' + IP4 + '/testlocalhost/upload/' + widget.image),
                  radius: 29.0,),),
              Container(
                width: 200,
                height: 30,
                //color: Colors.red,
                margin: EdgeInsets.only(top: 30, right: 80, left: 50),
                child: Text(widget.namefirst + " " + widget.namelast,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Changa',
                    color: Color(0xFF666360),
                    fontWeight: FontWeight.bold,
                  ),),),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top:58,right: 80),
                    child: Text("4.9",
                      style: TextStyle(
                        color: Color(0xFF666360),
                      ),),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:58,right: 3, left: 15,),
                    child: Icon(Icons.star,
                      color: Color(0xFFECCB45),),
                  ),

                ],
              ),
              // Container(
              //   width: 200,
              //   margin: EdgeInsets.only(top: 70, right: 120),
              //   child: Text(widget.Work,
              //     style: TextStyle(
              //       fontSize: 18.0,
              //       fontFamily: 'Changa',
              //       color: Color(0xFF666360),
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),),
              Row(
                children: [
                  Container(
                    width: 110,
                    margin: EdgeInsets.only(top: 80, right: 80),
                    child: Text(widget.phone,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Changa',
                        color: Color(0xFF666360),
                        fontWeight: FontWeight.bold,
                      ),
                    ),),
                  Container(
                    margin: EdgeInsets.only(top: 80, left: 10,),
                    child: Icon(Icons.phone,
                      color: Color(0xFF666360),),
                  ),
                  Container(
                    width: 57,
                    margin: EdgeInsets.only(left: 0, right: 0, top: 80),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.transparent)
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 2),
                      color: L_ORANGE.withOpacity(0.75),
                      onPressed: () async {
                        DateTime _selectedDay = DateTime.now();
                        var dateParse = DateTime.parse(_selectedDay.toString());
                        var formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDay);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => user_order(phone:widget.phone,),));
                      },
                      child: Center(child: Text("طلب",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Changa',
                          color:  Colors.white,
                          fontWeight: FontWeight.bold,
                        ),),),),
                  ),
                  Container(
                    width: 80,
                    margin: EdgeInsets.only(left: 0, right: 10, top: 80),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.transparent)
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 2),
                      color:L_ORANGE.withOpacity(0.75),
                      onPressed: () async {

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => user_worker(image:widget.image,phone:widget.phone,name: widget.name,namelast:widget.namelast,name_Me: widget.name_Me,namefirst: widget.namefirst,token: widget.token,Information: widget.Information,Experiance:widget.Experiance,),));
                      },
                      child: Center(child: Text("عرض المزيد",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Changa',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),),),),
                  ),
                ],),
              //Container (margin: EdgeInsets.only(top: 20,left: 150),child:Text(widget.name),),
              // Row(
              //   children: [
              //     Container(
              //       margin: EdgeInsets.only(top: 125,right: 150),
              //       child:Text("4.9"),
              //     ),
              //     Container(
              //       margin: EdgeInsets.only(top: 120,right: 3,left: 15,),
              //       child:Icon(Icons.star),
              //     ),
              //     Container(
              //       margin: EdgeInsets.only(top: 120,left: 0,right: 5),
              //       child:Text(" 123 تعليق"),
              //     ),
              //     Container(
              //       margin: EdgeInsets.only(top: 120,right: 3,left: 90),
              //       child:Icon(Icons.comment),
              //     ),
              //
              //   ],
              // ),

            ],),
            Container(
              height: 10,
              margin: EdgeInsets.only(top: 5),
            child:Divider(
              color: Color(0xFF666360),
              thickness: 1,
            ),),

          ],),
      ),);
  }
}
