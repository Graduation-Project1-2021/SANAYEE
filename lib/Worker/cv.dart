import 'dart:async';
import 'dart:math';
import 'ColorScheme.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
String IP4="192.168.1.8";

DateTime _selectedDay = DateTime.now();
var dateParse = DateTime.parse(_selectedDay.toString());
//var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
var formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDay);

class HomeScreen extends StatefulWidget {
  List<dynamic> List1;
  List<dynamic> ListDate;
  HomeScreen({this.ListDate,this.List1});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CalendarController _calendarController;
  StreamController<Map<DateTime, List>> _streamController;
   Map<DateTime, List<dynamic>> _events;
  @override
  void initState() {
    //getdata();
    super.initState();
    _calendarController = CalendarController();
    _streamController = StreamController();
    _fetchEvents();
    //_events=_gruopTurns(widget.List1);
  }

  @override
  void dispose() {
    _calendarController.dispose();
    _streamController.close();
    super.dispose();
  }
  Future getorders() async {
    var url = 'https://'+IP4+'/testlocalhost/orders.php';
    var ressponse = await http.post(url, body: {
      "date": _selectedDay,
      "phone": '+970595320479',
    });
    return json.decode(ressponse.body);
  }
  Future getallorders() async {
    var url = 'https://'+IP4+'/testlocalhost/allorders.php';
    var ressponse = await http.post(url, body: {
      "phone": '+970595320479',
    });
    return json.decode(ressponse.body);
  }
  void _onDaySelected(DateTime day, List events,List r) {
    setState(() {
      _selectedDay = day;
      var dateParse = DateTime.parse(_selectedDay.toString());
      formattedDate = DateFormat('yyyy-MM-dd').format(day);
      print(formattedDate);

      print(_selectedDay);
    });
    // _events.forEach((key, value) {//
  }
  // void _onDaySelected(DateTime day, List events,List r) {
  //   setState(() {
  //     _selectedDay = day;
  //     _selectedEvents = events;
  //     // _events.forEach((key, value) {
  //     //
  //     // });
  //     var dateParse = DateTime.parse(_selectedDay.toString());
  //     var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
  //     var finalDate = formattedDate.toString() ;
  //     print(finalDate);
  //     VB();
  //   });
  //   void Print(){
  //     print("kkk");
  //   }
  // }
  Map<DateTime, List<dynamic>> _gruopTurns(List turns) {
    Map<DateTime, List<dynamic>> data = {};
    DateTime date;
    turns[0].forEach(
          (element) {
        //date = DateTime.tryParse(element['dateTime']);
        //if (data[date] == null) data[date] = [];
        //data[date].add(turns);
        data[date].add(element);
      },
    );
    return data;
  }


  // Fetches two events on two random days within the current month
  void _fetchEvents() {
    final random = Random();
    final randomIntA = random.nextInt(13) + 1;
    final randomIntC = random.nextInt(20) + 1;
    final randomIntB = random.nextInt(13) + 14;
    //var List=['5','6','8','8'];
    final now = DateTime.now();
    print(widget.List1);
    //var date=List1[0];
   // date.split('-');
    DateTime dt = DateTime.tryParse(widget.ListDate[0]);
   //  print(ListDate[0]);
   // print(date.day);
   // _events.addEntries(DateTime(dt.year, dt.month, dt.day),widget.List1[i]))

    final events = {
       // DateTime(dt.year, dt.month, dt.day): widget.List1,
       // DateTime(now.year, now.month, randomIntB): ['Random event #$randomIntB'],
    };
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
    // for(int i=0;i<widget.List1.length;i++){
    //   DateTime date;
    //   DateTime dt = DateTime.now();
    //   _events[dt].add(widget.List1[i]);
    // }

   //   events.addAll(other)
    //  events[0]=(DateTime(dt.year, dt.month, dt.day),widget.List1[i]);
    _streamController.add(_events);
    }
    //events.a
    // events.addEntries(List1);

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: ui.TextDirection.ltr,
    child:Scaffold(
      appBar: AppBar(title: Text('TableCalendar Dynamic Demo')),
      body: Center(
        child: Column(
          children: <Widget>[
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
                    color: Colors.white
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
                                    return new_order(date:snapshot.data[index]['date'],timestart:snapshot.data[index]['timestart'],timeend:snapshot.data[index]['timeend'],Am_Pm:snapshot.data[index]['Am_Pm'],id:snapshot.data[index]['id']);
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
            )
          ],
        ),
      ),),);
  }
  Directionality dayTask(String time, String name)
  {
    return Directionality(
      child:Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width*0.2,
            child: Text(time, style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ), textAlign: TextAlign.right,),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.all(20),
              color: Color(0xffdfdeff),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(
                      color: purple,
                      fontWeight: FontWeight.w700
                  ),),
                  SizedBox(height: 10,),
                  Text('Upkeep Cleaning', style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500
                  ),),
                  SizedBox(height: 5,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.timer, color: purple,),
                      SizedBox(width: 5,),
                      Text("$time - 5 pm", style: TextStyle(
                          color: purple,
                          fontSize: 13,
                          fontWeight: FontWeight.w600
                      ),)
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Text("Client Rating", style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500
                      ),),
                      SizedBox(width: 5,),
                      Icon(Icons.star),
                      Icon(Icons.star),
                      Icon(Icons.star),
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
                  Row(
                    children: [
                      Icon(Icons.call, color: purple,),
                      SizedBox(width: 5,),
                      Icon(Icons.mail_outline, color: purple,),
                      Expanded(
                        child: Container(),
                      ),
                      Text("\$50", style: TextStyle(
                          color: purple,
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      ),)
                    ],
                  )

                ],
              ),
            ),
          )
        ],
      ),);
  }

}
class new_order  extends StatefulWidget {
  final  date;
  final  timeend;
  final  timestart;
  final  Am_Pm;
  final id;

  // final  token;
  //
  new_order({this.date, this.timeend, this.timestart, this.Am_Pm,this.id});

  @override
  _new_order createState() => _new_order();
}

class _new_order extends State<new_order> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
        Text(widget.Am_Pm),
        Text(widget.timestart),
        Text(widget.timeend),
        Text(widget.date),
        card(widget.date,"SARAH",widget.timestart,widget.timeend,widget.Am_Pm),
      ],
    );

  }
  Row card(String date, String name,String timestart,String timeend,String Am_Pm)
  {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width*0.2,
          child: Text(date, style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ), textAlign: TextAlign.right,),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(20),
            color: Color(0xffdfdeff),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(
                    color: purple,
                    fontWeight: FontWeight.w700
                ),),
                SizedBox(height: 10,),
                Text(date, style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500
                ),),
                SizedBox(height: 5,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.timer, color: purple,),
                    SizedBox(width: 5,),
                    Text(timeend +"-" +timestart, style: TextStyle(
                        color: purple,
                        fontSize: 13,
                        fontWeight: FontWeight.w600
                    ),),
                    Text(" "),
                    Text(Am_Pm=="am"?"صباحا":"مساء", style: TextStyle(
                        color: purple,
                        fontSize: 13,
                        fontWeight: FontWeight.w600
                    ),),
                    Container(
                      margin: EdgeInsets.only(right: 60),
                      child:GestureDetector(
                        onTap: (){
                          setState(() {
                          });
                        },
                        child:Row(children:[
                          Text('قبول الطلب',style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1C1C1C),
                            // decoration: TextDecoration.underline,
                            fontFamily: 'Changa',),),
                          Icon(Icons.check),
                        ],),),),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Icon(Icons.location_on),
                    Container(
                      margin: EdgeInsets.only(right: 125),
                      child:GestureDetector(
                        onTap: (){
                          setState(() {
                          });
                        },
                        child:Row(children:[
                          Text('رفض الطلب',style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1C1C1C),
                            // decoration: TextDecoration.underline,
                            fontFamily: 'Changa',),),
                          Icon(Icons.close),
                        ],),),
                    ),
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
        )
      ],
    );
  }
}

