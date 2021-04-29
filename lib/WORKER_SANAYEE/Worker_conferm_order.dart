import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterphone/Inside_the_app/user_Profile.dart';
import 'package:flutterphone/USER/user_search_map.dart';
import 'package:flutterphone/WORKER_SANAYEE/State_order_accept.dart';
import 'package:flutterphone/constants.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import 'Profile.dart';
import 'orders_workers.dart';

String IP4="192.168.1.8";

DateTime _selectedDay = DateTime.now();

class accept_order extends StatefulWidget {
  final phone;
  final DateTime time;
  final name;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;
  final namefirst;
  final namelast;
  final lat;
  final lng;
  accept_order({this.lat,this.lng,this.phone,this.time,this.name,this.namefirst,this.namelast,this.image,this.Work, this.Experiance, this.Information, this.token});
  @override
  _accept_order createState() => _accept_order();
}

class _accept_order extends State<accept_order> {
  var List11=[];
  var ListDate11=[];
  StreamController<Map<DateTime, List>> _streamController;
  CalendarController _calendarController;
  Map<DateTime, List<dynamic>> _events;
  Future getallorders() async {
    var formattedDate = DateFormat('yyyy-MM-dd').format(widget.time);
    var url = 'https://'+IP4+'/testlocalhost/count.php';
    var ressponse = await http.post(url, body: {
      "phone": widget.phone,
    });
    return json.decode(ressponse.body);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calendarController = CalendarController();
    _streamController = StreamController();
    //_fetchEvents();
  }
  @override
  void dispose() {
    _calendarController.dispose();
    _streamController.close();
    super.dispose();
  }
  // void _fetchEvents() {
  //   List11=widget.List1;
  //   ListDate11=widget.ListDate;
  //   int i=0;
  //   print(widget.List1);
  //   Map<DateTime, List<dynamic>> _events={};
  //   DateTime date;
  //   widget.List1.forEach(
  //         (element) {
  //       date = DateTime.tryParse(widget.ListDate[i]);i++;
  //       if (_events[date] == null) _events[date] = [];
  //       _events[date].add(element);
  //     },
  //   );
  //   _streamController.add(_events);
  // }
  void _onDaySelected(DateTime day, List events,List r) {
    setState(() {
      _selectedDay = day;
      var dateParse = DateTime.parse(_selectedDay.toString());

      print(_selectedDay);
    });
  }
  @override
  Widget build(BuildContext context) {
   // print(Listsearch.toString());
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Directionality(textDirection: ui.TextDirection.rtl,
      child:Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.grey[50],
            key: _scaffoldKey,
            body: Form(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => order_worker(lat:widget.lat,lng:widget.lng,Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,name:widget.name,phone:widget.phone,image:widget.image,token:widget.token,namefirst:widget.namefirst)));},
                    child:Container(
                      margin: EdgeInsets.only(top:70,left:370),
                      child:Icon(Icons.arrow_back,color: Colors.black,),),
                  ),
                  SingleChildScrollView(
                    child:  Container(
                      height: 702,
                      width: 500,
                      margin: EdgeInsets.only(top: 0),
                      // color:  Color(0xFFF3D657),
                      //padding:EdgeInsets.only(right:25,left: 25),
                      decoration: BoxDecoration(
                        color:Colors.grey[50],
                        // borderRadius: BorderRadius.only(
                        //   topLeft: Radius.circular(50),
                        //   topRight: Radius.circular(50),
                        // ),
                      ),
                      child:FutureBuilder(
                        future: getallorders(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if(snapshot.hasData){
                            return ListView.builder(
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                var Listorder=snapshot.data;
                                //if(Listslot=='NO Date'){return Container();}
                                return order(lat:widget.lat,lng:widget.lng,List1:Listorder,phone: widget.phone,time: widget.time,workername:widget.name,Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst,);
                                // return slot(List1:Listslot,time: widget.time,);
                              },
                            );
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  ),
                ],),),),],),);
  }
}


class order extends StatefulWidget {
  final phone;
  final workername;
  final DateTime time;
  List<dynamic> List1;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;
  final namefirst;
  final namelast;
  final lat;
  final lng;
  order({this.lat,this.lng,this.workername,this.phone,this.List1,this.time,this.namefirst,this.namelast,this.image,this.Work, this.Experiance, this.Information, this.token});
  @override
  _order createState() => _order();
}

class _order extends State<order> {
  var List11=[];
  var ListDate11=[];
  StreamController<Map<DateTime, List>> _streamController;
  CalendarController _calendarController;
  Map<DateTime, List<dynamic>> _events;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calendarController = CalendarController();
    _streamController = StreamController();
    _fetchEvents();
  }
  @override
  void dispose() {
    _calendarController.dispose();
    _streamController.close();
    super.dispose();
  }

  // Future getallorders() async {
  //   var url = 'https://'+IP4+'/testlocalhost/day_order_accept.php';
  //   var ressponse = await http.post(url, body: {
  //     "phone": widget.phone,
  //     "date": formattedDate,
  //   });
  //   return json.decode(ressponse.body);
  // }

  void _fetchEvents() {
    int i=0;
    print(widget.List1);
    Map<DateTime, List<dynamic>> _events={};
    DateTime date;
    widget.List1.forEach(
          (element) {
        date = DateTime.tryParse(widget.List1[i]['date']);i++;
        if (_events[date] == null) _events[date] = [];
        _events[date].add(element);
      },
    );
    _streamController.add(_events);
  }
  void _onDaySelected(DateTime day, List events,List r) {
    _selectedDay = day;
    var dateParse = DateTime.parse(_selectedDay.toString());
    var formattedDate = DateFormat('yyyy-MM-dd').format(day);
    print(formattedDate);
      print("Nulllll");
      // print(_selectedDay);
      Navigator.push(context, MaterialPageRoute(builder: (context) => accept_order(lat:widget.lat,lng:widget.lng,name:widget.workername,phone:widget.phone,time: _selectedDay,Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst,),),);

  }
  Future getallorders() async {
    var formattedDate = DateFormat('yyyy-MM-dd').format(widget.time);
    var url = 'https://'+IP4+'/testlocalhost/day_order_accept.php';
    var ressponse = await http.post(url, body: {
      "phone": widget.phone,
      "date": formattedDate,
    });
    return json.decode(ressponse.body);
  }

  @override
  Widget build(BuildContext context) {
    _fetchEvents();
    print(widget.List1);
    return Container(
      height: 700,
      transform: Matrix4.translationValues(0.0, -42.0, 0.0),
      color: Colors.white,
      child:Column(
        children:<Widget>[
          Container(color: Colors.grey[50],
          child:StreamBuilder<Map<DateTime, List>>(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SizedBox(
                  height: 100.0,
                  width: 100.0,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final events = snapshot.data;
              return TableCalendar(
                onDaySelected: _onDaySelected,

                calendarController: _calendarController,
                events: events,
                initialSelectedDay: widget.time,
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
                  leftChevronIcon: Icon(Icons.arrow_back_ios, color:Colors.black, size: 15,),
                  rightChevronIcon: Icon(Icons.arrow_forward_ios, color:Colors.black, size: 15,),
                  leftChevronMargin: EdgeInsets.only(left: 70),
                  rightChevronMargin: EdgeInsets.only(right: 70),
                ),
                calendarStyle: CalendarStyle(
                    todayColor: Colors.grey[200],
                    selectedColor: Y,
                    weekendStyle: TextStyle(
                        color: Colors.black
                    ),
                    weekdayStyle: TextStyle(
                        color: Colors.black
                    )
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                    weekendStyle: TextStyle(
                      color: Colors.black,
                    ),
                    weekdayStyle: TextStyle(
                        color: Colors.black
                    )

                ),);},) ,),
              Container(
                height: 532,
                color: Colors.white,
                margin: EdgeInsets.only(top: 35),
                child: Container(
                  child:FutureBuilder(
                    future: getallorders(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if(snapshot.hasData){
                        if(snapshot.data.length==0) {
                          return Empty();
                        }
                        return ListView.builder(
                          itemCount:snapshot.data.length,
                          itemBuilder: (context, index) {
                            print(snapshot.data[index]['id']);
                            print('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm');
                            DateTime date=DateTime.parse("2020-05-12 "+snapshot.data[index]['timesend'].toString());
                            DateTime acc=DateTime.parse("2020-05-12 "+snapshot.data[index]['timeaccept'].toString());
                            return order_accept(namefirstworker:widget.namefirst,namelastworker:widget.namelast,tokenworker:widget.token,imageworker:widget.image,work:widget.Work,Information:widget.Information,Experiance:widget.Experiance,lnguser:snapshot.data[index]['lng'],latuser:snapshot.data[index]['lat'],lat:widget.lat,lng:widget.lng,city:snapshot.data[index]['city'],country:snapshot.data[index]['country'],orderimage:snapshot.data[index]['orderimage'],workername:widget.workername,ChooseDate:_selectedDay,timesend:date.hour.toString()+":"+date.minute.toString(),timeaccept:acc.hour.toString()+":"+acc.minute.toString(),datesend:snapshot.data[index]['datesend'],dateaccept:snapshot.data[index]['dateaccept'],image:snapshot.data[index]['image'],phoneworker:widget.phone,description:snapshot.data[index]['description'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],phone:snapshot.data[index]['phoneuser'],name:snapshot.data[index]['username'],date:snapshot.data[index]['date'],timestart:snapshot.data[index]['timestart'],timeend:snapshot.data[index]['timeend'],Am_Pm:snapshot.data[index]['Am_Pm'],id:snapshot.data[index]['id']);
                            },
                        );
                      }
                      return Center(child: Container());
                      },
                  ),
                ),
                // Column(
                //   children: [
                                  //     dayTask("10 am", "Michael Hamilton"),
                //     dayTask("11 am", "Alexandra Johnson"),
                                  //     dayTask("2 pm", "Michael Hamilton"),
                //   ],
                                  // )
                              ),
            ],),);
  }
}

class Empty extends StatefulWidget {
  @override
  final phone;
  final DateTime time;
  final name;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;
  final namefirst;
  final namelast;
  final lat;
  final lng;
  Empty({this.lat,this.lng,this.phone,this.time,this.name,this.namefirst,this.namelast,this.image,this.Work, this.Experiance, this.Information, this.token});
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
    var formattedDate = DateFormat('yyyy-MM-dd').format(day);
    print(formattedDate);
    print("Nulllll");
    // print(_selectedDay);
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => accept_order(lat:widget.lat,lng:widget.lng,Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst,name:widget.name,phone: widget.phone,time:_selectedDay,)));

  }
  @override
  int _page = 0;
  bool image = false;
  GlobalKey _bottomNavigationKey = GlobalKey();

  Widget build(BuildContext context) {
    return Container(
      height: 650,
      // transform: Matrix4.translationValues(0.0, -100.0, 0.0),
      color: Colors.white,
      child: Column(
          children: <Widget>[
            // final events = snapshot.data;
            Expanded(
              child: Container(
                width: 500,
                height: 400,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 150,),
                    Center(
                      child: Text('لا توجد لديك مواعيد في هذا اليوم',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15.0,
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




class order_accept  extends StatefulWidget {
  final  date;
  final  timeend;
  final  timestart;
  final  Am_Pm;
  final AVG;
  final id;
  final Information;
  final Experiance;
  final name;
  final phone;
  final namefirst;
  final namelast;
  final image;
  final work;
  final country;
  final phoneworker;
  final description;
  final time;
  final datesend;
  final dateaccept;
  final timesend;
  final timeaccept;
  final datecancel;
  final timecancel;
  final  token;
  final workertoken;
  final index;
  final ChooseDate;
  final workername;
  final orderimage;
  final city;
  final lat;
  final lng;
  final latuser;
  final lnguser;
  final namefirstworker;
  final namelastworker;
  final imageworker;
  final tokenworker;
  //
  order_accept({this.namefirstworker,this.namelastworker,this.imageworker,this.tokenworker,this.Experiance,this.Information,this.work,this.latuser,this.lnguser,this.lng,this.lat,this.city,this.orderimage,this.workername,this.ChooseDate,this.datecancel,this.timecancel,this.index,this.AVG,this.token,this.workertoken,this.timeaccept,this.dateaccept,this.datesend,this.timesend,this.description,this.id,this.country,this.phoneworker,this.image,this.namefirst,this.namelast,this.name,this.date, this.timeend, this.timestart, this.Am_Pm,this.phone, this.time});

  @override
  _order_accept createState() => _order_accept();
}
class _order_accept extends State<order_accept> {
  var List=[];
  var DateList=[];
  @override
  Widget build(BuildContext context) {

    return Column(
      children:[
        card(widget.date,widget.namefirst+" "+widget.namelast,widget.timestart,widget.timeend,widget.Am_Pm,widget.image,widget.work),
      ],
    );

  }
  GestureDetector card(String date, String name,String timestart,String timeend,String Am_Pm,String image,String work)
  {
    return GestureDetector(
      onTap: (){
        print("SDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD"+widget.workername);
        Navigator.push(context, MaterialPageRoute(builder: (context) => State_order_accept(tokenworker:widget.tokenworker,imageworker:widget.imageworker,namelastworker:widget.namelastworker,namefirstworker:widget.namefirstworker,Experiance:widget.Experiance,Information:widget.Information,work:widget.work,country:widget.country,city:widget.city,latuser:widget.latuser,lnguser:widget.lnguser,lat:widget.lat,lng:widget.lng,Am_Pm:widget.Am_Pm,orderimage:widget.orderimage,workername:widget.workername,ChooseDate:widget.ChooseDate,name:widget.name,id:widget.id,timesend:widget.timesend,timeaccept:widget.timeaccept,dateaccept:widget.dateaccept,datesend:widget.datesend,date:widget.date,time:widget.timestart+" - "+widget.timeend,phoneworker:widget.phoneworker,description:widget.description,namefirst: widget.namefirst,namelast: widget.namelast,phoneuser: widget.phone,image: widget.image,),),);
      },
      child:Container(
        width: 380,
        height: 165,
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
          color:Colors.grey[50],
          borderRadius: BorderRadius.circular(5),
        ),
        margin: EdgeInsets.only(bottom: 20,),
        padding: EdgeInsets.only(right: 20,top: 20,bottom: 10),
        child:Column(
          children: [
            // Container(
            //   margin: EdgeInsets.only(top: 10, right: 5),
            //   child: CircleAvatar(backgroundImage: NetworkImage(
            //       'https://' + IP4 + '/testlocalhost/upload/' + widget.image),
            //     radius: 25.0,),),
            Container(
              alignment: Alignment.topRight,
              child:Row(
                children: [
                  Text('اسم العميل    ', style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    fontFamily: 'Changa',
                  ),
                  ),
                  Text(widget.namefirst+" "+widget.namelast, style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54,
                    fontFamily: 'Changa',
                  ),
                  ),
                ],
              ),

            ),
            Container(
              width: 370,
              margin: EdgeInsets.only(top:3),
              child:  Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width:83,
                    child:Text('الوقت', style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      fontFamily: 'Changa',
                    ),
                    ),
                  ),
                  // Icon(Icons.access_time_rounded,size:20,color:Colors.black87,),
                  // SizedBox(width: 30,),
                  Container(child:Row(
                    children: [
                      Text(timestart +" - " +timeend, style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54,
                        fontFamily: 'Changa',
                      ),),
                      Text(" "),
                      Text(Am_Pm=="am"?"صباحا":"مساء", style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54,
                        fontFamily: 'Changa',
                      ),),
                    ],
                  ),),
                ],
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(top:3),
              child:Row(
                children: [
                  Text('الموقع  ', style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    fontFamily: 'Changa',
                  ),
                  ),
                  SizedBox(width: 30,),
                  Text(""+widget.country+" ("+widget.city+") ", style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54,
                    fontFamily: 'Changa',
                  ),
                  ),
                  Icon(Icons.location_on,size:20,color:Colors.black87,),
                ],
              ),

            ),

            SizedBox(height:10,),
            // Row(
            //   children: [
            //     Container(
            //       width:110,
            //       child:Text('التاريخ', style: TextStyle(
            //         fontSize: 14,
            //         fontWeight: FontWeight.w700,
            //         color: Colors.black87,
            //         fontFamily: 'Changa',
            //       ),
            //       ),
            //     ),
            //     Container(
            //       width:170,
            //       child:Text('الوقت', style: TextStyle(
            //         fontSize: 14,
            //         fontWeight: FontWeight.w700,
            //         color: Colors.black87,
            //         fontFamily: 'Changa',
            //       ),
            //       ),
            //     ),
            //   ],
            // ),
            // Container(
            //   width: 370,
            //   child:  Row(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Directionality(textDirection: ui.TextDirection.ltr,
            //         child:Container(
            //           width: 110,
            //           alignment: Alignment.topRight,
            //           child:Text(date, style: TextStyle(
            //             fontSize: 14,
            //             fontWeight: FontWeight.w700,
            //             color: Colors.black54,
            //             fontFamily: 'Changa',
            //           ),),),
            //       ),
            //       Container(child:Row(
            //         children: [
            //           Text(timeend +" - " +timestart, style: TextStyle(
            //             fontSize: 14,
            //             fontWeight: FontWeight.w700,
            //             color: Colors.black54,
            //             fontFamily: 'Changa',
            //           ),),
            //           Text(" "),
            //           Text(Am_Pm=="am"?"صباحا":"مساء", style: TextStyle(
            //             fontSize: 15,
            //             fontWeight: FontWeight.w700,
            //             color: Colors.black54,
            //             fontFamily: 'Changa',
            //           ),),
            //         ],
            //       ),),
            //     ],
            //   ),
            // ),
            Container(
              margin:EdgeInsets.only(top: 10.0,right:280),
              child: Row(
                children: [
                  GestureDetector(
                    child: Container(
                      child: Row(
                        children: [
                          Text('عرض المزيد',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Y,
                              fontFamily: 'Changa',
                            ),),
                          // Icon(Icons.keyboard_arrow_down,size: 20,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Divider(
            //   color: Colors.black54,
            //   thickness: 1.0,
            // ),
          ],
        ),),
      // Container(
      //   padding: EdgeInsets.all(20),
      //   width: MediaQuery.of(context).size.width*0.2,
      //   child: Text(date, style: TextStyle(
      //     color: Colors.black,
      //     fontWeight: FontWeight.w700,
      //   ), textAlign: TextAlign.right,),
      // ),
    );
  }

}
