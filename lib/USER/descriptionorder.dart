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
import 'package:image_picker/image_picker.dart';
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
String IP4="192.168.1.8";
String imagePath;
Image image;

class description extends StatefulWidget {
  final id;
  final phoneworker;
  final workername;
  final phoneuser;
  final username;
  final tokenuser;
  final tokenworker;
  final namefirst;
  final namelast;
  final image;
  final work;
  final country;
  description({this.country,this.work,this.namefirst,this.namelast,this.image,this.tokenuser,this.tokenworker,this.phoneworker,this.username,this.id,this.phoneuser,this.workername});
  _description createState() => _description();
}

class _description extends State<description> {
  @override
  bool c1=false;
  bool c2=false;
  File image_file;
  PickedFile im_file;
  File _file;
  TextEditingController description =TextEditingController();
  bool desc=true;
  void Desc(){
    desc=true;
    setState(() {

    });
  }
  final picker = ImagePicker();
  Future getImageGallory() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    // final x = await ImagePicker.pickImage(source: ImageSource.gallery);
   // imagePath = x.path;
   // image_file = x;
    im_file =pickedFile;
    image = Image(image: FileImage(File(im_file.path)),width: 600,height: 200,fit: BoxFit.cover,);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
            backgroundColor: Colors.grey[50],
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
                              margin: EdgeInsets.only(top: 70,left: 380),
                              child:Icon(Icons.arrow_forward,color: Colors.black,),
                            )
                        ),
                      ],
                    ),
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 20,),
                        child:Text('حجز طقة لدى الصنايعي ',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontFamily: 'vibes',
                            //fontStyle: FontStyle.italic,
                          ),)
                    ),
                    Container(
                      width: 400,
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only(top: 30,right: 35),
                      child: Text('تفاصيل عملية الصيانة التي تريد طلبها',
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
                            await _dialogCall();
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

  Future<void> _dialogCall() {
    print(widget.id);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Directionality(textDirection: ui.TextDirection.rtl,
            child:MyDialog(im_file:im_file,country:widget.country,work:widget.work,namefirst:widget.namefirst,namelast:widget.namelast,image: widget.image,description:description.text,username:widget.username,id:widget.id,phoneworker:widget.phoneworker,phone:widget.phoneuser,tokenworker:widget.tokenworker,token:widget.tokenuser,),);
        });
  }

}
class MyDialog extends StatefulWidget {
  @override
  final work;
  final phone;
  final id;
  final token;
  final tokenworker;
  final phoneworker;
  final username;
  final description;
  final namefirst;
  final namelast;
  final image;
  final country;
  PickedFile im_file;
  MyDialog({this.im_file,this.country,this.work,this.namefirst,this.namelast,this.image,this.description,this.phone,this.id,this.username,this.token,this.phoneworker,this.tokenworker});
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {

  // String imagePath;
  // Image image;
  // File image_file;
  @override
  Widget build(BuildContext context){
    return AlertDialog(
      backgroundColor: Colors.white,
      actionsPadding: EdgeInsets.zero,
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 0,top: 10),
                    child: Text('هل أنت متأكد من أنك تريد حجز هذا الطلب ؟',
                      style: TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.black45,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                  SizedBox(height:50,),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async{
                          await reserve();
                         // Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => not_conferm_user_statues(country:widget.country,work:widget.work,name_Me:widget.username,id:widget.id,phoneworker:widget.phoneworker,description:widget.description,namefirst: widget.namefirst,namelast: widget.namelast,phoneuser: widget.phone,image: widget.image,),),);

                        },
                        child: Container(
                            margin: EdgeInsets.only(right: 170),
                            child:Text('حسنا',
                              style: TextStyle(
                                fontFamily: 'Changa',
                                color: Y,
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                            margin: EdgeInsets.only(right: 48),
                            child:Text('إلغاء',
                              style: TextStyle(
                                fontFamily: 'Changa',
                                color: Y,
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(width: 10,),
                ],
              ),
          ],
        ),
      ),
    );
  }
  Future uploadFile() async {
    print("hiiii");
    File _file;
    _file = File(widget.im_file.path);
    print("hiiii");
    // print(image_file.path);
    if (_file == Null) {
      return;
    }
    print("hiiii");
    String base64 = base64Encode(_file.readAsBytesSync());
    String imagename = _file.path.split('/').last;
    print("hiiii");
    print(imagename);
    print(base64);
    var url = 'https://'+IP4+'/testlocalhost/EXP_Image.php';
    // final uri=Uri.parse("https://192.168.2.111/testlocalhost/signup.php");
    var response = await http.post(url, body: {

      "phone": '9564122',
      "imagename": imagename,
      "image64": base64,
    });
    setState(() {

    });
    String massage= json.decode(response.body);
    print(massage);
  }
Future reserve()async{
  File _file;
  DateTime date=DateTime.now();
  var formattedDate = DateFormat('yyyy-MM-dd').format(date);
  var formattedTime = DateFormat('HH:mm:ss').format(date);
  print("''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''");
  var url;
  var ressponse;
  if(widget.im_file==null) {
    url = 'https://'+IP4+'/testlocalhost/reserve.php';
     ressponse = await http.post(url, body: {
      "description": widget.description,
      "phone": widget.phone,
      "id": widget.id,
      "tokenuser": widget.token,
      "tokenworker": widget.tokenworker,
      "phoneworker": widget.phoneworker,
      "username": widget.username,
      "datesend": formattedDate,
      "timesend": formattedTime,
    });
  }
  else{
    _file = File(widget.im_file.path);
    url = 'https://'+IP4+'/testlocalhost/reserve_imge.php';
    String base64 = base64Encode(_file.readAsBytesSync());
    String imagename = _file.path.split('/').last;
    print("baseeeeeeeeeeeeee");
    print(base64);
    print(imagename);
    ressponse = await http.post(url, body: {
      "description": widget.description,
      "phone": widget.phone,
      "id": widget.id,
      "tokenuser": widget.token,
      "tokenworker": widget.tokenworker,
      "phoneworker": widget.phoneworker,
      "username": widget.username,
      "datesend": formattedDate,
      "timesend": formattedTime,
      "base64":base64,
      "image":imagename,
    });

  }
  //String massage= json.decode(ressponse.body);
  //print(massage);
}}
