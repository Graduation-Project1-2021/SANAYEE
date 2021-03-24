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
  final DateTime time;
  My_SLot({this.name_Me,this.country,this.namefirst,this.namelast,this.image,this.phone,this.time});
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
    var dateParse = DateTime.parse(widget.time.toString());
    var formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDay);
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
                    height: 700,
                    width: 500,
                    // color:  Color(0xFFF3D657),
                    margin: EdgeInsets.only(top:20),
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => My_SLot(time: _selectedDay,),),);

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
  @override
  int _page = 0;
  bool image=false;
  GlobalKey _bottomNavigationKey = GlobalKey();
  Widget build(BuildContext context) {
    seprate();
    print(List_Am.toString());
    print(List_Pm.toString());
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
                                  return time1(List_Am[index]['timestart']+"  "+List_Am[index]['timeend'],"Am");
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
                                  return time1(List_Pm[index]['timestart']+"  "+List_Pm[index]['timeend'],"Am");
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
    );
    }
  Future<void> _dialogCall(String phone) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyDialog(phone: phone,);
        });
  }
  Container time1(String time,String d)
  {
    return Container(
      child:GestureDetector(
        onTap: (){
          _dialogCall("vffb");
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
  MyDialog({this.phone});
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {

  TextEditingController description =TextEditingController();
  String imagePath;
  Image image;
  File image_file;
  bool desc=true;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: MY_BLACK,
      actionsPadding: EdgeInsets.zero,
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(left: 0, right: 259),
                child: IconButton(icon: Icon(
                    Icons.close,
                    color: Colors.grey.withOpacity(0.5)),
                    onPressed: () {
                      Navigator.pop(context);
                    })
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
                  color: Colors.grey.withOpacity(0.5),
                  fontSize: 16.0,
                  fontFamily: 'Changa',
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  enabledBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                    borderSide:  BorderSide(color:MY_BLACK),

                  ),
                  focusedBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                    borderSide:  BorderSide(color:MY_BLACK),

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
                child: Row(
                  children: <Widget>[
                    Icon(Icons.image),
                    Text('إضافة صورة قد تفيد في طلبك'),
                    SizedBox(width: 5),
                  ],
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
                      SizedBox(width: 60),
                      Icon(Icons.create),
                      SizedBox(width: 30),
                      Text('حجز',
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
                    if(description.text.isEmpty){
                      desc=false;
                    }
                    setState(() {
                    });
                  }),),
          ],
        ),
      ),
    );
  }
  Future getImageGallory() async {
    final x = await ImagePicker.pickImage(source: ImageSource.gallery);
    imagePath = x.path;
    image_file = x;
    image = Image(image: FileImage(x),width: 400,height: 150,fit: BoxFit.cover,);
  }

  Future senddata()async{
    if(image==null){
      print("image null");
      var url = 'https://'+IP4+'/testlocalhost/add_post.php';
      var ressponse = await http.post(url, body: {
        "text": description.text,
        "phone": widget.phone,
        "imagename": 'null',
        "image64": '',
      });
      String massage= json.decode(ressponse.body);
      print(massage);
    }
    else{ String base64;
    String imagename;
    File _file = File(image_file.path);
    base64 = base64Encode(_file.readAsBytesSync());
    imagename = _file.path.split('/').last;
    var url = 'https://'+IP4+'/testlocalhost/add_post.php';
    var ressponse = await http.post(url, body: {
      "text": description.text,
      "phone": widget.phone,
      "imagename": imagename,
      "image64": base64,
    });
    String massage= json.decode(ressponse.body);
    print(massage);
    }
  }

}
