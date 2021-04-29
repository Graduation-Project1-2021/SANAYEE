import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/Chatworker/chatListworker.dart';
import 'package:flutterphone/Inside_the_app/user_order.dart';
import 'package:flutterphone/components/timepicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
import 'orders_workers.dart';
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

class Worker_SLot extends StatefulWidget {
  final  name;
  final  phone;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;
  final namefirst;
  final namelast;
  final DateTime time;
  Worker_SLot({this.name,this.phone,this.time,this.namefirst,this.namelast,this.image,this.Work, this.Experiance, this.Information, this.token});
  _Worker_SLot createState() =>  _Worker_SLot();
}
class  _Worker_SLot extends State<Worker_SLot> {
  // AnimationController _animationController;
  int _page = 0;
  var DefultSlot=[];
  //DefultSlot.add(value);
  GlobalKey _bottomNavigationKey = GlobalKey();
  final List1 = [];
  var ListDate1 = [];
  final List2 = [];
  var ListDate2 = [];
  var ListBlock=["8.00 - 9.00 ","9.00 - 10.00","","","",];
  var Listsearch=[];

  Future getMYslot()async{
    print(widget.name);
    print(widget.phone);
    print(widget.time);
    var formattedDate = DateFormat('yyyy-MM-dd').format(widget.time);
    print(formattedDate);
    var url='https://'+IP4+'/testlocalhost/show_slot_of_worker.php';
    var ressponse=await http.post(url,body: {
      "phoneworker": widget.phone,
      "date":formattedDate,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  @override
  void initState() {
    super.initState();
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
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Directionality(textDirection: ui.TextDirection.rtl,
      child:Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.grey[50],
            key: _scaffoldKey,
            body: Form(
              // child:SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => order_worker(Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,name:widget.name,phone:widget.phone,image:widget.image,token:widget.token,namefirst:widget.namefirst)));},
                    child:Container(
                      margin: EdgeInsets.only(top:70,left: 370),
                      child:Icon(Icons.arrow_back,color: Colors.black,),
                    ),
                  ),
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
                    height: 700,
                    width: 500,
                    decoration: BoxDecoration(
                      // color:Color(0xFF1C1C1C),
                    ),
                    child:FutureBuilder(
                      future: getMYslot(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if(snapshot.hasData){
                          return ListView.builder(
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              var Listslot=snapshot.data;

                              if(Listslot.length==0){
                                return Empty(name:widget.name,time: widget.time,phone: widget.phone,Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst);}
                              else{
                                print(Listslot.length);
                                return slot(List1:Listslot,name:widget.name,time: widget.time,phone: widget.phone,Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst);}
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
class slot extends StatefulWidget {
  final phone;
  final name;
  List<dynamic> List1;
  final DateTime time;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;
  final namefirst;
  final namelast;
  slot({this.List1,this.name,this.phone,this.time,this.namefirst,this.namelast,this.image,this.Work, this.Experiance, this.Information, this.token});
  @override
  _slot createState() => _slot();
}

class _slot extends State<slot> {
  var List11=[];
  var List22=[];
  var List_Am=[];
  var List_Pm=[];
  var dateParse = DateTime.parse(_selectedDay.toString());
  var formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDay);
  // StreamController<Map<DateTime, List>> _streamController;
  // CalendarController _calendarController;
  Future<TimeOfDay> _selectTime(BuildContext context,
      {@required DateTime initialDate}) {
    final now = DateTime.now();

    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: initialDate.hour, minute: initialDate.minute),
    );
  }
  Map<DateTime, List<dynamic>> _events;
  // var ListBlock=["8.00 - 9.00 ","9.00 - 10.00","","","",];
  // Future getList() async {
  //   var url = 'https://' + IP4 + '/testlocalhost/getList.php';
  //   var ressponse = await http.post(url, body: {
  //     "phone": widget.phone,
  //     "date":formattedDate,
  //   });
  //   ListBlock=[];
  //   var responsepody = json.decode(ressponse.body);
  //   for (int i = 0; i < responsepody.length; i++) {
  //     String start_to_end=responsepody[i]['timestart']+" "+"-"+" "+responsepody[i]['timeend'];
  //     print("fgggggggggggggggggggggggggggggggggggggggggg");
  //     ListBlock.add(start_to_end);
  //     print(ListBlock);
  //   }
  // }
  CalendarController _calendarController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calendarController = CalendarController();
    // _streamController = StreamController();
    _fetchEvents();
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
  void _fetchEvents() {
  }
  void _onDaySelected(DateTime day, List events,List r) {
    _selectedDay = day;
    var dateParse = DateTime.parse(_selectedDay.toString());
    formattedDate = DateFormat('yyyy-MM-dd').format(day);
    print(formattedDate);
    if(ListBlock.isEmpty){
      print("Nulllll");
      // print(_selectedDay);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Worker_SLot(Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,name:widget.name,phone:widget.phone,image:widget.image,token:widget.token,namefirst:widget.namefirst,time: _selectedDay,),),);

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
  // Future cv(){
  //   String selectedTime;
  //   showCustomTimePicker(
  //       context: context,
  //       // It is a must if you provide selectableTimePredicate
  //       onFailValidation: (context) => print('Unavailable selection'),
  //       initialTime: TimeOfDay(hour: 2, minute: 0),
  //       selectableTimePredicate: (time) =>
  //       time.hour > 1 &&
  //           time.hour < 14 &&
  //           time.minute % 10 == 0).then((time) =>
  //       setState(() => selectedTime = time?.format(context)));
  // }
  @override
  int _page = 0;
  bool image=false;
  GlobalKey _bottomNavigationKey = GlobalKey();
  Widget build(BuildContext context) {
    DateTime selected;
    return Container(
      height: 700,
      transform: Matrix4.translationValues(0.0, -42.0, 0.0),
      child:Column(
          children:<Widget>[
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
                leftChevronIcon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 15,),
                rightChevronIcon: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 15,),
                leftChevronMargin: EdgeInsets.only(left: 70),
                rightChevronMargin: EdgeInsets.only(right: 70),
              ),
              calendarStyle: CalendarStyle(

                  todayColor: Colors.grey[200],
                  selectedColor:Y,
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
            // Container(
            //   margin: EdgeInsets.only(top: 10),
            //   child:Row(
            //     children: [
            //       GestureDetector(
            //         child: Container(
            //           margin: EdgeInsets.only(right: 100),
            //           child:Text('حجوزات',style: TextStyle(
            //             fontFamily: 'Changa',
            //             color: Colors.white,
            //             fontSize: 16,
            //             fontWeight: FontWeight.bold,
            //           ),),
            //       ),
            //       ),
            //       GestureDetector(
            //         child:Container(
            //           margin: EdgeInsets.only(right: 50),
            //         child: Text(' حجوزات غير مؤكدة',style: TextStyle(
            //           fontFamily: 'Changa',
            //           color: Colors.white,
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //         ),),
            //       ),),
            //     ],
            //   ),
            // ),

            Expanded(
              child: Container(
                width: 500,
                height: 500,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Container(
                  height: 500,
                  margin: EdgeInsets.only(right: 1),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            // _showSnackBar(context, 'لقد تمت الإضافة  بنجاح');
                            _dialogCall();
                          },
                          child: Container(
                            width: 112,
                            color:Colors.white,
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(left: 0,top:10,right: 275),
                            child: Row(
                              children: [
                                Text('  إضافة سلوت',style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15.0,
                                  fontFamily: 'Changa',
                                  fontWeight: FontWeight.bold,
                                ),),
                                Icon(Icons.add,size: 20,),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                            height: 150,
                            child:GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                                childAspectRatio: 3.02,
                              ),
                              itemCount: widget.List1.length,
                              itemBuilder: (context,index){
                                return time(widget.List1[index]['timestart']+" - "+widget.List1[index]['timeend'],widget.List1[index]['Am_Pm'],widget.List1[index]['timestart'],widget.List1[index]['timeend']);
                              },
                            )
                        ),
                        //IconButton(icon: Icon(Icons.date_range), onPressed: (){cv(initialDate:selected);})
                      ],
                    ),
                  ),
                ),
              ),
            ),

          ]
      ),
    );
  }
  Future<void> _dialogCall() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Directionality(textDirection: ui.TextDirection.rtl,
            child:MyDialog(name:widget.name,phone: widget.phone,time: widget.time,Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst),);
        });
  }
  Future<void> _dialogCall2(String init1,String init2,String initPeriode) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Directionality(textDirection: ui.TextDirection.rtl,
            child:edit_delete(name:widget.name,phone: widget.phone,time: widget.time,init1:init1 ,init2:init2,initPeriode: initPeriode,Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst),);
        });
  }

  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content:
    Text(text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Changa',
      ),)));
  }

  Container time(String time,String d,String from,String to)
  {
    return Container(
      width: 200,
      child:GestureDetector(
        onTap: (){
          _dialogCall2(from,to,d);
          // _dialogCall(phone,phoneworker,token,workertoken,username);
        },
        child: Container(
          // margin: EdgeInsets.only(right: 4,),
          //padding: EdgeInsets.symmetric(horizontal: 5),
          // height: 54,
          // width: 119,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Y, width: 1),
            borderRadius: BorderRadius.circular(10),),
          child:Center(
            child:Container(
              color: Colors.white,
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
      ),
    );}

  List<int> _availableHours = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23];
  List<int> _availableMinutes = [0,30];
 String hour;
  TimeOfDay selectedTime;
  Future cv({@required DateTime initialDate}){
    showCustomTimePicker(
        context: context,
        initialTime: TimeOfDay(
              hour: _availableHours.first,
              minute: _availableMinutes.first),
        // It is a must if you provide selectableTimePredicate
        onFailValidation: (context) => print('Unavailable selection'),
        selectableTimePredicate: (time) =>
        _availableHours.indexOf(time.hour) != -1 &&
            _availableMinutes.indexOf(time.minute) != -1).then(
            (time){print(time);
                   selectedTime=time;
                   print(selectedTime.toString());
                //setState(() => selectedTime = time?.format(context) as TimeOfDay);
              }
        );

  }
}


class Empty extends StatefulWidget {
  @override
  final phone;
  final name;
  List<dynamic> List1;
  final DateTime time;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;
  final namefirst;
  final namelast;
  Empty({this.List1,this.name,this.phone,this.time,this.namefirst,this.namelast,this.image,this.Work, this.Experiance, this.Information, this.token});

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
  void _onDaySelected(DateTime day, List events, List r) {
    _selectedDay = day;
    var dateParse = DateTime.parse(_selectedDay.toString());
    formattedDate = DateFormat('yyyy-MM-dd').format(day);
    print(formattedDate);
    if (ListBlock.isEmpty) {
      print("Nulllll");
      // print(_selectedDay);
      //Navigator.push(context, MaterialPageRoute(builder: (context) => My_SLot(date:_selectedDay,phoneworker: widget.phoneworker,),),);

      Navigator.push(context, MaterialPageRoute(builder: (context) => Worker_SLot(Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,name:widget.name,phone:widget.phone,image:widget.image,token:widget.token,namefirst:widget.namefirst,time: _selectedDay),),);
    }
  }

  @override
  int _page = 0;
  bool image = false;
  GlobalKey _bottomNavigationKey = GlobalKey();

  Widget build(BuildContext context) {
    return Container(
      height: 700,
      transform: Matrix4.translationValues(0.0, -42.0, 0.0),
      color: Colors.white,
      child: Column(
          children: <Widget>[
            // final events = snapshot.data;
            Container(
              color:Colors.grey[50],
              child: TableCalendar(
                onDaySelected: _onDaySelected,
                calendarController: _calendarController,
                //events: events,
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
                  leftChevronIcon: Icon(
                    Icons.arrow_back_ios, color: Colors.black, size: 15,),
                  rightChevronIcon: Icon(
                    Icons.arrow_forward_ios, color: Colors.black, size: 15,),
                  leftChevronMargin: EdgeInsets.only(left: 70),
                  rightChevronMargin: EdgeInsets.only(right: 70),
                ),
                calendarStyle: CalendarStyle(

                    todayColor: Colors.grey[200],
                    selectedColor:Y,
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
            Expanded(
              child: Container(
                width: 500,
                height: 500,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                         _dialogCall();
                      },
                      child: Container(
                        width: 112,
                        color:Colors.white,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 0,top:10,right: 275),
                        child: Row(
                          children: [
                            Text('  إضافة سلوت',style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontFamily: 'Changa',
                              fontWeight: FontWeight.bold,
                            ),),
                            Icon(Icons.add,size: 20,),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 150,),
                    Center(
                      child: Text('لا توجد لديك سلوتات  لعرضها في هذا اليوم',
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
  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content:
    Text(text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Changa',
      ),)));
  }
  Future<void> _dialogCall() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Directionality(textDirection: ui.TextDirection.rtl,
            child:MyDialog(phone: widget.phone,time: widget.time,Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst),);
        });
  }
}



class MyDialog extends StatefulWidget {
  @override
  final phone;
  final name;
  final DateTime time;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;
  final namefirst;
  final namelast;
  MyDialog({this.phone,this.time,this.name,this.namefirst,this.namelast,this.image,this.Work, this.Experiance, this.Information, this.token});
  _MyDialogState createState() => new _MyDialogState();
}
class _MyDialogState extends State<MyDialog> {

  TextEditingController description =TextEditingController();
  var selectedDate1;
  var selectedDate2;
  var from;
  var to;
  var show1;
  var show2;
  var period1;
  var period2;


  bool valed=false;
  bool choose1=false;
  bool choose2=false;

  bool reject=false;
  @override
  DateTime selectedTime;

  Future date1(){
    showCustomTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: _availableHours.first,
            minute: _availableMinutes.first),
        // It is a must if you provide selectableTimePredicate
        onFailValidation: (context) => print('Unavailable selection'),
        selectableTimePredicate: (time) =>
        _availableHours.indexOf(time.hour) != -1 &&
            _availableMinutes.indexOf(time.minute) != -1).then(
            (time){print(time);
            DateTime date = DateTime(0,0,0, time.hour, time.minute);
            selectedDate1= DateFormat("HH:mm:ss").format(date);
            from=DateFormat("HH:mm").format(date);
            show1=time.format(context);
            period1=time.period.index==0?'am':'pm';
            print(period1);
            setState(() {

            });
          //setState(() => selectedTime = time?.format(context) as TimeOfDay);
        }
    );

  }
  Future date2(){
    showCustomTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: _availableHours.first,
            minute: _availableMinutes.first),
        // It is a must if you provide selectableTimePredicate
        onFailValidation: (context) => print('Unavailable selection'),
        selectableTimePredicate: (time) =>
        _availableHours.indexOf(time.hour) != -1 &&
            _availableMinutes.indexOf(time.minute) != -1).then(
            (time){print(time);
            DateTime date = DateTime(0,0,0, time.hour, time.minute);
            selectedDate2= DateFormat("HH:mm:ss").format(date);
            to=DateFormat("HH:mm").format(date);
            show2=time.format(context);
            period2=time.period.index==0?'am':'pm';
            print(period2);
            setState(() {

            });
          //setState(() => selectedTime = time?.format(context) as TimeOfDay);
        }
    );

  }
  List<int> _availableHours = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23];
  List<int> _availableMinutes = [0,30];
  Future<TimeOfDay> _selectTime(BuildContext context,
      {@required DateTime initialDate}) {
    final now = DateTime.now();
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(
          hour: _availableHours.first,
          minute: _availableMinutes.first),
         // hour: initialDate.hour, minute: initialDate.minute

    );
  }
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      actionsPadding: EdgeInsets.zero,
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
             Column(
               children: [
                 GestureDetector(
                   child:Container(
                     margin: EdgeInsets.only(right: 265),
                     child:Icon(Icons.close),
                   ),
                   onTap: (){
                     Navigator.pop(context);
                   },
                 ),
                 Container(
                   margin: EdgeInsets.only(right:10),
                   child:Row(
                     children: [
                       Text('من',style: TextStyle(
                         fontFamily: 'Changa',
                         color: Color(0xFF1C1C1C),
                         fontSize: 16,
                         fontWeight: FontWeight.bold,
                       ),),
                       SizedBox(width: 10,),
                       Container(
                         color: Colors.grey[100],
                         height: 35,
                         width: 100,
                         padding: EdgeInsets.only(top: 5,bottom: 5,right:5,left: 5),
                         child: Row(
                           children: [
                             Container(
                               width: 50,
                               child: choose1?Text(from.toString(),
                                 style: TextStyle(
                                   fontFamily: 'Changa',
                                   color: Color(0xFF1C1C1C),
                                   fontSize: 16,
                                   fontWeight: FontWeight.bold,
                                 ),):
                               Text('00:00',
                                 style: TextStyle(
                                   fontFamily: 'Changa',
                                   color: Color(0xFF1C1C1C),
                                   fontSize: 16,
                                   fontWeight: FontWeight.bold,
                                 ),),
                             ),
                             SizedBox(width: 10,),
                             GestureDetector(
                               onTap: ()async {
                                 setState(() {
                                   reject=false;
                                 });
                                 await date1();
                                 print(selectedDate1);
                                 setState(() {
                                   choose1=true;
                                 });

                                 // widget.onSelectedDate(selectedDate);
                               },
                               child: Icon(Icons.date_range,size: 25,),
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ),
                // SizedBox(width: 10,),
                 Container(
                   margin: EdgeInsets.only(top:20,right:10),
                   child:Row(
                     children: [
                       Text('إلى',style: TextStyle(
                         fontFamily: 'Changa',
                         color: Color(0xFF1C1C1C),
                         fontSize: 16,
                         fontWeight: FontWeight.bold,
                       ),),
                       SizedBox(width: 10,),
                       Container(
                         color: Colors.grey[100],
                         height: 35,
                         width: 100,
                         padding: EdgeInsets.only(top: 5,bottom: 5,right:5,left: 5),
                         child: Row(
                           children: [
                         Container(
                         width: 50,
                         child:choose2?Text(to.toString(),
                               style: TextStyle(
                                 fontFamily: 'Changa',
                                 color: Color(0xFF1C1C1C),
                                 fontSize: 16,
                                 fontWeight: FontWeight.bold,
                               ),):
                             Text('00:00',
                               style: TextStyle(
                                 fontFamily: 'Changa',
                                 color: Color(0xFF1C1C1C),
                                 fontSize: 16,
                                 fontWeight: FontWeight.bold,
                               ),),),
                             SizedBox(width: 10,),
                             GestureDetector(
                               onTap: ()async {
                                 setState(() {
                                   reject=false;
                                 });
                                 await date2();
                                 print(selectedDate2);
                                 setState(() {
                                   choose2=true;
                                 });

                                 // widget.onSelectedDate(selectedDate);
                               },
                               child: Icon(Icons.date_range,size: 25,),
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ),
               ],
             ),
            reject?Container(
              margin: EdgeInsets.fromLTRB(40, 20, 0, 0),
              child: Text('يوجد تعارض في هذا الوقت مع وقت آخر لديك',textAlign:TextAlign.end,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Changa',
                  color: Colors.red,

                ),),
            ):Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text('',textAlign:TextAlign.end,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Changa',
                  color: Colors.red,

                ),),
            ),
            Container(
              margin: EdgeInsets.only(top:30),
              color: Y,
              width: 200,
              child:GestureDetector(
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 60),
                      SizedBox(width: 50),
                      Text('إضافة',
                        style:  TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Changa',
                          color: Colors.black87,
                        ),),
                      SizedBox(width: 10),
                      SizedBox(width: 20),
                    ],
                  ),
                  onTap: () async {
                    // senddata();
                    await check_Slot();
                    print(reject);
                    if(reject==false){
                      Navigator.pop(context);
                      print(widget.time); print(widget.phone); print(widget.namelast); print(widget.namefirst); print(widget.Information); print(widget.Experiance);print(widget.image);
                      print(widget.name); print(widget.token); print(widget.Work);
                      Fluttertoast.showToast(msg: " تمت الإضافة  بنجاح ",fontSize: 16,textColor:Colors.black87,backgroundColor: Colors.white);
                      // _showSnackBar(context, 'لقد تمت الإضافة  بنجاح');
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Worker_SLot(time: widget.time,phone:widget.phone,name:widget.name,Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst,),),);

                    }
                    //reject=false;
                  }),),
          ],
        ),
      ),
    );
  }
  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content:
    Text(text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Changa',
      ),)));
  }
  Future check_Slot()async{
    var dateParse = DateTime.parse(widget.time.toString());
    var formattedDate = DateFormat('yyyy-MM-dd').format(widget.time);
    var url='https://'+IP4+'/testlocalhost/add_slot.php';
    var ressponse=await http.post(url,body: {
      "phoneworker": '+970595320479',
      "date":formattedDate,
      "timestart":from,
      "timeend":to,
      "period1":period1,
      // "period2":period2,
      "time":selectedDate1,
    });
    // ignore: deprecated_member_use
    var massage=json.decode(ressponse.body);
    if(massage=='regect'){
        reject=true;
    }
    else{
      reject=false;
    }
    setState(() {

    });
    print(massage);
    return json.decode(ressponse.body);
  }
}




class edit_delete extends StatefulWidget {
  @override
  final phone;
  final DateTime time;
  final name;
  var init1;
  var init2;
  var initPeriode;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;
  final namefirst;
  final namelast;
  edit_delete({this.name,this.phone,this.time,this.init1,this.init2,this.initPeriode,this.namefirst,this.namelast,this.image,this.Work, this.Experiance, this.Information, this.token});
  _edit_delete createState() => new _edit_delete();
}
class _edit_delete extends State<edit_delete> {

  TextEditingController description =TextEditingController();
  var selectedDate1;
  var selectedDate2;
  var from_before;
  var to_before;
  var show1;
  var show2;
  var period1;
  var period2;


  bool valed=false;
  bool choose1=false;
  bool choose2=false;

  bool reject=false;
  @override
  DateTime selectedTime;

  Future date1(){
    showCustomTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: _availableHours.first,
            minute: _availableMinutes.first),
        // It is a must if you provide selectableTimePredicate
        onFailValidation: (context) => print('Unavailable selection'),
        selectableTimePredicate: (time) =>
        _availableHours.indexOf(time.hour) != -1 &&
            _availableMinutes.indexOf(time.minute) != -1).then(
            (time){print(time);
        DateTime date = DateTime(0,0,0, time.hour, time.minute);
        selectedDate1= DateFormat("HH:mm:ss").format(date);
        widget.init1=DateFormat("HH:mm").format(date);
        show1=time.format(context);
        widget.initPeriode=time.period.index==0?'am':'pm';
        print(period1);
        setState(() {

        });
          //setState(() => selectedTime = time?.format(context) as TimeOfDay);
        }
    );

  }
  Future date2(){
    showCustomTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: _availableHours.first,
            minute: _availableMinutes.first),
        // It is a must if you provide selectableTimePredicate
        onFailValidation: (context) => print('Unavailable selection'),
        selectableTimePredicate: (time) =>
        _availableHours.indexOf(time.hour) != -1 &&
            _availableMinutes.indexOf(time.minute) != -1).then(
            (time){print(time);
        DateTime date = DateTime(0,0,0, time.hour, time.minute);
        selectedDate2= DateFormat("HH:mm:ss").format(date);
        widget.init2=DateFormat("HH:mm").format(date);
        show2=time.format(context);
        period2=time.period.index==0?'am':'pm';
        print(period2);
        setState(() {

        });
          //setState(() => selectedTime = time?.format(context) as TimeOfDay);
        }
    );

  }
  List<int> _availableHours = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23];
  List<int> _availableMinutes = [0,30];
  Future<TimeOfDay> _selectTime(BuildContext context,
      {@required DateTime initialDate}) {
    final now = DateTime.now();
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(
          hour: _availableHours.first,
          minute: _availableMinutes.first),
      // hour: initialDate.hour, minute: initialDate.minute

    );
  }
  Widget build(BuildContext context) {
    from_before=widget.init1;
    to_before=widget.init2;
    return AlertDialog(
      backgroundColor: Colors.white,
      actionsPadding: EdgeInsets.zero,
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            Column(
              children: [
                GestureDetector(
                  child:Container(
                    margin: EdgeInsets.only(right: 265),
                    child:Icon(Icons.close),
                  ),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
                Container(
                  margin: EdgeInsets.only(right:10,top:20),
                  child:Row(
                    children: [
                      Text('من',style: TextStyle(
                        fontFamily: 'Changa',
                        color: Color(0xFF1C1C1C),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),),
                      SizedBox(width: 10,),
                      Container(
                        color: Colors.grey[100],
                        height: 35,
                        width: 100,
                        padding: EdgeInsets.only(top: 5,bottom: 5,right:5,left: 5),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              child: choose1?Text(widget.init1,
                                style: TextStyle(
                                  fontFamily: 'Changa',
                                  color: Color(0xFF1C1C1C),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),):
                              Text(widget.init1,
                                style: TextStyle(
                                  fontFamily: 'Changa',
                                  color: Color(0xFF1C1C1C),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),),
                            ),
                            SizedBox(width: 10,),
                            GestureDetector(
                              onTap: ()async {
                                setState(() {
                                  reject=false;
                                });
                                await date1();
                                print(selectedDate1);
                                setState(() {
                                  choose1=true;
                                });

                                // widget.onSelectedDate(selectedDate);
                              },
                              child: Icon(Icons.date_range,size: 25,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(width: 10,),
                Container(
                  margin: EdgeInsets.only(top:20,right:10),
                  child:Row(
                    children: [
                      Text('إلى',style: TextStyle(
                        fontFamily: 'Changa',
                        color: Color(0xFF1C1C1C),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),),
                      SizedBox(width: 10,),
                      Container(
                        color: Colors.grey[100],
                        height: 35,
                        width: 100,
                        padding: EdgeInsets.only(top: 5,bottom: 5,right:5,left: 5),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              child:choose2?Text(widget.init2,
                                style: TextStyle(
                                  fontFamily: 'Changa',
                                  color: Color(0xFF1C1C1C),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),):
                              Text(widget.init2,
                                style: TextStyle(
                                  fontFamily: 'Changa',
                                  color: Color(0xFF1C1C1C),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),),),
                            SizedBox(width: 10,),
                            GestureDetector(
                              onTap: ()async {
                                setState(() {
                                  reject=false;
                                });
                                await date2();
                                print(selectedDate2);
                                setState(() {
                                  choose2=true;
                                });

                                // widget.onSelectedDate(selectedDate);
                              },
                              child: Icon(Icons.date_range,size: 25,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            reject?Container(
              margin: EdgeInsets.fromLTRB(40, 20, 0, 0),
              child: Text('يوجد تعارض في هذا الوقت مع وقت آخر لديك',textAlign:TextAlign.end,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Changa',
                  color: Colors.red,

                ),),
            ):Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text('',textAlign:TextAlign.end,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Changa',
                  color: Colors.red,

                ),),
            ),
            Container(
              margin: EdgeInsets.only(top:25),
              color: Y,
              width: 200,
              child:GestureDetector(
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 100),
                      Text('تعديل',
                        style:  TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Changa',
                          color: MY_BLACK,
                        ),),
                      Icon(Icons.edit),
                      SizedBox(width: 10),
                    ],
                  ),
                  onTap: () async {
                    // senddata();
                    await check_Slot();
                    Navigator.pop(context);
                    Fluttertoast.showToast(msg: " تم التعديل بنجاح ",fontSize: 16,textColor:Colors.black87,backgroundColor: Colors.white);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Worker_SLot(time: widget.time,phone:widget.phone,name:widget.name,Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst),),);
                  }),),
            Container(
              margin: EdgeInsets.only(top:10),
              color: Y,
              width: 200,
              child:GestureDetector(
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 100),
                      Text('حذف',
                        style:  TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Changa',
                          color: MY_BLACK,
                        ),),
                      SizedBox(width:10),
                      Icon(Icons.delete),

                    ],
                  ),
                  onTap: () async {
                    // senddata();
                    await delete_Slot();
                    Navigator.pop(context);
                    Fluttertoast.showToast(msg: " تم الحذف بنجاح   ",fontSize: 16,textColor:Colors.black87,backgroundColor: Colors.white);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Worker_SLot(time:_selectedDay,phone:widget.phone,name:widget.name,Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst),),);
                    setState(() {
                    });
                    if(description.text.isEmpty){
                      // desc=false;
                    }
                    setState(() {
                    });
                  }),),
          ],
        ),
      ),
    );
  }
  Future delete_Slot()async{
    var dateParse = DateTime.parse(widget.time.toString());
    var formattedDate = DateFormat('yyyy-MM-dd').format(widget.time);
    var url='https://'+IP4+'/testlocalhost/delete_slot.php';
    var ressponse=await http.post(url,body: {
      "phoneworker": widget.phone,
      "date":formattedDate,
      "timestart":widget.init1,
      "timeend":widget.init2,
    });
    // ignore: deprecated_member_use
      setState(() {
      });
    return json.decode(ressponse.body);
    }
  Future check_Slot()async{
    var dateParse = DateTime.parse(widget.time.toString());
    var formattedDate = DateFormat('yyyy-MM-dd').format(widget.time);
    var url='https://'+IP4+'/testlocalhost/update_slot.php';
    var ressponse=await http.post(url,body: {
      "phoneworker": widget.phone,
      "date":formattedDate,
      "timestart":widget.init1,
      "timeend":widget.init2,
      "period1":widget.initPeriode,
      "from_before":from_before,
      "to_before":to_before,
      // "time":selectedDate1,
      // "period2":period2,
    });
    // ignore: deprecated_member_use
    var massage=json.decode(ressponse.body);
    if(massage=='regect'){
      reject=true;
    }
    else{
      reject=false;
    }
    setState(() {
    });
    print(massage);
    return json.decode(ressponse.body);
  }
}