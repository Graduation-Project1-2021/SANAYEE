import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'Comment.dart';
import 'WORKER_PROFILE.dart';
String IP4="192.168.1.8";


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
  Search_user({this.token_Me,this.image_Me,this.namefirst_Me,this.nameLast_Me,this.phone_Me,this.work,this.name_Me,this.location});
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

  double roundDouble(double value, int places){
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
  @override
  void initState() {
    super.initState();
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
  Future getSearchavalibel()async{
    var url='https://'+IP4+'/testlocalhost/searchavalibel.php';
    var ressponse=await http.post(url,body: {
      "Work":widget.work,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  bool button1=true;
  bool button2=false;

//Build our Home widget
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child:Scaffold(
      appBar: new AppBar(
        title: new Text("SearchView ListView"),
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
                      button1=true;
                      button2=false;
                      setState(() {

                      });
                    },
                    child: Container(
                      width:50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color:button1==true?Colors.red:Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('الكل',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Changa',
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 30,),
                  GestureDetector(
                    onTap: (){
                      button1=false;
                      button2=true;
                      setState(() {

                      });
                    },
                    child: Container(
                      width:50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color:button2==true?Colors.red:Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('المتاحين',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Changa',
                          color: Colors.black54,
                        ),
                      ),

                    ),
                  ),
                  SizedBox(width: 30,),
                  GestureDetector(
                    child: Container(
                      child: Text('الريت',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Changa',
                          color: Colors.black54,
                        ),
                      ),

                    ),
                  ),
                  SizedBox(width: 30,),
                  GestureDetector(
                    child: Container(
                      child: Text('الأف',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Changa',
                          color: Colors.black54,
                        ),
                      ),

                    ),
                  ),
                ],
              ),
            ),
          ),



          button1==true?  Container(
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
                  return ListView.builder(
                    itemCount:snapshot.data.length,
                    itemBuilder: (context, index) {
                      print(snapshot.data.length);print('dddddddddddddddddddddddddd');
                      var Listslot=snapshot.data;
                      double Rate;
                      if(snapshot.data[index]['name']==null && snapshot.data[index]['namefirst']==null && snapshot.data[index]['namelast']==null && snapshot.data[index]['phone']==null && snapshot.data[index]['image']==null && snapshot.data[index]['Work']==null && snapshot.data[index]['Experiance']==null && snapshot.data[index]['Information']==null && snapshot.data[index]['token']==null)
                      {return Container();}
                      if(snapshot.data[index]['AVG']==null){Rate=0.0;}
                      else{ Rate =roundDouble(double.parse(snapshot.data[index]['AVG']),1);}
                      return Group(token_Me:widget.token_Me,namefirst_Me:widget.namefirst_Me,nameLast_Me:widget.nameLast_Me,phone_Me:widget.phone_Me,image_Me:widget.image_Me,Rate:Rate,name_Me:widget.name_Me,name:snapshot.data[index]['name'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],phone:snapshot.data[index]['phone'],image:snapshot.data[index]['image'],Work:snapshot.data[index]['Work'],Experiance:snapshot.data[index]['Experiance'],Information:snapshot.data[index]['Information'],token:snapshot.data[index]['token']);
                      return Container(child: Text('bggngn'),);
                    },
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ):Container(),
          button2==true?  Container(
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
                      print(snapshot.data.length);print('dddddddddddddddddddddddddd');
                      var Listslot=snapshot.data;
                      double Rate;
                      if(snapshot.data[index]['name']==null && snapshot.data[index]['namefirst']==null && snapshot.data[index]['namelast']==null && snapshot.data[index]['phone']==null && snapshot.data[index]['image']==null && snapshot.data[index]['Work']==null && snapshot.data[index]['Experiance']==null && snapshot.data[index]['Information']==null && snapshot.data[index]['token']==null)
                      {return Container();}
                      if(snapshot.data[index]['AVG']==null){Rate=0.0;}
                      else{ Rate =roundDouble(double.parse(snapshot.data[index]['AVG']),1);}
                      return Group(token_Me:widget.token_Me,namefirst_Me:widget.namefirst_Me,nameLast_Me:widget.nameLast_Me,phone_Me:widget.phone_Me,image_Me:widget.image_Me,Rate:Rate,name_Me:widget.name_Me,name:snapshot.data[index]['name'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],phone:snapshot.data[index]['phone'],image:snapshot.data[index]['image'],Work:snapshot.data[index]['Work'],Experiance:snapshot.data[index]['Experiance'],Information:snapshot.data[index]['Information'],token:snapshot.data[index]['token']);
                      return Container(child: Text('bggngn'),);
                    },
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ):Container(),

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
  //Create a SearchView
  Widget _createSearchView() {

    return new Container(
      height: 55,
      margin: EdgeInsets.only(top: 30),
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
  //Create a ListView widge
  //Perform actual search
  Widget _performSearch() {
    _filterList = new List<String>();
    for (int i = 0; i < Listsearch.length; i++) {
      var item = Listsearch[i]['Work'];

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
        width: 370,
      height: 200,
      alignment: Alignment.topRight,
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

  Group({this.token_Me,this.phone_Me,this.nameLast_Me,this.namefirst_Me,this.image_Me,this.Rate,this.name_Me,this.name,this.namefirst,this.namelast, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token});

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
      onTap: (){
        print(widget.phone); print(widget.name_Me); print(widget.phone_Me);
        print(widget.token); print(widget.token_Me);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => user_worker(phoneuser:widget.phone_Me,tokenuser:widget.token_Me,Work:widget.Work,image:widget.image,phone:widget.phone,name: widget.name,namelast:widget.namelast,name_Me: widget.name_Me,namefirst: widget.namefirst,token: widget.token,Information: widget.Information,Experiance:widget.Experiance,),));
      },
      child: Container(
        height: 150,
        width: 200,
        decoration: BoxDecoration(
          //color:Colors.white,
          color: Colors.white,
           borderRadius: BorderRadius.circular(10),
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
              Row(
                children: [
                  Container(
                    // print(_image[index].id+"");
                    width: 80,
                    height: 80,
                    margin: EdgeInsets.only(right: 10,top:0),
                    decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(image: NetworkImage('https://'+IP4+'/testlocalhost/upload/'+widget.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    child:Column(
                      children: [

                        Container(
                          width: 200,
                          height: 30,
                          //color: Colors.red,
                          margin: EdgeInsets.only(right: 10,top: 15),
                          child: Text(widget.namefirst + " " + widget.namelast,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'Changa',
                              color: Color(0xFF666360),
                              fontWeight: FontWeight.bold,
                            ),),),
                        Container(
                          width: 200,
                          margin: EdgeInsets.only(right: 10,),
                          child:  Row(
                            children: [
                               Text(widget.Rate.toString(),
                                  style: TextStyle(
                                    color: Color(0xFF666360),
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
                        Container(
                         width: 200,
                         child: Row(
                           children: [
                             Directionality(textDirection: TextDirection.ltr,
                               child:Container(
                                 width: 110,
                                 // margin: EdgeInsets.only(top: 80, right: 70),
                                 child: Text(widget.phone,
                                   style: TextStyle(
                                     fontSize: 15.0,
                                     fontFamily: 'Changa',
                                     color: Color(0xFF666360),
                                     fontWeight: FontWeight.bold,
                                   ),
                                 ),),),
                             Container(
                               //margin: EdgeInsets.only(top: 80, left: 10,),
                               child: Icon(Icons.phone,
                                 color: Color(0xFF666360),),
                             ),
                           ],
                         ),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 40,
                              //margin: EdgeInsets.only(right: 0, top: 87),
                              child: IconButton(

                                onPressed:() {
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => comments(image:widget.image_Me,namelast:widget.nameLast_Me,namefirst: widget.namefirst_Me,Phoneuser: widget.phone_Me,Phoneworker: widget.phone,)));
                                  // Navigator.of(context).push(comments);
                                },
                                icon: Icon(Icons.comment),
                              ),
                            ),
                            // Container(height: 20,
                            //     width: 40,
                            //     margin: EdgeInsets.only(right: 30, top: 100),
                            //     //child:Text("تعليق")
                            // ),
                          ],),
                      ],
                    ),
                  )
                ],
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
