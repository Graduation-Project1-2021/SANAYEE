import 'dart:async';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/Inside_the_app/user_Profile.dart';
import 'package:flutterphone/Worker/ColorScheme.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import '../constants.dart';
import 'WORKER_PROFILE.dart';
import 'WORKER_PROFILE.dart';
import 'WORKER_PROFILE.dart';
var ListBlock=[];
String IP4="192.168.1.8";
String name="";
DateTime _selectedDay = DateTime.now();
var dateParse = DateTime.parse(_selectedDay.toString());
var formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDay);
var ListTime1=["6:00 - 8:00","8:00 - 10:00","10:00 - 12:00","12:00 - 2:00",];
var ListTime2=["2:00 - 4:00","4:00 - 6:00","6:00 - 8:00","8:00 - 10:00",];

class user_order extends StatefulWidget {
  final phone;
  List<dynamic> List1;
  List<dynamic> ListDate;
  user_order({this.phone,this.List1,this.ListDate});
  @override
  _user_order createState() => _user_order();
}

class _user_order extends State<user_order> {
  var List11=[];
  var ListDate11=[];
  StreamController<Map<DateTime, List>> _streamController;
  CalendarController _calendarController;
  Map<DateTime, List<dynamic>> _events;
 // var ListBlock=["8.00 - 9.00 ","9.00 - 10.00","","","",];
  Future getList() async {
    var url = 'https://' + IP4 + '/testlocalhost/getList.php';
    var ressponse = await http.post(url, body: {
      "phone": widget.phone,
      "date":formattedDate,
    });
     ListBlock=[];
    var responsepody = json.decode(ressponse.body);
    for (int i = 0; i < responsepody.length; i++) {
      String start_to_end=responsepody[i]['timestart']+" "+"-"+" "+responsepody[i]['timeend'];
      print("fgggggggggggggggggggggggggggggggggggggggggg");
      ListBlock.add(start_to_end);
      print(ListBlock);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calendarController = CalendarController();
    _streamController = StreamController();
    getList();
    _fetchEvents();
  }
  @override
  void dispose() {
    _calendarController.dispose();
    _streamController.close();
    super.dispose();
  }

  Future getallorders() async {
    var url = 'https://'+IP4+'/testlocalhost/day_order_accept.php';
    var ressponse = await http.post(url, body: {
      "phone": widget.phone,
      "date": formattedDate,
    });
    return json.decode(ressponse.body);
  }

  void _fetchEvents() {
    // List11=widget.List1;
    // ListDate11=widget.ListDate;
    // int i=0;
    // print(widget.List1);
    // Map<DateTime, List<dynamic>> _events={};
    // DateTime date;
    // widget.List1.forEach(
    //       (element) {
    //     date = DateTime.tryParse(widget.ListDate[i]);i++;
    //     if (_events[date] == null) _events[date] = [];
    //     _events[date].add(element);
    //   },
    // );
    // _streamController.add(_events);
  }
  void _onDaySelected(DateTime day, List events,List r) {
    setState(() {
      _selectedDay = day;
      var dateParse = DateTime.parse(_selectedDay.toString());
      formattedDate = DateFormat('yyyy-MM-dd').format(day);
      print(formattedDate);
      getList();
      cheack1();
      print(_selectedDay);
    });
    setState(() {
      
    });
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
  @override
  int _page = 0;
  bool image=false;
  GlobalKey _bottomNavigationKey = GlobalKey();
  Widget build(BuildContext context) {
    return  Directionality( textDirection: ui.TextDirection.rtl,
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
                 if (_page == 0) {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name:name,)));}
                 // if(_page==1){
                 //   Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>SettingPage(name: widget.name,phone: phone,image: image,Work: Work,Experiance: Experiance,Information: Information,token: token,)));
                 // }
                 });
                 },
            ),
                 backgroundColor: Color(0xFF1C1C1C),
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
              ),
    // backgroundColor: Colors.lightBlueAccent,
    body: Form(
    child:Container(
           height: 670,
          color: MY_YELLOW,
          child:Column(
              children:<Widget>[
                Container(),
                //StreamBuilder<Map<DateTime, List>>(
                  // stream: _streamController.stream,
                  // builder: (context, snapshot) {
                  //   if (!snapshot.hasData) {
                  //     return SizedBox(
                  //       height: 100.0,
                  //       width: 100.0,
                  //       child: Center(child: CircularProgressIndicator()),
                  //     );
                  //   }

                    // final events = snapshot.data;
                     TableCalendar(
                      onDaySelected: _onDaySelected,
                      calendarController: _calendarController,
                      //events: events,
                      initialCalendarFormat: CalendarFormat.week,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      formatAnimation: FormatAnimation.slide,
                      headerStyle: HeaderStyle(
                        centerHeaderTitle: true,
                        formatButtonVisible: false,
                        titleTextStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                        ),
                        leftChevronIcon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 15,),
                        rightChevronIcon: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 15,),
                        leftChevronMargin: EdgeInsets.only(left: 70),
                        rightChevronMargin: EdgeInsets.only(right: 70),
                      ),
                      calendarStyle: CalendarStyle(

                          todayColor: Color(0xFF1C1C1C),
                          selectedColor: Color(0xFFD9BC43),
                          weekendStyle: TextStyle(
                              color: Colors.white
                          ),
                          weekdayStyle: TextStyle(
                              color: Colors.white
                          )
                      ),
                      daysOfWeekStyle: DaysOfWeekStyle(
                          weekendStyle: TextStyle(
                              color: Colors.white
                          ),
                          weekdayStyle: TextStyle(
                              color: Colors.white
                          )

                      ),),
                      SizedBox(height: 5,),
                      SizedBox(height: 5,),
                Expanded(
                  child: Container(
                    width: 500,
                    height: 500,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                        color: MY_BLACK,
                    ),

                    child: Container(
                      height: 500,
                      margin: EdgeInsets.only(right: 1),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            cheack1(),
                            cheack2(),
                            Container(
                              margin: EdgeInsets.only(top: 20,left: 290),
                             child:Icon(Icons.wb_sunny,size: 50,color: Colors.yellow,),
                            ),
                            //IconData(Icons.wb_sunny),),
                            SizedBox(height: 20,),
                            Container(
                              height: 200,
                              child:GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 20,
                                  childAspectRatio: 2.2,
                                ),
                                itemCount: ListTimeSlot1.length,
                                itemBuilder: (context,index){
                                  return time1(ListTimeSlot1[index],"Am");
                                },
                              )
                            ),

                            SizedBox(height: 50,),
                            // Container(
                            //   margin: EdgeInsets.only(top: 20,left: 220),
                            //   child:Icon(Icons.wb_cloudy,size: 100,color:Color(0xFF1C1C1C)),
                            // ),
                            Container(

                                height: 200,
                                child:GridView.builder(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 20,
                                    childAspectRatio: 2.2,
                                  ),
                                  itemCount: ListTimeSlot2.length,
                                  itemBuilder: (context,index){
                                    if(ListBlock.contains(ListTimeSlot2[index])){
                                      while(true){
                                        index++;
                                        if(!ListBlock.contains(ListTime2[index])){break;}
                                      }
                                      print(index);
                                    }
                                    return time1(ListTime2[index],"Pm");
                                  },
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              ]
          ),
    ),),),);
  }
}
Container time1(String time,String d)
{
  return Container(
    child:GestureDetector(
      onTap: (){},
      child: Container(
        margin: EdgeInsets.only(right: 4,),
        //padding: EdgeInsets.symmetric(horizontal: 5),
       // height: 54,
       // width: 119,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFF1C1C1C), width: 1.7),
          borderRadius: BorderRadius.circular(20),),
        child:Center(
            child:Container(
              color: Colors.white,
              // margin: EdgeInsets.only(right: 20),
              child:Text(time,
                style: TextStyle(
                  fontFamily: 'Changa',
                  color: Color(0xFF1C1C1C),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),),
            ),
        ),),
    ),
  );}
Container time2(String time,String d)
{
  if(ListBlock.contains(time)){
    return Container();

  }
  else
  {
  return Container(
    child:GestureDetector(
      onTap: (){},
      child: Container(
        margin: EdgeInsets.only(right: 8,),
        padding: EdgeInsets.symmetric(horizontal: 5),
        height: 54,
        width: 115,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1.7),
          borderRadius: BorderRadius.circular(20),),
        child: Row(
          children: <Widget>[
            Container(
              color: Colors.white,
              // margin: EdgeInsets.only(right: 20),
              child:Text(time,
                style: TextStyle(
                  fontFamily: 'Changa',
                  color: Color(0xFFECCB45),
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),),
            ),
          ],
        ),),
    ),
  );}
}
