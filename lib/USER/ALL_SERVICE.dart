import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/ChatUuser/chatListUser.dart';
import 'package:flutterphone/Inside_the_app/Comment.dart';
import 'package:flutterphone/Inside_the_app/List_worker_group.dart';
import 'package:flutterphone/Inside_the_app/WORKER_PROFILE.dart';
import 'package:flutterphone/USER/search_user.dart';
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
import '../buttom_bar.dart';
import '../constants.dart';
import '../database.dart';

String  name_Me="";
String  name="";
String  phone="";
String  image="";
String namefirst="";
String namelast="";
String Country="";
String  token="";
String IP4="192.168.1.8";

class All_Service extends StatefulWidget {
  final name_Me;
  final country;
  final namefirst;
  final namelast;
  final image;
  final phone;
  final token;
  All_Service({this.token,this.name_Me,this.country,this.namefirst,this.namelast,this.image,this.phone});
  _All_Service createState() =>  _All_Service();
}
class  _All_Service extends State<All_Service> {
  // AnimationController _animationController;
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  final List1 = [];
  var ListDate1 = [];
  final List2 = [];
  var ListDate2 = [];
  var ListBlock=["8.00 - 9.00 ","9.00 - 10.00","","","",];
  var Listsearch=[];
   bool methode=true;
  @override
  void initState() {
    super.initState();
    // getChat();
  }
  Future getdata()async{
    var url='https://'+IP4+'/testlocalhost/all_worker.php';
    var ressponse=await http.get(url);
    var responsepody= json.decode(ressponse.body);
    return responsepody;
  }
  int _selectedIndex = 0;
  PageController _pageController;
  DatabaseMethods databaseMethods=new DatabaseMethods();
  Stream chatsRoom;
  @override
  int _selectedItem = 0;
  Widget build(BuildContext context) {
    print(Listsearch.toString());
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Directionality(textDirection: ui.TextDirection.rtl,
      child:Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
            key: _scaffoldKey,
            body: Form(
              // child:SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,)));
                    },
                    child:Container(
                      margin:EdgeInsets.only(top:70,left: 370),
                      child:Icon(Icons.arrow_back,color: Colors.black,),
                    )
                  ),
                  Container(
                    margin:EdgeInsets.only(top:20),
                    child:Row(
                      children: [
                        SizedBox(width: 30,),
                        Container(
                          child: Text('جميع الخدمات',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Changa',
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        SizedBox(width: 195,),
                        GestureDetector(
                          onTap: (){
                            methode=!methode;
                            setState(() {

                            });
                          },
                          child: Container(
                              child:Icon(Icons.grid_view,color: methode?Y:Colors.black54,size:25,)
                          ),
                        ),
                        SizedBox(width: 20,),
                        GestureDetector(
                            onTap: (){
                              methode=!methode;
                              setState(() {

                              });
                            },
                            child: Directionality(
                              textDirection: ui.TextDirection.rtl,
                              child:Container(
                                  child:Icon(Icons.format_list_bulleted_sharp,color: methode?Colors.black54:Y,size:25,)
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                  // Image.asset(
                  //   "assets/icons/ho.jpg",
                  //   height:250,
                  //   width:450,
                  //   fit: BoxFit.fill,
                  // ),
                  methode? Servis(token:widget.token,country:widget.country,image:widget.image,namelast:widget.namelast,namefirst:widget.namefirst,phone:widget.phone,name_Me:widget.name_Me,):  Container(
                    height: 655,
                    margin: EdgeInsets.only(top: 0),
                    decoration: BoxDecoration(
                      color:  Colors.white,
                      // color:Color(0xFF1C1C1C),
                      // borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(50),
                      //   topRight: Radius.circular(50),
                      // ),
                    ),
                    child: FutureBuilder(
                      future: getCount(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              String najarnum="0";
                              String elecnum="0";
                              String balnum="0";
                              String sabaknum="0";
                              String dahannum="0";
                              String mecnum="0";
                              for(int i=0;i<snapshot.data.length;i++){
                                if(snapshot.data[i]['work']=="نجار"){najarnum=snapshot.data[i]['count'].toString();}
                                else if(snapshot.data[i]['work']=="كهربائي"){elecnum=snapshot.data[i]['count'].toString();}
                              }
                              return Servish(token:widget.token,country:widget.country,image:widget.image,namelast:widget.namelast,namefirst:widget.namefirst,phone:widget.phone,name_Me:widget.name_Me,najarnum:najarnum,elecnum:elecnum,sabaknum:sabaknum,dahannum:dahannum,mecnum:mecnum,balnum:balnum,);
                            },
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ],),),),],),);
  }
  Future getCount() async {
    var url = 'https://' + IP4 + '/testlocalhost/countservice.php';
    var ressponse = await http.post(url, body: {
      "name": widget.name_Me,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
}

class Servis extends StatefulWidget{
  final List<dynamic>Search;
  final name_Me;
  final country;
  final namefirst;
  final namelast;
  final image;
  final phone;
  final token;
  Servis({this.token,this.Search,this.name_Me,this.country,this.namefirst,this.namelast,this.image,this.phone});
  _Servis createState() =>  _Servis();
}
class  _Servis extends State<Servis> {
  // AnimationController _animationController;
  int _page = 0;
  var Listsearch=[];
  List<String> _filterList;
  var _searchview = new TextEditingController();

  bool _firstSearch = true;
  String _query = "";
  _Servis() {
    //Register a closure to be called when the object changes.
    _searchview.addListener(() {
      if (_searchview.text.isEmpty) {
        //Notify the framework that the internal state of this object has changed.
        setState(() {
          _firstSearch = true;
          _query = "bvn";
        });
      } else {
        setState(() {
          _firstSearch = false;
          _query = _searchview.text;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
   return SingleChildScrollView(
     child:Container(
       height: 615,
       width: 450,
       // color:  Color(0xFFF3D657),
       margin: EdgeInsets.only(top:40),
       padding:EdgeInsets.only(right:25,left: 25),
       decoration: BoxDecoration(
         // color:Color(0xFF1C1C1C),
         // borderRadius: BorderRadius.only(
         //   topLeft: Radius.circular(50),
         //   topRight: Radius.circular(50),
         // ),
       ),
         child:Column(
           children: [
             Row(
               children: [
                 RecomendPlantCard1(
                   image: "assets/work/mec.png",
                   title: "ميكانيك",
                   press: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work: 'ميكانيك',name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);
                   },
                 ),
                 RecomendPlantCard2(
                   image: "assets/work/najar.png",
                   title: "نجّار",
                   press: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work: 'نجار',name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);
                     },
                 ),
               ],
             ),
             Row(
               children: [
                 RecomendPlantCard3(
                   image: "assets/work/dahan.png",
                   title: "دهّان",
                   press: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work: 'دهان',name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);
                   },
                 ),
                 RecomendPlantCard4(
                   image: "assets/work/bal.png",
                   title: "تبليط / تركيب ",
                   press: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work: 'بلييط',name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);
                   },
                 ),
               ],
             ),
             Row(
               children: [
                 RecomendPlantCard5(
                   image: "assets/work/sabak.png",
                   title: "سبّاك",
                   press: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work: 'سباك',name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);
                   },
                 ),
                 RecomendPlantCard6(
                   image: "assets/work/ele.png",
                   title: "كهربائي",
                   press: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work: 'كهربائي',name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);
                   },
                 ),
               ],
             ),
             Row(
               children: [
                 RecomendPlantCard5(
                   image: "assets/work/sabak.png",
                   title: "سبّاك",
                   press: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work: 'سباك',name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);
                   },
                 ),
                 RecomendPlantCard6(
                   image: "assets/work/ele.png",
                   title: "كهربائي",
                   press: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work: 'كهربائي',name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);
                   },
                 ),
               ],
             ),

           ],
         ),
       ),
   );
  }
}

class Servish extends StatefulWidget{
  final List<dynamic>Search;
  final name_Me;
  final country;
  final namefirst;
  final namelast;
  final image;
  final phone;
  final token;
  final najarnum;
  final elecnum;
  final balnum;
  final sabaknum;
  final dahannum;
  final mecnum;

  Servish({this.mecnum,this.najarnum,this.elecnum,this.balnum,this.sabaknum,this.dahannum,this.token,this.Search,this.name_Me,this.country,this.namefirst,this.namelast,this.image,this.phone});
  _Servish createState() =>  _Servish();
}
class  _Servish extends State<Servish> {
  // AnimationController _animationController;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 640,
      width: 450,
      decoration: BoxDecoration(
        color:Colors.white,
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(50),
        //   topRight: Radius.circular(50),
        // ),
      ),
        child:
        SingleChildScrollView(
          child:Column(
          children: [

                RecomendPlantCardh1(
                  image: "assets/work/mec.png",
                  title: "ميكانيك",
                  num:widget.mecnum,
                  press: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work: 'ميكانيك',name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);
                  },
                ),
                RecomendPlantCardh2(
                  image: "assets/work/najar.png",
                  title: "نجّار",
                  num:widget.najarnum,
                  press: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work: 'نجار',name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);
                  },
                ),
                RecomendPlantCardh3(
                  image: "assets/work/dahan.png",
                  title: "دهّان",
                  num:widget.dahannum,
                  press: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work: 'دهان',name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);
                  },
                ),
                RecomendPlantCardh4(
                  image: "assets/work/bal.png",
                  title: "تبليط / تركيب ",
                  num:widget.balnum,
                  press: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work: 'بلييط',name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);
                  },
                ),
                RecomendPlantCardh5(
                  image: "assets/work/sabak.png",
                  title: "سبّاك",
                  num:widget.sabaknum,
                  press: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work: 'سباك',name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);
                  },
                ),
                RecomendPlantCardh6(
                  image: "assets/work/ele.png",
                  title: "كهربائي",
                  num:widget.elecnum,
                  press: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work: 'كهربائي',name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);
                  },
                ),
                RecomendPlantCardh5(
                  image: "assets/work/sabak.png",
                  title: "سبّاك",
                  num:widget.sabaknum,
                  press: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work: 'سباك',name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);
                  },
                ),
                RecomendPlantCardh6(
                  image: "assets/work/ele.png",
                  title: "كهربائي",
                  num:widget.elecnum,
                  press: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work: 'كهربائي',name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);
                  },
                ),
            SizedBox(height: 30,),

        ],),
      ),
    );
  }
}



class RecomendPlantCard1 extends StatelessWidget {
  RecomendPlantCard1({
    Key key,
    this.image,
    this.title,
    this.press,
  }) : super(key: key);

  final String image, title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    List<Colors> Color=[];
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 20, top: 10, bottom: 10,right: 0),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child:Stack(
              children:<Widget>[
                // Icon(Icons.paint),
                Container(
                  width: 170,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomRight:  Radius.circular(10),
                      bottomLeft:  Radius.circular(10),
                    ),
                    color: Colors.grey[100],
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [X1,X3]
                    ),
                  ),
                  child:  Center(
                    child:Column(
                      children: [
                        Container(
                          height: 70,
                          width: 90,
                          margin: EdgeInsets.only(top: 10),
                          child:ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              image, height: 90,
                              width: 100,
                              // color: Colors.white,
                              fit: BoxFit.contain,),
                          ),),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child:Center(
                            child:Text(title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Changa',
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),),),
                      ],
                    ),),
                ),
              ],),
          ),
        ],),
    );
  }
}

class RecomendPlantCard2 extends StatelessWidget {
  RecomendPlantCard2({
    Key key,
    this.image,
    this.title,
    this.press,
  }) : super(key: key);

  final String image, title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    List<Colors> Color=[];
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 0, top: 10, bottom: 10,right: 0),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child:Stack(
              children:<Widget>[
                // Icon(Icons.paint),
                Container(
               width: 170,
               height: 130,
                decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight:  Radius.circular(10),
                  bottomLeft:  Radius.circular(10),
                ),
                    color: Colors.grey[100],
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [red1,red2]
                    ),
                  ),
                  child:Center(
                    child:Column(
                      children: [
                        Container(
                          height: 60,
                          width: 70,
                          margin: EdgeInsets.only(top: 20),
                          child:ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              image, height: 90,
                              width: 100,
                              // color: Colors.white,
                              fit: BoxFit.contain,),
                          ),),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child:Center(
                            child:Text(title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Changa',
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),),),
                      ],
                    ),
                  ),),
              ],),
          ),
        ],),
    );
  }
}

class RecomendPlantCard3 extends StatelessWidget {
  RecomendPlantCard3({
    Key key,
    this.image,
    this.title,
    this.press,
  }) : super(key: key);

  final String image, title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    List<Colors> Color=[];
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 20, top: 10, bottom: 10,right: 0),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child:Stack(
              children:<Widget>[
                // Icon(Icons.paint),
                Container(
                  width: 170,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomRight:  Radius.circular(10),
                      bottomLeft:  Radius.circular(10),

                    ),
                    color: Colors.grey[100],
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [blue1,blue2]
                    ),
                  ),
                  child:Center(
                    child:Column(
                      children: [
                        Container(
                          height: 60,
                          width: 70,
                          margin: EdgeInsets.only(top: 20),
                          child:ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              image, height: 90,
                              width: 100,
                              // color: Colors.white,
                              fit: BoxFit.contain,),
                          ),),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child:Center(
                            child:Text(title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Changa',
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),),),
                      ],
                    ),
                  ),),
              ],),
          ),
        ],),
    );
  }
}

class RecomendPlantCard4 extends StatelessWidget {
  RecomendPlantCard4({
    Key key,
    this.image,
    this.title,
    this.press,
  }) : super(key: key);

  final String image, title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    List<Colors> Color=[];
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 0, top: 10, bottom: 10,right: 0),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child:Stack(
              children:<Widget>[
                // Icon(Icons.paint),
                Container(
                  width: 170,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomRight:  Radius.circular(10),
                      bottomLeft:  Radius.circular(10),
                    ),
                    color: Colors.grey[100],
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [green1,green2]
                    ),
                  ),
                  child:Center(
                    child:Column(
                      children: [
                        Container(
                          height: 60,
                          width: 70,
                          margin: EdgeInsets.only(top: 20),
                          child:ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              image, height: 90,
                              width: 100,
                              // color: Colors.white,
                              fit: BoxFit.contain,),
                          ),),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child:Center(
                            child:Text(title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Changa',
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),),),
                      ],
                    ),
                  ),),
              ],),
          ),
        ],),
    );
  }
}

class RecomendPlantCard5 extends StatelessWidget {
  RecomendPlantCard5({
    Key key,
    this.image,
    this.title,
    this.press,
  }) : super(key: key);

  final String image, title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    List<Colors> Color=[];
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 20, top: 10, bottom: 10,right: 0),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child:Stack(
              children:<Widget>[
                // Icon(Icons.paint),
                Container(
                  width: 170,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomRight:  Radius.circular(10),
                      bottomLeft:  Radius.circular(10),
                    ),
                    color: Colors.grey[100],
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [perp1,perp2]
                    ),
                  ),
                  child:Center(
                    child:Column(
                      children: [
                        Container(
                          height: 60,
                          width: 70,
                          margin: EdgeInsets.only(top: 20),
                          child:ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              image, height: 90,
                              width: 100,
                              // color: Colors.white,
                              fit: BoxFit.contain,),
                          ),),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child:Center(
                            child:Text(title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Changa',
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),),),
                      ],
                    ),
                  ),
                ),
              ],),
          ),
        ],),
    );
  }
}

class RecomendPlantCard6 extends StatelessWidget {
  RecomendPlantCard6({
    Key key,
    this.image,
    this.title,
    this.press,
  }) : super(key: key);

  final String image, title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    List<Colors> Color=[];
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 0, top: 10, bottom: 10,right: 0),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child:Stack(
              children:<Widget>[
                // Icon(Icons.paint),
                Container(
                  width: 170,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomRight:  Radius.circular(10),
                      bottomLeft:  Radius.circular(10),
                    ),
                    color: Colors.grey[100],
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [X1,X3]
                    ),
                  ),
                  child:  Center(
                    child:Column(
                      children: [
                        Container(
                          height: 60,
                          width: 70,
                          margin: EdgeInsets.only(top: 20),
                          child:ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              image, height: 90,
                              width: 100,
                              // color: Colors.white,
                              fit: BoxFit.contain,),
                          ),),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child:Center(
                            child:Text(title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Changa',
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),),),
                      ],
                    ),),
                ),
              ],),
          ),
        ],),
    );
  }
}


class RecomendPlantCardh1 extends StatelessWidget {
  RecomendPlantCardh1({
    Key key,
    this.image,
    this.title,
    this.num,
    this.press,
  }) : super(key: key);

  final String image, title,num;
  final Function press;

  @override
  Widget build(BuildContext context) {
    List<Colors> Color=[];
    Size size = MediaQuery.of(context).size;
    return Container(
      width: 365,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomRight:  Radius.circular(10),
          bottomLeft:  Radius.circular(10),
        ),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [X3,X1]
        ),
      ),
      margin: EdgeInsets.only(left: 10, top: 0, bottom: 20,right: 10),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child:Row(
              children:<Widget>[
                // Icon(Icons.paint),
                        SizedBox(width:10,),
                        Container(
                          height: 80,
                          width: 78,
                          margin: EdgeInsets.only(top: 10),
                          child:ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              image, height: 90,
                              width: 100,
                              // color: Colors.white,
                              fit: BoxFit.contain,),
                          ),),
                        SizedBox(width:10,),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child:Center(
                            child:Text(title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Changa',
                                color: Colors.white,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),),),
                            SizedBox(width:168,),
                          Container(
                            margin:EdgeInsets.only(top:10),
                            child:Text("("+num+")",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Changa',
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),),
              ],),
    );
  }
}

class RecomendPlantCardh2 extends StatelessWidget {
  RecomendPlantCardh2({
    Key key,
    this.image,
    this.title,
    this.num,
    this.press,
  }) : super(key: key);

  final String image, title,num;
  final Function press;

  @override
  Widget build(BuildContext context) {
    List<Colors> Color=[];
    Size size = MediaQuery.of(context).size;
    return Container(
      width: 365,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomRight:  Radius.circular(10),
          bottomLeft:  Radius.circular(10),
        ),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [red2,red1]
        ),
      ),
      margin: EdgeInsets.only(left: 10, top: 0, bottom: 20,right: 10),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child:Row(
              children:<Widget>[
                // Icon(Icons.paint),
                SizedBox(width:15,),
                Container(
                  height: 60,
                  width: 60,
                  margin: EdgeInsets.only(top: 20),
                  child:ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      image, height: 90,
                      width: 100,
                      // color: Colors.white,
                      fit: BoxFit.contain,),
                  ),),
                SizedBox(width:25,),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child:Center(
                    child:Text(title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),),),
                SizedBox(width:195,),
                Container(
                  margin:EdgeInsets.only(top:10),
                  child:Text("("+num+")",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Changa',
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),),
        ],),
    );
  }
}

class RecomendPlantCardh3 extends StatelessWidget {
  RecomendPlantCardh3({
    Key key,
    this.image,
    this.title,
    this.num,
    this.press,
  }) : super(key: key);

  final String image, title,num;
  final Function press;

  @override
  Widget build(BuildContext context) {
    List<Colors> Color=[];
    Size size = MediaQuery.of(context).size;
    return Container(
      width: 365,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomRight:  Radius.circular(10),
          bottomLeft:  Radius.circular(10),
        ),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [blue2,blue1]
        ),
      ),
      margin: EdgeInsets.only(left: 10, top: 0, bottom: 20,right: 10),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child:Row(
              children:<Widget>[
                // Icon(Icons.paint),
                SizedBox(width:10,),
                Container(
                  height: 60,
                  width: 60,
                  margin: EdgeInsets.only(top: 20),
                  child:ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      image, height: 90,
                      width: 100,
                      // color: Colors.white,
                      fit: BoxFit.contain,),
                  ),),
                SizedBox(width:30,),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child:Center(
                    child:Text(title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),),),
                SizedBox(width:183,),
                Container(
                  margin:EdgeInsets.only(top:10,),
                  child:Text("("+num+")",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Changa',
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),),
        ],),
    );
  }
}

class RecomendPlantCardh4 extends StatelessWidget {
  RecomendPlantCardh4({
    Key key,
    this.image,
    this.title,
    this.num,
    this.press,
  }) : super(key: key);

  final String image, title,num;
  final Function press;

  @override
  Widget build(BuildContext context) {
    List<Colors> Color=[];
    Size size = MediaQuery.of(context).size;
    return Container(
      width: 365,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomRight:  Radius.circular(10),
          bottomLeft:  Radius.circular(10),
        ),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [green2,green1]
        ),
      ),
      margin: EdgeInsets.only(left: 10, top: 0, bottom: 20,right: 10),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child:Row(
              children:<Widget>[
                // Icon(Icons.paint),
                SizedBox(width:15,),
                Container(
                  height: 60,
                  width: 60,
                  margin: EdgeInsets.only(top: 20),
                  child:ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      image, height: 90,
                      width: 100,
                      // color: Colors.white,
                      fit: BoxFit.contain,),
                  ),),
                SizedBox(width:25,),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child:Center(
                    child:Text(title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),),),
                SizedBox(width:125,),
                Container(
                  margin:EdgeInsets.only(top:10),
                  child:Text("("+num+")",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Changa',
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),),
        ],),
    );
  }
}
class RecomendPlantCardh5 extends StatelessWidget {
  RecomendPlantCardh5({
    Key key,
    this.image,
    this.title,
    this.num,
    this.press,
  }) : super(key: key);

  final String image, title,num;
  final Function press;

  @override
  Widget build(BuildContext context) {
    List<Colors> Color=[];
    Size size = MediaQuery.of(context).size;
    return Container(
      width: 365,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomRight:  Radius.circular(10),
          bottomLeft:  Radius.circular(10),
        ),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [perp2,perp1]
        ),
      ),
      margin: EdgeInsets.only(left: 10, top: 0, bottom: 20,right: 10),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child:Row(
              children:<Widget>[
                // Icon(Icons.paint),
                SizedBox(width:15,),
                Container(
                  height: 60,
                  width: 60,
                  margin: EdgeInsets.only(top: 20),
                  child:ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      image, height: 90,
                      width: 100,
                      // color: Colors.white,
                      fit: BoxFit.contain,),
                  ),),
                SizedBox(width:25,),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child:Center(
                    child:Text(title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),),),
                SizedBox(width:182,),
                Container(
                  margin:EdgeInsets.only(top:10),
                  child:Text("("+num+")",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Changa',
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),),
        ],),
    );
  }
}

class RecomendPlantCardh6 extends StatelessWidget {
  RecomendPlantCardh6({
    Key key,
    this.image,
    this.title,
    this.num,
    this.press,
  }) : super(key: key);

  final String image, title,num;
  final Function press;

  @override
  Widget build(BuildContext context) {
    List<Colors> Color=[];
    Size size = MediaQuery.of(context).size;
    return Container(
      width: 365,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomRight:  Radius.circular(10),
          bottomLeft:  Radius.circular(10),
        ),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [X3,X1]
        ),
      ),
      margin: EdgeInsets.only(left: 10, top: 0, bottom: 20,right: 10),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child:Row(
              children:<Widget>[
                // Icon(Icons.paint),
                SizedBox(width:15,),
                Container(
                  height: 60,
                  width: 60,
                  margin: EdgeInsets.only(top: 20),
                  child:ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      image, height: 90,
                      width: 100,
                      // color: Colors.white,
                      fit: BoxFit.contain,),
                  ),),
                SizedBox(width:25,),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child:Center(
                    child:Text(title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),),),
                SizedBox(width:165,),
                Container(
                  margin:EdgeInsets.only(top:10),
                  child:Text("("+num+")",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Changa',
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),),
        ],),
    );
  }
}
