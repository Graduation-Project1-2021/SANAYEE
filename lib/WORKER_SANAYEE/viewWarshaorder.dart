
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/WORKER_SANAYEE/Worker_conferm_order.dart';
import 'package:flutterphone/WORKER_SANAYEE/GET_IMGS.dart';
import 'package:flutterphone/WORKER_SANAYEE/viewWarshaorder.dart';
import 'package:flutterphone/Worker/setting_worker.dart';
import 'package:flutterphone/Worker/worker_order.dart';
import 'package:flutterphone/screens/login_screen.dart';
import 'package:flutterphone/screens/welcome.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutterphone/constants.dart';
import '../constants.dart';
import '../database.dart';
import 'package:flutterphone/Chatworker/chatListworker.dart';

import 'Profile.dart';
import 'Worker_Slot.dart';
import 'Worker_notconferm_order.dart';
import 'homepage.dart';
import 'longtimework.dart';
import 'menue_Page.dart';
import 'longtimework.dart';
String IP4="192.168.1.8";
class viewWarsha extends StatefulWidget {
  final name;
  final phone;
  viewWarsha({this.phone,this.name});
  @override
  _viewWarshaState createState() => _viewWarshaState();
}

class _viewWarshaState extends State<viewWarsha> {
  @override
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future getWorker()async{
    var url='https://'+IP4+'/testlocalhost/viewOrder.php';
    var ressponse=await http.post(url,body: {
      "phone": widget.phone,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  Widget build(BuildContext context) {
    print("ddddddddddddddddddddd"); print(widget.phone); print(widget.name);
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
      body:Form(

     child:Column(
       children: [
         // Container(
         //   color: Colors.yellowAccent,
         //   height: 700,
         //   padding: EdgeInsets.only(top:30),
         //   child: FutureBuilder(
         //     future: getWorker(),
         //     builder: (BuildContext context, AsyncSnapshot snapshot) {
         //       if (snapshot.hasData) {
         //         print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"+widget.phone);
         //         return ListView.builder(
         //           itemCount: snapshot.data.length,
         //           itemBuilder: (context, index) {
         //             print(snapshot.data[index]['workerphone']);
         //             return Container(height: 200,);
         //             return view (describes:snapshot.data[index]['describes'],nameofwork : snapshot.data[index]['nameofwork'],workerphone : snapshot.data[index]['workerphone'], namefirst: snapshot.data[index]['namefirst'], namelast: snapshot.data[index]['namelast'], phoneuser: snapshot.data[index]['phoneuser']);
         //
         //           },
         //         );
         //       }
         //       return Center(child: CircularProgressIndicator());
         //     },
         //   ),
         // ),
         Container(
           height: 100,
           margin: EdgeInsets.only(top: 260,right: 150),
           color: Colors.yellowAccent,
           child:FutureBuilder(
             future: getWorker(),
             builder: (BuildContext context, AsyncSnapshot snapshot) {
               if(snapshot.hasData){
                 return ListView.builder(
                     itemCount:1,
                     itemBuilder: (context, index) {

                       return Center(child: Text('YAHHHHHHHHHHHHHHHHH'));
                     }
                 );
               }
               return Center(child: Text('NO'));
             },
           ),
         ),

       ],
     ) ,

    ),),);
  }

  Future getlongtimeorder() async {

    var url = 'https://'+IP4+'/testlocalhost/viewOrder.php';
    print("ssssssssssssssssssssssssssssssssssssssssssssssssssssssssss"+widget.phone);
    var ressponse = await http.post(url, body: {
      "phone": widget.phone,

    });
    return json.decode(ressponse.body);
  }
}

class view extends StatefulWidget {
  final phoneuser;
  final describes;
  final namefirst;
  final namelast;

  final workerphone;
  final nameofwork;
  view({this.namelast,this.workerphone,this.namefirst,this.phoneuser,this.nameofwork,this.describes});
  @override
  _viewState createState() => _viewState();
}

class _viewState extends State<view> {
  @override
  Widget build(BuildContext context) {
    return Column(

      children:[
        card(widget.namefirst,widget.namelast,widget.describes,widget.phoneuser,widget.workerphone,widget.nameofwork),

      ],);



  }
  Widget card(String namefirst , String namelast,String describes,String phoneuser,String workerphone,String nameofwork )
  { print("tafaseel talab "+workerphone);

  return Container (
    height: 100,
    margin: EdgeInsets.only(top:5),
    color: Colors.white,
    child:Card(
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 0,left: 350),
            child:IconButton(icon: Icon(Icons.arrow_forward_ios,color: Colors.blue,), onPressed: (){
              Navigator.pop(context);
              // Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,)));
              //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,)));
            }),
          ),
          ListTile(
            leading: Icon(Icons.arrow_drop_down_circle),
            title: const Text("                 "+'  تفاصيل الطلب'),
            // MainAxisAlignment.end,
            subtitle: Text(
              namefirst+' '+namelast+"                                             "+ "اسم العميل",
              style: TextStyle(color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              describes+"                   "+"وصف الطلب ",
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                //alignment: MainAxisAlignment.center,
                textColor: Colors.blue,
                onPressed: () {

                },
                child: const Text('الغاء'),
              ),
              FlatButton(
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => viewreservation(workerphoned: workerphone,nameofworkd:nameofwork,namelastd:namelast,namefirstd:namefirst,phoneuserd:phoneuser),
                    ),);},
                // Perform some action

                child: const Text('اضافة'),
              ),

            ],
          ),
          // Image.asset('assets/card-sample-image.jpg'),
          // Image.asset('assets/card-sample-image-2.jpg'),
        ],
      ),),);

  }

}
