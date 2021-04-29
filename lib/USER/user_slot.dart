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
import 'Choose_type.dart';
import 'not_conferm_user_state.dart';
import 'descriptionorder.dart';

DateTime _selectedDay = DateTime.now();
String  name_Me="";
String  name="";
String  phone="";
String  image="";
String namefirst="";
String namelast="";
String Country="";
String  token="";
String IP4="192.168.1.8";

class My_SLot extends StatefulWidget {
  final name_Me;
  final country;
  final namefirst;
  final namelast;
  final image;
  final phone;
  final phoneworker;
  final tokenworker;
  final token_Me;
  final DateTime date;
  final DateTime time;
  final AVG;
  final work;
  final Information;
  final Experiance;
  final nameworker;
  final client_count;
  final comment;
  My_SLot({this.comment,this.client_count,this.Information,this.Experiance,this.nameworker,this.AVG,this.work,this.date,this.token_Me,this.phoneworker,this.tokenworker,this.name_Me,this.country,this.namefirst,this.namelast,this.image,this.phone,this.time});
  _My_SLot createState() =>  _My_SLot();
}
class  _My_SLot extends State<My_SLot> {
  // AnimationController _animationController;
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  final List1 = [];
  var ListDate1 = [];
  final List2 = [];
  var ListDate2 = [];
  var ListBlock=["8.00 - 9.00 ","9.00 - 10.00","","","",];
  var Listsearch=[];


  Future getMYslot()async{
    var formattedDate = DateFormat('yyyy-MM-dd').format(widget.date);
    var url='https://'+IP4+'/testlocalhost/show_slot_of_worker.php';
    var ressponse=await http.post(url,body: {
      "phoneworker":widget.phoneworker,
      "date":formattedDate,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }

  CalendarController _calendarController;
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    // getChat();
  }
  int _selectedIndex = 0;
  PageController _pageController;
  DatabaseMethods databaseMethods=new DatabaseMethods();
  Stream chatsRoom;
  @override
  int _selectedItem = 0;
  Widget build(BuildContext context) {
    print(Listsearch.toString());
    // print(widget.phone);print(widget.name_Me);  print(widget.phoneworker);   print(widget.token_Me);   print(widget.tokenworker); print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Directionality(textDirection: ui.TextDirection.rtl,
      child:Scaffold(
            backgroundColor: Colors.grey[50],
            key: _scaffoldKey,
            body: Form(
              child:Container(
              height: 800,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Image.asset(
                  //   "assets/icons/ho.jpg",
                  //   height:250,
                  //   width:450,
                  //   fit: BoxFit.fill,
                  GestureDetector(
                    onTap: (){
                      print(widget.phone);print(widget.phoneworker);print(widget.nameworker);
                      print(widget.namefirst);print(widget.namelast);print(widget.tokenworker); print(widget.token_Me);print(widget.name_Me);print(widget.Information);
                      print(widget.Experiance);print(widget.image);print(widget.nameworker);
                      // Navigator.pop(context);
                      DateTime date=DateTime.now();
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>choose(Information:widget.Information,Experiance:widget.Experiance,country:widget.country,client_num:widget.client_count,comment:widget.comment,time:date,work:widget.work,phone:widget.phone,username:widget.name_Me,phoneworker:widget.phoneworker,name:widget.nameworker,namelast:widget.namelast,namefirst:widget.namefirst,image:widget.image,)));

                      // Navigator.push(context,MaterialPageRoute(builder: (context) => user_worker(comment:widget.comment,client_num:widget.client_count,country:widget.country,phoneuser:widget.phone,tokenuser:widget.token_Me,Work:widget.work,image:widget.image,phone:widget.phoneworker,name: widget.nameworker,namelast:widget.namelast,name_Me: widget.name_Me,namefirst: widget.namefirst,token: widget.tokenworker,Information: widget.Information,Experiance:widget.Experiance,)));
                    },
                    child:Container(
                      height: 20,
                      margin: EdgeInsets.only(top:70,left:370),
                      child:Icon(Icons.arrow_back,color: Colors.black,),
                    ),
                  ),
                 Container(
                   height:707,
                   color: Colors.grey[50],
                   margin: EdgeInsets.only(top:0),
                   child: FutureBuilder(
                     future: getMYslot(),
                     builder: (BuildContext context, AsyncSnapshot snapshot) {
                       if(snapshot.hasData){
                         return ListView.builder(
                           itemCount: 1,
                           itemBuilder: (context, index) {
                             var Listslot=snapshot.data;
                             //return Container(child: Text('SARAH'),);
                             if(Listslot.length==0){
                               print("vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv");
                               return Empty(country:widget.country,Information:widget.Information,Experiance:widget.Experiance,nameworker:widget.nameworker,name_Me:widget.name_Me,token_Me:widget.token_Me,AVG:widget.AVG,work:widget.work,image:widget.image,namefirst:widget.namefirst,namelast:widget.namelast,List1:Listslot,date:widget.date,username:widget.name_Me,token:widget.token_Me,tokenworker: widget.tokenworker,phoneworker: widget.phoneworker,phone: widget.phone,);

                             }
                             return slot(country:widget.country,Information:widget.Information,Experiance:widget.Experiance,nameworker:widget.nameworker,name_Me:widget.name_Me,token_Me:widget.token_Me,AVG:widget.AVG,work:widget.work,image:widget.image,namefirst:widget.namefirst,namelast:widget.namelast,List1:Listslot,date:widget.date,username:widget.name_Me,token:widget.token_Me,tokenworker: widget.tokenworker,phoneworker: widget.phoneworker,phone: widget.phone,);
                           },
                         );
                       }
                       return Center(child: CircularProgressIndicator());
                     },
                   ),
                 ),

                ],),),),),);
  }
}
class slot extends StatefulWidget {
  final phone;
  final token;
  final AVG;
  final tokenworker;
  final phoneworker;
  final username;
  final namefirst;
  final namelast;
  final image;
  final work;
  List<dynamic> List1;
  final DateTime date;
  final name_Me;
  final country;
  final token_Me;
  final Information;
  final Experiance;
  final nameworker;
  final client_count;
  final comment;
  slot({this.client_count,this.comment,this.nameworker,this.name_Me,this.country,this.token_Me,this.Information,this.Experiance,this.AVG,this.work,this.namelast,this.namefirst,this.image,this.phone,this.List1,this.date,this.tokenworker,this.phoneworker,this.token,this.username});
  @override
  _slot createState() => _slot();
}

class _slot extends State<slot> {
  var List11=[];
  var List22=[];
  var List_Am=[];
  var List_Pm=[];
  var Array =['true','true','true'];
  var dateParse = DateTime.parse(_selectedDay.toString());
  var formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDay);
  bool tap = false;
  bool tap0= false;
  bool tap1 = false;
  bool tap2 = false;
  List<bool>AB=[false,false,false,false,false,false,false,false,false,false,false,false];
  CalendarController _calendarController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calendarController = CalendarController();
    // _streamController = StreamController();
  }
  @override
  void seprate(){
    for(int i=0;i<widget.List1.length;i++){
      if(widget.List1[i]['states']!='yes') {
        if (widget.List1[i]['Am_Pm'] == 'am') {
          List_Am.add(widget.List1[i]);
        }
        else {
          List_Pm.add(widget.List1[i]);
        }
      }
    }
  }
  var ListTimeSlot1=[];
  Container cheack1(){
    ListTimeSlot1=[];
    for(int i=0;i<ListTime1.length;i++) {
      if (!ListBlock.contains(ListTime1[i])) {
        ListTimeSlot1.add(ListTime1[i]);
      }
    }
    return Container();
  }
  var ListTimeSlot2=[];
  Container cheack2(){
    ListTimeSlot2=[];
    for(int i=0;i<ListTime2.length;i++) {
      if (!ListBlock.contains(ListTime2[i])) {
        ListTimeSlot2.add(ListTime2[i]);
      }
    }
    return Container();
  }
  void _onDaySelected(DateTime day, List events,List r) {
    _selectedDay = day;
    formattedDate = DateFormat('yyyy-MM-dd').format(day);
    print(formattedDate);
    if(ListBlock.isEmpty){
      print("Nulllll");

      // print(_selectedDay);
      Navigator.push(context, MaterialPageRoute(builder: (context) => My_SLot(client_count:widget.client_count,comment:widget.comment,country:widget.country,date:_selectedDay,namelast:widget.namelast,namefirst:widget.namefirst,image:widget.image,nameworker:widget.nameworker,Information:widget.Information,Experiance:widget.Experiance,AVG:widget.AVG,work:widget.work,name_Me:widget.name_Me,token_Me:widget.token_Me,tokenworker: widget.token,phoneworker: widget.phoneworker,phone: widget.phone,),),);

    }
  }
  @override
  int _page = 0;
  bool image=false;
  var A=[];
  GlobalKey _bottomNavigationKey = GlobalKey();
  Widget build(BuildContext context) {
    seprate();
    print(List_Am.toString());
    print(List_Pm.toString());
    //print(phone);   print(widget.phoneworker);   print(token);   print(widget.tokenworker); print(";;;;;;;;;;;;;;;;;;;;;;");
    return Container(
      height: 700,
      color: Colors.white,
      transform: Matrix4.translationValues(0.0, -42.0, 0.0),
      child:Column(
                children: [
                  Container(
                    color: Colors.grey[50],
                    child:TableCalendar(
                    onDaySelected: _onDaySelected,
                    calendarController: _calendarController,
                    //events: events,
                    initialSelectedDay: widget.date,
                    initialCalendarFormat: CalendarFormat.week,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    formatAnimation: FormatAnimation.slide,
                    headerStyle: HeaderStyle(
                      centerHeaderTitle: true,
                      formatButtonVisible: false,
                      titleTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16
                      ),
                      leftChevronIcon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 15,),
                      rightChevronIcon: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 15,),
                      leftChevronMargin: EdgeInsets.only(left: 80),
                      rightChevronMargin: EdgeInsets.only(right: 80),
                    ),
                    calendarStyle: CalendarStyle(
                        todayColor: Colors.white,
                        selectedColor: Y.withOpacity(0.9),
                        weekendStyle: TextStyle(
                            color: Colors.black
                        ),
                        weekdayStyle: TextStyle(
                            color: Colors.black
                        )
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                        weekendStyle: TextStyle(
                            color: Colors.black
                        ),
                        weekdayStyle: TextStyle(
                            color: Colors.black
                        )

                    ),),
                  ),
                  // Container(
                  //   width: 420,
                  //   // transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                  //   // padding:EdgeInsets.only(right: 20,left: 20),
                  //   color: Colors.grey[50],
                  //   child: Divider(
                  //     thickness:0.15,
                  //     color: Colors.black87.withOpacity(0.7),
                  //   ),
                  // ),
                  Container(
                    width: 500,
                    height: 500,
                    //padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Container(
                      height: 400,
                      margin: EdgeInsets.only(right: 1),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height:30,),
                            Container(
                                height:400,
                                width: 400,
                                child:GridView.builder(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5,
                                    childAspectRatio: 3.02,
                                  ),
                                  itemCount: widget.List1.length,
                                  itemBuilder: (context,index){
                                    bool tap=true;
                                    bool not_tap=false;
                                    return GestureDetector(
                                      onTap: (){
                                        // _dialogCall(phone,id,phoneworker,token,workertoken,username,time,_selectedDay);
                                        setState(() {
                                          for(int i=0;i<AB.length;i++){
                                            AB[i]=not_tap;
                                          }
                                          AB[index]=tap;
                                        });
                                        print("SARAH"+index.toString());
                                      },
                                      child: Container(
                                        height: 50,
                                        // margin: EdgeInsets.only(right: 4,),
                                        //padding: EdgeInsets.symmetric(horizontal: 5),
                                        // height: 54,
                                        // width: 119,
                                        decoration: BoxDecoration(
                                           color: AB[index]?Y.withOpacity(0.8):Colors.white,
                                          border: Border.all(color: Y, width: 1),
                                          borderRadius: BorderRadius.circular(10),),
                                        child:Center(
                                          child:Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                              // color: AB[index]?Y.withOpacity(0.7):Colors.white,
                                              border: Border.all(color: Colors.grey[50], width: 1.7),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            // margin: EdgeInsets.only(right: 20),
                                            child:widget.List1[index]['Am_Pm']=='am'?Row(
                                              children: [
                                                SizedBox(width: 2,),
                                                Text(widget.List1[index]['timestart']+" - "+widget.List1[index]['timeend'],
                                                  style: TextStyle(
                                                    fontFamily: 'Changa',
                                                    color: Color(0xFF1C1C1C),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),),
                                                SizedBox(width: 5,),
                                                Icon(Icons.wb_sunny,size: 25,color: Colors.yellow,),
                                              ],
                                            ):Row(
                                              children: [
                                                SizedBox(width: 2,),
                                                Text(widget.List1[index]['timestart']+" - "+widget.List1[index]['timeend'],
                                                  style: TextStyle(
                                                    fontFamily: 'Changa',
                                                    color: Color(0xFF1C1C1C),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),),
                                                SizedBox(width: 5,),
                                                Icon(Icons.cloud,size: 25,color: Colors.black,),
                                              ],
                                            ),
                                          ),
                                        ),),
                                    );
                                      //time1(widget.List1[index]['timestart']+" - "+widget.List1[index]['timeend'],widget.List1[index]['Am_Pm'],widget.List1[index]['id'],widget.phone,widget.phoneworker,widget.token,widget.tokenworker,widget.username);
                                  },
                                )
                            ),
                            // SizedBox(height:10,),
                            // Container(
                            //   margin: EdgeInsets.only(top: 20,left: 290),
                            //   child:Icon(Icons.wb_cloudy,size: 35,color:Color(0xFF1C1C1C)),
                            // ),
                            // SizedBox(height: 20,),
                            // Container(
                            //     height: 180,
                            //     child:GridView.builder(
                            //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            //         crossAxisCount: 3,
                            //         crossAxisSpacing: 10,
                            //         mainAxisSpacing: 20,
                            //         childAspectRatio: 2.1,
                            //       ),
                            //       itemCount: List_Pm.length,
                            //       itemBuilder: (context,index){
                            //         return time1(List_Pm[index]['timestart']+"  "+List_Pm[index]['timeend'],"Am",List_Pm[index]['id'],widget.phone,widget.phoneworker,widget.token,widget.tokenworker,widget.username);
                            //       },
                            //     )
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 55,
                    margin: EdgeInsets.only(top:13.5,),
                    color:Y,
                    width:600,
                    // margin: EdgeInsets.only(left: 8,right: 15),
                    child: FlatButton(
                      onPressed: (){
                        DateTime date=DateTime.now();
                        print(date);
                        // if(c1){
                        //
                        // }
                        // else if(c2){
                        //   Navigator.push(context, MaterialPageRoute(builder: (context) => My_SLot(date:widget.time,country:widget.country,namelast:widget.namelast,namefirst:widget.namefirst,image:widget.image,nameworker:widget.name,work:widget.work,name_Me:widget.username,phoneworker: widget.phoneworker,phone: widget.phone,),),);
                        // }/
                        int index=AB.indexOf(true);
                        print("ASDF");
                        print(index.toString());
                        final time=widget.List1[index]['timestart']+" - "+widget.List1[index]['timeend'];
                        final id=widget.List1[index]['id'];
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>description(country:widget.country,work:widget.work,namefirst:widget.namefirst,namelast:widget.namelast,image:widget.image,id:id,tokenworker:widget.tokenworker,tokenuser:widget.token_Me,username:widget.name_Me,phoneuser:widget.phone,phoneworker:widget.phoneworker,workername:widget.nameworker,)));
                      },
                      color:Y,
                      child: Text(
                        "التالي",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 21.0,
                          fontFamily: 'Changa',
                        ),
                      ),
                    ),
                  ),

                ],),);
    }
  Future<void> _dialogCall(String phone,String id,String phoneworker,String token,String workertoken,String username,String time,DateTime date) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyDialog(work:widget.work,image:widget.image,namefirst:widget.namefirst,namelast:widget.namelast,phone: phone,id:id,phoneworker:phoneworker,token:token,username:username,tokenworker:workertoken,time:time,date:date);
        });
  }
  GestureDetector time1(String time,String d,String id,String phone,String phoneworker,String token,String workertoken,String username)
{
  bool tap=false;
  return GestureDetector(
      onTap: (){
       // _dialogCall(phone,id,phoneworker,token,workertoken,username,time,_selectedDay);
        setState(() {
          tap=!tap;
        });
        print("gggggggggggggggg");
      },
      child: Container(
        // margin: EdgeInsets.only(right: 4,),
        //padding: EdgeInsets.symmetric(horizontal: 5),
        // height: 54,
        // width: 119,
        decoration: BoxDecoration(
          color: tap?Colors.white:Colors.grey[50],
          border: Border.all(color: Color(0xFF1C1C1C), width: 1.7),
          borderRadius: BorderRadius.circular(10),),
        child:Center(
          child:Container(
            color: tap?Colors.white:Colors.grey[50],
            // margin: EdgeInsets.only(right: 20),
            child:d=='am'?Row(
              children: [
                SizedBox(width: 2,),
                Text(time,
                  style: TextStyle(
                    fontFamily: 'Changa',
                    color: Color(0xFF1C1C1C),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),),
                SizedBox(width: 5,),
                Icon(Icons.wb_sunny,size: 25,color: Colors.yellow,),
              ],
            ):Row(
              children: [
                SizedBox(width: 2,),
                Text(time,
                  style: TextStyle(
                    fontFamily: 'Changa',
                    color: Color(0xFF1C1C1C),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),),
                SizedBox(width: 5,),
                Icon(Icons.cloud,size: 25,color: Colors.black,),
              ],
            ),
          ),
        ),),
  );}
}



class Empty extends StatefulWidget {
  @override
  final phone;
  final token;
  final AVG;
  final tokenworker;
  final phoneworker;
  final username;
  final namefirst;
  final namelast;
  final image;
  final work;
  List<dynamic> List1;
  final DateTime date;
  final name_Me;
  final country;
  final token_Me;
  final Information;
  final Experiance;
  final nameworker;
  final client_count;
  final comment;
  Empty({this.comment,this.client_count,this.nameworker,this.name_Me,this.country,this.token_Me,this.Information,this.Experiance,this.AVG,this.work,this.namelast,this.namefirst,this.image,this.phone,this.List1,this.date,this.tokenworker,this.phoneworker,this.token,this.username});

  _Empty createState() => _Empty();
}

class _Empty extends State<Empty> {
  CalendarController _calendarController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calendarController = CalendarController();
    // _streamController = StreamController();
  }
  @override
  void _onDaySelected(DateTime day, List events,List r) {
    _selectedDay = day;
    var dateParse = DateTime.parse(_selectedDay.toString());
    formattedDate = DateFormat('yyyy-MM-dd').format(day);
    print(formattedDate);
    if(ListBlock.isEmpty){
      print("Nulllll");
      // print(_selectedDay);
      //Navigator.push(context, MaterialPageRoute(builder: (context) => My_SLot(date:_selectedDay,phoneworker: widget.phoneworker,),),);

      Navigator.push(context, MaterialPageRoute(builder: (context) => My_SLot(client_count:widget.client_count,comment:widget.comment,country:widget.country,date:_selectedDay,namelast:widget.namelast,namefirst:widget.namefirst,image:widget.image,nameworker:widget.nameworker,Information:widget.Information,Experiance:widget.Experiance,AVG:widget.AVG,work:widget.work,name_Me:widget.name_Me,token_Me:widget.token_Me,tokenworker: widget.token,phoneworker: widget.phoneworker,phone: widget.phone,),),);

    }
  }
  @override
  int _page = 0;
  bool image=false;
  GlobalKey _bottomNavigationKey = GlobalKey();
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      color: Colors.white,
      transform: Matrix4.translationValues(0.0, -42.0, 0.0),
      child:Column(
          children:<Widget>[
            // final events = snapshot.data;
            Container(
            color:Colors.grey[50],
            child:TableCalendar(
              onDaySelected: _onDaySelected,
              calendarController: _calendarController,
              //events: events,
              initialSelectedDay: widget.date,
              initialCalendarFormat: CalendarFormat.week,
              startingDayOfWeek: StartingDayOfWeek.monday,
              formatAnimation: FormatAnimation.slide,
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonVisible: false,
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16
                ),
                leftChevronIcon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 15,),
                rightChevronIcon: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 15,),
                leftChevronMargin: EdgeInsets.only(left: 70),
                rightChevronMargin: EdgeInsets.only(right: 70),
              ),
              calendarStyle: CalendarStyle(
                  todayColor: Colors.white,
                  selectedColor: Y.withOpacity(0.9),
                  weekendStyle: TextStyle(
                      color: Colors.black
                  ),
                  weekdayStyle: TextStyle(
                      color: Colors.black
                  )
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                  weekendStyle: TextStyle(
                      color: Colors.black
                  ),
                  weekdayStyle: TextStyle(
                      color: Colors.black
                  )

              ),),),
            // Container(
            //   width: 380,
            //   child: Divider(
            //     thickness:1.0,
            //     color: Colors.black54.withOpacity(0.1),
            //   ),
            // ),
            Expanded(
              child: Container(
                width: 500,
                height: 600,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child:Column(
                  children: [
                    SizedBox(height: 200,),
                    Center(
                      child: Text('لا توجد مواعيد لعرضها في هذا اليوم',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16.0,
                          fontFamily: 'Changa',
                          fontWeight: FontWeight.bold,
                        ),),
                    ),
                  ],
                ),
                ),
              ),

          ]
      ),
    );
  }
}
class MyDialog extends StatefulWidget {
  @override
  final phone;
  final AVG;
  final id;
  final token;
  final tokenworker;
  final phoneworker;
  final username;
  final namefirst;
  final namelast;
  final image;
  final work;
  final date;
  final time;
  MyDialog({this.date,this.time,this.AVG,this.work,this.namelast,this.namefirst,this.image,this.phone,this.id,this.username,this.token,this.phoneworker,this.tokenworker});
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
            Container(
              width:500,
              height: 100,
              child: TextFormField(
                textAlign: TextAlign.right,
                //controller: text_post,
                maxLines: 20,
                controller: description,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontFamily: 'Changa',
                  fontWeight: FontWeight.bold,
                ),
               //o: Desc(),
                decoration: InputDecoration(
                  enabledBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                    borderSide:  BorderSide(color:Colors.white),

                  ),
                  focusedBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                    borderSide:  BorderSide(color:Colors.white),

                  ),
                  hintText: 'أضف تفصيل للطلب',
                  hintStyle: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Changa',
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
            desc?Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text('',textAlign:TextAlign.end,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Changa',
                  color: Colors.red,

                ),),
            ): Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text('يجب إرسال تفاصيل عن الطلب ',textAlign:TextAlign.end,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Changa',
                  color: Colors.red,

                ),),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
            ),
            Container(
              color: Y2,
              width: 200,
              child:GestureDetector(
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 125),
                      // Icon(Icons.create),
                      Text('حجز',
                        style:  TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Changa',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),),
                      SizedBox(width: 5),
                    ],
                  ),
                  onTap: () async {
                    // senddata();
                    if(description.text.isEmpty){
                      desc=false;
                    }

                    else{
                      await reserve();
                      DateTime date=DateTime.now();
                      var formattedDate = DateFormat('yyyy-MM-dd').format(date);
                      var formattedTime = DateFormat('HH:mm:ss').format(date);
                      print(widget.username);print(widget.id);print(widget.AVG);print(widget.work);
                      print(widget.date);print(widget.phoneworker);print(widget.phone);print(widget.image);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => not_conferm_user_statues(name_Me:widget.username,id:widget.id,AVG:widget.AVG,work:widget.work,timesend:formattedTime,datesend:formattedDate,date:widget.date,time:widget.time,phoneworker:widget.phoneworker,description:description.text,namefirst: widget.namefirst,namelast: widget.namelast,phoneuser: widget.phone,image: widget.image,),),);

                    }
                    setState(() {
                    });
                  }),),
          ],
        ),
      ),
    );
  }
  void Desc(){
    desc=true;
    setState(() {

    });
  }
  Future reserve()async{

    DateTime date=DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(date);
    var formattedTime = DateFormat('HH:mm:ss').format(date);
    print(widget.id);
    print(widget.phone); print(widget.username); print(widget.phoneworker);
    print(description.text); print(widget.tokenworker); print(widget.token); print(formattedDate); print(formattedTime);
    print("''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''");
    var url = 'https://'+IP4+'/testlocalhost/reserve.php';
      var ressponse = await http.post(url, body: {
        "description": description.text,
        "phone": widget.phone,
        "id": widget.id,
        "tokenuser":widget.token,
        "tokenworker":widget.tokenworker,
        "phoneworker":widget.phoneworker,
        "username":widget.username,
        "datesend":formattedDate,
        "timesend":formattedTime,
      });
      // String massage= json.decode(ressponse.body);
      // print(massage);
  }

}
