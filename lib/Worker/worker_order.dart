import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterphone/screens/home.dart';
import 'package:table_calendar/table_calendar.dart';
import '../constants.dart';
import 'ColorScheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

String IP4="192.168.1.8";

DateTime _selectedDay = DateTime.now();
var dateParse = DateTime.parse(_selectedDay.toString());
var formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDay);



class work_order extends StatefulWidget {
  final phone;
  List<dynamic> List1;
  List<dynamic> ListDate;
  work_order({this.phone,this.List1,this.ListDate});
  @override
  _work_order createState() => _work_order();
}

class _work_order extends State<work_order> {
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

  Future getallorders() async {
    var url = 'https://'+IP4+'/testlocalhost/day_orders.php';
    var ressponse = await http.post(url, body: {
      "phone": widget.phone,
      "date": formattedDate,
    });
    return json.decode(ressponse.body);
  }

  void _fetchEvents() {
    List11=widget.List1;
    ListDate11=widget.ListDate;
    int i=0;
    print(widget.List1);
    Map<DateTime, List<dynamic>> _events={};
    DateTime date;
    widget.List1.forEach(
          (element) {
        date = DateTime.tryParse(widget.ListDate[i]);i++;
        if (_events[date] == null) _events[date] = [];
        _events[date].add(element);
      },
    );
    _streamController.add(_events);
  }
  void _onDaySelected(DateTime day, List events,List r) {
    setState(() {
      _selectedDay = day;
      var dateParse = DateTime.parse(_selectedDay.toString());
      formattedDate = DateFormat('yyyy-MM-dd').format(day);
      print(formattedDate);

      print(_selectedDay);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
           height: 700,
        child:Column(
              children:<Widget>[
                Container(

                ),
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
                SizedBox(height: 5,),

                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                        color:MY_BLACK,
                    ),
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [

                            Row(
                              children: [
                                // IconButton(
                                //     icon: Icon(Icons.description), onPressed: (){
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(builder: (context) => HomeScreen(List1:List1,ListDate:ListDate),));
                                // }
                                // ),
                              ],
                            ),
                            SizedBox(height: 15,),

                            Container(
                              height: 500,
                              child:FutureBuilder(
                                future: getallorders(),
                                builder: (BuildContext context, AsyncSnapshot snapshot) {
                                  if(snapshot.hasData){
                                    return ListView.builder(
                                      itemCount:snapshot.data.length,
                                      itemBuilder: (context, index) {
                                        return new_order(List1:List11,ListDate:ListDate11,phone:snapshot.data[index]['phoneworker'],name:snapshot.data[index]['username'],date:snapshot.data[index]['date'],timestart:snapshot.data[index]['timestart'],timeend:snapshot.data[index]['timeend'],Am_Pm:snapshot.data[index]['Am_Pm'],id:snapshot.data[index]['id']);
                                      },
                                    );
                                  }
                                  return Center(child: CircularProgressIndicator());
                                },
                              ),),
                            // Column(
                            //   children: [
                            //     dayTask("10 am", "Michael Hamilton"),
                            //     dayTask("11 am", "Alexandra Johnson"),
                            //     dayTask("2 pm", "Michael Hamilton"),
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]),);
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
  List<dynamic> List1;
  List<dynamic> ListDate;

  // final  token;
  //
  new_order({this.name,this.date, this.timeend, this.timestart, this.Am_Pm,this.id,this.phone,this.ListDate,this.List1});

  @override
  _new_order createState() => _new_order();
}

class _new_order extends State<new_order> {
  var List=[];
  var DateList=[];
  @override
  Widget build(BuildContext context) {
    List=widget.List1;
    DateList=widget.ListDate;

    return Column(
      children:[
        card(widget.date,widget.name,widget.timestart,widget.timeend,widget.Am_Pm),
      ],
    );

  }
  Row card(String date, String name,String timestart,String timeend,String Am_Pm)
  {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
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
                Column(
                  children: [

                  ],
                )

              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top:150),
          child:IconButton(
            onPressed: _showMyAccept,
            icon: Icon(Icons.check,
              size: 40.0,
              color:MY_YELLOW,),
          ),
        ),
        // GestureDetector(
        //   child:Container(
        //     width: 50,
        //     height: 50,
        //     child:ClipRect(
        //      child:Image.asset('assets/icons/check1.jpg')
        //     ),
        //   ),
        // ),
        Container(
          margin: EdgeInsets.only(top:150),
          child:IconButton(
            onPressed: _showMyDialog,
            icon: Icon(Icons.close,
              size: 40.0,
              color: Colors.grey.withOpacity(0.5),),
          ),// This trailing comma makes auto-formatting nicer for build methods.
        ),
        // Container(
        //   padding: EdgeInsets.all(20),
        //   width: MediaQuery.of(context).size.width*0.2,
        //   child: Text(date, style: TextStyle(
        //     color: Colors.black,
        //     fontWeight: FontWeight.w700,
        //   ), textAlign: TextAlign.right,),
        // ),
      ],
    );
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
                  final id =widget.id;

                  print(id);
                  print(widget.timestart);
                  print(widget.List1);
                  print(widget.ListDate);
                  int i=widget.List1.indexOf(id);
                  widget.List1.remove(id);
                  widget.ListDate.removeAt(i);
                  List=widget.List1;
                  DateList=widget.ListDate;
                  delete(id);
                  setState(() {
                    widget.List1=List;
                    widget.ListDate=DateList;
                  });
                  Navigator.pop(context);
                 // Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>work_order(phone: widget.phone,List1: List,ListDate:DateList,)));
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
                  final id =widget.id;

                  print(widget.id);
                  print(widget.List1);
                  int i=widget.List1.indexOf(id);
                  widget.List1.remove(id);
                  widget.ListDate.removeAt(i);
                  List=widget.List1;
                  DateList=widget.ListDate;
                  accept(id);
                  setState(() {
                    widget.List1=List;
                    widget.ListDate=DateList;
                  });
                  Navigator.pop(context);
                 // Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>work_order(phone: widget.phone,List1: List,ListDate:DateList,)));
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



