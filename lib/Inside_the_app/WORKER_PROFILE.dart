import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/Inside_the_app/user_Profile.dart';
import 'package:flutterphone/Worker/GET_IMGS.dart';
import 'package:flutterphone/Worker/setting_worker.dart';
import 'package:flutterphone/commons/radial_progress.dart';
import 'package:flutterphone/screens/login_screen.dart';
import 'package:flutterphone/screens/welcome_screen.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

import '../constants.dart';

String  name="";
String  phone="";
String  image="";
String  Work="";
String  Experiance="";
String  Information="";
String  token="";
String IP4="192.168.1.8";

class user_worker extends StatefulWidget {
  final  name;
  final  namefirst;
  final  namelast;
  final  phone;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;


  user_worker({this.name,this.namelast,this.namefirst, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token});
  _user_worker createState() =>  _user_worker();
}
class  _user_worker extends State<user_worker> {
  // AnimationController _animationController;
  void initState() {
    super.initState();
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
  @override
  int _page = 0;
  bool image=false;
  GlobalKey _bottomNavigationKey = GlobalKey();
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return  Directionality( textDirection: TextDirection.rtl,
        child:Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            color: Color(0xFFECCB45),
            buttonBackgroundColor: Color(0xFFECCB45),
            backgroundColor: MY_BLACK,
            height: 48,
            key: _bottomNavigationKey,
            items: <Widget>[
              Icon(Icons.home, size: 25),
              Icon(Icons.settings, size: 25),
              Icon(Icons.playlist_add_check, size: 25),
              Icon(Icons.notifications, size: 25),
              Icon(Icons.logout, size: 25),
            ],
            onTap: (index) {
              setState(() {
                _page = index;
                if (_page == 0) {
                  // print(List2);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) =>
                          U_PROFILE(name: widget.name,)));
                }
                // if(_page==1){
                //   Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>SettingPage(name: widget.name,phone: phone,image: image,Work: Work,Experiance: Experiance,Information: Information,token: token,)));
                // }
              });
            },
          ),
          backgroundColor: Color(0xFF1C1C1C),
          key: _scaffoldKey,
          appBar: AppBar(
            automaticallyImplyLeading: false, // this will hide Drawer hamburger icon
            elevation: 0,
            backgroundColor:  Color(0xFFECCB45),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                onPressed: () => _scaffoldKey.currentState.openDrawer(),
                icon: Icon(Icons.menu),)
            ],
          ),
          // backgroundColor: Colors.lightBlueAccent,
          body: Form(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top:0),
                    //transform: Matrix4.translationValues(0, 5.0, 0),
                    child:Center(
                      child:CircleAvatar(backgroundImage: NetworkImage('https://'+IP4+'/testlocalhost/upload/'+widget.image),radius: 35.0,),),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:10),
                    child:Center(
                      child: Text(widget.namefirst+ " "+widget.namelast,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontFamily: 'Changa',
                          fontWeight: FontWeight.bold,),),
                    ),),
                  Row(children: [
                    GestureDetector(

                      child:Container(
                        child:Column(
                          children: [
                            Container(
                              height: 20,
                              width: 40,
                              margin: EdgeInsets.only(right: 50,top:30),
                              child: IconButton(
                                icon:Icon(Icons.person),
                              ),
                            ),
                            Container(
                              height: 20,
                              width: 25,
                              margin: EdgeInsets.only(right: 50,top:10),
                              child: Text('حول',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.3,
                                  fontFamily: 'Changa',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      child:Container(
                        child:Column(
                          children: [
                            Container(
                              height: 20,
                              width: 40,
                              margin: EdgeInsets.only(right: 50,top:30),
                              child: IconButton(
                                icon:Icon(Icons.my_library_books_sharp),
                              ),
                            ),
                            Container(
                              height: 20,
                              width: 60,
                              margin: EdgeInsets.only(right: 50,top:10),
                              child: Text('منشورات',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.3,
                                  fontFamily: 'Changa',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        setState(() {
                          image=true;
                        });
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => PROFILE(name: widget.name,profile:1,)),);
                      },
                      child:Container(
                        child:Column(
                          children: [
                            Container(
                              height: 20,
                              width: 40,
                              margin: EdgeInsets.only(right: 50,top:30),
                              child: IconButton(
                                icon:Icon(Icons.image,
                                  color: image==true?MY_BLACK:Color(0xFF716C10),),
                              ),
                            ),
                            Container(
                              height: 20,
                              width: 25,
                              margin: EdgeInsets.only(right: 50,top:10),
                              child: Text('صور',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.3,
                                  fontFamily: 'Changa',
                                  fontWeight: FontWeight.bold,
                                ),),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      child:Container(
                        child:Column(
                          children: [
                            Container(
                              height: 20,
                              width: 40,
                              margin: EdgeInsets.only(right: 50,top:30),
                              child: IconButton(
                                icon:Icon(Icons.comment),
                              ),
                            ),
                            Container(
                              height: 20,
                              width: 50,
                              margin: EdgeInsets.only(right: 50,top:10),
                              child: Text('تعليقات',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.3,
                                  fontFamily: 'Changa',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],),

],),),),) );
  }
  myAlbum(String asset1, String asset2, String asset3, String asset4, String more){
    return Container(
      margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
      // padding:EdgeInsets.fromLTRB(5, 0, 5, 0),
      height:290,
      width:370,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40.0),
          border: Border.all(color: Colors.grey, width: 1.2)
      ),
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
                    margin: EdgeInsets.only(right: 10,bottom: 10),
                    child:Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            asset4, height: 110,
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
                              child: Text(more, style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),),
                            ),
                          ),
                        )
                      ],
                    ),),),
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                  child:ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      asset4, height: 110,
                      width:209,
                      fit: BoxFit.cover,),
                  ),),
              ],),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            padding: EdgeInsets.only(left: 230),
            child:Text("ألبومي ",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16.0,
                fontFamily: 'Changa',
                fontWeight: FontWeight.bold,
              ),),
          ),
        ],),);
  }

  myAlbum0(){
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
              child:Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>Get_Images(phone:widget.phone,name:widget.name)));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10,bottom: 10),
                      child:Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              'assets/icons/signup.jpg', height: 110,
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
                                child: Text("انقر لإضافة صور", style: TextStyle(
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
  myAlbum1(String asset){
    return Container(
      margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
      padding:EdgeInsets.fromLTRB(15, 0, 15, 0),
      height:130,
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
              child:Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>Get_Images(phone:widget.phone,name:widget.name)));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 190,bottom: 10,top:10),
                      child:Stack(
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
  myAlbum2(String asset1,String asset2){
    return Container(
      margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
      padding:EdgeInsets.fromLTRB(15, 0, 15, 0),
      height:130,
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
              child:Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>Get_Images(phone:widget.phone,name:widget.name)));
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
                          Positioned(
                            child: Container(
                              height: 110,
                              width: 110,
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


