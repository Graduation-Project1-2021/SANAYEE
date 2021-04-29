import 'dart:math';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/WORKER_SANAYEE/Worker_conferm_order.dart';
import 'package:flutterphone/WORKER_SANAYEE/GET_IMGS.dart';
import 'Profile.dart';
import 'Setting.dart';
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

import 'homepage.dart';
import 'orders_workers.dart';

String  name="";
String  phone="";
String  image="";
String  Work="";
String  Experiance="";
String  Information="";
String  token="";
String IP4="192.168.1.8";

class Post extends StatefulWidget {
  final name;
  final phone;
  final namefirst;
  final namelast;
  final image;
  Post({this.image,this.namelast,this.namefirst,this.phone,this.name});
  _Post createState() =>  _Post();
}
class  _Post extends State<Post> {
  // AnimationController _animationController;
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  final List1=[];
  var ListDate1=[];
  final List2=[];
  var ListDate2=[];
  List<dynamic>L;
  File _file;
  bool uploading = false;
  double val = 0;
  File uploadimage;
  var path_image="";
  // File _file;
  List<File> _image = []; //هاي هي
  int counter = 0;
  final picker = ImagePicker();
  var mytoken ;
  Future getdata1()async{
    var url='https://'+IP4+'/testlocalhost/count.php';
    var ressponse=await http.post(url,body: {
      "phone": phone,
    });
    var responsepody= json.decode(ressponse.body);
    for(int i=0;i<responsepody.length;i++){
      //L.add(responsepody[i]['count']);
      List1.add(responsepody[i]['id']);
      ListDate1.add(responsepody[i]['date']);
    }
    // print(List1);
    // print(ListDate1);
  }
  Future getpost()async{
    var url='https://'+IP4+'/testlocalhost/getpost.php';
    var ressponse=await http.post(url,body: {
      "phone": widget.phone,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  Future getdata2()async{
    var url='https://'+IP4+'/testlocalhost/count2.php';
    var ressponse=await http.post(url,body: {
      "phone": phone,
    });
    var responsepody= json.decode(ressponse.body);
    for(int i=0;i<responsepody.length;i++){
      //L.add(responsepody[i]['count']);
      List2.add(responsepody[i]['id']);
      ListDate2.add(responsepody[i]['date']);
    }
    // print(List2);
    // print(ListDate2);
  }
  void initState() {
    super.initState();

  }
  int _selectedIndex = 1;
  @override
  DatabaseMethods databaseMethods=new DatabaseMethods();
  Stream chatsRoom;
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Directionality(textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: new AppBar(
          backgroundColor:Y,
          leading:GestureDetector(
            onTap: (){
              Navigator.pop(context);
              // Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => PROFILE(name: widget.name,)));
            },
            child:Icon(Icons.arrow_back,color: Colors.white,),
          ),
          title: new Text('المنشورات',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Changa',
              color: Colors.white,
            ),
          ),
        ),
        // appBar: PreferredSize(
        //     preferredSize: Size.fromHeight(40.0), // here the desired height
        //     child: AppBar(
        //       backgroundColor: Color(0xFFECCB45),
        //       elevation: 0.0,
        //       //leading: I,
        //     )
        // ),
        body: Form(
          child:SingleChildScrollView(
          child:Column(
          children:[
            Container(
                margin:EdgeInsets.only(top:35,left: 5,right: 260),
                decoration: BoxDecoration(
                  color: Colors.white,),
                child:Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        _dialogCall(context);
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Text('إضافة منشور',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15.0,
                                fontFamily: 'Changa',
                                fontWeight: FontWeight.bold,
                              ),),
                          ],
                        ),
                      ),
                    )
                  ],
                )
            ),

            SingleChildScrollView(
            child:Container(
              height: 600,
              width: 400,
              margin: EdgeInsets.only(right: 10,left: 10,top:10),
              child:FutureBuilder(
                future: getpost(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData){
                    print(snapshot.data.length);
                    return ListView.builder(
                        itemCount:snapshot.data.length,
                        itemBuilder: (context, index) {
                          return myPost(snapshot.data[index]['text'],snapshot.data[index]['image'],snapshot.data[index]['date']);
                        }
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
          ],),),),),);
  }

  Future<void> _dialogCall(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyDialog(phone: widget.phone,namelast: widget.namelast,namefirst:widget.namefirst,name:widget.name,image:widget.image,);
        });
  }
  myPost(String text,String image,String date) {
    return Container(
                width: 380, height: 321,
                margin:EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1.0,
                      spreadRadius: 1.0,
                      offset: Offset(1,1), // shadow direction: bottom right
                    )
                  ],

                ),
                child:Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top:10,left:10,right: 20),
                          //transform: Matrix4.translationValues(0, -40.0, 0),
                          child: Center(
                            child: CircleAvatar(backgroundImage: NetworkImage(
                                'https://' + IP4 + '/testlocalhost/upload/' + widget.image),
                              radius: 18.0,),),
                        ),
                        Column(
                          children: [
                            Container(
                              height: 22,
                              margin: EdgeInsets.only(top:10,left: 150),
                              child: Center(
                                child: Text(widget.namefirst + " " + widget.namelast,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14.0,
                                    fontFamily: 'Changa',
                                    fontWeight: FontWeight.bold,),),
                              ),),
                            Container(
                              height: 20,
                              margin: EdgeInsets.only(top:0,left: 165),
                              child: Center(
                                child: Text(date,
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 11.5,
                                    fontFamily: 'Changa',
                                    fontWeight: FontWeight.bold,),),
                              ),),
                          ],
                        ),
                      ],
                    ),
                     text!=null?Container(
                      height: 50,
                      width: 320,
                      margin: EdgeInsets.only(top: 5,right: 20,left:0),
                      child:Text(text,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15.0,
                          fontFamily: 'Changa',
                          fontWeight: FontWeight.bold,
                        ),),
                    ):Container(height: 0,),
                    image!=null?Container(
                      width: 360,
                      margin: EdgeInsets.only(top: 10),
                      alignment: Alignment.centerRight,
                      // margin:  EdgeInsets.only(left:10,),
                      child: ClipRRect(
                        child: Image.network('https://'+IP4+'/testlocalhost/upload/'+  image, height: 204, width: 352, fit: BoxFit.cover,),
                      ),):Container(height:0,),
                  ],
                ),
      );
  }
}

class MyDialog extends StatefulWidget {
  @override
  final phone;
  final name;
  final namefirst;
  final namelast;
  final image;
  MyDialog({this.name,this.namelast,this.namefirst,this.image,this.phone});
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {

  TextEditingController text_post=new TextEditingController();
  String imagePath;
  Image image;
  File image_file;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      actionsPadding: EdgeInsets.zero,
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(left: 0, right: 259),
                child: IconButton(icon: Icon(
                    Icons.close,
                    color: Colors.grey.withOpacity(0.5)),
                    onPressed: () {
                      Navigator.pop(context);
                    })
            ),
            Container(
              width:500,
              height: 100,
              child: TextFormField(
                textAlign: TextAlign.right,
                controller: text_post,
                maxLines: 20,
                style: TextStyle(
                  color: Colors.grey.withOpacity(0.5),
                  fontSize: 16.0,
                  fontFamily: 'Changa',
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  enabledBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                    borderSide:  BorderSide(color:MY_BLACK),

                  ),
                  focusedBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                    borderSide:  BorderSide(color:MY_BLACK),

                  ),
                  hintText: 'أضف إعلاناتك هنا ',
                  hintStyle: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Changa',
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
            image!= null? Container(
              // width:400,
              // height:200,
              //padding: EdgeInsets.all(50),
                margin: EdgeInsets.only(right:0,left:0,top: 10,bottom: 10),
                child: Container(
                  height: 200,width: 400,
                  child:image,)
            ):Container(),
            GestureDetector(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.image),
                    SizedBox(width: 5),
                  ],
                ),
                onTap: () async {
                  await getImageGallory();
                  setState(() {
                    // print(image.g)

                  });
                }),
            Padding(
              padding: EdgeInsets.all(8.0),
            ),
            Container(
              color: Colors.grey.withOpacity(0.5),
              child:GestureDetector(
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 60),
                      Icon(Icons.create),
                      SizedBox(width: 30),
                      Text('إنشاء منشور',
                        style:  TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Changa',
                          color: MY_BLACK,
                        ),),
                      SizedBox(width: 5),
                    ],
                  ),
                  onTap: () async {
                    await senddata();
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Post(namelast:widget.namelast,image:widget.image,namefirst:widget.namefirst,phone: widget.phone, name: widget.name)));

                  }),),
          ],
        ),
      ),
    );
  }


  Future getImageGallory() async {
    final x = await ImagePicker.pickImage(source: ImageSource.gallery);
    imagePath = x.path;
    image_file = x;
    image = Image(image: FileImage(x),width: 400,height: 150,fit: BoxFit.cover,);
  }

  Future senddata()async{
    if(image==null){
      print("image null");
      var url = 'https://'+IP4+'/testlocalhost/add_post.php';
      var ressponse = await http.post(url, body: {
        "text": text_post.text,
        "phone": widget.phone,
        "imagename": 'null',
        "image64": '',
      });
      String massage= json.decode(ressponse.body);
      print(massage);
    }
    else{ String base64;
    String imagename;
    File _file = File(image_file.path);
    base64 = base64Encode(_file.readAsBytesSync());
    imagename = _file.path.split('/').last;
    DateTime date=DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(date);
    var url = 'https://'+IP4+'/testlocalhost/add_post.php';
    var ressponse = await http.post(url, body: {
      "text": text_post.text,
      "phone": widget.phone,
      "imagename": imagename,
      "image64": base64,
      "date":formattedDate,
    });
    String massage= json.decode(ressponse.body);
    print(massage);
    }
  }

}