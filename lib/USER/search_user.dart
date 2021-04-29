import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterphone/USER/user_Profile.dart';
import 'package:flutterphone/USER/userLocation.dart';
import 'package:flutterphone/USER/userlocation_avalibel.dart';
import 'package:flutterphone/USER/userlocation_avalibel_rate.dart';
import 'package:flutterphone/USER/userlocation_rate.dart';
import 'package:flutterphone/components/Drop_Down_country.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import '../constants.dart';
import 'Comment.dart';
import 'WORKER_PROFILE.dart';
String IP4="192.168.1.8";

String country_choose;
//Our MyApp class. Represents our application
//Represents the Homepage widget
class Search_user extends StatefulWidget {
  final work;
  final name_Me;
  final namefirst_Me;
  final nameLast_Me;
  final phone_Me;
  final image_Me;
  final token_Me;
  final location;
  final country;
  Search_user({this.country,this.token_Me,this.image_Me,this.namefirst_Me,this.nameLast_Me,this.phone_Me,this.work,this.name_Me,this.location});
  //`createState()` will create the mutable state for this widget at
  //a given location in the tree.
  @override
  _HomeState createState() => _HomeState();
}

//Our Home state, the logic and internal state for a StatefulWidget.
class _HomeState extends State<Search_user> {
  //A controller for an editable text field.
  //Whenever the user modifies a text field with an associated
  //TextEditingController, the text field updates value and the
  //controller notifies its listeners.
  var _searchview = new TextEditingController();

  bool _firstSearch = true;
  String _query = "";

  List<String> _nebulae;
  List<String> _filterList;
  OverlayEntry floatingDropdown_country;
  bool isDropdownOpened_country=false;
  String country_id;
  String hint="اختيار المنطقة";
  List<String>country=["جنين","نابلس","طولكرم","رام الله","طوباس","حيفا","يافا","عكا","الخليل","قلقيلية","جميع المناطق"];
  OverlayEntry _createFloatingDropdown_coutry() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: 10,
        top: 180,
        //right: 40,
        height: 500,

        child: Container(
          //color: Colors.red,
          child: Drop_country(),
        ),
      );
    });
  }
  double roundDouble(double value, int places){
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
  @override
  void initState() {
    super.initState();
    country_id=widget.country;
  }
  var Listsearch=[];
  Future getdata()async{
    var url='https://'+IP4+'/testlocalhost/all_worker.php';
    var ressponse=await http.get(url);
    var responsepody= json.decode(ressponse.body);
    return responsepody;
  }
  _HomeState() {
    //Register a closure to be called when the object changes.
    _searchview.addListener(() {
      if (_searchview.text.isEmpty) {
        //Notify the framework that the internal state of this object has changed.
        setState(() {
          _firstSearch = true;
          _query = "";
        });
      } else {
        setState(() {
          _firstSearch = false;
          _query = _searchview.text;
        });
      }
    });
  }
  Future getSearchall()async{
    var url='https://'+IP4+'/testlocalhost/search_all_work.php';
    var ressponse=await http.post(url,body: {
      "Work":widget.work,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  Future getSearchall_rate()async{
    var url='https://'+IP4+'/testlocalhost/searchall_rate.php';
    var ressponse=await http.post(url,body: {
      "Work":widget.work,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  Future getSearchavalibel()async{
    var url='https://'+IP4+'/testlocalhost/searchavalibel.php';
    var ressponse=await http.post(url,body: {
      "Work":widget.work,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  Future getSearchavalibel_rate()async{
    var url='https://'+IP4+'/testlocalhost/searchavalibal_rate.php';
    var ressponse=await http.post(url,body: {
      "Work":widget.work,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  Future getSearchcoutry(String country)async{
    var url='https://'+IP4+'/testlocalhost/searchcoutry.php';
    var ressponse=await http.post(url,body: {
      "Work":widget.work,
      "country":country,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  Future getSearchcoutry_rate(String country)async{
    var url='https://'+IP4+'/testlocalhost/searchcountry_rate.php';
    var ressponse=await http.post(url,body: {
      "Work":widget.work,
      "country":country,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  Future searchavalibelcountry(String country)async{
    var url='https://'+IP4+'/testlocalhost/searchavalibelcountry.php';
    var ressponse=await http.post(url,body: {
      "Work":widget.work,
      "country":country,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  Future searchcountry_avalibel_rate(String country)async{
    var url='https://'+IP4+'/testlocalhost/searchcountry_avalibel_rate.php';
    var ressponse=await http.post(url,body: {
      "Work":widget.work,
      "country":country,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  bool button1=true;
  bool button2=false;
  bool button3=false;
  bool button4=true;
  bool button5=false;
//Build our Home widget
  @override
  Widget build(BuildContext context) {
    print(widget.name_Me);
    print(widget.nameLast_Me);
    print(widget.namefirst_Me);
    print(widget.phone_Me);
    print(widget.token_Me);

    return Directionality(
      textDirection: TextDirection.rtl,
      child:Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: new AppBar(
          backgroundColor: Y,
          leading:GestureDetector(
            onTap:(){
              Navigator.pop(context,);
             // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,)));
            },
            child:Icon(Icons.arrow_back,color: Colors.white,),
          ),
          title: new Text(widget.work,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Changa',
              color: Colors.white,
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: 5,
              child: FutureBuilder(
                  future: getdata(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      print("has data================================================================================================");
                      return ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          Listsearch=snapshot.data;
                          print(snapshot.data.length);
                          return Container();
                        },);
                    }
                    return Center(child: CircularProgressIndicator());
                  }
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: 30,
              width: 350,
              margin: EdgeInsets.only(left: 10.0, right: 20.0, top: 100),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        button2=false;
                        button1=!button1;
                        setState(() {

                        });
                      },
                      child: Container(
                        width:50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:button1==true?Y:Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('الكل',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Changa',
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width:20,),
                    GestureDetector(
                      onTap: (){
                        button1=false;
                        button2=!button2;
                        setState(() {

                        });
                      },
                      child: Container(
                        width:70,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:button2==true?Y:Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('المتاحين',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Changa',
                            color: Colors.black87,
                          ),
                        ),

                      ),
                    ),
                    SizedBox(width:20,),
                    GestureDetector(
                      onTap: (){
                        button3=!button3;
                        setState(() {

                        });
                      },
                      child: Container(
                        width: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:button3==true?Y:Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('الريت',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Changa',
                            color: Colors.black87,
                          ),
                        ),

                      ),
                    ),
                    SizedBox(width: 20,),
                    GestureDetector(
                      onTap: (){
                        button4=!button4;
                        button5=false;
                        setState(() {

                        });
                      },
                      child: Container(
                        width: 120,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:button4==true?Y:Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 10,),
                            Text(country_id,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'Changa',
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  if (isDropdownOpened_country) {
                                    floatingDropdown_country.remove();
                                  } else {
                                    //findDropdownData();
                                    floatingDropdown_country = _createFloatingDropdown_coutry();
                                    Overlay.of(context).insert(floatingDropdown_country);
                                  }
                                  isDropdownOpened_country = !isDropdownOpened_country;
                                });
                              },
                              child:Icon(
                              Icons.arrow_drop_down_outlined,
                              color: Colors.black,
                              size: 27,
                            ),),
                          ],
                        ),
                      ),),
                    SizedBox(width: 20,),
                    GestureDetector(
                      onTap: (){
                        button5=!button5;
                        button4=false;
                        setState(() {

                        });
                      },
                      child: Container(
                        width: 110,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:button5==true?Y:Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('الأقرب لمنطقتك',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Changa',
                            color: Colors.black87,
                          ),
                        ),

                      ),
                    ),
                    SizedBox(width: 20,),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 105,right: 375),
              child:Icon(Icons.arrow_forward_ios,size: 18,color: Colors.black87,),
            ),
            button1==true && button3==false && button2==false && button4==false?  Container(
              height: 500,
              width: 500,
              // color:  Color(0xFFF3D657),
              margin: EdgeInsets.only(top:150),
              //padding:EdgeInsets.only(right:25,left: 25),
              decoration: BoxDecoration(
                // color:Color(0xFF1C1C1C),
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(50),
                //   topRight: Radius.circular(50),
                // ),
              ),
              child:FutureBuilder(
                future: getSearchall(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData){
                    print("SARAHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
                    return ListView.builder(
                      itemCount:snapshot.data.length,
                      itemBuilder: (context, index) {
                        var Listslot=snapshot.data;
                        double Rate;
                        if(snapshot.data[index]['name']==null && snapshot.data[index]['namefirst']==null && snapshot.data[index]['namelast']==null && snapshot.data[index]['phone']==null && snapshot.data[index]['image']==null && snapshot.data[index]['Work']==null && snapshot.data[index]['Experiance']==null && snapshot.data[index]['Information']==null && snapshot.data[index]['token']==null)
                        {return Container();}
                        if(snapshot.data[index]['AVG']==null){Rate=0.0;
                        }
                        else{ Rate =roundDouble(double.parse(snapshot.data[index]['AVG']),1);}
                        print(snapshot.data.length);
                        print(snapshot.data[index]['name']);print(snapshot.data[index]['namefirst']);
                        print(snapshot.data.length);
                        print(snapshot.data.length);
                        print(snapshot.data.length);



                        return Group(client_num:snapshot.data[index]['Client'],country:widget.country,token_Me:widget.token_Me,namefirst_Me:widget.namefirst_Me,nameLast_Me:widget.nameLast_Me,phone_Me:widget.phone_Me,image_Me:widget.image_Me,Rate:Rate,name_Me:widget.name_Me,name:snapshot.data[index]['name'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],phone:snapshot.data[index]['phone'],image:snapshot.data[index]['image'],Work:snapshot.data[index]['Work'],Experiance:snapshot.data[index]['Experiance'],Information:snapshot.data[index]['Information'],token:snapshot.data[index]['token']);
                        return Container(child: Text('bggngn'),);
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ):Container(),
            button1==true && button3==true && button2==false && button4==false? Container(
              height: 500,
              width: 500,
              // color:  Color(0xFFF3D657),
              margin: EdgeInsets.only(top:150),
              //padding:EdgeInsets.only(right:25,left: 25),
              decoration: BoxDecoration(
                // color:Color(0xFF1C1C1C),
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(50),
                //   topRight: Radius.circular(50),
                // ),
              ),
              child:FutureBuilder(
                future: getSearchall_rate(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount:snapshot.data.length,
                      itemBuilder: (context, index) {
                        var Listslot=snapshot.data;
                        double Rate;
                        if(snapshot.data[index]['name']==null && snapshot.data[index]['namefirst']==null && snapshot.data[index]['namelast']==null && snapshot.data[index]['phone']==null && snapshot.data[index]['image']==null && snapshot.data[index]['Work']==null && snapshot.data[index]['Experiance']==null && snapshot.data[index]['Information']==null && snapshot.data[index]['token']==null)
                        {return Container();}
                        if(snapshot.data[index]['AVG']==null){Rate=0.0;}
                        else{ Rate =roundDouble(double.parse(snapshot.data[index]['AVG']),1);}
                        return Group(client_num:snapshot.data[index]['Client'],country:widget.country,token_Me:widget.token_Me,namefirst_Me:widget.namefirst_Me,nameLast_Me:widget.nameLast_Me,phone_Me:widget.phone_Me,image_Me:widget.image_Me,Rate:Rate,name_Me:widget.name_Me,name:snapshot.data[index]['name'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],phone:snapshot.data[index]['phone'],image:snapshot.data[index]['image'],Work:snapshot.data[index]['Work'],Experiance:snapshot.data[index]['Experiance'],Information:snapshot.data[index]['Information'],token:snapshot.data[index]['token']);
                        return Container(child: Text('bggngn'),);
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ):Container(),
            button2==true && button3==false && button1==false && button4==false ? Container(
              height: 500,
              width: 500,
              // color:  Color(0xFFF3D657),
              margin: EdgeInsets.only(top:150),
              //padding:EdgeInsets.only(right:25,left: 25),
              decoration: BoxDecoration(
                // color:Color(0xFF1C1C1C),
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(50),
                //   topRight: Radius.circular(50),
                // ),
              ),
              child:FutureBuilder(
                future: getSearchavalibel(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount:snapshot.data.length,
                      itemBuilder: (context, index) {
                        var Listslot=snapshot.data;
                        double Rate;
                        if(snapshot.data[index]['name']==null && snapshot.data[index]['namefirst']==null && snapshot.data[index]['namelast']==null && snapshot.data[index]['phone']==null && snapshot.data[index]['image']==null && snapshot.data[index]['Work']==null && snapshot.data[index]['Experiance']==null && snapshot.data[index]['Information']==null && snapshot.data[index]['token']==null)
                        {return Container();}
                        if(snapshot.data[index]['AVG']==null){Rate=0.0;}
                        else{ Rate =roundDouble(double.parse(snapshot.data[index]['AVG']),1);}
                        return Group(client_num:snapshot.data[index]['Client'],country:widget.country,token_Me:widget.token_Me,namefirst_Me:widget.namefirst_Me,nameLast_Me:widget.nameLast_Me,phone_Me:widget.phone_Me,image_Me:widget.image_Me,Rate:Rate,name_Me:widget.name_Me,name:snapshot.data[index]['name'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],phone:snapshot.data[index]['phone'],image:snapshot.data[index]['image'],Work:snapshot.data[index]['Work'],Experiance:snapshot.data[index]['Experiance'],Information:snapshot.data[index]['Information'],token:snapshot.data[index]['token']);
                        return Container(child: Text('bggngn'),);
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ):Container(),
            button2==true && button3==true && button1==false && button4==false? Container(
              height: 500,
              width: 500,
              // color:  Color(0xFFF3D657),
              margin: EdgeInsets.only(top:150),
              //padding:EdgeInsets.only(right:25,left: 25),
              decoration: BoxDecoration(
                // color:Color(0xFF1C1C1C),
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(50),
                //   topRight: Radius.circular(50),
                // ),
              ),
              child:FutureBuilder(
                future: getSearchavalibel_rate(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount:snapshot.data.length,
                      itemBuilder: (context, index) {
                        var Listslot=snapshot.data;
                        double Rate;
                        if(snapshot.data[index]['name']==null && snapshot.data[index]['namefirst']==null && snapshot.data[index]['namelast']==null && snapshot.data[index]['phone']==null && snapshot.data[index]['image']==null && snapshot.data[index]['Work']==null && snapshot.data[index]['Experiance']==null && snapshot.data[index]['Information']==null && snapshot.data[index]['token']==null)
                        {return Container();}
                        if(snapshot.data[index]['AVG']==null){Rate=0.0;}
                        else{ Rate =roundDouble(double.parse(snapshot.data[index]['AVG']),1);}
                        return Group(client_num:snapshot.data[index]['Client'],country:widget.country,token_Me:widget.token_Me,namefirst_Me:widget.namefirst_Me,nameLast_Me:widget.nameLast_Me,phone_Me:widget.phone_Me,image_Me:widget.image_Me,Rate:Rate,name_Me:widget.name_Me,name:snapshot.data[index]['name'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],phone:snapshot.data[index]['phone'],image:snapshot.data[index]['image'],Work:snapshot.data[index]['Work'],Experiance:snapshot.data[index]['Experiance'],Information:snapshot.data[index]['Information'],token:snapshot.data[index]['token']);
                        return Container(child: Text('bggngn'),);
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ):Container(),
            button3==true && button1==false && button2==false && button4==false? Container(
              height: 500,
              width: 500,
              // color:  Color(0xFFF3D657),
              margin: EdgeInsets.only(top:150),
              //padding:EdgeInsets.only(right:25,left: 25),
              decoration: BoxDecoration(
                // color:Color(0xFF1C1C1C),
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(50),
                //   topRight: Radius.circular(50),
                // ),
              ),
              child:FutureBuilder(
                future: getSearchall_rate(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount:snapshot.data.length,
                      itemBuilder: (context, index) {
                        var Listslot=snapshot.data;
                        double Rate;
                        if(snapshot.data[index]['name']==null && snapshot.data[index]['namefirst']==null && snapshot.data[index]['namelast']==null && snapshot.data[index]['phone']==null && snapshot.data[index]['image']==null && snapshot.data[index]['Work']==null && snapshot.data[index]['Experiance']==null && snapshot.data[index]['Information']==null && snapshot.data[index]['token']==null)
                        {return Container();}
                        if(snapshot.data[index]['AVG']==null){Rate=0.0;}
                        else{ Rate =roundDouble(double.parse(snapshot.data[index]['AVG']),1);}
                        return Group(client_num:snapshot.data[index]['Client'],country:widget.country,token_Me:widget.token_Me,namefirst_Me:widget.namefirst_Me,nameLast_Me:widget.nameLast_Me,phone_Me:widget.phone_Me,image_Me:widget.image_Me,Rate:Rate,name_Me:widget.name_Me,name:snapshot.data[index]['name'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],phone:snapshot.data[index]['phone'],image:snapshot.data[index]['image'],Work:snapshot.data[index]['Work'],Experiance:snapshot.data[index]['Experiance'],Information:snapshot.data[index]['Information'],token:snapshot.data[index]['token']);
                        return Container(child: Text('bggngn'),);
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ):Container(),
            button4==true && button3==false && button2==false?Container(
              height: 500,
              width: 500,
              // color:  Color(0xFFF3D657),
              margin: EdgeInsets.only(top:150),
              //padding:EdgeInsets.only(right:25,left: 25),
              decoration: BoxDecoration(
                // color:Color(0xFF1C1C1C),
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(50),
                //   topRight: Radius.circular(50),
                // ),
              ),
              child:FutureBuilder(
                future: getSearchcoutry(country_id),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount:snapshot.data.length,
                      itemBuilder: (context, index) {
                        print(snapshot.data.length);print('bbbbbbbbbbbbbbbbbbbbb');
                        var Listslot=snapshot.data;print(country_id.toString());
                        double Rate;
                        if(snapshot.data[index]['AVG']==null){Rate=0.0;}
                        else{ Rate =roundDouble(double.parse(snapshot.data[index]['AVG']),1);}
                        return Group(client_num:snapshot.data[index]['Client'],country:widget.country,token_Me:widget.token_Me,namefirst_Me:widget.namefirst_Me,nameLast_Me:widget.nameLast_Me,phone_Me:widget.phone_Me,image_Me:widget.image_Me,Rate:Rate,name_Me:widget.name_Me,name:snapshot.data[index]['name'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],phone:snapshot.data[index]['phone'],image:snapshot.data[index]['image'],Work:snapshot.data[index]['Work'],Experiance:snapshot.data[index]['Experiance'],Information:snapshot.data[index]['Information'],token:snapshot.data[index]['token']);
                        return Container(child: Text('bggngn'),);
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ):Container(),
            button4==true && button3==true && button2==false?Container(
              height: 500,
              width: 500,
              // color:  Color(0xFFF3D657),
              margin: EdgeInsets.only(top:150),
              //padding:EdgeInsets.only(right:25,left: 25),
              decoration: BoxDecoration(
                // color:Color(0xFF1C1C1C),
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(50),
                //   topRight: Radius.circular(50),
                // ),
              ),
              child:FutureBuilder(
                future: getSearchcoutry_rate(country_id),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount:snapshot.data.length,
                      itemBuilder: (context, index) {
                        print(snapshot.data.length);print('bbbbbbbbbbbbbbbbbbbbb');
                        var Listslot=snapshot.data;print(country_id.toString());
                        double Rate;
                        if(snapshot.data[index]['name']==null && snapshot.data[index]['namefirst']==null && snapshot.data[index]['namelast']==null && snapshot.data[index]['phone']==null && snapshot.data[index]['image']==null && snapshot.data[index]['Work']==null && snapshot.data[index]['Experiance']==null && snapshot.data[index]['Information']==null && snapshot.data[index]['token']==null)
                        {return Container();}
                        if(snapshot.data[index]['AVG']==null){Rate=0.0;}
                        else{ Rate =roundDouble(double.parse(snapshot.data[index]['AVG']),1);}
                        return Group(client_num:snapshot.data[index]['Client'],country:widget.country,token_Me:widget.token_Me,namefirst_Me:widget.namefirst_Me,nameLast_Me:widget.nameLast_Me,phone_Me:widget.phone_Me,image_Me:widget.image_Me,Rate:Rate,name_Me:widget.name_Me,name:snapshot.data[index]['name'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],phone:snapshot.data[index]['phone'],image:snapshot.data[index]['image'],Work:snapshot.data[index]['Work'],Experiance:snapshot.data[index]['Experiance'],Information:snapshot.data[index]['Information'],token:snapshot.data[index]['token']);
                        return Container(child: Text('bggngn'),);
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ):Container(),
            button4==true && button3==false && button2==true?Container(
              height: 500,
              width: 500,
              // color:  Color(0xFFF3D657),
              margin: EdgeInsets.only(top:150),
              //padding:EdgeInsets.only(right:25,left: 25),
              decoration: BoxDecoration(
                // color:Color(0xFF1C1C1C),
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(50),
                //   topRight: Radius.circular(50),
                // ),
              ),
              child:FutureBuilder(
                future: searchavalibelcountry(country_id),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount:snapshot.data.length,
                      itemBuilder: (context, index) {
                        print(snapshot.data.length);print('bbbbbbbbbbbbbbbbbbbbb');
                        var Listslot=snapshot.data;print(country_id.toString());
                        double Rate;
                        if(snapshot.data[index]['name']==null && snapshot.data[index]['namefirst']==null && snapshot.data[index]['namelast']==null && snapshot.data[index]['phone']==null && snapshot.data[index]['image']==null && snapshot.data[index]['Work']==null && snapshot.data[index]['Experiance']==null && snapshot.data[index]['Information']==null && snapshot.data[index]['token']==null)
                        {return Container();}
                        if(snapshot.data[index]['AVG']==null){Rate=0.0;}
                        else{ Rate =roundDouble(double.parse(snapshot.data[index]['AVG']),1);}
                        return Group(client_num:snapshot.data[index]['Client'],country:widget.country,token_Me:widget.token_Me,namefirst_Me:widget.namefirst_Me,nameLast_Me:widget.nameLast_Me,phone_Me:widget.phone_Me,image_Me:widget.image_Me,Rate:Rate,name_Me:widget.name_Me,name:snapshot.data[index]['name'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],phone:snapshot.data[index]['phone'],image:snapshot.data[index]['image'],Work:snapshot.data[index]['Work'],Experiance:snapshot.data[index]['Experiance'],Information:snapshot.data[index]['Information'],token:snapshot.data[index]['token']);
                        return Container(child: Text('bggngn'),);
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ):Container(),
            button4==true && button3==true && button2==true?Container(
              height: 500,
              width: 500,
              // color:  Color(0xFFF3D657),
              margin: EdgeInsets.only(top:150),
              //padding:EdgeInsets.only(right:25,left: 25),
              decoration: BoxDecoration(
                // color:Color(0xFF1C1C1C),
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(50),
                //   topRight: Radius.circular(50),
                // ),
              ),
              child:FutureBuilder(
                future: searchcountry_avalibel_rate(country_id),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount:snapshot.data.length,
                      itemBuilder: (context, index) {
                        print(snapshot.data.length);print('bbbbbbbbbbbbbbbbbbbbb');
                        var Listslot=snapshot.data;print(country_id.toString());
                        double Rate;
                        if(snapshot.data[index]['name']==null && snapshot.data[index]['namefirst']==null && snapshot.data[index]['namelast']==null && snapshot.data[index]['phone']==null && snapshot.data[index]['image']==null && snapshot.data[index]['Work']==null && snapshot.data[index]['Experiance']==null && snapshot.data[index]['Information']==null && snapshot.data[index]['token']==null)
                        {return Container();}
                        if(snapshot.data[index]['AVG']==null){Rate=0.0;}
                        else{ Rate =roundDouble(double.parse(snapshot.data[index]['AVG']),1);}
                        return Group(client_num:snapshot.data[index]['Client'],country:snapshot.data[index]['country'],token_Me:widget.token_Me,namefirst_Me:widget.namefirst_Me,nameLast_Me:widget.nameLast_Me,phone_Me:widget.phone_Me,image_Me:widget.image_Me,Rate:Rate,name_Me:widget.name_Me,name:snapshot.data[index]['name'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],phone:snapshot.data[index]['phone'],image:snapshot.data[index]['image'],Work:snapshot.data[index]['Work'],Experiance:snapshot.data[index]['Experiance'],Information:snapshot.data[index]['Information'],token:snapshot.data[index]['token']);
                        return Container(child: Text('bggngn'),);
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ):Container(),
            button5==true && button3==false && button2==false? Container(
                margin: EdgeInsets.only(top:150),
                child:Search_map(work: widget.work,),) :Container(),
            button5==true && button3==true && button2==false? Container(
              margin: EdgeInsets.only(top:150),
              child:Search_map_rate(work: widget.work,),) :Container(),
            button5==true && button3==false && button2==true? Container(
              margin: EdgeInsets.only(top:150),
              child:Search_map_avalibel(work: widget.work,),) :Container(),
            button5==true && button3==true && button2==true? Container(
              margin: EdgeInsets.only(top:150),
              child:Search_map_avalibel_rate(work: widget.work,),) :Container(),
            new Container(
              margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 0.0),
              child: new Column(
                children: <Widget>[
                  _createSearchView(),
                  _firstSearch ? Container() : _performSearch()
                ],
              ),
            ),

          ],
        ),
      ),);
  }
  Widget Drop_country(){
    return Container(
        child:Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 40,right: 50),
          decoration: BoxDecoration(

          ),
          child:Icon(Icons.arrow_drop_up,size: 50,color: Colors.white,),

        ),
        Container(
          transform: Matrix4.translationValues(0.0, -18.0, 0.0),
          margin: EdgeInsets.only(left: 40,top: 0),
          child:Material(
            elevation: 5,
            //shape: ArrowShape(),
            child: Container(
              height: 400,
              width: 120,
              //margin: EdgeInsets.only(right: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child:SingleChildScrollView(
                child:Container(
                  decoration: BoxDecoration(
                    color:button4==true?Y2:Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Column(
                  children: <Widget>[
                    DropDownItem_country("جنين"),
                    DropDownItem_country("نابلس"),
                    DropDownItem_country("طوباس"),
                    DropDownItem_country("طولكرم"),
                    DropDownItem_country("رام الله"),
                    DropDownItem_country("بيت لحم"),
                    DropDownItem_country("الخليل"),
                    DropDownItem_country("قلقيلية"),
                    DropDownItem_country("عكا"),
                    DropDownItem_country("حيفا"),
                    DropDownItem_country("يافا"),
                    DropDownItem_country("جميع المناطق"),
                  ],
                ),
              ),
            ),
          ),),),],
        ),);
  }
  Widget DropDownItem_country(String text) {

    return Directionality(textDirection: TextDirection.ltr,
      child:Container(
        width:150,
        height: 50,
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
          color:Colors.white,
        ),
        //margin: EdgeInsets.only(left: 16,),
        //padding: EdgeInsets.only(right:10, top: 8,bottom: 8),
        child: Container(
          width: 150,
          color: Colors.white,
          padding: EdgeInsets.only(right: 0,),
          // alignment: Alignment.topRight,
          child:FlatButton(
            onPressed: (){
              print(text);
              setState(() {
                isDropdownOpened_country=false;
                floatingDropdown_country.remove();
                 country_id=text;
                setState(() {

                });
              });
            },
            child: Text(text,
              style: TextStyle(
                fontSize: 14.0,
                fontFamily: 'Changa',
                color: Color(0xFF666360),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),),);
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
            Directionality(textDirection: TextDirection.rtl,
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
                      country_id=country_choose;
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:country_id,work: 'نجار',name_Me: widget.name_Me,location: widget.country,),),);
                      Navigator.pop(context);
                      setState(() {
                        button4=!button4;
                        button3=button2=button1=false;

                      });
                     // Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>List_Worker(work:widget.work,location:country_choose,name_Me: widget.name_Me,)));
                    },
                  ),),
              ],
            ),

          ],
        );
      },
    );
  }
  //Create a SearchView
  Widget _createSearchView() {

    return new Container(
      height: 55,
      width: 430,
      margin: EdgeInsets.only(top: 30,right: 0,left: 10),
      padding: EdgeInsets.only(right: 10),
      // decoration: BoxDecoration(border: Border.all(width: 1.0)),
      child: new TextField(
        controller: _searchview,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Changa',
        ),
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: "البحث عن مقدم خدمة",
          hintStyle: new TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Changa',
          ),
          enabledBorder: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15.0),
            borderSide:  BorderSide(color:Colors.grey[100]),

          ),
          focusedBorder: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15.0),
            borderSide:  BorderSide(color:Colors.grey[100]),

          ),
          suffixIcon: GestureDetector(
            onTap: () {
            },
            child:  Container(
              // margin: EdgeInsets.only(top: 5),
              child:RotatedBox(
                quarterTurns: 1,
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color:Colors.black54,
                    size: 25.0,
                  ),
                  onPressed: null,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  //Create a ListView widget
  Widget _createListView() {
    return new Flexible(
      child: new ListView.builder(
          itemCount: Listsearch.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              color: Colors.white,
              elevation: 5.0,
              child: new Container(
                margin: EdgeInsets.all(15.0),
                child: new Text("${Listsearch[index]}"),
              ),
            );
          }),
    );
  }
  //Perform actual search
  Widget _performSearch() {
    _filterList = new List<String>();
    for (int i = 0; i < Listsearch.length; i++) {
      var item = Listsearch[i]['namefirst']+" "+Listsearch[i]['namelast'];

      if (item.toLowerCase().contains(_query.toLowerCase())) {
        _filterList.add(item);
      }
    }
    return _createFilteredListView();
  }
  //Create the Filtered ListView
  Widget _createFilteredListView() {

    return new Stack(
      children:[
        SingleChildScrollView(
          child:Directionality(textDirection: TextDirection.ltr,
            child:Container(
              width: 390,
              height: 200,
              margin:EdgeInsets.only(left: 10,right: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0,0.5),
                    blurRadius: 0.01,
                    color: Colors.black54,
                  ),],
              ),
              child: new ListView.builder(
                  itemCount: _filterList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new GestureDetector(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => user_worker(phoneuser:widget.phone_Me,tokenuser:widget.token_Me,Work:Listsearch[index]['Work'],image:Listsearch[index]['image'],phone:Listsearch[index]['phone'],name: Listsearch[index]['name'],namelast:Listsearch[index]['namelast'],name_Me: widget.name_Me,namefirst:Listsearch[index]['namefirst'],token:Listsearch[index]['token'],Information:Listsearch[index]['Information'],Experiance:Listsearch[index]['Experiance'],),));
                      },
                      child:  Container(
                        alignment: Alignment.topRight,
                        color: Colors.white,
                        width: 200,
                        margin: EdgeInsets.only(right: 20,top:10),
                        padding:EdgeInsets.only(right: 5,),
                        child: new Text("${_filterList[index]}",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Changa',
                            color: Colors.black54,
                          ),),
                      ),
                    );
                  }),
            ),),),],);
  }
}
class Group  extends StatefulWidget {
  final name_Me;
  final  name;
  final  namefirst;
  final  namelast;
  final  phone;
  final  image;
  final country;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;
  final double Rate;
  final namefirst_Me;
  final nameLast_Me;
  final phone_Me;
  final image_Me;
  final token_Me;
  final int post_numper;
  final client_num;
  final int comment_num;

  Group({this.post_numper,this.client_num,this.comment_num,this.country,this.token_Me,this.phone_Me,this.nameLast_Me,this.namefirst_Me,this.image_Me,this.Rate,this.name_Me,this.name,this.namefirst,this.namelast, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token});

  @override
  _Group createState() => _Group();
}

class _Group extends State<Group> {
  var ma="";
  @override
  void initState(){
    getpost();
    super.initState();
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
  var List_Post=[];
  Future getpost()async{
    var url='https://'+IP4+'/testlocalhost/getpost.php';
    var ressponse=await http.post(url,body: {
      "phone": widget.phone,
    });
    List_Post=await json.decode(ressponse.body);
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  @override
  Widget build(BuildContext context) {
    print(List_Post.toString());
    return GestureDetector(
      onTap: (){
        print(widget.phone); print(widget.name_Me); print(widget.phone_Me);
        print(widget.token); print(widget.token_Me);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => user_worker(List_Post:List_Post,client_num: widget.client_num,comment: ma,country:widget.country,phoneuser:widget.phone_Me,tokenuser:widget.token_Me,Work:widget.Work,image:widget.image,phone:widget.phone,name: widget.name,namelast:widget.namelast,name_Me: widget.name_Me,namefirst: widget.namefirst,token: widget.token,Information: widget.Information,Experiance:widget.Experiance,),));
      },
      child: Container(

        height: 135,
        width: 200,
        decoration: BoxDecoration(
          //color:Colors.white,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 1,
              color: Colors.grey,
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),

        child: Column(
          children: <Widget>[
            Stack(children: [
              Container(
                height: 135,
                child: FutureBuilder(
                    future: getComment(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        print("SARAHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHhhhhhhhhh");
                        //_MyHomePageState c= new _MyHomePageState();
                        return ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            ma=snapshot.data[index]['count'];
                            return row_worker();
                          },);
                      }
                      return Container(
                        child:Text(''),
                      );

                    }
                ),
              ),
              // Container(
              //   margin: EdgeInsets.only(top: 30, right: 10),
              //   child: CircleAvatar(backgroundImage: NetworkImage(
              //       'https://' + IP4 + '/testlocalhost/upload/' + widget.image),
              //     radius: 29.0,),),
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
            // Container(
            //   height: 10,
            //   margin: EdgeInsets.only(top: 5),
            //   child:Divider(
            //     color: Color(0xFF666360),
            //     thickness: 1,
            //   ),),

          ],),
      ),);
  }
  Widget row_worker(){
    return   Row(
      children: [

        Container(
          // print(_image[index].id+"");
          width: 110,
          height: 110,
          margin: EdgeInsets.only(right: 10,top:10),
          decoration: BoxDecoration(
            color:Colors.white,
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(image: NetworkImage('https://'+IP4+'/testlocalhost/upload/'+widget.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child:Column(
            children: [

              Container(
                width: 230,
                height: 22,
                //color: Colors.red,
                margin: EdgeInsets.only(right: 10,top: 0),
                child: Text(widget.namefirst + " " + widget.namelast,
                  style: TextStyle(
                    fontSize: 15.5,
                    fontFamily: 'Changa',
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),),),
              Container(
                width: 230,
                height: 22,
                //color: Colors.red,
                margin: EdgeInsets.only(right: 10,bottom:20),
                child: Text(widget.Work,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Changa',
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),),),
              Container(
                width: 230,
                margin: EdgeInsets.only(right: 15,),
                child:  Row(
                  children: [
                    Text('العملاء',
                      style: TextStyle(
                        color: Color(0xFF666360),
                        fontSize: 13.0,
                        fontFamily: 'Changa',
                        fontWeight: FontWeight.bold,

                      ),),
                    SizedBox(width: 44.5,),
                    Text('التعليقات',
                      style: TextStyle(
                        color: Color(0xFF666360),
                        fontSize: 13.0,
                        fontFamily: 'Changa',
                        fontWeight: FontWeight.bold,
                      ),),
                    SizedBox(width: 47.5,),
                    Text('الريت',
                      style: TextStyle(
                        color: Color(0xFF666360),
                        fontSize: 13.0,
                        fontFamily: 'Changa',
                        fontWeight: FontWeight.bold,
                      ),),
                  ],
                ),
              ),
              Container(
                width: 230,
                margin: EdgeInsets.only(right: 10,),
                child:  Row(
                  children: [
                    SizedBox(width: 15,),
                    Text(widget.client_num.toString(),
                      style: TextStyle(
                        color: Color(0xFF666360),
                        fontSize: 13.0,
                        fontFamily: 'Changa',
                        fontWeight: FontWeight.bold,
                      ),),
                    SizedBox(width: 85.5,),
                    Text(ma.toString(),
                      style: TextStyle(
                        color: Color(0xFF666360),
                        fontSize: 13.0,
                        fontFamily: 'Changa',
                        fontWeight: FontWeight.bold,
                      ),),
                    SizedBox(width: 70.5,),
                    Text(widget.Rate.toString(),
                      style: TextStyle(
                        color: Color(0xFF666360),
                        fontSize: 13.0,
                        fontFamily: 'Changa',
                        fontWeight: FontWeight.bold,
                      ),),
                    Icon(Icons.star, color: Colors.yellow,),
                  ],
                ),
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
              // Container(
              //   width: 200,
              //   child: Row(
              //     children: [
              //       Directionality(textDirection: TextDirection.ltr,
              //         child:Container(
              //           width: 110,
              //           // margin: EdgeInsets.only(top: 80, right: 70),
              //           child: Text(widget.phone,
              //             style: TextStyle(
              //               fontSize: 15.0,
              //               fontFamily: 'Changa',
              //               color: Color(0xFF666360),
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),),),
              //       Container(
              //         //margin: EdgeInsets.only(top: 80, left: 10,),
              //         child: Icon(Icons.phone,
              //           color: Color(0xFF666360),),
              //       ),
              //     ],
              //   ),
              // ),
              // Row(
              //   children: [
              //     Container(
              //       height: 20,
              //       width: 40,
              //       //margin: EdgeInsets.only(right: 0, top: 87),
              //       child: IconButton(
              //
              //         onPressed:() {
              //           Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => comments(image:widget.image_Me,namelast:widget.nameLast_Me,namefirst: widget.namefirst_Me,Phoneuser: widget.phone_Me,Phoneworker: widget.phone,)));
              //           // Navigator.of(context).push(comments);
              //         },
              //         icon: Icon(Icons.comment),
              //       ),
              //     ),
              //     // Container(height: 20,
              //     //     width: 40,
              //     //     margin: EdgeInsets.only(right: 30, top: 100),
              //     //     //child:Text("تعليق")
              //     // ),
              //   ],),
            ],
          ),
        )
      ],
    );
  }
}

