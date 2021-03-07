import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
String IP4="192.168.2.110";
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class CalendarPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: calendarPage(),
      theme: ThemeData(
          fontFamily: 'ubuntu'
      ),
    );
  }
}
class calendarPage extends StatefulWidget {

  // final  phone;
  // final  image;
  // final  Work;
  // final  Experiance;
  // final  Information;
  // final  token;
  // SettingsUI({this.name, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token});

  @override
  _calendarPageState createState() => _calendarPageState();
}

class _calendarPageState extends State<calendarPage> {
  CalendarController _calendarController;
  String timeController ;
  var massage;

  var _selectedDay = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState


    super.initState();
    _calendarController = CalendarController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _calendarController.dispose();
    super.dispose();
  }
  // void _onDaySelected(DateTime day, List events, List holidays) {
  //   print('CALLBACK: _onDaySelected');
  //   setState(() {
  //     //_selectedEvents = events;
  //   });
  // }
  void _onDaySelected(DateTime day, List events,List r) {
    setState(() {
      _selectedDay = day;
      // _selectedEvents = events;a

      var dateParse = DateTime.parse(_selectedDay.toString());
      var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
      var finalDate = formattedDate.toString() ;
      checkorders(finalDate);
      print(finalDate);
      //  VB();
    });
    void Print(){
      print("kkk");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.red,
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

            // this.onDaySelected,
            // onDaySelected:_onDaySelected,
            calendarController: _calendarController,
            initialCalendarFormat: CalendarFormat.week,
            startingDayOfWeek: StartingDayOfWeek.monday,
            formatAnimation: FormatAnimation.slide,
            builders: CalendarBuilders(
              selectedDayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(5.0),
                  alignment: Alignment.center,

                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.purpleAccent),
                  )),
              todayDayBuilder: (context, date, events) => Container(
                margin: const EdgeInsets.all(5.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(8.0)),
                child: Text(
                  date.day.toString(),
                  style: TextStyle(color: Colors.white),
                ),

              ),
            ),
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
                          Text("18 April 2020", style: TextStyle(
                              color: Colors.grey
                          ),),
                          // SizedBox(height: 15,),
                          // Text("18 April 2020", style: TextStyle(
                          //   color: Colors.black,
                          //   fontWeight: FontWeight.w700,
                          // ), textAlign: TextAlign.right,),
                          //
                          // SizedBox(height: 15,),
                          // Text("18 April 2020", style: TextStyle(
                          //     color: Colors.grey
                          // ),)
                        ],
                      ),
                      SizedBox(height: 15,),
                      Column(
                        children: [
                           addAm("Am"),
                          // dayTask("08.00 - 11:00 ","PM"),
                           dayTask( "09:00 - 12:00","Am"),
                           dayTask("12:00 - 03.00","PM"),
                           dayTask("03.00 -06.00","PM"),
                           addAm("PM"),
                           dayTask("06.00 - 09.00","PM"),
                           dayTask("09.00 - 12.00","PM"),
                          dayTask("08.00 - 11:00 ","PM"),

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
    );
  }
  Row addAm(String st){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 15,),
        Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width*0.2,
          child: Text(st, style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 25,
          ), textAlign: TextAlign.right,),
        )],);
  }
  Row dayTask(String time,String st)
  {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Container(
        //   padding: EdgeInsets.all(20),
        //   width: MediaQuery.of(context).size.width*0.2,
        //   child: Text(st, style: TextStyle(
        //     color: Colors.black,
        //     fontWeight: FontWeight.w700,
        //   ), textAlign: TextAlign.right,),
        // ),
        Expanded(

          child:   Container(

            margin: EdgeInsets.only(right: 0,bottom: 2),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const SizedBox(height: 10),
                RaisedButton.icon(
                  icon: Icon(Icons.timer, color:Colors.purple,),
                  onPressed: () {
                    askforReservation(time);
                  },
                  label:  Text(time, style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900,)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black)
                  ),
                ),

                //  SizedBox(height: 30,),


              ],
            ),
          ),
        )
      ],
    );
  }

  //void askforReservation(String time) {
  askforReservation(String time) {
    // Create button
    timeController= time ;
    print(timeController);
    Widget okButton = FlatButton(

      child: Text("ok"),
      onPressed: () {
        sendToDataBase();
        Navigator.of(context).pop();
        // Navigator.of(context).pop();
      },
    );
    Widget cancelButton = FlatButton(
      child: Text("cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Send this Request?"),
      content: Text("if you pressed ok, Request will be send to the worker."),
      actions: [
        cancelButton,
        okButton,

      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  Future  sendToDataBase()async{
    print(timeController);
    var url = 'https://'+IP4+'/testlocalhost/SendRequest.php';
    var ressponse = await http.post(url, body: {
      "name": "duaa",
      "phone": "+970597980336",
      "timeChosen": timeController ,
      //"mytoken":mytoken,
    });

  }
  Future getdata()async{
    var url='https://'+IP4+'/testlocalhost/checkorders.php';
    var ressponse=await http.get(url);
    return json.decode(ressponse.body);
  }
  Future  checkorders(String date)async{
    print(date);
    var url = 'https://'+IP4+'/testlocalhost/checkorders.php';
    var ressponse = await http.post(url, body: {
      "nameOfWorker": "duaa",
      //"phone": "+970597980336",
      "date": date ,
      "mytoken":"mytoken",
    });
    massage = json.decode(ressponse.body.toString());
    if (massage == "")//show them all
        {
    }
    else{List<String>b=  massage.split("h");
    //  print (b);
    test(String value) => value.contains("09:00 - 12:00");

    if(b.any(test)==false)dayTask( "09:00 - 12:00","Am");

    test2(String value) => value.contains("12:00 - 03:00");

    if(b.any(test2)==false)dayTask( "12:00 - 03:00","Am");

    test3(String value) => value.contains("03:00 - 06:00");
    if(b.any(test3)==false)dayTask( "03:00 - 06:00","Am");
    test4(String value) => value.contains("06:00 - 09:00");
    if(b.any(test3)==false)dayTask( "06:00 - 09:00","Am");


    }
  }
  f(){
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
                    Text("18 April 2020", style: TextStyle(
                        color: Colors.grey
                    ),),
                    // SizedBox(height: 15,),
                    // Text("18 April 2020", style: TextStyle(
                    //   color: Colors.black,
                    //   fontWeight: FontWeight.w700,
                    // ), textAlign: TextAlign.right,),
                    //
                    // SizedBox(height: 15,),
                    // Text("18 April 2020", style: TextStyle(
                    //     color: Colors.grey
                    // ),)
                  ],
                ),
                SizedBox(height: 15,),
                Column(
                  children: [
                    addAm("Am"),
                    // dayTask("08.00 - 11:00 ","PM"),
                    // for(int i=0;i<)
                    //  dayTask( "09:00 - 12:00","Am"),
                    //  dayTask("12:00 - 03.00","PM"),
                    //  dayTask("03.00 -06.00","PM"),
                    addAm("PM"),
                    // dayTask("06.00 - 09.00","PM"),
                    // dayTask("09.00 - 12.00","PM"),
                    // dayTask("08.00 - 11:00 ","PM"),

                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}