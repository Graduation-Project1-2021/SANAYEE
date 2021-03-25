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
  My_SLot({this.date,this.token_Me,this.phoneworker,this.tokenworker,this.name_Me,this.country,this.namefirst,this.namelast,this.image,this.phone,this.time});
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
            backgroundColor: Colors.white,
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
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    height: 100,
                    decoration: BoxDecoration(
                      // color:ca,
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                          colors: [G,A,B]),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child:IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,)));
                      //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,)));
                    }),
                  ),
                 Container(
                   margin: EdgeInsets.only(top:50),
                   child: FutureBuilder(
                     future: getMYslot(),
                     builder: (BuildContext context, AsyncSnapshot snapshot) {
                       if(snapshot.hasData){
                         return ListView.builder(
                           itemCount: 1,
                           itemBuilder: (context, index) {
                             var Listslot=snapshot.data;
                             //return Container(child: Text('SARAH'),);
                             if(Listslot=="null"){
                               print("vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv");
                               return Empty(date:widget.date,username:widget.name_Me,token:widget.token_Me,tokenworker: widget.tokenworker,phoneworker: widget.phoneworker,phone: widget.phone,);
                             }
                             return slot(List1:Listslot,date:widget.date,username:widget.name_Me,token:widget.token_Me,tokenworker: widget.tokenworker,phoneworker: widget.phoneworker,phone: widget.phone,);
                           },
                         );
                       }
                       return Center(child: CircularProgressIndicator());
                     },
                   ),
                 ),

                ],),),),);
  }
}
class slot extends StatefulWidget {
  final phone;
  final token;
  final tokenworker;
  final phoneworker;
  final username;
  List<dynamic> List1;
  final DateTime date;
  slot({this.phone,this.List1,this.date,this.tokenworker,this.phoneworker,this.token,this.username});
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
      Navigator.push(context, MaterialPageRoute(builder: (context) => My_SLot(date:_selectedDay,name_Me:widget.username,token_Me:widget.token,tokenworker: widget.tokenworker,phoneworker: widget.phoneworker,phone: widget.phone,),),);

    }
  }
  @override
  int _page = 0;
  bool image=false;
  GlobalKey _bottomNavigationKey = GlobalKey();
  Widget build(BuildContext context) {
    seprate();
    print(List_Am.toString());
    print(List_Pm.toString());
    //print(phone);   print(widget.phoneworker);   print(token);   print(widget.tokenworker); print(";;;;;;;;;;;;;;;;;;;;;;");
    return Container(
      height: 610,
      color: A,
      child:Column(
                children: [
                  Container(
                    color: Colors.red,
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
                  ),
                  Container(
                    width: 500,
                    height: 470,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      color: Colors.white,
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
                                  itemCount: List_Am.length,
                                  itemBuilder: (context,index){
                                    return time1(List_Am[index]['timestart']+"  "+List_Am[index]['timeend'],"Am",List_Am[index]['id'],widget.phone,widget.phoneworker,widget.token,widget.tokenworker,widget.username);
                                  },
                                )
                            ),

                            SizedBox(height:10,),
                            Container(
                              margin: EdgeInsets.only(top: 20,left: 290),
                              child:Icon(Icons.wb_cloudy,size: 50,color:Color(0xFF1C1C1C)),
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
                                    return time1(List_Pm[index]['timestart']+"  "+List_Pm[index]['timeend'],"Am",List_Pm[index]['id'],widget.phone,widget.phoneworker,widget.token,widget.tokenworker,widget.username);
                                  },
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],),);
    }
  Future<void> _dialogCall(String phone,String id,String phoneworker,String token,String workertoken,String username) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyDialog(phone: phone,id:id,phoneworker:phoneworker,token:token,username:username,tokenworker:workertoken,);
        });
  }
  Container time1(String time,String d,String id,String phone,String phoneworker,String token,String workertoken,String username)
  {
    return Container(
      child:GestureDetector(
        onTap: (){
          _dialogCall(phone,id,phoneworker,token,workertoken,username);
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
}



class Empty extends StatefulWidget {
  @override
  final DateTime date;
  final phone;
  final token;
  final tokenworker;
  final phoneworker;
  final username;
  Empty({this.date,this.phoneworker,this.phone,this.token,this.tokenworker,this.username});
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

      Navigator.push(context, MaterialPageRoute(builder: (context) => My_SLot(date:_selectedDay,name_Me:widget.username,token_Me:widget.token,tokenworker:  widget.tokenworker,phoneworker: widget.phoneworker,phone: widget.phone,),),);

    }
  }
  @override
  int _page = 0;
  bool image=false;
  GlobalKey _bottomNavigationKey = GlobalKey();
  Widget build(BuildContext context) {
    return Container(
      height: 610,
      color: A,
      child:Column(
          children:<Widget>[
            // final events = snapshot.data;
            TableCalendar(
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
                  selectedColor: Colors.black,
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
            Expanded(
              child: Container(
                width: 500,
                height: 500,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                  color: Colors.white,
                ),
                ),
              ),

          ]
      ),
    );
  }
  Future<void> _dialogCall(String phone,String id,String phoneworker,String token,String workertoken,String username) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyDialog(phone: phone,id:id,phoneworker:phoneworker,token:token,tokenworker:workertoken,username:username);
        });
  }
  Container time1(String time,String d,String id,String phone,String phoneworker,String token,String workertoken,String username)
  {
    return Container(
      child:GestureDetector(
        onTap: (){
          _dialogCall(phone,id,phoneworker,token,workertoken,username);
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
}
class MyDialog extends StatefulWidget {
  @override
  final phone;
  final id;
  final token;
  final tokenworker;
  final phoneworker;
  final username;
  MyDialog({this.phone,this.id,this.username,this.token,this.phoneworker,this.tokenworker});
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
            image!= null? Container(
              // width:400,
              // height:200,
              //padding: EdgeInsets.all(50),
                margin: EdgeInsets.only(right:0,left:0,top: 10,bottom: 10),
                child: Container(
                  height: 200,width: 400,
                  child:image,)
            ):Container(),
            GestureDetector(
               child:Container(
                 margin: EdgeInsets.only(left: 35),
                 width: 350,
                 child: Row(
                   children: <Widget>[
                     Text('إضافة صورة قد تفيد في طلبك',
                       style: TextStyle(
                         color: Colors.grey.withOpacity(0.5),
                         fontSize: 16.0,
                         fontFamily: 'Changa',
                         fontWeight: FontWeight.bold,
                       ),),
                     Icon(Icons.image),
                     SizedBox(width: 5),
                   ],
                 ),
               ),
                onTap: () async {
              await getImageGallory();
              setState(() {
                // print(image.g)

              });
            }),
            Padding(
              padding: EdgeInsets.all(8.0),
            ),
            Container(
              color: Colors.grey.withOpacity(0.5),
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
                          color: Colors.black,
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
  Future getImageGallory() async {
    final x = await ImagePicker.pickImage(source: ImageSource.gallery);
    imagePath = x.path;
    image_file = x;
    image = Image(image: FileImage(x),width: 400,height: 150,fit: BoxFit.cover,);
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
      String massage= json.decode(ressponse.body);
      print(massage);
  }

}
