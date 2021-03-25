import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/Chat/chatListUser.dart';
import 'package:flutterphone/Inside_the_app/Comment.dart';
import 'package:flutterphone/Inside_the_app/List_worker_group.dart';
import 'package:flutterphone/Inside_the_app/WORKER_PROFILE.dart';
import 'package:flutterphone/USER/user_Profile.dart';
import 'package:flutterphone/Inside_the_app/user_order.dart';
import 'package:flutterphone/components/timepicker.dart';
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
  final name_Me;
  final country;
  final namefirst;
  final namelast;
  final image;
  final phone;
  final DateTime time;
  Worker_SLot({this.name_Me,this.country,this.namefirst,this.namelast,this.image,this.phone,this.time});
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
    var dateParse = DateTime.parse(widget.time.toString());
    var formattedDate = DateFormat('yyyy-MM-dd').format(widget.time);
    var url='https://'+IP4+'/testlocalhost/show_slot_of_worker.php';
    var ressponse=await http.post(url,body: {
      "phoneworker": '+970595320479',
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
            backgroundColor: D,
            key: _scaffoldKey,

            bottomNavigationBar: Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
              ]),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                  child: GNav(
                      rippleColor: Colors.grey[300],
                      hoverColor: Colors.grey[100],
                      gap: 8,
                      activeColor: Colors.black,
                      iconSize: 24,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      duration: Duration(milliseconds: 400),
                      tabBackgroundColor: Colors.grey[100],
                      tabs: [
                        GButton(
                          icon: Icons.home,
                          text: 'Home',
                        ),
                        GButton(
                          icon: Icons.hail,
                          text: 'Likes',
                        ),
                        GButton(
                          icon: Icons.search,
                          text: 'Search',
                        ),
                        GButton(
                          icon: Icons.umbrella,
                          text: 'Profile',
                        ),
                      ],
                      selectedIndex: _selectedIndex,
                      onTabChange: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      }),
                ),
              ),),
            body: Form(
              // child:SingleChildScrollView(
              child: Stack(
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
                    margin: EdgeInsets.only(top: 50),
                    child:IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,)));
                      //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,)));
                    }),
                  ),
                  Container(
                    height: 700,
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
                      future: getMYslot(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if(snapshot.hasData){
                          return ListView.builder(
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              var Listslot=snapshot.data;
                              //if(Listslot=='NO Date'){return Container();}
                              //return Container(child: Text('SARAH'),);
                              return slot(List1:Listslot,time: widget.time,);
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
  List<dynamic> List1;
  final DateTime time;
  slot({this.phone,this.List1,this.time});
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
    //
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
    _selectedDay = day;
    var dateParse = DateTime.parse(_selectedDay.toString());
    formattedDate = DateFormat('yyyy-MM-dd').format(day);
    print(formattedDate);
    if(ListBlock.isEmpty){
      print("Nulllll");
      // print(_selectedDay);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Worker_SLot(time: _selectedDay,),),);

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
    seprate();
    print(List_Am.toString());
    print(List_Pm.toString());
    DateTime selected;
    return Container(
      height: 700,
      color: D,
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
                  selectedColor: A,
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
            SizedBox(height: 5,),
            SizedBox(height: 5,),
            Expanded(
              child: Container(
                width: 500,
                height: 500,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
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
                            _dialogCall("bb");
                          },
                          child: Container(
                            width: 110,
                            margin: EdgeInsets.only(left: 10,top:20,right: 250),
                            child: Row(
                              children: [
                                Text('إضافة سلوت',style: TextStyle(
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
                        Container(
                          margin: EdgeInsets.only(top: 20,left: 290),
                          child:Icon(Icons.wb_sunny,size: 40,color: Colors.yellow,),
                        ),
                        //IconData(Icons.wb_sunny),),
                        SizedBox(height: 20,),
                        Container(
                            height: 150,
                            child:GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 20,
                                childAspectRatio: 2.2,
                              ),
                              itemCount: List_Am.length,
                              itemBuilder: (context,index){
                                return time1(List_Am[index]['timestart']+"-"+List_Am[index]['timeend'],"am",List_Am[index]['timestart'],List_Am[index]['timeend']);
                              },
                            )
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10,left: 290),
                          child:Icon(Icons.wb_cloudy,size: 40,color:Color(0xFF1C1C1C)),
                        ),
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
                              itemCount: List_Pm.length,
                              itemBuilder: (context,index){
                                return time1(List_Pm[index]['timestart']+"-"+List_Pm[index]['timeend'],"pm",List_Pm[index]['timestart'],List_Pm[index]['timeend']);
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
  Future<void> _dialogCall(String phone) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Directionality(textDirection: ui.TextDirection.rtl,
            child:MyDialog(phone: phone,time: widget.time,),);
        });
  }
  Future<void> _dialogCall2(String phone,String init1,String init2,String initPeriode) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Directionality(textDirection: ui.TextDirection.rtl,
            child:edit_delete(phone: phone,time: widget.time,init1:init1 ,init2:init2,initPeriode: initPeriode,),);
        });
  }

  Container time1(String time,String d,String from,String to)
  {
    return Container(
      child:GestureDetector(
        onTap: (){
          _dialogCall2("vffb",from,to,d);
        },
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),),
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

class MyDialog extends StatefulWidget {
  @override
  final phone;
  final DateTime time;
  MyDialog({this.phone,this.time});
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
                         color: Colors.grey[200],
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
                         color: Colors.grey[200],
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
              color: Colors.grey.withOpacity(0.5),
              width: 200,
              child:GestureDetector(
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 60),
                      Icon(Icons.create),
                      SizedBox(width: 30),
                      Text('إضافة',
                        style:  TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Changa',
                          color: MY_BLACK,
                        ),),
                      SizedBox(width: 5),
                    ],
                  ),
                  onTap: () async {
                    // senddata();
                    await check_Slot();
                    print(reject);
                    if(reject==false){
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Worker_SLot(time: widget.time,),),);
                    }
                    //reject=false;
                  }),),
          ],
        ),
      ),
    );
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
  var init1;
  var init2;
  var initPeriode;
  edit_delete({this.phone,this.time,this.init1,this.init2,this.initPeriode});
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
                        color: Colors.grey[200],
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
                        color: Colors.grey[200],
                        height: 35,
                        width: 100,
                        padding: EdgeInsets.only(top: 5,bottom: 5,right:5,left: 5),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              child:choose2?Text(widget.init1,
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
              margin: EdgeInsets.only(top:30),
              color: Colors.grey.withOpacity(0.5),
              width: 200,
              child:GestureDetector(
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 60),
                      Icon(Icons.create),
                      SizedBox(width: 30),
                      Text('تعديل',
                        style:  TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Changa',
                          color: MY_BLACK,
                        ),),
                      SizedBox(width: 5),
                    ],
                  ),
                  onTap: () async {
                    // senddata();
                    await check_Slot();
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Worker_SLot(time: widget.time,),),);
                  }),),
            Container(
              margin: EdgeInsets.only(top:30),
              color: Colors.grey.withOpacity(0.5),
              width: 200,
              child:GestureDetector(
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 60),
                      Icon(Icons.delete),
                      SizedBox(width: 30),
                      Text('حذف',
                        style:  TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Changa',
                          color: MY_BLACK,
                        ),),
                      SizedBox(width: 5),
                    ],
                  ),
                  onTap: () async {
                    // senddata();
                    await delete_Slot();
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Worker_SLot(time: widget.time,),),);
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
      "phoneworker": '+970595320479',
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
      "phoneworker": '+970595320479',
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