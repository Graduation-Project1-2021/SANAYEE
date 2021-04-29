import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutterphone/constants.dart';
import '../constants.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'State_warshe_accept.dart';
import 'orders_workers.dart';

String  name="";
String  phone="";
String  image="";
String  Work="";
String  Experiance="";
String  Information="";
String  token="";
String IP4="192.168.1.8";
bool press=true;
double hight=150;
class Warshat extends StatefulWidget {
  final name;
  final phone;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;
  final namefirst;
  final namelast;
  final lat;
  final lng;
  Warshat({this.image,this.lng,this.lat,this.namelast,this.namefirst,this.token,this.Experiance,this.Information,this.Work,this.phone,this.name});

  @override
  _viewWarshaState createState() => _viewWarshaState();
}

class _viewWarshaState extends State<Warshat> {
  @override
  void initState() {
    super.initState();
    press=true;
    setState(() {

    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future getreservation()async{
    var url='https://'+IP4+'/testlocalhost/seereservations.php';
    var ressponse=await http.post(url,body: {
      "phone": widget.phone,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  Widget build(BuildContext context) {
    print("ddddddddddddddddddddd"); print(widget.phone); print(widget.name);
    return Directionality(textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        backgroundColor:Colors.white,
        key: _scaffoldKey,
        body:Form(
          child:Stack(
            children: [

              Container(
                  margin: EdgeInsets.only(top:70,right: 10),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => order_worker(lat:widget.lat,lng:widget.lng,Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,name:widget.name,phone:widget.phone,image:widget.image,token:widget.token,namefirst:widget.namefirst)));},

                    child:Icon(Icons.arrow_back,color: Colors.grey[600],),
                  )
              ),
              Container(
                  height: 50,
                  color: Colors.white,
                  margin: EdgeInsets.only(top:100,right:0),
                  alignment: Alignment.center,
                  // transform: Matrix4.translationValues(0, -120.0, 0),
                  child:Text('ورشاتي',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontFamily: 'vibes',
                      //fontStyle: FontStyle.italic,
                    ),)
              ),
              Container(
                color: Colors.white,
                height: 647.5,
                margin: EdgeInsets.only(top:150),
                child: FutureBuilder(
                  future: getreservation(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          print(snapshot.data[index]['workerphone']);
                          // return Container(height: 200,);
                          return view (name:snapshot.data[index]['name'],Information:widget.Information,Experiance:widget.Information,from:snapshot.data[index]['Fromdate'],to:snapshot.data[index]['Todate'],lnguser:snapshot.data[index]['lnguser'],latuser:snapshot.data[index]['latuser'],lat:widget.lat,lng:widget.lng,tokenworker:widget.token,work:widget.Work,imageworker:widget.image,namelastworker:widget.namelast,namefirstworker:widget.namefirst,orderimage:snapshot.data[index]['orderimage'],city:snapshot.data[index]['city'],country:snapshot.data[index]['country'],start:snapshot.data[index]['Fromdate'],end:snapshot.data[index]['Todate'],id:snapshot.data[index]['id'],type:snapshot.data[index]['type'],image:snapshot.data[index]['image'],describes:snapshot.data[index]['describes'],nameofwork :widget.name,workerphone : snapshot.data[index]['workerphone'], namefirst: snapshot.data[index]['namefirst'], namelast: snapshot.data[index]['namelast'], phoneuser: snapshot.data[index]['phoneuser']);

                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              // Container(
              //   height: 100,
              //   margin: EdgeInsets.only(top: 260,right: 150),
              //   color: Colors.yellowAccent,
              //   child:FutureBuilder(
              //     future: getWorker(),
              //     builder: (BuildContext context, AsyncSnapshot snapshot) {
              //       if(snapshot.hasData){
              //         return ListView.builder(
              //             itemCount:1,
              //             itemBuilder: (context, index) {
              //
              //               return Center(child: Text('YAHHHHHHHHHHHHHHHHH'));
              //             }
              //         );
              //       }
              //       return Center(child: Text('NO'));
              //     },
              //   ),
              // ),

            ],
          ) ,

        ),),);
  }

  Future getlongtimeorder() async {

    var url = 'https://'+IP4+'/testlocalhost/seereservations.php';
    print("ssssssssssssssssssssssssssssssssssssssssssssssssssssssssss"+widget.phone);
    var ressponse = await http.post(url, body: {
      "phone": widget.phone,

    });
    return json.decode(ressponse.body);
  }
}


class view extends StatefulWidget {
  final lat;
  final lng;
  final latuser;
  final lnguser;
  final orderimage;
  final phoneuser;
  final name;
  final describes;
  final namefirst;
  final namelast;
  final image;
  final type;
  final workerphone;
  final nameofwork;
  final start;
  final end;
  final id;
  final city;
  final country;
  final namefirstworker;
  final namelastworker;
  final imageworker;
  final tokenworker;
  final Information;
  final Experiance;
  final work;
  final from;
  final to;
  view({this.name,this.from,this.to,this.work,this.namefirstworker,this.namelastworker,this.imageworker,this.tokenworker,this.Experiance,this.Information,this.orderimage,this.latuser,this.lnguser,this.lng,this.lat,this.country,this.city,this.start,this.id,this.end,this.image,this.type,this.namelast,this.workerphone,this.namefirst,this.phoneuser,this.nameofwork,this.describes});
  @override
  _viewState createState() => _viewState();
}

class _viewState extends State<view> {
  @override
  bool datepicher=false;
  Widget build(BuildContext context) {
    return Column(

      children:[
        card(widget.namefirst,widget.namelast,widget.describes,widget.phoneuser,widget.workerphone,widget.nameofwork,widget.image,widget.type),

      ],);
  }
  Widget card(String namefirst , String namelast,String describes,String phoneuser,String workerphone,String nameofwork,String image,String type)
  { print("tafaseel talab "+workerphone);

  return GestureDetector(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => State_warshe_accept(name:widget.name,type:widget.type,from:widget.from,to:widget.to,tokenworker:widget.tokenworker,imageworker:widget.imageworker,namelastworker:widget.namelastworker,namefirstworker:widget.namefirstworker,Information:widget.Information,Experiance:widget.Experiance,work:widget.work,country:widget.country,city:widget.city,description:widget.describes,latuser:widget.latuser,lnguser:widget.lnguser,lat:widget.lat,lng:widget.lng,orderimage:widget.orderimage,workername:widget.nameofwork,id:widget.id,namefirst: widget.namefirst,namelast: widget.namelast,phoneuser: widget.phoneuser,image: widget.image,phoneworker:widget.workerphone),),);
    },
    child:Container (
      height:160,
      width: 380,
      margin: EdgeInsets.only(top:5,bottom: 15),
      padding: EdgeInsets.all(5),
      alignment: Alignment.topRight,
      decoration: BoxDecoration(
        color:Colors.grey[50],
        borderRadius: BorderRadius.circular(5),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top:10,right: 15),
            child:  Row(
              children: [
                Container(
                  width:90,
                  child:Text('اسم العميل ', style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    fontFamily: 'Changa',
                  ),
                  ),
                ),
                Container(
                  width:170,
                  child:Text(namefirst + " " +namelast, style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54,
                    fontFamily: 'Changa',
                  ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(top:3,right: 15),
            child:Row(
              children: [
                Text('الموقع  ', style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                  fontFamily: 'Changa',
                ),
                ),
                SizedBox(width: 38,),
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
          Container(
            margin: EdgeInsets.only(top:3,right: 15),
            child:  Row(
              children: [
                Container(
                  width:90,
                  child:Text('نوع الورشة', style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    fontFamily: 'Changa',
                  ),
                  ),
                ),
                Container(
                  width:170,
                  child:Text(type, style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54,
                    fontFamily: 'Changa',
                  ),
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   alignment:Alignment.topRight,
          //   margin:EdgeInsets.only(right:15,top:3),
          //   child:Row(
          //    children: [
          //      Text('مدة الورشة ',
          //        style: TextStyle(
          //          fontSize: 13,
          //          fontWeight: FontWeight.w700,
          //          color: Colors.black87,
          //          fontFamily: 'Changa',
          //        ),),
          //      SizedBox(width: 20,),
          //      Text('من '+"  "+widget.start,
          //        style: TextStyle(
          //          fontSize: 13,
          //          fontWeight: FontWeight.w700,
          //          color: Colors.black54,
          //          fontFamily: 'Changa',
          //        ),),
          //    ],
          //   )
          //
          // ),
          // Container(
          //   child: Row(
          //     children: [
          //       SizedBox(width: 100,),
          //       Text('إلى '+ " "+widget.end,
          //         style: TextStyle(
          //           fontSize: 13,
          //           fontWeight: FontWeight.w700,
          //           color: Colors.black54,
          //           fontFamily: 'Changa',
          //         ),),
          //     ],
          //   ),
          // ),
          Container(
            width: 500,
            height: 40,
            margin: EdgeInsets.only(right: 15,top:10),
            child: Row(
              children: [
                SizedBox(width:280,),
                GestureDetector(
                  child: Container(
                    child: Row(
                      children: [
                        Text('عرض المزيد',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Y,
                            fontFamily: 'Changa',
                          ),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Image.asset('assets/card-sample-image.jpg'),
          // Image.asset('assets/card-sample-image-2.jpg'),
        ],
      ),),
  );

  }
  Future<void> _showMyDialog(final List<DateTime> picked,final type) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Directionality(textDirection: ui.TextDirection.rtl,
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top:10,right: 10,bottom:40),
                          alignment: Alignment.center,
                          // transform: Matrix4.translationValues(0, -120.0, 0),
                          child:Text('الموافقة على الورشة',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontFamily: 'vibes',
                              //fontStyle: FontStyle.italic,
                            ),)
                      ),
                      Container(
                        alignment:Alignment.topRight,
                        child: Row(
                          children: [
                            Text('نوع الورشة',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                                fontFamily: 'Changa',
                              ),),
                            SizedBox(width: 10,),
                            Text(type,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Colors.black54,
                                fontFamily: 'Changa',
                              ),),
                          ],
                        ),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        alignment:Alignment.topRight,
                        child:Text('مدة الورشة ',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            fontFamily: 'Changa',
                          ),),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        alignment: Alignment.topRight,
                        child: Text('من تاريخ '+"  "+ DateFormat('yyyy-MM-dd').format(picked.first),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.black54,
                            fontFamily: 'Changa',
                          ),),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child:  Text('إلى تاريخ '+ " "+DateFormat('yyyy-MM-dd').format(picked.last),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.black54,
                            fontFamily: 'Changa',
                          ),),
                      ),
                      SizedBox(height: 30),
                      Container(
                        alignment: Alignment.topRight,
                        child:Text('لقبول هذه الورشة اضغط على تأكيد',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.black54,
                            fontFamily: 'Changa',
                          ),),
                      ),
                    ],
                  ),
                ),
              ],),),
          actions: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child:Container(
                margin: EdgeInsets.only(bottom:10,left: 10),
                child: Text('إلغاء',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color:Y,
                    fontFamily: 'Changa',
                  ),),
              ),
            ),
            GestureDetector(
              onTap: (){
                addlongtimework(picked);
                Navigator.of(context).pop();
              },
              child:Container(
                width: 70,
                margin: EdgeInsets.only(left:40,bottom:10),
                child: Text('تأكيد',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color:Y,
                    fontFamily: 'Changa',
                  ),),
              ),
            ),
            SizedBox(width: 150,),
          ],
        );
      },
    );
  }

  Future<void> addlongtimework(final List<DateTime> picked) async {
    // int i = 0;
    // print(widget.workerphoned);
    // var flag=true;
    // //  DateTime fromDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(widget.fromdate);
    // if(widget.fromdate ==null||widget.Todate==null){
    //   print('hi hi hi');
    //   // print(widget.nameofwork);
    //   //print(widget.namefirst);
    //   var url ='https://'+IP4+'/testlocalhost/reservations.php';
    //   var ressponse = await http.post(url, body: {
    //     "nameofwork": widget.nameofworkd,
    //     "namefirst": widget.namefirstd,
    //     "namelast": widget.namelastd,
    //     "phoneuser": widget.phoneuserd,
    //     "workerphone": widget.workerphoned,
    //     //"id": widget.id,
    //     "Fromdate": picked.first.toString(),
    //     "Todate": picked.last.toString(),
    //   });
    // }
    // else{ bool flag=false;
    // print("I am checking for overlapping");
    // print(widget.fromdate.length-1);
    // print(widget.Todate.length-1);
    // for(int p=0;p<widget.fromdate.length-1;p++){
    //   if(flag==true)break;
    //   DateTime from = DateTime.parse(widget.fromdate[p]);
    //   print(from);
    //   DateTime to = DateTime.parse(widget.Todate[p]);
    //   print(to);
    //   DateTime start = picked.first;
    //   DateTime end = picked.last;
    //
    //   if (start == from || start == to ||(start.isBefore(to) && start.isAfter(from))){
    //     flag=true;_showMyDialogo();break;
    //
    //     print("overlap");}
    //   else
    //   if (end == from || end == to || (end.isBefore(to) && end.isAfter(from))) {
    //     print("overlap");flag=true;_showMyDialogo();break;
    //   }
    // }
    // if(flag==true) _showMyDialogo();
    // if(flag==false) {
    //   widget.ifpicked=true;
    //   //print(from); // 2020-01-02 03:04:05.000
    //   //row["name"].contains(value)
    //   //if(picked.first [i]>= dt)
    //   var mesaage;
    //   print('hi hi hi');
    //   var url = 'https://'+IP4+'/testlocalhost/reservations.php';
    //   var ressponse = await http.post(url, body: {
    //     "nameofwork": widget.nameofworkd,
    //     "namefirst": widget.namefirstd,
    //     "namelast": widget.namelastd,
    //     "phoneuser": widget.phoneuserd,
    //     "workerphone": widget.workerphoned,
    //     //"id": widget.id,
    //     "Fromdate": picked.first.toString(),
    //     "Todate": picked.last.toString(),
    //   });
    //
    //   // mesaage = json.decode(ressponse.body);
    // }
    // }
  }
  Future<void> _showMyDialogo( ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تضارب في المواعيد'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("يوجد لديك حجز في التاريخ المختار"),
                Text('اختر موعدا اخر'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

          ],
        );
      },
    );
  }

}
class datep extends StatefulWidget {
  List<dynamic>fromdate;
  List<dynamic>Todate;
  bool ifpicked=false;
  //final fromdate;
  //final Todate;
  final phoneuserd;
  final namefirstd;
  final namelastd;
  final nameofworkd;
  final workerphoned;


  // final nameofwork; final namelast;final namefirst;final phoneuser;final workerphone;
  datep({this.namefirstd,this.namelastd,this.nameofworkd,this.phoneuserd,this.workerphoned,this.fromdate,this.Todate});
  @override
  _datepState createState() => _datepState();
}

class _datepState extends State<datep> {

  @override
  Widget build(BuildContext context) {
    return
      Theme(
        data: Theme.of(context).copyWith(
            accentColor: Y,
            primaryColor: Y,
            buttonTheme: ButtonThemeData(
                highlightColor: Colors.indigoAccent,
                buttonColor: Y,
                colorScheme: Theme.of(context).colorScheme.copyWith(
                    secondary: Colors.white,
                    background: Colors.white,
                    primary:MY_BLACK,
                    primaryVariant: Y,
                    //brightness: Brightness.,
                    onBackground: Y),
                textTheme: ButtonTextTheme.accent)),
        child: Builder(
          builder: (context) => RaisedButton(
              color: Color.fromRGBO(212, 20, 15, 1.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 30.0, right: 30.0),
                child: Text(
                  "Date",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              onPressed: () async {

                final List<DateTime> picked = await DateRangePicker.showDatePicker(
                    context: context,
                    initialFirstDate: new DateTime.now(),
                    initialLastDate: (new DateTime.now()).add(new Duration(days: 7)),
                    firstDate: new DateTime(2021),
                    lastDate: new DateTime(DateTime.now().year + 2));
                if (picked != null && picked.length == 2) {
                  print(picked);
                  print(picked.first);
                  _showMyDialog(picked);

                }
                else {
                }
              }),),);
  }

  Future<void> _showMyDialog(final List<DateTime> picked ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('حجز ورشة'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('مدة الورشة :'+picked.toString()),
                Text('انت على وشك قبول ورشةلارسال التفاصيل للزبون اضغط تأكيد '),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('تأكيد'),
              onPressed: () {
                addlongtimework(picked);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('الغاء'),
              onPressed: () {

                Navigator.of(context).pop();
              },),
          ],
        );
      },
    );
  }

  Future<void> addlongtimework(final List<DateTime> picked) async {
    int i = 0;
    print(widget.workerphoned);
    var flag=true;
    //  DateTime fromDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(widget.fromdate);
    if(widget.fromdate ==null||widget.Todate==null){
      print('hi hi hi');
      // print(widget.nameofwork);
      //print(widget.namefirst);
      var url ='https://'+IP4+'/testlocalhost/reservations.php';
      var ressponse = await http.post(url, body: {
        "nameofwork": widget.nameofworkd,
        "namefirst": widget.namefirstd,
        "namelast": widget.namelastd,
        "phoneuser": widget.phoneuserd,
        "workerphone": widget.workerphoned,
        //"id": widget.id,
        "Fromdate": picked.first.toString(),
        "Todate": picked.last.toString(),
      });
    }
    else{ bool flag=false;
    print("I am checking for overlapping");
    print(widget.fromdate.length-1);
    print(widget.Todate.length-1);
    for(int p=0;p<widget.fromdate.length-1;p++){
      if(flag==true)break;
      DateTime from = DateTime.parse(widget.fromdate[p]);
      print(from);
      DateTime to = DateTime.parse(widget.Todate[p]);
      print(to);
      DateTime start = picked.first;
      DateTime end = picked.last;

      if (start == from || start == to ||(start.isBefore(to) && start.isAfter(from))){
        flag=true;_showMyDialogo();break;

        print("overlap");}
      else
      if (end == from || end == to || (end.isBefore(to) && end.isAfter(from))) {
        print("overlap");flag=true;_showMyDialogo();break;
      }
    }
    if(flag==true) _showMyDialogo();
    if(flag==false) {
      widget.ifpicked=true;
      //print(from); // 2020-01-02 03:04:05.000
      //row["name"].contains(value)
      //if(picked.first [i]>= dt)
      var mesaage;
      print('hi hi hi');
      var url = 'https://'+IP4+'/testlocalhost/reservations.php';
      var ressponse = await http.post(url, body: {
        "nameofwork": widget.nameofworkd,
        "namefirst": widget.namefirstd,
        "namelast": widget.namelastd,
        "phoneuser": widget.phoneuserd,
        "workerphone": widget.workerphoned,
        //"id": widget.id,
        "Fromdate": picked.first.toString(),
        "Todate": picked.last.toString(),
      });

      // mesaage = json.decode(ressponse.body);
    }
    }
  }
  Future<void> _showMyDialogo( ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تضارب في المواعيد'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("يوجد لديك حجز في التاريخ المختار"),
                Text('اختر موعدا اخر'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

          ],
        );
      },
    );
  }
}

class ClippingClass extends CustomClipper<Path>{
  @override

  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    var controlPoint = Offset(size.width - (size.width / 2), size.height - 90);
    var endPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}