import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/USER/WORKER_PROFILE.dart';
import 'package:flutterphone/USER/user_Profile.dart';
import 'package:flutterphone/Inside_the_app/user_order.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutterphone/constants.dart';
import 'package:table_calendar/table_calendar.dart';
import '../buttom_bar.dart';
import '../constants.dart';
import '../database.dart';
import 'not_conferm_user_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/USER/user_slot.dart';
import '../constants.dart';
import '../Inside_the_app/user_order.dart';
class war_description extends StatefulWidget {
  final name;
  final country;
  final namefirst;
  final namelast;
  final image;
  final phone;
  final work;
  final DateTime time;
  final phoneworker;
  final username;
  war_description({this.phoneworker,this.username,this.time,this.phone,this.image,this.country,this.work,this.name,this.namelast,this.namefirst});
  _war_description createState() => _war_description();
}

class _war_description extends State<war_description> {
  @override
  bool c1=false;
  bool c2=false;
  TextEditingController description =TextEditingController();
  String imagePath;
  Image image;
  File image_file;
  bool desc=true;
  void Desc(){
    desc=true;
    setState(() {

    });
  }
  Future getImageGallory() async {
    final x = await ImagePicker.pickImage(source: ImageSource.gallery);
    imagePath = x.path;
    image_file = x;
    image = Image(image: FileImage(x),width: 400,height: 150,fit: BoxFit.cover,);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor:Colors.black.withOpacity(0.75),
      //   leading:   IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
      //     Navigator.pop(context);
      //   }), ),
      body:
      // return Directionality(
      //   textDirection: TextDirection.rtl,

      Stack(
        children: [
          // Container(
          //  // margin: EdgeInsets.only(top:0,),
          //
          //   color:Colors.black.withOpacity(0.75),
          //      child: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
          //       Navigator.pop(context);
          //     }), ),
//}
          Scaffold(
            backgroundColor:Colors.grey[50],
            //backgroundColor:Colors.white,
            body: Form(
              child: SingleChildScrollView(

                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: [

                        Container(
                            height: 200,
                            width: 500,
                            margin: EdgeInsets.only(top:0,),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              image: new DecorationImage(
                                fit: BoxFit.cover,
                                // colorFilter:
                                // ColorFilter.mode(Colors.blue.withOpacity(0.3),
                                //     BlendMode.dstATop),
                                image: new AssetImage(
                                  'assets/work/intro3.jpg',
                                ),
                              ),
                            )),
                        GestureDetector(
                            onTap:(){
                              Navigator.pop(context);
                            },
                            child:Container(
                              margin: EdgeInsets.only(top: 70,left: 370),
                              child:Icon(Icons.arrow_forward,color: Colors.black,),
                            )
                        ),
                      ],
                    ),

                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 20,),
                        child:Text('حجز ورشة لدى الصنايعي ',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontFamily: 'vibes',
                            //fontStyle: FontStyle.italic,
                          ),)
                    ),
                    //Image.asset('assets/icons/ho.jpg',fit: BoxFit.cover,) ,
                    Container(
                      width: 400,
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only(top: 30,right: 45),
                      child: Text('تفاصيل أخرى عن الورشة التي تريد طلبها',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14.5,
                          fontFamily: 'Changa',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width:340,
                      height: 120,
                      margin: EdgeInsets.only(top: 8),
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        onChanged: (content) {
                          desc=true;
                          setState(() {

                          });
                        },
                        onEditingComplete: (){
                          desc=true;
                          setState(() {

                          });

                        },
                        //controller: text_post,
                        maxLines: 20,
                        controller: description,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontFamily: 'Changa',
                          fontWeight: FontWeight.bold,
                        ),
                        //o: Desc(),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide:  BorderSide(color:Colors.white),

                          ),
                          focusedBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide:  BorderSide(color:Colors.white),

                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                    ),
                    desc?Container(
                      height: 20,
                      width: 250,
                      margin: EdgeInsets.fromLTRB(100,9, 0, 0),
                      child: Text('',textAlign:TextAlign.end,
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Changa',
                          color: Colors.red,

                        ),),
                    ): Container(
                      height: 20,
                      width: 250,
                      margin: EdgeInsets.fromLTRB(90,9, 0, 0),
                      child: Text(' يجب إرسال تفاصيل عن الطلب *',textAlign:TextAlign.end,
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Changa',
                          color: Colors.red,

                        ),),
                    ),
                    GestureDetector(
                        child:Container(
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.topRight,
                          width: 400,
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 160,),
                              Text('إضافة صورة قد تفيد في طلبك',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 13.0,
                                  fontFamily: 'Changa',
                                  fontWeight: FontWeight.bold,
                                ),),
                              Icon(Icons.add_a_photo,color: Colors.black,size: 30,),
                            ],),
                        ),
                        onTap: () async {
                          await getImageGallory();
                          setState(() {
                            // print(image.g)

                          });
                        }),
                    Stack(
                     children: [
                       image!= null? Container(
                         // width:400,
                         // height:200,
                         //padding: EdgeInsets.all(50),
                           alignment: Alignment.topRight,
                           margin: EdgeInsets.only(right:35,top:10,bottom: 0),
                           child: Container(
                             height: 180,width: 340,
                             child:image,)
                       ):Container(
                         height: 180,
                         margin: EdgeInsets.only(right:30,top:10,bottom: 0),
                       ),
                       image!= null? GestureDetector(
                         onTap: (){
                           image=null;
                           setState(() {

                           });
                         },
                         child: Container(
                           margin: EdgeInsets.only(left:40,top:15,bottom:0),
                           child:Icon(Icons.cancel,color: Colors.black.withOpacity(0.4),),
                         ),
                       ):Container(),
                     ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    Container(
                      height: 55,
                      margin: EdgeInsets.only(top:6,),
                      color:Y,
                      width:600,
                      // margin: EdgeInsets.only(left: 8,right: 15),
                      child: FlatButton(
                        onPressed: ()async{

                          if(description.text.isEmpty){
                            setState(() {
                              desc=false;
                            });
                          }
                          else{
                            setState(() {
                              desc=true;
                            });
                            // await reserve();
                          }
                          print(desc);
                        },
                        color:Y,
                        child: Text(
                          "إرسال طلبك",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 21.0,
                            fontFamily: 'Changa',
                          ),
                        ),
                      ),
                    ),

                  ],

                ),),
            ),),],),);
  }
}
class MyDialog extends StatefulWidget {
  @override
  final phone;
  final id;
  final token;
  final tokenworker;
  final phoneworker;
  final username;
  MyDialog({this.phone,this.id,this.username,this.token,this.phoneworker,this.tokenworker});
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {

  TextEditingController description =TextEditingController();
  String imagePath;
  Image image;
  File image_file;
  bool desc=true;
  @override
  Widget build(BuildContext context){
    print(widget.phoneworker);   print(widget.phone);   print(widget.token); print(widget.username);   print(widget.tokenworker); print("nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
    return AlertDialog(
      backgroundColor: Colors.white,
      actionsPadding: EdgeInsets.zero,
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            GestureDetector(
              child:Container(
                margin: EdgeInsets.only(left: 0, right: 259),
                child:Icon(
                    Icons.close,
                    color: Colors.grey.withOpacity(0.5)),
              ),
              onTap: (){
                Navigator.pop(context);
              },
            ),

          ],
        ),
      ),
    );
  }

// Future reserve()async{
//
//   DateTime date=DateTime.now();
//   var formattedDate = DateFormat('yyyy-MM-dd').format(date);
//   var formattedTime = DateFormat('HH:mm:ss').format(date);
//   print(widget.id);
//   print(widget.phone); print(widget.username); print(widget.phoneworker);
//   print(description.text); print(widget.tokenworker); print(widget.token); print(formattedDate); print(formattedTime);
//   print("''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''");
//   var url = 'https://'+IP4+'/testlocalhost/reserve.php';
//   var ressponse = await http.post(url, body: {
//     "description": description.text,
//     "phone": widget.phone,
//     "id": widget.id,
//     "tokenuser":widget.token,
//     "tokenworker":widget.tokenworker,
//     "phoneworker":widget.phoneworker,
//     "username":widget.username,
//     "datesend":formattedDate,
//     "timesend":formattedTime,
//   });
//   String massage= json.decode(ressponse.body);
//   print(massage);
// }

}
