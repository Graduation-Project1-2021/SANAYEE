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
double hight=200;
class viewWarsha extends StatefulWidget {
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
  viewWarsha({this.image,this.lng,this.lat,this.namelast,this.namefirst,this.token,this.Experiance,this.Information,this.Work,this.phone,this.name});
  @override
  _viewWarshaState createState() => _viewWarshaState();
}

class _viewWarshaState extends State<viewWarsha> {
  @override
  void initState() {
    super.initState();
     press=true;
     setState(() {

     });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future getorder()async{
    var url='https://'+IP4+'/testlocalhost/viewOrder.php';
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
                     // Navigator.pop(context);
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => order_worker(lat:widget.lat,lng:widget.lng,Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,name:widget.name,phone:widget.phone,image:widget.image,token:widget.token,namefirst:widget.namefirst)));},

                    child:Icon(Icons.arrow_back,color: Colors.grey[600],),
                  )
              ),
              Container(
                  height: 100,
                  color: Colors.white,
                  margin: EdgeInsets.only(top:90,right:0),
                  alignment: Alignment.center,
                  // transform: Matrix4.translationValues(0, -120.0, 0),
                  child:Text('طلبات جديدة',
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
                  future: getorder(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"+widget.phone);
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          print(snapshot.data[index]['workerphone']);
                          // return Container(height: 200,);
                          print("WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW"+snapshot.data[index]['id']);
                          return view (city:snapshot.data[index]['city'],country:snapshot.data[index]['country'],id:snapshot.data[index]['id'],type:snapshot.data[index]['type'],image:snapshot.data[index]['image'],describes:snapshot.data[index]['describes'],nameofwork : snapshot.data[index]['nameofwork'],workerphone : snapshot.data[index]['workerphone'], namefirst: snapshot.data[index]['namefirst'], namelast: snapshot.data[index]['namelast'], phoneuser: snapshot.data[index]['phoneuser']);

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

    var url = 'https://'+IP4+'/testlocalhost/viewOrder.php';
    print("ssssssssssssssssssssssssssssssssssssssssssssssssssssssssss"+widget.phone);
    var ressponse = await http.post(url, body: {
      "phone": widget.phone,

    });
    return json.decode(ressponse.body);
  }
}


class view extends StatefulWidget {
  final phoneuser;
  final describes;
  final namefirst;
  final namelast;
  final image;
  final type;
  final workerphone;
  final nameofwork;
  final id;
  final city;
  final country;
  view({this.country,this.city,this.id,this.image,this.type,this.namelast,this.workerphone,this.namefirst,this.phoneuser,this.nameofwork,this.describes});
  @override
  _viewState createState() => _viewState();
}

class _viewState extends State<view> {
  @override
   bool datepicher=false;
  double h=165;
  Widget build(BuildContext context) {
    return Column(

      children:[
        card(widget.namefirst,widget.namelast,widget.describes,widget.phoneuser,widget.workerphone,widget.nameofwork,widget.image,widget.type),

      ],);



  }
  Widget card(String namefirst , String namelast,String describes,String phoneuser,String workerphone,String nameofwork,String image,String type)
  { print("tafaseel talab "+workerphone);

  return Container (
    height:h,
    width: 380,
    margin: EdgeInsets.only(top:0,bottom: 15),
    padding: EdgeInsets.all(5),
      alignment: Alignment.topRight,
      decoration: BoxDecoration(
        color:Colors.grey[50],
        borderRadius: BorderRadius.circular(5),
       ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          SizedBox(height: 5,),
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
          press?Container():Container(
            margin: EdgeInsets.only(top:10,right: 15),
            child:  Row(
              children: [
                Container(
                  width:90,
                  height: 75,
                  child:Text('تفاصبل الطلب', style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    fontFamily: 'Changa',
                  ),
                  ),
                ),
                Container(
                  width:250,
                  height: 75,
                  child:Text(describes, style: TextStyle(
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
          image!=null && !press?Container(
            // print(_image[index].id+"");
            width: 200,
            height: 150,
            margin: EdgeInsets.only(left: 150,top:0,bottom: 15),
            decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(image: NetworkImage('https://'+IP4+'/testlocalhost/upload/'+image),
                fit: BoxFit.cover,
              ),
            ),
          ):Container(),
          Container(
            width: 500,
            height: 40,
            margin: EdgeInsets.only(right: 15,top:10),
            child: Row(
              children: [
                !press?GestureDetector(
                  onTap: (){
                    press=!press;
                    h=165;
                    setState(() {
                    });
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Text('عرض أقل',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            fontFamily: 'Changa',
                          ),),
                        Icon(Icons.keyboard_arrow_up_outlined,size: 20,),
                      ],
                    ),
                  ),
                ):
                GestureDetector(
                  onTap: (){
                      press=!press;
                      if(image==null)h=165;
                      else h=410;
                      setState(() {

                      });
                    },
                  child: Container(
                    child: Row(
                      children: [
                        Text('عرض المزيد',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            fontFamily: 'Changa',
                          ),),
                        Icon(Icons.keyboard_arrow_down,size: 20,),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 160,),
                Theme(
                  data: Theme.of(context).copyWith(
                      accentColor: Y,
                      primaryColor: Y,
                      buttonTheme: ButtonThemeData(
                        colorScheme: Theme.of(context).colorScheme.copyWith(
                          primary:MY_BLACK,
                        ),
                      )),
                  child: Builder(
                    builder: (context) => GestureDetector(
                        child: Container(
                          width: 50,
                          margin:EdgeInsets.only(top: 0.0, bottom: 0.0, left: 30.0, right: 0.0),
                          child: Text(
                            "قبول",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Y,
                              fontFamily: 'Changa',
                            ),
                          ),
                        ),
                        onTap: () async {
                          final List<DateTime> picked = await DateRangePicker.showDatePicker(
                              context: context,
                              initialFirstDate: new DateTime.now(),
                              initialLastDate: (new DateTime.now()).add(new Duration(days: 7)),
                              firstDate: new DateTime(2021),
                              lastDate: new DateTime(DateTime.now().year + 2));
                          if (picked != null && picked.length == 2) {
                            print(picked);
                            print(picked.first);
                            _showMyDialog(picked,type);

                          }
                          else {
                          }
                        }),),),

                GestureDetector(
                  onTap: (){
                    _dialogCall2();
                  },
                  child: Container(
                    width: 30,
                    padding: const EdgeInsets.only(top: 0.0, bottom: 0.0, left: 0.0, right: 0.0),
                    child: Text(
                      "حذف",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Y,
                        fontFamily: 'Changa',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Image.asset('assets/card-sample-image.jpg'),
          // Image.asset('assets/card-sample-image-2.jpg'),
        ],
      ),);

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
                print("SARAHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHhh");
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
    int i = 0;
    var url ='https://'+IP4+'/testlocalhost/reservations.php';
    var ressponse = await http.post(url, body: {
      "nameofwork": widget.nameofwork,
      "namefirst": widget.namefirst,
      "namelast": widget.namelast,
      "phoneuser": widget.phoneuser,
      "workerphone": widget.workerphone,
      "type": widget.type,
      "images": widget.image,
      "describes": widget.describes,
      "Fromdate": picked.first.toString(),
      "Todate": picked.last.toString(),
    });
  }
  Future<void> _dialogCall2() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Directionality(textDirection: ui.TextDirection.rtl,
            child:delete_order(id:widget.id,phone:widget.workerphone,name:widget.nameofwork,));
        });
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

class delete_order extends StatefulWidget {
  @override
  final id;
  final phone;
  final name;
  delete_order({this.name,this.id,this.phone,});
  _delete_order createState() => new _delete_order();

}
class _delete_order extends State<delete_order> {
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      actionsPadding: EdgeInsets.zero,
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 0,top: 10),
                  child: Text('هل أنت متأكد من أنك تريد حذف هذا الطلب ؟',
                    style: TextStyle(
                      fontFamily: 'Changa',
                      color: Colors.black45,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),),
                ),
                SizedBox(height:50,),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async{
                        await delete_Order();
                        DateTime date_d =DateTime.now();
                        print('=========================================================================');

                        // Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => viewWarsha(phone:widget.phone,name:widget.name,)));
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 170),
                          child:Text('حسنا',
                            style: TextStyle(
                              fontFamily: 'Changa',
                              color: Y,
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 48),
                          child:Text('إلغاء',
                            style: TextStyle(
                              fontFamily: 'Changa',
                              color: Y,
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                      ),
                    ),
                  ],
                ),
                // SizedBox(width: 10,),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future delete_Order() async {
    DateTime date=DateTime.now();
    print("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF");
    print(widget.id);
    var formattedDate = DateFormat('yyyy-MM-dd').format(date);
    var formattedTime = DateFormat('HH:mm:ss').format(date);
    var url = 'https://' + IP4 + '/testlocalhost/delete_warsha.php';
    var ressponse = await http.post(url, body: {
      "id": widget.id,
      "datecancel":formattedDate,
      "timecancel":formattedTime,
      "who":'worker',
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
}