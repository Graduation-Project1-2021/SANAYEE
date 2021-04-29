import 'dart:math';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/ChatUuser/Conversation.dart';
import 'package:flutterphone/ChatUuser/chatListUser.dart';
import 'package:flutterphone/Inside_the_app/user_Profile.dart';
import 'package:flutterphone/USER/search_user.dart';
import 'package:flutterphone/USER/user_slot.dart';
import 'GET_IMGS.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import '../constants.dart';
import '../database.dart';
import 'Worker_Slot.dart';
import 'Choose_type.dart';

String  name="";
String  phone="";
String  image="";
String  Work="";
String  Experiance="";
String  Information="";
String  token="";
String IP4="192.168.1.8";


class  user_worker extends StatefulWidget {
  final  name_Me;
  final  name;
  final  namefirst;
  final  namelast;
  final  phone;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;
  final tokenuser;
  final phoneuser;
  final country;
  final client_num;
  final comment;
   List<dynamic>List_Post;
  user_worker({this.List_Post,this.comment,this.client_num,this.country,this.tokenuser,this.phoneuser,this.name_Me,this.name,this.namelast,this.namefirst, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token});
  _user_worker createState() =>  _user_worker();
}
class  _user_worker extends State<user_worker> {
  // AnimationController _animationController;
  void initState() {
    super.initState();
    getRate();
  }
  double Rate;
  String Rate_S;
  bool faverate=false;
  var List_P=[];
  double f=2.2.floorToDouble();
  double roundDouble(double value, int places){
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
  Future getpost()async{
    var url='https://'+IP4+'/testlocalhost/getpost.php';
    var ressponse=await http.post(url,body: {
      "phone": widget.phone,
    });
    // ignore: deprecated_member_use
    List_P= await json.decode(ressponse.body);
    return json.decode(ressponse.body);
  }
  Future getRate() async {
    var url = 'https://'+IP4+'/testlocalhost/show_Rate.php';
    var ressponse = await http.post(url, body: {
      "phoneworker": widget.phone,
    });
    return json.decode(ressponse.body);
  }
  Future getImages() async {
    var url = 'https://'+IP4+'/testlocalhost/Show_EXP.php';
    var ressponse = await http.post(url, body: {
      "phone": widget.phone,
    });
    // ignore: deprecated_member_use
    // var responsebody = json.decode(ressponse.body);
    // print(responsebody);
    return json.decode(ressponse.body);
  }
  var List_Images=[];
  var List_Post=[];

  @override
  Widget build(BuildContext context) {
    print(widget.List_Post.toString());print('BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB');
    // List_P=widget.List_Post;
    // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return  Directionality(textDirection: ui.TextDirection.rtl,
        child:Stack(
         children:[
           Container(
             //transform: Matrix4.translationValues(0.0, -70.0, 0.0),
             child:Image(image:NetworkImage('https://'+IP4+'/testlocalhost/upload/'+widget.image,),),
           ),
           // Image(image:NetworkImage('https://'+IP4+'/testlocalhost/upload/'+widget.image,),),
            Scaffold(
          backgroundColor:Colors.transparent,
          // key: _scaffoldKey,
          // appBar: AppBar(
          //   automaticallyImplyLeading: false, // this will hide Drawer hamburger icon
          //   elevation: 0,
          //   backgroundColor:L_ORANGE,
          //   leading: IconButton(
          //     icon: Icon(Icons.arrow_back,color: Colors.white,),
          //     onPressed: (){
          //       Navigator.pop(context);
          //     },
          //   ),
          // ),
          // backgroundColor: Colors.lightBlueAccent,
          body: Form(child: Container(
              color: Colors.transparent,
              child:Column(
              children: [
                Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top:50,left: 310),
                        child:IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
                          print(widget.country);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work: 'نجار',name_Me: widget.name_Me,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);

                          // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,)));
                        }),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                //   height: 400,
                //   decoration: BoxDecoration(
                //      color:D,
                //     // gradient: LinearGradient(
                //     //     begin: Alignment.topCenter,
                //     //     end: Alignment.bottomCenter,
                //     //     colors: [E,D]),
                //   ),
                // ),
                Container(
                  height: 0,
                  child:FutureBuilder(
                    future: getpost(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if(snapshot.hasData){
                        return ListView.builder(
                            itemCount:1,
                            itemBuilder: (context, index) {
                              List_Post=snapshot.data;
                              // postnumber=snapshot.data.length;
                              return Container(height:0.0,);
                            }
                        );
                      }
                      return Center(child: Text(''));
                    },
                  ),
                ),
              Stack(
              children:[
                Container(
                  height: 55,
                  margin: EdgeInsets.only(top:638.6,),
                   color:Y,
                   width:500,
                   // margin: EdgeInsets.only(left: 8,right: 15),
                   child: FlatButton(
                     onPressed: (){
                       DateTime date=DateTime.now();
                       var formattedDate = DateFormat('yyyy-MM-dd').format(date);
                       print(widget.phone);
                       print(date);
                       // Navigator.push(context, MaterialPageRoute(builder: (context) => My_SLot(date:date,phoneworker: widget.phone,),),);
                       print(widget.phoneuser); print(widget.name_Me); print(widget.phone);
                       print(widget.token); print(widget.tokenuser);print("=====================================================");
                       // Navigator.push(context, MaterialPageRoute(builder: (context) => My_SLot(comment:widget.comment,client_count:widget.client_num,country:widget.country,namelast:widget.namelast,namefirst:widget.namefirst,image:widget.image,nameworker:widget.name,Information:widget.Information,Experiance:widget.Experiance,AVG:Rate,work:widget.Work,date:date,name_Me:widget.name_Me,token_Me:widget.tokenuser,tokenworker: widget.token,phoneworker: widget.phone,phone: widget.phoneuser,),),);
                       Navigator.push(context, MaterialPageRoute(builder: (context) =>choose(time:date,work:widget.Work,phone:widget.phoneuser,username:widget.name_Me,phoneworker:widget.phone,name:widget.name,namelast:widget.namelast,namefirst:widget.namefirst,image:widget.image,tokenworker: widget.token,tokenuser: widget.tokenuser,Information: widget.Information,Experiance:widget.Experiance,comment:widget.comment,client_num:widget.client_num,country:widget.country,)));
                     },
                     // shape: RoundedRectangleBorder(
                     //     borderRadius: BorderRadius.circular(25.0),
                     //     side: Failed assertion: line 378 pos 10: 'datsa != null'
                     //
                     // When the exception was thrown, this was the stack:
                     // #2      new Text (package:flutter/src/widgets/text.dart:378:10)
                     // #3      _worker.Container_number (package:flutterphone/USER/WORKER_PROFILE.dart:578:19)
                     // #4      _worker.build.<anonymous closure>.<anonymous closure> (package:flutterphone/USER/WORKER_PROFILE.dart:407:46)
                     // #5      SliverChildBuilderDelegate.build (package:flutter/src/widgets/sliver.dart:455:22)
                     // #6      SliverMultiBoxAdaptorElement._build (package:flutter/src/widgets/sliver.dart:1213:28)
                     // ...
                     // ====================================================================================================
                     //
                     // ======== Exception caught by widgets library =======================================================
                     // A non-null String must be provided to a Text widget.
                     // 'package:flutter/src/widgets/text.dart':
                     // Failed assertion: line 378 pos 10: 'data != null'
                     // ====================================================================================================
                     // I/chatty  ( 4597): uid=10153(com.example.flutterphone) 1.ui identical 2 lines
                     // I/flutter ( 4597): SARAHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHhhhhhhhhh
                     // I/flutter ( 4597): Instance of '_MapStream<QuerySnapshotPlatform, QuerySnapshot>'BorderSide(color: Colors.transparent)
                     // ),
                     // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                     color:Y,
                     child: Text(
                       "حجز الآن",
                       style: TextStyle(
                         color: Colors.white,
                         fontWeight: FontWeight.bold,
                         fontSize: 21.0,
                         fontFamily: 'Changa',
                       ),
                     ),
                   ),
                 ),
                Container(
                  height: 0,
                  margin: EdgeInsets.only(top: 0),
                  color: Colors.white,
                  child:FutureBuilder(
                    future: getImages(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if(snapshot.hasData){
                        return ListView.builder(
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              int num =snapshot.data.length-4;
                              List_Images=snapshot.data;
                              return Container();
                            }
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
                Container(
                    height: 0,
                    width: 390,
                    margin: EdgeInsets.only(right: 11,left: 11,top:10),
                    child:FutureBuilder(
                      future: getpost(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if(snapshot.hasData){
                          return ListView.builder(
                              itemCount:snapshot.data.length,
                              itemBuilder: (context, index) {
                                List_Post=snapshot.data;
                                return Container();
                              }
                          );
                        }
                        return Center(child: Text('NOOOOOOOOOOOOOOOOOOOOOoo'));
                      },
                    ),
                  ),
                SingleChildScrollView(
                child: Container(
                  height: 550,
                  margin: EdgeInsets.only(top:90),
                  color: Colors.transparent,
                child:FutureBuilder(
                  future: getRate(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if(snapshot.hasData){
                      print('MMMMMMMMAAAAAAAAAAAAAAAAAMMMMMMMMMMMOOOOOOOOOOOOOOOO');
                      return ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          Rate =roundDouble(double.parse(snapshot.data[index]['AVG']),1);
                           bool AVG1=double.parse(snapshot.data[index]['AVG1'])>=4?true:false;
                           bool AVG2=double.parse(snapshot.data[index]['AVG2'])>=4?true:false;
                           bool AVG3=double.parse(snapshot.data[index]['AVG3'])>=4?true:false;
                           bool AVG4=double.parse(snapshot.data[index]['AVG4'])>=4?true:false;
                           bool AVG5=double.parse(snapshot.data[index]['AVG5'])>=4?true:false;
                           bool AVG6=double.parse(snapshot.data[index]['AVG6'])>=4?true:false;
                          return worker(List_Images:List_Images,List_Post:List_Post,comment:widget.comment,client_num:widget.client_num,AVG1:AVG1,AVG2:AVG2,AVG3:AVG3,AVG4:AVG4,AVG5:AVG5,AVG6:AVG6,Rate:Rate,phone:widget.phone,name: widget.name,namefirst: widget.namefirst,namelast: widget.namelast,image: widget.image,token: widget.token,Information: widget.Information,Experiance: widget.Experiance,name_Me: widget.name_Me,Work: widget.Work,);
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),),
            ],),],),),),),
   ], ), );

}
  Future delete_faverate() async {
    var url = 'https://' + IP4 + '/testlocalhost/delete_faverate.php';
    var ressponse = await http.post(url, body: {
      "phoneuser":widget.phoneuser,
      "phoneworker":widget.phone,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  Future add_faverate() async {
    var url = 'https://' + IP4 + '/testlocalhost/addfaverate.php';
    var ressponse = await http.post(url, body: {
      "phoneuser":widget.phoneuser,
      "phoneworker":widget.phone,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  var ma;
  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content:
    Text(text,
      style: TextStyle(
        fontFamily: 'Changa',
        color: Colors.white,
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
      ),)));
  }


}
class worker extends StatefulWidget {
  final  name_Me;
  final  name;
  final  namefirst;
  final  namelast;
  final  phone;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;
  final Rate;
  final bool AVG1;
  final bool AVG2;
  final bool AVG3;
  final bool AVG4;
  final bool AVG5;
  final bool AVG6;
  final client_num;
  final comment;
  List<dynamic>List_Post;
  List<dynamic>List_Images;
  worker({this.List_Images,this.List_Post,this.client_num,this.comment,this.AVG1,this.AVG2,this.AVG3,this.AVG4,this.AVG5,this.AVG6,this.Rate,this.name_Me,this.name,this.namelast,this.namefirst, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token});
  _worker createState() =>  _worker();
}
class  _worker extends State<worker> {
  // AnimationController _animationController;
  Container refresh(){
    setState(() {
     h=0;
    });
    setState(() {
      h=0;
    });
    return Container(height: 0.0,);
  }
  double h;
  void initState() {
    super.initState();
     h=100;
    var boolien = [widget.AVG1,widget.AVG2,widget.AVG3,widget.AVG4,widget.AVG5,widget.AVG6];
  }
  bool Show_anatherPost=false;
  bool Show_firstPost=true;
  var List_Another_Post=[];
  var elements = [
    'جودة',
    'سرعة وإتقان',
    'احترام',
    'سعر جيد',
    'التزام بالوقت',
  ];
  int Post_num=0;
  double Rate;
  String Rate_S;
  double f=2.2.floorToDouble();
  bool faverate=false;
  Future getImages() async {
    var url = 'https://'+IP4+'/testlocalhost/Show_EXP.php';
    var ressponse = await http.post(url, body: {
      "phone": widget.phone,
    });
    // ignore: deprecated_member_use
    // var responsebody = json.decode(ressponse.body);
    // print(responsebody);
    return json.decode(ressponse.body);
  }
  DatabaseMethods databaseMethods=new DatabaseMethods();
  CreatChatRoom (){
    print(widget.name_Me);
    print(widget.name);
    String chatRoomId=getChatRoomId(widget.name,widget.name_Me);
    List<String>Users=[widget.name_Me,widget.name];
    Map<String,dynamic>ChatRoom={
      "users":Users,
      "chatroomid":chatRoomId
    };
    databaseMethods.createChat(chatRoomId, ChatRoom);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Conversation(chatRoomId: chatRoomId,name_Me: widget.name_Me,name: widget.name,image: widget.image,namefirst: widget.namefirst,namelast: widget.namefirst,);
    },
    ),
    );

  }
  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  int _page=0;
  int index=0;
  bool image=false;
  bool info=true;
  bool comment=false;
  bool post=false;
  bool shown=false;
  var ma='';
  int Length_Post;
  var List_Postanother=[];
  Widget build(BuildContext context) {
    List_Postanother=widget.List_Post;
    print(widget.List_Post.toString());print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
    return  Container(
           height: 2000,
           color:Colors.white,
            child:Column(
                //crossAxisAlignment:CrossAxisAlignment.stretch,
                children: <Widget>[
                 // SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.only(top: 10,),
                    color:Colors.white,
                    height: 400,
                    width: 700,
                    child:Column(
                      children: [
                        Container(
                          height:35,
                          child:Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right:35,top:8),
                                width: 280,
                                alignment: Alignment.topRight,
                                child:Text(widget.namefirst+ " "+widget.namelast,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontFamily: 'Changa',
                                    fontWeight: FontWeight.bold,),),
                              ),

                              Container(
                                width: 40,
                                margin: EdgeInsets.only(top: 8,),
                                child:IconButton(icon:Icon(Icons.person_add,),
                                    onPressed: ()async{
                                      // faverate?await add_faverate():await delete_faverate();
                                      _showSnackBar(context, 'تمت المتابعة');
                                    }),
                              ),
                              Container(
                                width: 40,
                                margin: EdgeInsets.only(top: 8,),
                                child:IconButton(icon:Icon(faverate?Icons.favorite_border:Icons.favorite,color: faverate?Colors.black:Colors.red,),
                                    onPressed: ()async{
                                     //faverate?await add_faverate():await delete_faverate();
                                      faverate?_showSnackBar(context, 'تمت الإضافة إلى قائمة المفضلة لديك'):_showSnackBar(context, 'تم الحذف من مفضلتك ');
                                      faverate=!faverate;
                                      setState(() {

                                      });
                                }),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right:20,),
                          width: 360,
                          height: 25,
                          alignment: Alignment.topRight,
                          child:Text(widget.Work,style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontFamily: 'Changa',
                            fontWeight: FontWeight.bold,),),
                        ),
                        Container(
                          width: 370,
                          margin: EdgeInsets.only(right:20,top:15),
                          child:Text(widget.Information + ', ' + widget.Experiance +'.',style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Changa',
                            fontWeight: FontWeight.bold,),),
                        ),
                        Container(
                          height:90,
                          child: FutureBuilder(
                              future: getPost(),
                              builder: (BuildContext context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  print(
                                      "SARAHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHhhhhhhhhh");
                                  //_MyHomePageState c= new _MyHomePageState();
                                  return ListView.builder(
                                    itemCount: 1,
                                    itemBuilder: (context, index) {
                                      ma = snapshot.data[index]['count'];
                                      return Container_number();
                                    },);
                                }
                                return Container(
                                  child: Text(''),
                                );
                              }
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30,top: 20),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  UrlLauncher.launch("tel://0595320479");
                                },
                                child:Container(
                                  width: 40,
                                  height: 40,
                                  margin: EdgeInsets.only(left:10,),
                                  decoration: BoxDecoration(
                                    color: Y,
                                    shape: BoxShape.circle,
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Colors.black.withOpacity(0.5),
                                    //     blurRadius: 2.0,
                                    //     spreadRadius: 0.0,
                                    //     offset: Offset(1.0,1.0), // shadow direction: bottom right
                                    //   )
                                    // ],
                                  ),
                                  child:Icon(Icons.phone,
                                    color: Colors.white,
                                    size: 27.0,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  //CreatChatRoom();
                                },
                                child:Container(
                                  width: 40,
                                  height: 40,
                                  margin: EdgeInsets.only(left:10,),
                                  decoration: BoxDecoration(
                                    color: Y,
                                    shape: BoxShape.circle,
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Colors.black.withOpacity(0.5),
                                    //     blurRadius: 2.0,
                                    //     spreadRadius: 0.0,
                                    //     offset: Offset(1.0,1.0), // shadow direction: bottom right
                                    //   )
                                    // ],
                                  ),
                                  child:Icon(Icons.mark_chat_unread,
                                    color:Colors.white,
                                    size: 27.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 350,
                         margin: EdgeInsets.only(top:15),
                         child: Divider(
                           thickness: 1.0,
                           color: Colors.black26.withOpacity(0.1),
                         ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child:Wrap(children:[
                            _MyButton(name:'جودة',IS: widget.AVG1,),
                            _MyButton(name:'سرعة وإتقان',IS: widget.AVG2,),
                            _MyButton(name:'احترام',IS: widget.AVG3,),
                            _MyButton(name:'سعر جيد',IS: widget.AVG4,),
                            _MyButton(name:'التزام بالوقت',IS: widget.AVG5,),
                          ]),
                        ),
                       // Container(height: 200,color: Colors.white,)
                      ],
                    ),
                    ),
                  Images(widget.List_Images),
                  widget.List_Post.length==0?Container(height:0.0,):Container(height:0.0,),
                  widget.List_Post.length==1 && widget.List_Post[0]['image']=='null'? myPosttext(widget.List_Post[0]['text'],widget.List_Post[0]['date']):Container(height:0.0,),
                  widget.List_Post.length==1 && widget.List_Post[0]['image']!='null'? myPost(widget.List_Post[0]['text'],widget.List_Post[0]['image'],widget.List_Post[0]['date']):Container(height:0.0,),
                  widget.List_Post.length >=2?myPost2():Container(height:0.0,),
                  Show_anatherPost?
                  Container(
                     // margin: EdgeInsets.only(top: 200),
                    // color: Colors.yellowAccent,
                    child:myPost2another(),
                  ):Container(height:0.0,),
                  Post_num<=widget.List_Post.length-1?
                  GestureDetector(
                    onTap: (){
                      Show_anatherPost=true;
                      Show_firstPost=true;
                      Post_num=0;
                      setState(() {});
                    },
                    child: Container(
                      child: Row(
                        children: [
                          SizedBox(width: 170,),
                          Text('عرض المزيد',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 13,
                              fontFamily: 'Changa',
                              fontWeight: FontWeight.bold,),),
                          SizedBox(width: 10,),
                          Icon(Icons.refresh,color:Colors.black.withOpacity(0.7),),
                        ],
                      ),
                    ),
                   ):Container(),
                ],
          ),);
  }
  Container Images(List<dynamic>Images){
   return Container(
     height:Images.length==0?0:140,
     padding: EdgeInsets.only(top: 10),
     child:Column(
       children: [
         Images.length==1?myAlbum1('https://'+IP4+'/testlocalhost/upload/'+ Images[0]['images']):Container(height: 0.0,),
         Images.length==2?myAlbum2('https://'+IP4+'/testlocalhost/upload/'+ Images[0]['images'],'https://'+IP4+'/testlocalhost/upload/'+ Images[1]['images']):Container(height: 0.0,),
         Images.length>=3?worker_Images('https://'+IP4+'/testlocalhost/upload/'+ Images[0]['images'],'https://'+IP4+'/testlocalhost/upload/'+ Images[1]['images'],'https://'+IP4+'/testlocalhost/upload/'+ Images[2]['images']):Container(height: 0.0,),
       ],
     )
   );
  }
  Future getpost()async{
    var url='https://'+IP4+'/testlocalhost/getpost.php';
    var ressponse=await http.post(url,body: {
      "phone": widget.phone,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  myPosttext(String text,String date){
    return Container(
      width: 360, height: 150,
      margin:EdgeInsets.only(left: 30,right: 30,bottom: 20,top: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
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
                fontSize: 13.0,
                fontFamily: 'Changa',
                fontWeight: FontWeight.bold,
              ),),
          ):Container(height: 0,),
        ],
      ),
    );
  }

  myPost(String text,String image,String date) {
    return Container(
      width: 380, height: 321,
      margin:EdgeInsets.only(left: 30,right: 30,bottom: 20,top: 5),
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
                fontSize: 13.0,
                fontFamily: 'Changa',
                fontWeight: FontWeight.bold,
              ),),
          ):Container(height: 0,),
          image!='null'?Container(
            width: 380,
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.centerRight,
            // margin:  EdgeInsets.only(left:10,),
            child: ClipRRect(
              child: Image.network('https://'+IP4+'/testlocalhost/upload/'+  image, height: 204, width: 380, fit: BoxFit.cover,),
            ),):Container(height:0,),
        ],
      ),
    );
  }

  myPost2() {
   Length_Post= widget.List_Post.length;
    print( widget.List_Post.toString());
    return Column(
      children: [
        Post_num<Length_Post?Container(
          child: Column(
            children: [
              widget.List_Post[Post_num]['image']=='null'? myPosttext( widget.List_Post[Post_num]['text'], widget.List_Post[Post_num++]['date']):myPost( widget.List_Post[Post_num]['text'], widget.List_Post[Post_num]['image'], widget.List_Post[Post_num++]['date']),

            ],
          ),
        ):Container(height:10.0,color: Colors.yellowAccent,),
        Post_num<Length_Post?Container(
          child: Column(
            children: [
              widget.List_Post[Post_num]['image']=='null'? myPosttext( widget.List_Post[Post_num]['text'], widget.List_Post[Post_num++]['date']):myPost( widget.List_Post[Post_num]['text'], widget.List_Post[Post_num]['image'], widget.List_Post[Post_num++]['date']),

            ],
          ),
        ):Container(height:0.0,),
      ],
    );
  }

  myPost2another() {
    List_Postanother=widget.List_Post;
    return Column(
      children: [
        Post_num<Length_Post?Container(
          child: Column(
            children: [
             List_Postanother[Post_num]['image']=='null'? myPosttext(List_Postanother[Post_num]['text'],List_Postanother[Post_num++]['date']):myPost(List_Postanother[Post_num]['text'],List_Postanother[Post_num]['image'],List_Postanother[Post_num++]['date']),

            ],
          ),
        ):Container(height:0.0,),
        Post_num<Length_Post?Container(
          child: Column(
            children: [
              List_Postanother[Post_num]['image']=='null'? myPosttext(List_Postanother[Post_num]['text'],List_Postanother[Post_num++]['date']):myPost(List_Postanother[Post_num]['text'],List_Postanother[Post_num]['image'],List_Postanother[Post_num++]['date']),

            ],
          ),
        ):Container(height:0.0,),
        // widget.List_Post[Post_num]['image']=='null'? myPosttext(widget.List_Post[Post_num]['text'],widget.List_Post[Post_num++]['date']):Container(height: 0.0,),
        // Post_num<Length_Post && widget.List_Post[Post_num]['image']!='null'?myPost(widget.List_Post[Post_num]['text'],widget.List_Post[Post_num]['image'],widget.List_Post[Post_num++]['date']):Container(height: 0.0,),
        // Post_num<Length_Post && widget.List_Post[Post_num]['image']=='null'? myPosttext(widget.List_Post[Post_num]['text'],widget.List_Post[Post_num++]['date']):Container(height: 0.0,),
        // Post_num<Length_Post && widget.List_Post[Post_num]['image']!='null'?myPost(widget.List_Post[Post_num]['text'],widget.List_Post[Post_num]['image'],widget.List_Post[Post_num++]['date']):Container(height: 0.0,),

        // widget.List_Post[Post_num]['image']=='null'? myPosttext(widget.List_Post[Post_num]['text'],widget.List_Post[Post_num++]['date']):myPost(widget.List_Post[Post_num]['text'],widget.List_Post[Post_num]['image'],widget.List_Post[Post_num++]['date']),

      ],
    );
  }

  Widget Container_number(){
    return  Center(
      child:Container(
        height: 60,
        width: 380,
        margin: EdgeInsets.only(top: 28),
        padding: EdgeInsets.only(top: 5,left: 0),
        decoration: BoxDecoration(
          //color: Colors.white,
          // border: Border.all(
          //   color: Colors.white,
          // ),
        ),
        child: Row (
          children: [
            SizedBox(width: 30,),
            GestureDetector(
              child:Column(
                children: [
                  Text('منشورات',style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.bold,),),
                  Text(ma.toString(),style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14.0,
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.bold,),),

                ],
              ),
            ),
            SizedBox(width: 50,),
            GestureDetector(
              child:Column(
                children: [
                  Text('تعليقات',style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.bold,),),
                  Text(widget.comment,style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14.0,
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.bold,),),

                ],
              ),
            ),
            SizedBox(width: 50,),
            GestureDetector(
              child:Column(
                children: [
                  Text('عملاء',style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.bold,),),
                  Text(widget.client_num,style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14.0,
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.bold,),),

                ],
              ),
            ),
            SizedBox(width: 50,),
            GestureDetector(
              child:Column(
                children: [
                  Text('الريت',style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.bold,),),
                  Container(
                    //margin: EdgeInsets.only(top:320,left: 290),
                    child:Row(
                      children: [
                        Text(widget.Rate.toString(),
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14.0,
                            fontFamily: 'Changa',
                            fontWeight: FontWeight.bold,),),
                        Icon(Icons.star,color: Colors.yellow,size: 25.0,),
                      ],
                    ),),

                ],
              ),
            ),

          ],
        ),
      ),);
  }
  Future getPost() async {
    var url = 'https://' + IP4 + '/testlocalhost/getpostcount.php';
    var ressponse = await http.post(url, body: {
      "phone": widget.phone,
    });
    // ignore: deprecated_member_use
    // var responsebody = json.decode(ressponse.body);
    // print(responsebody);

    return json.decode(ressponse.body);
  }

  myAlbum1(String asset){
    return Container(
      margin: EdgeInsets.fromLTRB(15,0, 15, 10),
      padding:EdgeInsets.fromLTRB(15, 0, 15, 0),
      height:110,
      width:400,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.symmetric(vertical: 0),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Container(
              child:Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>Get_Images(phone:widget.phone,name:widget.name)));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right:0,bottom: 0,top:0),
                      child:Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              asset, height: 100,
                              width: 110,
                              fit: BoxFit.cover,),
                          ),
                        ],
                      ),),),
                ],),
            ),
            // Container(
            //  child:Text("ألبومي "),
            // ),
          ],),),);
  }
  myAlbum2(String asset1,String asset2){
    return Container(
      margin: EdgeInsets.fromLTRB(15,0, 15, 10),
      padding:EdgeInsets.fromLTRB(15, 0, 15, 0),
      height:130,
      width:400,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.symmetric(vertical: 0),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Container(
              child:Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10,bottom: 10,top:10),
                      child:Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              asset1, height: 110,
                              width: 110,
                              fit: BoxFit.cover,),
                          ),
                        ],
                      ),),),
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 10),
                    child:ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        asset2, height: 110,
                        width:209,
                        fit: BoxFit.cover,),
                    ),),
                ],),
            ),
          ],),
      ),
      // Container(
      //  child:Text("ألبومي "),
      // ),
    );
  }
  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content:
    Text(text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Changa',
      ),)));
  }
  myAlbum3(String asset1, String asset2, String asset3){
    return Container(
      margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
      padding:EdgeInsets.fromLTRB(15, 0, 15, 0),
      height:250,
      width:400,
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 0),
        color: Colors.yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),),
        shadowColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              // margin: EdgeInsets.only(top:5,right: 30,),
              child:Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10,bottom: 10,top: 10),
                    // margin:  EdgeInsets.only(left:15,right: 15),
                    child:ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        asset2, height: 110,
                        width: 159,
                        fit: BoxFit.cover,),
                    ),),
                  Container(
                    margin: EdgeInsets.all(10),
                    // margin:  EdgeInsets.only(left:10,),
                    child:ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        asset1, height: 110,
                        width:159,
                        fit: BoxFit.cover,),
                    ),),
                ],
              ),),
            Container(
              child:Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>Get_Images(phone:widget.phone,name:widget.name)));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 130,bottom: 10),
                      child:Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              asset3, height: 110,
                              width: 209,
                              fit: BoxFit.cover,),
                          ),
                          Positioned(
                            child: Container(
                              height: 110,
                              width: 209,
                              decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Center(
                                child: Text("+0", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),),
                              ),
                            ),
                          )
                        ],
                      ),),),
                ],),
            ),
            // Container(
            //  child:Text("ألبومي "),
            // ),
          ],),),);
  }

  worker_Images(String Image1,String Image2,String Image3){
    return Container(
      child:SingleChildScrollView(
        child: Row(
          children: [

            Container(
              margin: EdgeInsets.only(left: 10,right: 30),
              child:ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.network(
                  Image1, height: 100,
                  width: 110,
                  fit: BoxFit.cover,),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5,right: 5),
              child:ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.network(
                  Image2, height: 100,
                  width: 110,
                  fit: BoxFit.cover,),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>Get_Images(phone:widget.phone,name:widget.name)));
              },
              child: Container(
                margin: EdgeInsets.only(left: 5,right: 5),
                child: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        Image3, height: 100,
                        width: 110,
                        fit: BoxFit.cover,),
                    ),
                    Positioned(
                      child: Container(
                        height: 100,
                        width: 110,
                        decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Center(
                          child: Text("عرض كل الصور", style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Changa',
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                      ),
                    )
                  ],
                ),
                // child:ClipRRect(
                //   borderRadius: BorderRadius.circular(5.0),
                //   child: Image.network(
                //     Image3, height: 120,
                //     width: 160,
                //     fit: BoxFit.cover,),
                // ),
              ),
            ),
          ],
        ),
      ),);
  }

}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
class _MyButton extends StatelessWidget {
  _MyButton({Key key, this.name,this.IS}) : super(key: key);
  final String name;
  final bool IS;
  @override
  Widget build(BuildContext context) {
    return IS?Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(horizontal:10,vertical:5),
      decoration: BoxDecoration(
        //color: Colors.yellow,
        // border: Border.all(
        //   color: Colors.yellow,
        //   width: 1.2,
        // ),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(1.0,1.0), // shadow direction: bottom right
          )
        ],
      ),
      child: Text(name,style: TextStyle(
        color: Colors.black.withOpacity(0.7),
        fontSize: 16,
        fontFamily: 'Changa',
        fontWeight: FontWeight.bold,),),
    ):Text('');
  }
}

// class Imeges_Post extends StatefulWidget {
//   List<dynamic> Images;
//   List<dynamic> Post;
//   final image;
//   final namelast;
//   final namefirst;
//   final int Length_Post;
//   Imeges_Post({this.Length_Post,this.namefirst,this.namelast,this.image,this.Post,this.Images});
//   _Imeges_Post createState() => _Imeges_Post();
// }
//
// class _Imeges_Post extends State<Imeges_Post> {
//   @override
//   int Post_num=0;
//   Widget build(BuildContext context) {
//     print(widget.Post.toString());
//     print("finalllllllllllllllllllllllll_________________________Class____________-----------------------------------------");
//    return widget.Post.length== 0?Container(height:0,):
//     Container(
//       color: Colors.red,
//        height: 700,
//        child:
//     Column(
//       children:[
//         widget.Post.length==1 &&widget.Post[0]['image']=='null'? myPosttext(widget.Post[0]['text'],widget.Post[0]['date']):Container(height:20.0,color:Colors.red,),
//         // widget.List_Post.length==1 && widget.List_Post[0]['(image']!='null'? myPost(widget.List_Post[0]['text'],widget.List_Post[0]['image'],widget.List_Post[0]['date']):Container(height:0.0,),
//         widget.Post.length>=2? myPost2():Container(child: Text('SAD'),),
//         //Show_anatherPost?myPost2():Container(height:0.0,),
//       ]
//     ),);
//
//   }
//   myPost(String text,String image,String date) {
//     return Container(
//       width: 380, height: 321,
//       margin:EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 5),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(10),
//           topRight: Radius.circular(10),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey,
//             blurRadius: 1.0,
//             spreadRadius: 1.0,
//             offset: Offset(1,1), // shadow direction: bottom right
//           )
//         ],
//
//       ),
//       child:Column(
//         children: [
//           Row(
//             children: [
//               Container(
//                 margin: EdgeInsets.only(top:10,left:10,right: 20),
//                 //transform: Matrix4.translationValues(0, -40.0, 0),
//                 child: Center(
//                   child: CircleAvatar(backgroundImage: NetworkImage(
//                       'https://' + IP4 + '/testlocalhost/upload/' + widget.image),
//                     radius: 18.0,),),
//               ),
//               Column(
//                 children: [
//                   Container(
//                     height: 22,
//                     margin: EdgeInsets.only(top:10,left: 150),
//                     child: Center(
//                       child: Text(widget.namefirst + " " + widget.namelast,
//                         style: TextStyle(
//                           color: Colors.black87,
//                           fontSize: 14.0,
//                           fontFamily: 'Changa',
//                           fontWeight: FontWeight.bold,),),
//                     ),),
//                   Container(
//                     height: 20,
//                     margin: EdgeInsets.only(top:0,left: 165),
//                     child: Center(
//                       child: Text(date,
//                         style: TextStyle(
//                           color: Colors.black54,
//                           fontSize: 11.5,
//                           fontFamily: 'Changa',
//                           fontWeight: FontWeight.bold,),),
//                     ),),
//                 ],
//               ),
//             ],
//           ),
//           text!=null?Container(
//             height: 50,
//             width: 320,
//             margin: EdgeInsets.only(top: 5,right: 20,left:0),
//             child:Text(text,
//               style: TextStyle(
//                 color: Colors.black87,
//                 fontSize: 13.0,
//                 fontFamily: 'Changa',
//                 fontWeight: FontWeight.bold,
//               ),),
//           ):Container(height: 0,),
//           image!='null'?Container(
//             width: 380,
//             margin: EdgeInsets.only(top: 10),
//             alignment: Alignment.centerRight,
//             // margin:  EdgeInsets.only(left:10,),
//             child: ClipRRect(
//               child: Image.network('https://'+IP4+'/testlocalhost/upload/'+  image, height: 204, width: 380, fit: BoxFit.cover,),
//             ),):Container(height:0,),
//         ],
//       ),
//     );
//   }
//   myPost2() {
//     return Column(
//       children: [
//         Post_num<widget.Length_Post?Container(
//           child: Column(
//             children: [
//               widget.Post[Post_num]['image']=='null'? myPosttext(widget.Post[Post_num]['text'],widget.Post[Post_num++]['date']):myPost(widget.Post[Post_num]['text'],widget.Post[Post_num]['image'],widget.Post[Post_num++]['date']),
//
//             ],
//           ),
//         ):Container(height:0.0,),
//         Post_num<widget.Length_Post?Container(
//           child: Column(
//             children: [
//               widget.Post[Post_num]['image']=='null'? myPosttext(widget.Post[Post_num]['text'],widget.Post[Post_num++]['date']):myPost(widget.Post[Post_num]['text'],widget.Post[Post_num]['image'],widget.Post[Post_num++]['date']),
//
//             ],
//           ),
//         ):Container(height:0.0,),
//         // widget.List_Post[Post_num]['image']=='null'? myPosttext(widget.List_Post[Post_num]['text'],widget.List_Post[Post_num++]['date']):Container(height: 0.0,),
//         // Post_num<Length_Post && widget.List_Post[Post_num]['image']!='null'?myPost(widget.List_Post[Post_num]['text'],widget.List_Post[Post_num]['image'],widget.List_Post[Post_num++]['date']):Container(height: 0.0,),
//         // Post_num<Length_Post && widget.List_Post[Post_num]['image']=='null'? myPosttext(widget.List_Post[Post_num]['text'],widget.List_Post[Post_num++]['date']):Container(height: 0.0,),
//         // Post_num<Length_Post && widget.List_Post[Post_num]['image']!='null'?myPost(widget.List_Post[Post_num]['text'],widget.List_Post[Post_num]['image'],widget.List_Post[Post_num++]['date']):Container(height: 0.0,),
//
//         // widget.List_Post[Post_num]['image']=='null'? myPosttext(widget.List_Post[Post_num]['text'],widget.List_Post[Post_num++]['date']):myPost(widget.List_Post[Post_num]['text'],widget.List_Post[Post_num]['image'],widget.List_Post[Post_num++]['date']),
//
//       ],
//     );
//   }
//   myPosttext(String text,String date){
//     return Container(
//       width: 380, height: 150,
//       margin:EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 5),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(10),
//           topRight: Radius.circular(10),
//           bottomRight: Radius.circular(10),
//           bottomLeft: Radius.circular(10),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey,
//             blurRadius: 1.0,
//             spreadRadius: 1.0,
//             offset: Offset(1,1), // shadow direction: bottom right
//           )
//         ],
//
//       ),
//       child:Column(
//         children: [
//           Row(
//             children: [
//               Container(
//                 margin: EdgeInsets.only(top:10,left:10,right: 20),
//                 //transform: Matrix4.translationValues(0, -40.0, 0),
//                 child: Center(
//                   child: CircleAvatar(backgroundImage: NetworkImage(
//                       'https://' + IP4 + '/testlocalhost/upload/' + widget.image),
//                     radius: 18.0,),),
//               ),
//               Column(
//                 children: [
//                   Container(
//                     height: 22,
//                     margin: EdgeInsets.only(top:10,left: 150),
//                     child: Center(
//                       child: Text(widget.namefirst + " " + widget.namelast,
//                         style: TextStyle(
//                           color: Colors.black87,
//                           fontSize: 14.0,
//                           fontFamily: 'Changa',
//                           fontWeight: FontWeight.bold,),),
//                     ),),
//                   Container(
//                     height: 20,
//                     margin: EdgeInsets.only(top:0,left: 165),
//                     child: Center(
//                       child: Text(date,
//                         style: TextStyle(
//                           color: Colors.black54,
//                           fontSize: 11.5,
//                           fontFamily: 'Changa',
//                           fontWeight: FontWeight.bold,),),
//                     ),),
//                 ],
//               ),
//             ],
//           ),
//           text!=null?Container(
//             height: 50,
//             width: 320,
//             margin: EdgeInsets.only(top: 5,right: 20,left:0),
//             child:Text(text,
//               style: TextStyle(
//                 color: Colors.black87,
//                 fontSize: 13.0,
//                 fontFamily: 'Changa',
//                 fontWeight: FontWeight.bold,
//               ),),
//           ):Container(height: 0,),
//         ],
//       ),
//     );
//   }
//
// }

