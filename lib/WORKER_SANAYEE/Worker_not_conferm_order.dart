import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterphone/Inside_the_app/user_Profile.dart';
import 'package:flutterphone/constants.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import 'State_order.dart';
import 'State_order_accept.dart';
import 'orders_workers.dart';

String IP4="192.168.1.8";

DateTime _selectedDay = DateTime.now();

class not_conferm__order extends StatefulWidget {
  final phone;
  final name;
  final DateTime time;
  not_conferm__order({this.phone,this.time,this.name});
  @override
  _not_conferm__order createState() => _not_conferm__order();
}

class _not_conferm__order extends State<not_conferm__order> {
  var List11=[];
  var ListDate11=[];
  StreamController<Map<DateTime, List>> _streamController;
  CalendarController _calendarController;
  Map<DateTime, List<dynamic>> _events;
  Future getallorders() async {
    var formattedDate = DateFormat('yyyy-MM-dd').format(widget.time);
    var url = 'https://'+IP4+'/testlocalhost/count_not_conferm.php';
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
            backgroundColor: D,
            key: _scaffoldKey,
            body: Form(
              // child:SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Image.asset(
                  //   "assets/icons/ho.jpg",
                  //   height:250,
                  //   width:450,
                  //   fit: BoxFit.fill,
                  // ),
                  // Container(
                  //   margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  //   height: 100,
                  //   decoration: BoxDecoration(
                  //     // color:ca,
                  //     gradient: LinearGradient(
                  //         begin: Alignment.topLeft,
                  //         end: Alignment.topRight,
                  //         colors: [G,A,B]),
                  //   ),
                  // ),
                  Container(
                    margin: EdgeInsets.only(top: 50,left:365),
                    child:IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,), onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => order_worker(phone: widget.phone,name:widget.name,)));
                      //  Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,)));
                      //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,)));
                    }),
                  ),
                  Container(
                    height: 500,
                    width: 500,
                    // color:  Color(0xFFF3D657),
                    margin: EdgeInsets.only(top:50),
                    //padding:EdgeInsets.only(right:25,left: 25),
                    decoration: BoxDecoration(
                      // color:Color(0xFF1C1C1C),
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
                              return order(List1:Listorder,phone: widget.phone,time: widget.time,);
                              // return slot(List1:Listslot,time: widget.time,);
                            },
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ],),),),],),);
  }
}


class order extends StatefulWidget {
  final phone;
  final DateTime time;
  List<dynamic> List1;
  order({this.phone,this.List1,this.time});
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => not_conferm__order(phone:widget.phone,time: _selectedDay,),),);

  }
  Future getallorders() async {
    var formattedDate = DateFormat('yyyy-MM-dd').format(widget.time);
    var url = 'https://'+IP4+'/testlocalhost/day_orders.php';
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
      child:Column(
        children:<Widget>[
          StreamBuilder<Map<DateTime, List>>(
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

                ),);},),
          Container(
            height: 500,
            child: Container(
              child:FutureBuilder(
                future: getallorders(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount:snapshot.data.length,
                      itemBuilder: (context, index) {
                        return new_order(timesend:snapshot.data[index]['timesend'],timeaccept:snapshot.data[index]['timeaccept'],datesend:snapshot.data[index]['datesend'],dateaccept:snapshot.data[index]['dateaccept'],image:snapshot.data[index]['image'],phoneworker:widget.phone,description:snapshot.data[index]['description'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],phone:snapshot.data[index]['phoneworker'],name:snapshot.data[index]['username'],date:snapshot.data[index]['date'],timestart:snapshot.data[index]['timestart'],timeend:snapshot.data[index]['timeend'],Am_Pm:snapshot.data[index]['Am_Pm'],id:snapshot.data[index]['id']);
                      },
                    );
                  }
                  return Center(child: Container());
                },
              ),),
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
class new_order  extends StatefulWidget {
  final  date;
  final  timeend;
  final  timestart;
  final  Am_Pm;
  final id;
  final name;
  final phone;
  final namefirst;
  final namelast;
  final image;
  final phoneworker;
  final description;
  final datesend;
  final dateaccept;
  final timesend;
  final timeaccept;
  // final  token;
  //
  new_order({this.timesend,this.timeaccept,this.datesend,this.dateaccept,this.description,this.phoneworker,this.namefirst,this.namelast,this.image,this.name,this.date, this.timeend, this.timestart, this.Am_Pm,this.id,this.phone});

  @override
  _new_order createState() => _new_order();
}
class _new_order extends State<new_order> {
  var List=[];
  var DateList=[];
  @override
  Widget build(BuildContext context) {

    return Column(
      children:[
        card(widget.date,widget.namefirst+" "+widget.namelast,widget.timestart,widget.timeend,widget.Am_Pm),
      ],
    );

  }
  GestureDetector card(String date, String name,String timestart,String timeend,String Am_Pm)
  {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => State_order(chooseDate:_selectedDay,id:widget.id,timesend:widget.timesend,datesend:widget.datesend,date:widget.date,time:widget.timestart+"-"+widget.timeend,phoneworker:widget.phoneworker,description:widget.description,namefirst: widget.namefirst,namelast: widget.namelast,phoneuser: widget.phone,image: widget.image,),),);
      },
      child:Container(
        width: 300,
        margin: EdgeInsets.only(bottom: 40,right: 10),
        padding: EdgeInsets.only(right: 20,top: 20,bottom: 20),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.grey[600],
              fontFamily: 'Changa',
            ),
            ),
            SizedBox(height: 10,),
            Text(date, style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.grey[600],
              fontFamily: 'Changa',
            ),),
            SizedBox(height: 5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.timer, color:MY_BLACK,),
                SizedBox(width: 5,),
                Text(timeend +"-" +timestart, style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[600],
                  fontFamily: 'Changa',
                ),),
                Text(" "),
                Text(Am_Pm=="am"?"صباحا":"مساء", style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[600],
                  fontFamily: 'Changa',
                ),),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                Icon(Icons.location_on),
              ],
            ),
            SizedBox(height: 5,),
            Container(
              height: 0.5,
              color: Colors.grey,
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
        // Container(
        //   padding: EdgeInsets.all(20),
        //   width: MediaQuery.of(context).size.width*0.2,
        //   child: Text(date, style: TextStyle(
        //     color: Colors.black,
        //     fontWeight: FontWeight.w700,
        //   ), textAlign: TextAlign.right,),
        // ),
      ),);
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      //this means the user must tap a button to exit the Alert Dialog
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(right: 50,left:10,top: 30),
          titlePadding: EdgeInsets.only(right: 50,left:50,top: 30),
          content: Text('هل تريد حذف هذا الطلب ',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
              fontFamily: 'Changa',
            ),),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10,bottom: 20,top: 30),
              child:FlatButton(
                child: Text('نعم',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontFamily: 'Changa',
                  ),),
                onPressed: () {
                  //h(context,MaterialPageRoute(builder: (BuildContext context) =>work_order(phone: widget.phone,List1: List,ListDate:DateList,)));
                },
              ),),
            Container(
              margin: EdgeInsets.only(left: 10,bottom: 20,top: 30),
              child:FlatButton(
                child: Text('لا',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontFamily: 'Changa',
                  ),),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),),
          ],
        );
      },
    );
  }
  Future<void> _showMyAccept() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      //this means the user must tap a button to exit the Alert Dialog
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(right: 50,left:10,top: 30),
          titlePadding: EdgeInsets.only(right: 50,left:50,top: 30),
          content: Text('هل تريد قبول هذا الطلب ',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
              fontFamily: 'Changa',
            ),),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10,bottom: 20,top: 30),
              child:FlatButton(
                child: Text('نعم',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontFamily: 'Changa',
                  ),),
                onPressed: () {
                  //sh(context,MaterialPageRoute(builder: (BuildContext context) =>work_order(phone: widget.phone,List1: List,ListDate:DateList,)));
                },
              ),),
            Container(
              margin: EdgeInsets.only(left: 10,bottom: 20,top: 30),
              child:FlatButton(
                child: Text('لا',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontFamily: 'Changa',
                  ),),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),),
          ],
        );
      },
    );
  }
  Future delete (final id)async{
    var url = 'https://'+IP4+'/testlocalhost/deleteorder.php';
    var response = await http.post(url, body: {
      "id":id,
    });
    String massage = json.decode(response.body);
    print(massage);
    setState(() {

    });
  }
  Future accept (final id)async{
    var url = 'https://'+IP4+'/testlocalhost/acceptorder.php';
    var response = await http.post(url, body: {
      "id":id,
    });
    // String massage = json.decode(response.body);
    // print(massage);
  }

}