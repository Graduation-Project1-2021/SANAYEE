//import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/USER/warshat_description.dart';
import 'package:http/http.dart' as http;
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

import '../constants.dart';
import 'List_worker_group.dart';
String IP4="192.168.1.8";
class viewreservation extends StatefulWidget {
  //final workerphone;
  // final phone;
  // final id;

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
  final AVG;
  final work;
  final Information;
  final Experiance;
  final nameworker;
  final client_count;
  final comment;
  viewreservation({this.comment,this.client_count,this.Information,this.Experiance,this.nameworker,this.AVG,this.work,this.date,this.token_Me,this.phoneworker,this.tokenworker,this.name_Me,this.country,this.namefirst,this.namelast,this.image,this.phone,this.time});

  @override
  _viewreservationState createState() => _viewreservationState();
}

class _viewreservationState extends State<viewreservation> {
  // List <String>fromdate=List <String>();
  // List<String>Todate=[];
  var ListFromdate=[];
  var listTodate=[];
  @override
  Widget build(BuildContext context) {
    return Container(
      //    color: Colors.green,
      //    height: 200,
      //    width:500,
      //    padding: EdgeInsets.only(top:30),
      //    child:Column(
      //  children: [
      //      Container(
      //      width: 400,
      //      height: 100,
      //      margin: EdgeInsets.only(top:80,),
      //      child: FlatButton(
      //        shape: RoundedRectangleBorder(
      //            borderRadius: BorderRadius.circular(25.0),
      //            side: BorderSide(color: Colors.transparent)
      //        ),
      //        // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
      //        color:Y2,
      //        onPressed: (){
      //          print("warsha add"+widget.namefirstd);
      //          Navigator.push(
      //          context,
      //          MaterialPageRoute(
      //          builder: (context) => datep(workerphoned: widget.workerphoned,namefirstd:widget.namefirstd,namelastd: widget.namelastd,phoneuserd: widget.phoneuserd,fromdate: widget.fromdate,Todate: widget.Todate),),);
      //        },
      //        child: Text(
      //          "اضافة الورشة",
      //          style: TextStyle(
      //            color: Colors.white,
      //            fontWeight: FontWeight.bold,
      //            fontSize: 20.0,
      //            fontFamily: 'Changa',
      //          ),
      //        ),
      //      ),
      //    ),
      // //    FlatButton(
      // //      child: Text("اضافة"),
      // //      onPressed: (){
      // // Navigator.push(
      // // context,
      // // MaterialPageRoute(
      // // builder: (context) => datep(workerphone: widget.workerphone),
      // // ),);},
      //
      //
      //
      //
      //    //  color:  Color(0xFF1C1C1C),
      //  Column(
      //      crossAxisAlignment: CrossAxisAlignment.stretch,
      //      mainAxisAlignment: MainAxisAlignment.center,
      //      children: <Widget>[
      //    Expanded(child: Container(
      //      height: 800,
      //      // color:  Color(0xFFF3D657),
      //      margin: EdgeInsets.only(top: 0),
      //      decoration: BoxDecoration(
      //        // color:Color(0xFF1C1C1C),
      //        // borderRadius: BorderRadius.only(
      //        //   topLeft: Radius.circular(50),
      //        //   topRight: Radius.circular(50),
      //        // ),
      //      ),
      child:
      FutureBuilder(
        future: viewreservations(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            print("has data");
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                print(snapshot.data.length);
                print(snapshot.data[index]['Fromdate']+"men");
                ListFromdate.add( snapshot.data[index]['Fromdate']);
                listTodate.add( snapshot.data[index]['Todate']);
                if(index==snapshot.data.length-1)
                  return datep (fromdate:ListFromdate,Todate:listTodate,workerphoned: widget.phoneworker,namefirstd: widget.namefirst,namelastd: widget.namelast,phoneuserd: widget.phone,nameofworkd: widget.nameworker);
                return  Container (color:Colors.red);
              },
              // return datep (fromdate:ListFromdate,Todate:listTodate,workerphoned: widget.workerphoned,namefirstd: widget.namefirstd,namelastd: widget.namelastd,phoneuserd: widget.phoneuserd,nameofworkd: widget.nameofworkd,);
            );

          }
          return  CircularProgressIndicator ();
        },
      ),
      // ),),],),
      //     ],),
    );
  }
  viewreservations() async {
    var url = 'https://' + IP4 + '/DUAA/PHP/seereservations.php';
    print(widget.phoneworker);
    var ressponse = await http.post(url, body: {
      "phone": widget.phoneworker,
    });
    // ignore: deprecated_member_use
    // var responsebody = json.decode(ressponse.body);
    // print(responsebody);
    return json.decode(ressponse.body);
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
          splashColor: Colors.red,
          textSelectionHandleColor:Colors.black,
          textSelectionColor:Colors.black,
          bottomAppBarColor: Colors.black87,
          buttonColor:Colors.black87,
          backgroundColor:Colors.black,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.teal,
            primaryColorDark: Colors.teal,
            accentColor: Colors.teal,
          ),
          // buttonTheme: ButtonThemeData(
          //
          //     highlightColor: Colors.red,
          //     buttonColor: Colors.red,
          //     colorScheme: Theme.of(context).colorScheme.copyWith(
          //         secondary: Colors.red,
          //         background: Colors.red,
          //         primary:Colors.red,
          //         primaryVariant:Colors.red,
          //         //brightness: Brightness.,
          //         onBackground:Colors.red),
          //         textTheme: ButtonTextTheme.accent)
        ),
        child: Builder(
          builder: (context) => FlatButton(
              child: Text(
                "إضافة",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Y,
                  fontFamily: 'Changa',
                ),
              ),
              onPressed: () async {
                // Navigator.push(context, MaterialPageRoute(builder: (context) =>viewreservation(phoneuserd:widget.phoneuser,workerphoned:widget.workerphone,namefirstd:widget.namefirst,namelastd:widget.namelast,nameofworkd:widget.nameofwork,)));

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
      var url = 'https://' + IP4 + '/DUAA/PHP/reservations.php';
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
      var url = 'https://' + IP4 + '/DUAA/PHP/reservations.php';
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

class user extends StatefulWidget {
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
  final AVG;
  final work;
  final Information;
  final Experiance;
  final nameworker;
  final client_count;
  final comment;
  user({this.comment,this.client_count,this.Information,this.Experiance,this.nameworker,this.AVG,this.work,this.date,this.token_Me,this.phoneworker,this.tokenworker,this.name_Me,this.country,this.namefirst,this.namelast,this.image,this.phone,this.time});

  @override
  _userState createState() => _userState();
}

class _userState extends State<user> {
  DateTime selectedDate = DateTime.now();
  TextEditingController describe = TextEditingController();
  Future<void> _showMyDialog( String nameofwork ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("حجز ورشة لدى الصنايعي "),

          content: SingleChildScrollView(
            child: ListBody(

              children: <Widget>[
                TextFormField(
                  controller: describe,
                  decoration: const InputDecoration(

                      hintText: 'اكتب وصفا لطلبك',
                      labelText: 'ادخل تفاصيل الطلب الذي تريد ارساله'+"\n"
                  ),
                ),
                Text( "\n" +'انت على وشك ارسال طلب للصنايعي' )  ,

              ],
            ),
          ),
          actions: <Widget>[

            TextButton(
              child: Text('الغاء'),
              onPressed: () {

                Navigator.of(context).pop();
              },

            ),
            TextButton(
              child: Text('تأكيد'),
              onPressed: () {
                SendOrderDetails(nameofwork );

                Navigator.of(context).pop();
              },),
          ],
        );
      },
    );
  }
  bool box1=true;
  bool box2=false;
  bool box3=false;
  bool box4=false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor:Colors.black.withOpacity(0.75),
      //   leading:   IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
      //     Navigator.pop(context);
      //   }), ),
      body:Column(
        children: [
          GestureDetector(
              onTap:(){
                Navigator.pop(context);
              },
              child:Container(
                margin: EdgeInsets.only(top: 70,left: 370),
                child:Icon(Icons.arrow_forward,color: Colors.black,),
              )
          ),
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 50,),
              child:Text('اختر الورشة التي تريدها',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontFamily: 'vibes',
                  //fontStyle: FontStyle.italic,
                ),)
          ),
        Container(//color: Color(0xFF1C1C1C),
        //color:Colors.transparent,
        height: 300,
        width:500,
        margin: EdgeInsets.only(top:40,left:11,right:8),
          child: Column(
            children: <Widget>[
              Row(
                    children: <Widget>[
                      Container(
                        //color: Color(0xFF1C1C1C),
                        margin: EdgeInsets.only(left: 5, top: 10, bottom: 0,right:10),
                        width: 180,
                        height: 140,
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                  box2=true;
                                  box1=false;
                                  box3=false;
                                  box4=false;

                                  setState(() {

                                  });
                                  //_showMyDialog("أثاث بيت جديد ");

                                },
                              child: Container(
                                height: 130,
                                // padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  //border: Border.all(color: box2?Y:Colors.white, width:3),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(image: AssetImage('assets/work/w2.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child:Stack(
                                    children:<Widget>[
                                      // ClipRRect(
                                      //   borderRadius: BorderRadius.circular(29),
                                      //   child:Image.asset(image,width: 200,height: 100,),
                                      // ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Container(
                                          color:box2?Y.withOpacity(0.7):Colors.black.withOpacity(0.3),
                                          margin: EdgeInsets.only(top: 85),
                                          child:Center(
                                            child:Text('أثاث بيت جديد',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Changa',
                                                color: Colors.white,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),),),
                                      ), ],),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        //color: Color(0xFF1C1C1C),
                        margin: EdgeInsets.only(left: 5, top: 10, bottom: 0,right:10),
                        width: 180,
                        height: 140,
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                box2=false;
                                box1=true;
                                box3=false;
                                box4=false;

                                setState(() {

                                });
                              },
                              child: Container(
                                height: 130,
                                // padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  //border: Border.all(color: box2?Y:Colors.white, width:3),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(image: AssetImage('assets/work/w1.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child:Stack(
                                    children:<Widget>[
                                      // ClipRRect(
                                      //   borderRadius: BorderRadius.circular(29),
                                      //   child:Image.asset(image,width: 200,height: 100,),
                                      // ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Container(
                                          color:box1?Y.withOpacity(0.7):Colors.black.withOpacity(0.3),
                                          margin: EdgeInsets.only(top: 85),
                                          child:Center(
                                            child:Text(' تصميم مطبخ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Changa',
                                                color: Colors.white,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),),),
                                      ), ],),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],),
              Row(

                    children: <Widget>[
                      Container(
                        //color: Color(0xFF1C1C1C),
                        margin: EdgeInsets.only(left: 5, top: 10, bottom: 0,right:10),
                        width: 180,
                        height: 140,
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                box2=false;
                                box1=false;
                                box3=false;
                                box4=true;

                                setState(() {

                                });
                                //_showMyDialog("أثاث بيت جديد ");

                              },
                              child: Container(
                                height: 130,
                                // padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  //border: Border.all(color: box2?Y:Colors.white, width:3),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(image: AssetImage('assets/work/w4.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child:Stack(
                                    children:<Widget>[
                                      // ClipRRect(
                                      //   borderRadius: BorderRadius.circular(29),
                                      //   child:Image.asset(image,width: 200,height: 100,),
                                      // ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Container(
                                          color:box4?Y.withOpacity(0.7):Colors.black.withOpacity(0.3),
                                          margin: EdgeInsets.only(top: 85),
                                          child:Center(
                                            child:Text('تصميم خزانة',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Changa',
                                                color: Colors.white,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),),),
                                      ), ],),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        //color: Color(0xFF1C1C1C),
                        margin: EdgeInsets.only(left: 5, top: 10, bottom: 0,right:10),
                        width: 180,
                        height: 140,
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                box2=false;
                                box1=false;
                                box3=true;
                                box4=false;

                                setState(() {

                                });
                              },
                              child: Container(
                                height: 130,
                                // padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  //border: Border.all(color: box2?Y:Colors.white, width:3),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(image: AssetImage('assets/work/w3.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child:Stack(
                                    children:<Widget>[
                                      // ClipRRect(
                                      //   borderRadius: BorderRadius.circular(29),
                                      //   child:Image.asset(image,width: 200,height: 100,),
                                      // ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Container(
                                          color:box3?Y.withOpacity(0.7):Colors.black.withOpacity(0.3),
                                          margin: EdgeInsets.only(top: 85),
                                          child:Center(
                                            child:Text('تفصيل أبواب',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Changa',
                                                color: Colors.white,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),),),
                                      ), ],),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                    ],),
                ],),
      ),
          Container(
            height: 55,
            margin: EdgeInsets.only(top:196.5,),
            color:Y,
            width:600,
            // margin: EdgeInsets.only(left: 8,right: 15),
            child: FlatButton(
              onPressed: (){
                DateTime date=DateTime.now();
                print(date);
                // if(c1){
                //   if(widget.work=="نجار")
                //     Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => user()));
                //   else  if(widget.work=="كهربائي")
                //     Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => sabak()));
                //
                // }
                // else if(c2){
                //   Navigator.push(context, MaterialPageRoute(builder: (context) => My_SLot(date:widget.time,country:widget.country,namelast:widget.namelast,namefirst:widget.namefirst,image:widget.image,nameworker:widget.name,work:widget.work,name_Me:widget.username,phoneworker: widget.phoneworker,phone: widget.phone,),),);
                // }
                String type="";
                if(box1){type="تصميم مطبخ";}
                if(box2){type="أثاث بيت جديد";}
                if(box3){type="تفصيل أبواب";}
                if(box4){type="تصميم خزانة";}
                Navigator.push(context, MaterialPageRoute(builder: (context) =>war_description(type:type,tokenworker:widget.tokenworker,token_Me:widget.token_Me,comment:widget.comment,client_count:widget.client_count,Experiance:widget.Experiance,Information:widget.Information,date:widget.time,country:widget.country,namelast:widget.namelast,namefirst:widget.namefirst,image:widget.image,nameworker:widget.nameworker,work:widget.work,name_Me:widget.name_Me,phoneworker: widget.phoneworker,phone: widget.phone)));
              },
              color:Y,
              child: Text(
                "التالي",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 21.0,
                  fontFamily: 'Changa',
                ),
              ),
            ),
          ),

        ],),
      );
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2021, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate){
      //    _showMyDialog(picked);
      setState(() {

        selectedDate = picked;
        print(picked);
      });}
  }

  Future SendOrderDetails(String nameofwork) async{
    var mesaage;
    print('hi hi hi');
    print(describe.text);
    var url = 'https://'+IP4+'/DUAA/PHP/addlongtimerequest.php';
    var ressponse = await http.post(url, body: {
      "nameofwork": nameofwork,
      "namefirst":widget.namefirst,
      "namelast":widget.namelast,
      "phoneuser": widget.phone,
      "workerphone":widget.phoneworker,
      "describes":describe.text,
    });

    // mesaage= json.decode(ressponse.body);
  }
}
class sabak extends StatefulWidget {
  final phone;
  final namefirst;
  final nameLast;
  final phoneuser;
  final nameLast_Me;
  final namefirst_Me;
  sabak({this.phone,this.phoneuser,this.nameLast,this.namefirst,this.nameLast_Me,this.namefirst_Me});
  @override
  _sabakState  createState() => _sabakState ();
}

class _sabakState extends State<sabak> {
  DateTime selectedDate = DateTime.now();
  TextEditingController describe = TextEditingController();
  Future<void> _showMyDialog( String nameofwork ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("حجز ورشة لدى الصنايعي "),

          content: SingleChildScrollView(
            child: ListBody(

              children: <Widget>[
                TextFormField(
                  controller: describe,
                  decoration: const InputDecoration(

                      hintText: 'اكتب وصفا لطلبك',
                      labelText: 'ادخل تفاصيل الطلب الذي تريد ارساله'+"\n"
                  ),
                ),
                Text( "\n" +'انت على وشك ارسال طلب للصنايعي' )  ,

              ],
            ),
          ),
          actions: <Widget>[

            TextButton(
              child: Text('الغاء'),
              onPressed: () {

                Navigator.of(context).pop();
              },

            ),
            TextButton(
              child: Text('تأكيد'),
              onPressed: () {
                SendOrderDetails(nameofwork );

                Navigator.of(context).pop();
              },),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor:Colors.black.withOpacity(0.75),
        leading:   IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
          Navigator.pop(context);
        }), ),
      body:
      Container(//color: Color(0xFF1C1C1C),
        //color:Colors.transparent,
        height: 700,
        width:600,
        margin: EdgeInsets.only(top:150),
        child: SingleChildScrollView(

          scrollDirection: Axis.horizontal,
          child: Row(

            children: <Widget>[
              Column(

                children: <Widget>[

                  Row(

                    children: <Widget>[
                      RecomendPlantCard(

                        // image: "assets/work/najar.jpg",
                        title: "تمديدات بيت جديد ",
                        press: () async{


                          _showMyDialog("تمديدات بيت جديد ");

                        },
                      ),
                      RecomendPlantCard(

                        //  image: "assets/work/sapak.jpg",
                        title: "تصليح مطبخ",
                        press: ()async {
                          _showMyDialog(" تصليح مطبخ");
                        },
                      ),],),
                  Row(

                    children: <Widget>[
                      RecomendPlantCard(
                        //image: "assets/work/electric1.jpg",
                        title: "تمديدات لعمارة",
                        press: () async{
                          _showMyDialog("تمديدات لعمارة");
                        },
                      ),
                      RecomendPlantCard(
                        //image: "assets/work/fix.jpg",
                        title: "اخرى",
                        press: ()async {
                          _showMyDialog("اخرى");
                        },
                      ),],),

                  //       RecomendPlantCard(
                  //         //image: "assets/work/sapaak.jpg",
                  //         title: "سبّاك",
                  //         press: () {},
                  //       ),
                  //       RecomendPlantCard(
                  //         //image: "assets/work/dahan.jpg",
                  //         title: "دهّان",
                  //         press: () {},
                  //       ),
                  //       RecomendPlantCard(
                  //         //image: "assets/work/mec.jpg",
                  //         title: "ميكانيك",
                  //         press: () {},
                  //       ),
                  //       RecomendPlantCard(
                  //         //image: "assets/work/baleet.jpg",
                  //         title: "بلييط",
                  //         press: () {},
                  //       ),
                  //       RecomendPlantCard(
                  //         //image: "assets/work/repaier.jpg",
                  //         title: "إصلاح",
                  //         press: () {},
                  //       ),

                ],),
            ],
          ),
        ),
      ),);
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2021, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate){
      //    _showMyDialog(picked);
      setState(() {

        selectedDate = picked;
        print(picked);
      });}
  }

  Future SendOrderDetails(String nameofwork) async{
    var mesaage;
    print('hi hi hi');
    print(describe.text);
    var url = 'https://'+IP4+'/DUAA/PHP/addlongtimerequest.php';
    var ressponse = await http.post(url, body: {
      "nameofwork": nameofwork,
      "namefirst":widget.namefirst_Me,
      "namelast":widget.nameLast_Me,
      "phoneuser": widget.phoneuser,
      "workerphone":widget.phone,
      "describes":describe.text,
    });

    // mesaage= json.decode(ressponse.body);
  }
}

class RecomendPlantCard extends StatelessWidget {
  const RecomendPlantCard({
    Key key,
    this.image,
    this.title,
    this.press,
  }) : super(key: key);

  final String image, title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      //color: Color(0xFF1C1C1C),
      margin: EdgeInsets.only(left: 5, top: 10, bottom: 0,right:10),
      width: 180,
      height: 140,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child: Container(
              height: 130,
              // padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(29),
                // boxShadow: [
                //   BoxShadow(
                //     offset: Offset(0, 10),
                //     blurRadius: 50,
                //     color:Color(0xFF1C1C1C),
                //   ),
                // ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
                child:Stack(
                  children:<Widget>[
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(29),
                //   child:Image.asset(image,width: 200,height: 100,),
                // ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        color:Colors.black.withOpacity(0.3),
                        margin: EdgeInsets.only(top: 85),
                        child:Center(
                          child:Text(title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Changa',
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),),),
                    ), ],),
              ),
            ),
          )
        ],
      ),
    );
  }
}