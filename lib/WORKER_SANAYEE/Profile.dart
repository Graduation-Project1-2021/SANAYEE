import 'dart:math';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/Inside_the_app/Comment.dart';
import 'package:flutterphone/WORKER_SANAYEE/Worker_conferm_order.dart';
import 'package:flutterphone/WORKER_SANAYEE/GET_IMGS.dart';
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

import 'all_post.dart';
import 'homepage.dart';
import 'menue_Page.dart';
import 'orders_workers.dart';

String  name="";
String  phone="";
String  image="";
String  Work="";
String  Experiance="";
String  Information="";
String  token="";
String namefirst="";
String namelast="";
String IP4="192.168.1.8";

class PROFILE extends StatefulWidget {
  final name;
  final phone;
  final lat;
  final lng;

  PROFILE({this.lat,this.lng,this.name,this.phone});
  _PROFILE createState() =>  _PROFILE();
}
class  _PROFILE extends State< PROFILE> {
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
  var commentnumber;
  var postnumber;
  getChat(){
    print(widget.name);
    databaseMethods.getChatsMe(widget.name).then((val){
      setState(() {
        print(val.toString());
        chatsRoom=val;
      });
    });
  }
  void initState() {
    super.initState();
    getChat();

  }
  Future getWorker()async{
    var url='https://'+IP4+'/testlocalhost/getworker.php';
    var ressponse=await http.post(url,body: {
      "name": widget.name,
    });
    // ignore: deprecated_member_use
      return json.decode(ressponse.body);
    }
  Future getComment() async {
    var url = 'https://' + IP4 + '/testlocalhost/getcomment.php';
    var ressponse = await http.post(url, body: {
      "phone": widget.phone,
    });
    // ignore: deprecated_member_use
    // var responsebody = json.decode(ressponse.body);
    // print(responsebody);

    return json.decode(ressponse.body);
  }
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
    return json.decode(ressponse.body);
  }
  var List_Post=[];
  int _selectedIndex = 3;
  @override
  DatabaseMethods databaseMethods=new DatabaseMethods();
  Stream chatsRoom;
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return  Directionality( textDirection: TextDirection.rtl,
      child:Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar:Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
          ]),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                  rippleColor: Colors.grey[100],
                  hoverColor: Colors.grey[100],
                  gap: 8,
                  activeColor: Colors.black,
                  iconSize: 24,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  duration: Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.grey[100],
                  tabs: [
                    GButton(
                      icon: Icons.home,
                      text: 'الرئيسية',
                      textStyle:TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.black,
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GButton(
                      onPressed: (){
                      },
                      icon: Icons.calendar_today,
                      text: 'طلباتي',
                      textStyle:TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.black,
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GButton(
                      onPressed: (){

                      },
                      icon: Icons.mark_chat_unread,
                      text: 'شات',
                      textStyle:TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.black,
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GButton(
                      icon: Icons.person,
                      text: 'حسابي',
                      textStyle:TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.black,
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GButton(
                      icon: Icons.menu,
                      text: 'القائمة',
                      textStyle:TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.black,
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      _selectedIndex = index;
                      if(index==0){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Home_Page(name: widget.name)));
                      }
                      if(index==1){
                       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => order_worker(Information:Information,Experiance:Experiance,Work:Work,namelast:namelast,name:widget.name,phone:phone,image:image,token:token,namefirst:namefirst,)));
                      }
                      if(index==2){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Chat(name_Me:widget.name,chatsRoomList: chatsRoom,Information:Information,Experiance:Experiance,Work:Work,namelast:namelast,phone:phone,image:image,token:token,namefirst:namefirst)));
                      }
                      if(index==4){
                        DateTime date=DateTime.now();
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MenuePage(Information:Information,Experiance:Experiance,Work:Work,namelast:namelast,name:widget.name,phone:phone,image:image,token:token,namefirst:namefirst,)));
                      }


                    });
                  }
              ),
            ),
          ),),
        backgroundColor:Colors.grey[50],
        // appBar: PreferredSize(
        //     preferredSize: Size.fromHeight(40.0), // here the desired height
        //     child: AppBar(
        //       backgroundColor: Color(0xFFECCB45),
        //       elevation: 0.0,
        //       //leading: I,
        //     )
        // ),
        body: Form(
          // child:SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                            postnumber=snapshot.data.length;
                            return Container(height:0.0,);
                          }
                      );
                    }
                    return Center(child: Text(''));
                  },
                ),
              ),
              Container(
                height: 0,
                margin: EdgeInsets.only(top: 0),
                color: Colors.white,
                child:FutureBuilder(
                  future: getComment(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            commentnumber=snapshot.data[index]['count'];
                            return Container();
                          }
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),


              Container(
                height:730,
                margin: EdgeInsets.only(top:0),
                decoration: BoxDecoration(
                  color:Colors.grey[50],
                ),
                child:FutureBuilder(
                  future: getWorker(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(
                        itemCount: 1,
                          itemBuilder: (context, index) {
                          name=snapshot.data[index]['name'];
                          namefirst=snapshot.data[index]['namefirst'];
                          namelast=snapshot.data[index]['namelast'];
                          phone=snapshot.data[index]['phone'];
                          image=snapshot.data[index]['image'];
                          Work=snapshot.data[index]['Work'];
                          Information=snapshot.data[index]['Information'];
                          Experiance=snapshot.data[index]['Experiance'];
                          token=snapshot.data[index]['token'];
                          double Rate=0.0;
                          if(snapshot.data[index]['AVG']!=null){Rate =roundDouble(double.parse(snapshot.data[index]['AVG']),1);}
                         return Profile_worker(List_Post:List_Post,postnumber:List_Post.length,commentnumber:commentnumber,client_num:snapshot.data[index]['Client'],Rate:Rate,name:snapshot.data[index]['name'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],phone:snapshot.data[index]['phone'],image:snapshot.data[index]['image'],Work:snapshot.data[index]['Work'],Experiance:snapshot.data[index]['Experiance'],Information:snapshot.data[index]['Information'],token:snapshot.data[index]['token']);

                          return Container();
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),],),),),);



  }}

TextEditingController text_post =TextEditingController();
class Profile_worker  extends StatefulWidget {
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
  final client_num;
  final commentnumber;
  final postnumber;
  List<dynamic>List_Post;

  Profile_worker({this.List_Post,this.postnumber,this.commentnumber,this.client_num,this.Rate,this.name,this.namelast,this.namefirst, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token,});

  @override
  _Profile_woeker createState() => _Profile_woeker();
}

class _Profile_woeker extends State<Profile_worker> {

  bool image=false;
  bool info=true;
  bool comment=false;
  bool post=false;

  bool uploading = false;
  double val = 0;
  int Post_num=0;
  bool image_post = false;
  File uploadimage;
  var ListPost=[];
  // File _file;
  List<File> _image = []; //هاي هي
  int counter = 0;
  File _file;
  final picker = ImagePicker();
  PickedFile image_file;
  final ImagePicker image_picker = ImagePicker();
  int Length_Post;
  var List_Postanother=[];
  @override
  void initState() {
    super.initState();
  }
   bool zeropost=false;
   bool zeroimage=false;
  bool Show_anatherPost=false;
  bool Show_firstPost=true;
  var List_Another_Post=[];
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
  Future getComment() async {
    var url = 'https://' + IP4 + '/testlocalhost/getcomment.php';
    var ressponse = await http.post(url, body: {
      "phone": widget.phone,
    });
    // ignore: deprecated_member_use
    // var responsebody = json.decode(ressponse.body);
    // print(responsebody);

    return json.decode(ressponse.body);
  }
  Future getpost()async{
    var url='https://'+IP4+'/testlocalhost/getpost.php';
    var ressponse=await http.post(url,body: {
      "phone": widget.phone,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  @override
  Widget build(BuildContext context) {
    // getChat();
    List_Postanother=widget.List_Post;
    print(widget.List_Post.toString());
    return SingleChildScrollView(
      child:Container(
      height: 1400,
      
      color: Colors.white,
      child:Column(
      children:<Widget>[
        Container(
          margin: EdgeInsets.only(top:0),
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            // gradient: LinearGradient(
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter,
            //     // colors: [B,A,G]
            //     colors: [Y1,Y4]
            // ),
          ),
         ),
        // Row(children: [
        //   GestureDetector(
        //     child: Container(
        //       child: Column(
        //         children: [
        //           Container(
        //             height: 20,
        //             width: 40,
        //             margin: EdgeInsets.only(right: 50, top: 30),
        //             child: IconButton(
        //               icon: Icon(Icons.person,
        //                 color:info?Colors.white:Colors.black.withOpacity(0.5),),
        //             ),
        //           ),
        //           Container(
        //             height: 20,
        //             width: 25,
        //             margin: EdgeInsets.only(right: 50, top: 10),
        //             child: Text('حول',
        //               style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 13.3,
        //                 fontFamily: 'Changa',
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        //   GestureDetector(
        //     onTap: () {
        //       setState(() {
        //         post = true;
        //         image=false;
        //       });
        //       // Navigator.push(context,
        //       //     MaterialPageRoute(builder: (context) => PROFILE(name: widget.name,profile:1,)),);
        //     },
        //     child: Container(
        //       child: Column(
        //         children: [
        //           Container(
        //             height: 20,
        //             width: 40,
        //             margin: EdgeInsets.only(right: 50, top: 30),
        //             child: IconButton(
        //               icon: Icon(Icons.my_library_books_sharp,
        //                 color:post?Colors.white:Colors.black.withOpacity(0.5),),
        //             ),
        //           ),
        //           Container(
        //             height: 20,
        //             width: 60,
        //             margin: EdgeInsets.only(right: 50, top: 10),
        //             child: Text('منشورات',
        //               style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 13.3,
        //                 fontFamily: 'Changa',
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        //
        //   GestureDetector(
        //     onTap: () {
        //       setState(() {
        //         image = true;
        //         post = false;
        //       });
        //       // Navigator.push(context,
        //       //     MaterialPageRoute(builder: (context) => PROFILE(name: widget.name,profile:1,)),);
        //     },
        //     child: Container(
        //       child: Column(
        //         children: [
        //           Container(
        //             height: 20,
        //             width: 40,
        //             margin: EdgeInsets.only(right: 50, top: 30),
        //             child: IconButton(
        //               icon: Icon(Icons.image,
        //                 color:image?Colors.white:Colors.black.withOpacity(0.5),),),
        //           ),
        //           Container(
        //             height: 30,
        //             width: 40,
        //             margin: EdgeInsets.only(right: 50, top: 10),
        //             child: Text('ألبومي',
        //               style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 13.3,
        //                 fontFamily: 'Changa',
        //                 fontWeight: FontWeight.bold,
        //               ),),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        //   GestureDetector(
        //     child: Container(
        //       child: Column(
        //         children: [
        //           Container(
        //             height: 20,
        //             width: 40,
        //             margin: EdgeInsets.only(right: 50, top: 30),
        //             child: IconButton(
        //               icon: Icon(Icons.comment,
        //                 color:comment?Colors.white:Colors.black.withOpacity(0.5),),
        //             ),
        //           ),
        //           Container(
        //             height: 20,
        //             width: 50,
        //             margin: EdgeInsets.only(right: 50, top: 10),
        //             child: Text('تعليقات',
        //               style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 13.3,
        //                 fontFamily: 'Changa',
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ],),
        //bodyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy

        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top:20),
            height: 1200,
            width: 410,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child:Column(
              children: [
                Container(
                  transform: Matrix4.translationValues(0, -60.0, 0),
                  //transform: Matrix4.translationValues(0, -40.0, 0),
                  child: Center(
                    child: CircleAvatar(backgroundImage: NetworkImage(
                        'https://' + IP4 + '/testlocalhost/upload/' + widget.image),
                      radius: 45.0,),),
                ),
                Container(
                  transform: Matrix4.translationValues(0, -55.0, 0),
                  margin: EdgeInsets.only(top: 0),
                  child: Center(
                    child: Text(widget.namefirst + " " + widget.namelast,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18.0,
                        fontFamily: 'Changa',
                        fontWeight: FontWeight.bold,),),
                  ),),
                Container(
                  transform: Matrix4.translationValues(0, -60.0, 0),
                  alignment: Alignment.topRight,
                  child:Center(
                    child:Text(widget.Work,style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontFamily: 'Changa',
                      fontWeight: FontWeight.bold,),),
                  ),
                ),
                Center(
                  child:Container(
                    height: 60,
                    width: 380,
                    transform: Matrix4.translationValues(0, -30.0, 0),
                    padding: EdgeInsets.only(top: 5,right:5),
                    decoration: BoxDecoration(
                      //color: Colors.white,
                      // border: Border.all(
                      //   color: Colors.white,
                      // ),
                    ),
                    child: Row (
                      children: [
                        SizedBox(width: 20,),
                        GestureDetector(
                          child:Column(
                            children: [
                              // Container(
                              //   height: 0,
                              //   margin: EdgeInsets.only(top: 0),
                              //   color: Colors.white,
                              //   child:FutureBuilder(
                              //     future: getComment(),
                              //     builder: (BuildContext context, AsyncSnapshot snapshot) {
                              //       if(snapshot.hasData){
                              //         return ListView.builder(
                              //             itemCount: 1,
                              //             itemBuilder: (context, index) {
                              //               commentnumber=snapshot.data.length;
                              //               return Container();
                              //             }
                              //         );
                              //       }
                              //       return Center(child: CircularProgressIndicator());
                              //     },
                              //   ),
                              // ),
                              Text('عملاء',style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                fontFamily: 'Changa',
                                fontWeight: FontWeight.bold,),),
                              Text(widget.client_num,style: TextStyle(
                                color: Colors.black,
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
                              Text(widget.commentnumber.toString(),style: TextStyle(
                                color: Colors.black,
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
                              Text('منشورات',style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                fontFamily: 'Changa',
                                fontWeight: FontWeight.bold,),),
                              Text(widget.postnumber.toString(),style: TextStyle(
                                color: Colors.black,
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
                                        color: Colors.black,
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
                  ),),
                Container(
                  width: 370,
                  transform: Matrix4.translationValues(0, -0.0, 0),
                  margin: EdgeInsets.only(right:20,),
                  child:Text(widget.Information + ', ' + widget.Experiance +'.',style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.bold,),),
                ),
                Row(
                  children: [
                    GestureDetector(
                            onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) =>
                      Get_Images(
                      phone: widget.phone, name: widget.name)));
                      },
                        child:Container(
                          height: 30,
                          width: 75,
                          margin: EdgeInsets.only(right: 190, top: 40),
                          child: Text('إضافة صورة',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Changa',
                              fontWeight: FontWeight.bold,
                            ),),
                        ),),
                    GestureDetector(
                              onTap: (){
                                _dialogCall(context);
                              },
                              child: Container(
                                height: 30,
                                width: 110,
                                margin: EdgeInsets.only(left:20,right: 0, top: 40),
                                child: Column(
                                  children: [
                                    Text('/  إضافة منشور',
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
                ),
                      Container(
                        height: 270,
                        child:FutureBuilder(
                          future: getImages(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if(snapshot.hasData){
                              return ListView.builder(
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    int num =snapshot.data.length-4;
                                    if(snapshot.data.length==1){
                                      return myAlbum1('https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index]['images']);
                                    }
                                    if(snapshot.data.length==2){
                                      return myAlbum2('https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+1]['images']);
                                    }
                                    if(snapshot.data.length==3){
                                      return myAlbum3('https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+1]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+2]['images']);
                                    }
                                    if(snapshot.data.length==4){
                                      return myAlbum4('https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+1]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+2]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+3]['images']);
                                    }
                                    return myAlbummore('https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+1]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+2]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+3]['images'],num.toString()+"+");
                                  }

                              );
                            }
                            return Center(child: CircularProgressIndicator());
                          },
                        ),
                      ),

                        // GestureDetector(
                        //   onTap: ()async{
                        //     await _dialogCall(context, phone);
                        //   },
                        //   child:Row(
                        //     children: [
                        //       Container(
                        //         margin: EdgeInsets.only(right: 250,left: 10,top:0),
                        //         child:Text("إضافة منشور",
                        //           style: TextStyle(
                        //             color: MY_YELLOW,
                        //             fontSize: 16.0,
                        //             fontFamily: 'Changa',
                        //             fontWeight: FontWeight.bold,
                        //           ),
                        //
                        //         ),),
                        //
                        //       Container(
                        //         margin: EdgeInsets.only(left: 10,top:0),
                        //         child:Icon(Icons.add,size: 25,color: MY_YELLOW,),
                        //       ),
                        //     ],

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
                //             Container(
                //            margin:EdgeInsets.only(left: 5,right: 200),
                //            decoration: BoxDecoration(
                //             color: Colors.white,),
                //            child:Column(
                //               children: [
                //           GestureDetector(
                //             onTap: (){
                //               Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Post(namelast:widget.namelast,image:widget.image,namefirst:widget.namefirst,phone: widget.phone, name: widget.name)));
                //             },
                //           child: Container(
                //             child: Column(
                //               children: [
                //                 Text('عرض المزيد',
                //                   style: TextStyle(
                //                     color: Colors.black87,
                //                     fontSize: 15.0,
                //                     fontFamily: 'Changa',
                //                     fontWeight: FontWeight.bold,
                //                   ),),
                //               ],
                //             ),
                //           ),
                //         )
                //       ],
                //     )
                // ),

              ],),
                         ),),],
                    ),
                  ),);
  }

  Widget image_profile() {
    return Center(
      child: Stack(children: <Widget>[

        image_file != null ? Container(
          decoration: BoxDecoration(
            color: Colors.red,
            image: DecorationImage(image: FileImage(File(image_file.path)),
            ),),) : Container(),
        // Container(
        //   child:Backgroundimage_file==null?AssetImage('assets/icons/signup.jpg'):FileImage(File(image_file.path)),
        //    ),
        // CircleAvatar(
        //   backgroundImage: image_file==null? AssetImage('assets/icons/signup.jpg'):FileImage(File(image_file.path)),
        //   //radius: 60.0,
        // ),
        Positioned(
          child: InkWell(
            onTap: () {
              setState(() {
                showModalBottomSheet(
                  context: context, builder: (builder) => buttom_camera(),);
                // showMyDialogPost();
              });
            },
            child: Icon(Icons.camera_alt, color: Colors.grey, size: 35.0,),),),
      ],
      ),);
  }

  Widget buttom_camera() {
    return Container(
      height: 100.0,
      width: MediaQuery
          .of(context)
          .size
          .width,
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(children: <Widget>[
        Text('Choose Profile Photo'),
        SizedBox(height: 20.0,),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              takePhoto(ImageSource.camera);
            },
            label: Text("Camera"),),
          FlatButton.icon(
            icon: Icon(Icons.image),
            onPressed: () {
              setState(() {
                takePhoto(ImageSource.gallery);
              });
            },
            label: Text("Gallery"),),
        ],),
      ],),
    );
  }

  void takePhoto(ImageSource source) async {
    final file = await image_picker.getImage(
      source: source,
    );
    setState(() {
      if (file == Null) {
        image_file = Image.asset("assets/icons/signup.png") as PickedFile;
      }
      else {
        image_file = file;
      }
      print(image_file.path);
      //showMyDialogPost();

      //image_profile();
    });
  }

  chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      print(pickedFile.path);
      _image.add(File(pickedFile?.path));

      // uploadFile();
    });
    if (pickedFile.path == null) retrieveLostData();
    image_post = true;
    // uploadFile();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file.path));
      });
    } else {
      print(response.file);
    }
  }

  Future uploadFile() async {
    print("hiiii");
    _file = File(_image[counter].path);
    print("hiiii");
    counter++;
    // print(image_file.path);
    if (_file == Null) {
      return;
    }
    print("hiiii");
    String base64 = base64Encode(_file.readAsBytesSync());
    String imagename = _file.path
        .split('/')
        .last;
    print("hiiii");
    print(imagename);
    var url = 'https://' + IP4 + '/testlocalhost/EXP_Image.php';
    // final uri=Uri.parse("https://192.168.2.111/testlocalhost/signup.php");
    var response = await http.post(url, body: {

      "phone": widget.phone,
      "imagename": imagename,
      "image64": base64,
    });
    String massage = json.decode(response.body);
    print(massage);
  }
  myAlbummore(String asset1, String asset2, String asset3, String asset4,
      String more) {
    return Container(
      margin: EdgeInsets.fromLTRB(30,0, 30, 20),
      // padding:EdgeInsets.fromLTRB(5, 0, 5, 0),
      height: 290,
      width: 370,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40.0),
        //border: Border.all(color: MY_BLACK, width: 1.2)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top:5,right: 30,),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10, bottom: 10, top: 10),
                  // margin:  EdgeInsets.only(left:15,right: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      asset2, height: 110,
                      width: 159,
                      fit: BoxFit.cover,),
                  ),),
                Container(
                  margin: EdgeInsets.all(10),
                  // margin:  EdgeInsets.only(left:10,),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      asset1, height: 110,
                      width: 159,
                      fit: BoxFit.cover,),
                  ),),
              ],
            ),),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 0, right: 10, bottom: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      asset3, height: 110,
                      width: 110,
                      fit: BoxFit.cover,),
                  ),),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Get_Images(
                                phone: widget.phone, name: widget.name)));
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10, bottom: 10),
                    child: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            asset4, height: 110,
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
                              child: Text(more, style: TextStyle(
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
        ],),);
  }
  myAlbum4(String asset1, String asset2, String asset3, String asset4) {
    return Container(
      margin: EdgeInsets.fromLTRB(30,0, 30, 20),
      // padding:EdgeInsets.fromLTRB(5, 0, 5, 0),
      height: 250,
      width: 370,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40.0),
          //border: Border.all(color: MY_BLACK, width: 1.2)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top:5,right: 30,),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10, bottom: 10, top: 10),
                  // margin:  EdgeInsets.only(left:15,right: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      asset2, height: 110,
                      width: 159,
                      fit: BoxFit.cover,),
                  ),),
                Container(
                  margin: EdgeInsets.all(10),
                  // margin:  EdgeInsets.only(left:10,),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      asset1, height: 110,
                      width: 159,
                      fit: BoxFit.cover,),
                  ),),
              ],
            ),),
          Container(
            child: Row(
              children: <Widget>[
                 Container(
                    margin: EdgeInsets.only(right: 10, bottom: 10),
                        child:ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            asset3, height: 110,
                            width: 110,
                            fit: BoxFit.cover,),
                        ),),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      asset4, height: 110,
                      width: 209,
                      fit: BoxFit.cover,),
                  ),),
                      ],
                    ),
          ),
              ],),
        );
  }

  myAlbum3(String asset1, String asset2, String asset3) {
    return Container(
      margin: EdgeInsets.fromLTRB(30,0, 30, 20),
      // padding:EdgeInsets.fromLTRB(5, 0, 5, 0),
      height: 290,
      width: 370,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40.0),
        //border: Border.all(color: MY_BLACK, width: 1.2)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top:5,right: 30,),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10, bottom: 10, top:10),
                  // margin:  EdgeInsets.only(left:15,right: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      asset2, height: 110,
                      width: 159,
                      fit: BoxFit.cover,),
                  ),),
                Container(
                  margin: EdgeInsets.all(10),
                  // margin:  EdgeInsets.only(left:10,),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      asset1, height: 110,
                      width: 159,
                      fit: BoxFit.cover,),
                  ),),
              ],
            ),),
          Container(
            child: Row(
              children: <Widget>[
                 Container(
                    margin: EdgeInsets.only(right: 10, bottom: 10),
                    child: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            asset3, height: 110,
                            width: 209,
                            fit: BoxFit.cover,),
                        ),
                      ],
                    ),),
              ],),
          ),
        ],),);
  }
  myAlbum2(String asset1, String asset2) {
    return Container(
      margin: EdgeInsets.fromLTRB(30,0, 30, 20),
      // padding:EdgeInsets.fromLTRB(5, 0, 5, 0),
      height: 180,
      width: 370,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40.0),
        //border: Border.all(color: MY_BLACK, width: 1.2)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top:5,right: 30,),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10, bottom: 10, top: 0),
                  // margin:  EdgeInsets.only(left:15,right: 15),
                  child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          asset1, height: 110,
                          width: 110,
                          fit: BoxFit.cover,),
                      ),),
                Container(
                  margin: EdgeInsets.only(right: 10, bottom: 10, top: 0),
                  child:ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      asset2, height: 110,
                      width: 209,
                      fit: BoxFit.cover,),
                  ),
                ),
                    ],
                  ),
                ),
              ],
      ),);
  }

  myAlbum1(String asset1) {
    return Container(
      margin: EdgeInsets.fromLTRB(30,0, 30, 20),
      // padding:EdgeInsets.fromLTRB(5, 0, 5, 0),
      height: 180,
      width: 370,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40.0),
        //border: Border.all(color: MY_BLACK, width: 1.2)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top:5,right: 30,),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10, bottom: 10, top: 0),
                  // margin:  EdgeInsets.only(left:15,right: 15),
                  child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          asset1, height: 110,
                          width: 159,
                          fit: BoxFit.cover,),
                      ),
                    ),
                  ],),
                ),
              ],
            ),);
  }
  myAlbum0() {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      height: 100,
      width: 400,
      child: Center(child: Text("لا يوجد لديك صور لعرضها",
        style: TextStyle(
          color: Colors.black54,
          fontSize: 17.0,
          fontFamily: 'Changa',
          fontWeight: FontWeight.bold,
        ),),),
     );
  }

  myAlb(String asset) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      height: 130,
      width: 400,
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
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Get_Images(
                                  phone: widget.phone, name: widget.name)));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 190, bottom: 10, top: 10),
                      child: Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              asset, height: 110,
                              width: 150,
                              fit: BoxFit.cover,),
                          ),
                          Positioned(
                            child: Container(
                              height: 110,
                              width: 150,
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

  myAlbum2f(String asset1, String asset2) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      height: 130,
      width: 400,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 0),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),),
        shadowColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Container(
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Get_Images(
                                  phone: widget.phone, name: widget.name)));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10, bottom: 10, top: 10),
                      child: Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              asset1, height: 110,
                              width: 110,
                              fit: BoxFit.cover,),
                          ),
                          Positioned(
                            child: Container(
                              height: 110,
                              width: 110,
                              decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Center(
                                child: Text('معرضي', style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Changa',
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ),
                          )
                        ],
                      ),),),
                  Container(
                    margin: EdgeInsets.only(
                        left: 10, right: 10, bottom: 10, top: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        asset2, height: 110,
                        width: 209,
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

  // myAlbum3(String asset1, String asset2, String asset3) {
  //   return Container(
  //     margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
  //     padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
  //     height: 250,
  //     width: 400,
  //     child: Card(
  //       elevation: 5,
  //       margin: EdgeInsets.symmetric(vertical: 0),
  //       color: Colors.white,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(20),),
  //       shadowColor: Colors.white,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Container(
  //             // margin: EdgeInsets.only(top:5,right: 30,),
  //             child: Row(
  //               children: <Widget>[
  //                 Container(
  //                   margin: EdgeInsets.only(right: 10, bottom: 10, top: 10),
  //                   // margin:  EdgeInsets.only(left:15,right: 15),
  //                   child: ClipRRect(
  //                     borderRadius: BorderRadius.circular(10.0),
  //                     child: Image.network(
  //                       asset2, height: 110,
  //                       width: 159,
  //                       fit: BoxFit.cover,),
  //                   ),),
  //                 Container(
  //                   margin: EdgeInsets.all(10),
  //                   // margin:  EdgeInsets.only(left:10,),
  //                   child: ClipRRect(
  //                     borderRadius: BorderRadius.circular(10.0),
  //                     child: Image.network(
  //                       asset1, height: 110,
  //                       width: 159,
  //                       fit: BoxFit.cover,),
  //                   ),),
  //               ],
  //             ),),
  //           Container(
  //             child: Row(
  //               children: <Widget>[
  //                 GestureDetector(
  //                   onTap: () {
  //                     Navigator.push(context, MaterialPageRoute(
  //                         builder: (BuildContext context) =>
  //                             Get_Images(
  //                                 phone: widget.phone, name: widget.name)));
  //                   },
  //                   child: Container(
  //                     margin: EdgeInsets.only(right: 130, bottom: 10),
  //                     child: Stack(
  //                       overflow: Overflow.visible,
  //                       children: <Widget>[
  //                         ClipRRect(
  //                           borderRadius: BorderRadius.circular(10.0),
  //                           child: Image.network(
  //                             asset3, height: 110,
  //                             width: 209,
  //                             fit: BoxFit.cover,),
  //                         ),
  //                         Positioned(
  //                           child: Container(
  //                             height: 110,
  //                             width: 209,
  //                             decoration: BoxDecoration(
  //                                 color: Colors.black38,
  //                                 borderRadius: BorderRadius.circular(10.0)
  //                             ),
  //                             child: Center(
  //                               child: Text("+0", style: TextStyle(
  //                                 color: Colors.white,
  //                                 fontSize: 20,
  //                               ),),
  //                             ),
  //                           ),
  //                         )
  //                       ],
  //                     ),),),
  //               ],),
  //           ),
  //           // Container(
  //           //  child:Text("ألبومي "),
  //           // ),
  //         ],),),);
  // }

  Future<void> _dialogCall(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyDialog(phone:phone,);
        });
  }
}

class MyDialog extends StatefulWidget {
  @override
  final phone;
  MyDialog({this.phone});
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {

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
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                  width: 70,
                  color: Colors.white,
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 0, right: 170),
                  child:Icon(Icons.close, color: Colors.black.withOpacity(0.5)),
                      ),
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
                    borderSide:  BorderSide(color:Colors.white),

                  ),
                  focusedBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                    borderSide:  BorderSide(color:Colors.white),

                  ),
                  hintText: 'أضف إعلاناتك هنا ',
                  hintStyle: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Changa',
                    color: Colors.black.withOpacity(0.5),
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
                    SizedBox(width: 180),
                    Text('إضافة صورة',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 13.0,
                        fontFamily: 'Changa',
                        fontWeight: FontWeight.bold,
                      ),),
                    Icon(Icons.add_a_photo,color: Colors.black.withOpacity(0.5),),
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
            SizedBox(height:15),
            Container(
              color: Y,
              child:GestureDetector(
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 60),
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
                    senddata();
                    setState(() {
                    });
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
    var url = 'https://'+IP4+'/testlocalhost/add_post.php';
    var ressponse = await http.post(url, body: {
      "text": text_post.text,
      "phone": widget.phone,
      "imagename": imagename,
      "image64": base64,
    });
    String massage= json.decode(ressponse.body);
    print(massage);
    }
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
class CurvePainter extends CustomPainter {

  bool outterCurve;

  CurvePainter(this.outterCurve);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(0xFFF3D657);
    paint.style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.5, outterCurve ? size.height + 110 : size.height - 110, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}