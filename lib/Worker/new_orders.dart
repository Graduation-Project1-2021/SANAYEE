import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'ColorScheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/screens/login_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
String IP4="192.168.1.8";
DateTime _selectedDay = DateTime.now();

void VB(){
  print(_selectedDay);
}
bool neworder=false;
String date;
Map<DateTime, List<dynamic>> _events;
List<dynamic> _selectedEvents;
//List<dynamic> _selectedEvents = [];
//List<Widget> get _eventWidgets => _selectedEvents.map((e) => events(e)).toList();
// class CalendarPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: calendarPage(),
//       theme: ThemeData(
//           fontFamily: 'ubuntu'
//       ),
//     );
//   }
// }
class new_oders extends StatefulWidget {
  @override
  _new_oders createState() => _new_oders();
}

class _new_oders extends State<new_oders> {
  CalendarController _calendarController;
  Map<DateTime, List<dynamic>> _events = {};
  @override
  void initState() {
    // TODO: implement initState
    _events = {};
    _selectedEvents = [];
    super.initState();
    _calendarController = CalendarController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _calendarController.dispose();
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
      _selectedEvents = events;

      var dateParse = DateTime.parse(_selectedDay.toString());
      var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
      var finalDate = formattedDate.toString() ;
      print(finalDate);
      VB();
    });
    void Print(){
      print("kkk");
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Directionality( textDirection: TextDirection.rtl,
      child:Scaffold(
        backgroundColor: Color(0xFFECCB45),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text("Select Date", style: TextStyle(
              color: Colors.white
          ),),
        ),
        body: Column(
          children: [
            TableCalendar(
              onDaySelected: _onDaySelected,
              calendarController: _calendarController,
              events: _events,
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

              ),
            ),
            SizedBox(height: 5,),

            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                    color: Colors.white
                ),
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        Row(
                          children: [
                            GestureDetector(
                                onTap: (){
                                  setState(() {
                                    neworder=true;
                                  });
                                },
                                child:Text('طلبات جديدة للموافقة عليها',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1C1C1C),
                                    // decoration: TextDecoration.underline,
                                    fontFamily: 'Changa',),)

                            ),
                            Text("18 April 2020", style: TextStyle(
                                color: Colors.grey
                            ),)
                          ],
                        ),
                        SizedBox(height: 15,),

                        neworder?Container(
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
                          ),):
                        Column(
                          children: [
                            dayTask("10 am", "Michael Hamilton"),
                            dayTask("11 am", "Alexandra Johnson"),
                            dayTask("2 pm", "Michael Hamilton"),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),);
  }
  void  Display(){

  }
  Row dayTask(String time, String name)
  {
    return Row(
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
                    color: Color(0xFFECCB45),
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
                    Icon(Icons.timer, color:Color(0xFFECCB45),),
                    SizedBox(width: 5,),
                    Text("$time - 5 pm", style: TextStyle(
                        color: Color(0xFFECCB45),
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
                    Icon(Icons.call, color: Color(0xFFECCB45),),
                    SizedBox(width: 5,),
                    Icon(Icons.mail_outline, color: Color(0xFFECCB45),),
                    Expanded(
                      child: Container(),
                    ),
                    Text("\$50", style: TextStyle(
                        color: Color(0xFFECCB45),
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
    );
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
                    color: Color(0xFFECCB45),
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
                    Icon(Icons.timer, color: Color(0xFFECCB45),),
                    SizedBox(width: 5,),
                    Text(timeend +"-" +timestart, style: TextStyle(
                        color: Color(0xFFECCB45),
                        fontSize: 13,
                        fontWeight: FontWeight.w600
                    ),),
                    Text(" "),
                    Text(Am_Pm=="am"?"صباحا":"مساء", style: TextStyle(
                        color: Color(0xFFECCB45),
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

