import 'package:flutterphone/Inside_the_app/user_Profile.dart';
import 'package:flutterphone/Inside_the_app/user_order.dart';
import 'package:flutterphone/components/review_face.dart';
import 'package:http/http.dart' as http;
import 'package:flutterphone/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../Map.dart';
import 'WORKER_PROFILE.dart';
String IP4="192.168.1.8";
DateTime date=DateTime.now();
class Rate extends StatefulWidget {
  // final work;
  // final name_Me;
  // final location;
  // Rate({this.work,this.name_Me,this.location});
  @override
  _Body createState() => _Body();
}

class _Body extends State<Rate> {
  @override
  Future rate()async{
    var url='https://'+IP4+'/testlocalhost/Rate.php';
    var ressponse = await http.post(url, body: {
      "phoneworker":'+970595320479',
      "phoneuser": '+97059479',
      "service": _rating1.toString(),
      "speed":  _rating2.toString(),
      "respect": _rating3.toString(),
      "price": _rating5.toString(),
      "time": _rating4.toString(),
      "happyornot":(value+1).toString(),
      "total":((_rating1+_rating2+_rating3+_rating4+_rating5+(value+1))/6.0).toString(),
      "date":date.toString(),
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  final _ratingController = TextEditingController();
  double _rating1;
  double _rating2;
  double _rating3;
  double _rating4;
  double _rating5;
  double _rating6;
  double _userRating = 3.0;
  int _ratingBarMode1 = 1;
  int _ratingBarMode2 = 2;
  int _ratingBarMode3 = 3;
  int _ratingBarMode4 = 4;
  int _ratingBarMode5 = 5;
  int _ratingBarMode6 = 6;
  bool _isRTLMode = false;
  bool _isVertical = false;
  IconData _selectedIcon;

  @override
  void initState() {
    _ratingController.text = '3.0';
    super.initState();
  }
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor:Colors.yellow,
          leading:   IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
            Navigator.pop(context);
          }),
        ),
        body:Column(
          children: [

            Container(
              height: 100,
              width: 500,
              color: Colors.yellow,
              child:Column(
                children: [
                  Container(
                    width:200,
                    margin: EdgeInsets.only(left: 250,top:0,right: 30),
                    child: Text('تقييم الصنايعي',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Changa',
                      ),),
                  ),

                  Container(
                    margin: EdgeInsets.only(left:20,top: 10,right: 30),
                    height: 35,
                    width: 400,
                    alignment: Alignment.topRight,
                    child:Row(
                      children: [
                        Icon(Icons.info_outline,size:30,color: Colors.grey[600],),
                        Text('  نأمل منك أن تقوم بتقييم الصنايعي بناء على المصداقية',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontFamily: 'Changa',
                          ),),
                      ],
                    ),
                  ),
                  // Text('في النواحي التالية',
                  //   style: TextStyle(
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.grey[600],
                  //     fontFamily: 'Changa',
                  //   ),),
                ],
              ),
            ),
             Directionality(textDirection: ui.TextDirection.ltr,
               child:Container(
               child: Column(
                 children: [
                   SizedBox(height: 30.0,),
                   Row(
                     children: [
                       Container(margin:EdgeInsets.only(left:10),child: _ratingBar(_ratingBarMode1),),
                       Container(
                         width:150,alignment: Alignment.topRight,
                         margin:EdgeInsets.only(top: 20,left: 20,right: 10),child:  _heading('جودة الخدمة'),
                       ),
                     ],
                   ),
                   SizedBox(height: 10.0,),
                   // Divider(thickness: 1,color: Colors.black,),
                   Row(
                     children: [
                       Container(margin:EdgeInsets.only(left: 10),child: _ratingBar(_ratingBarMode2),),
                       Container(
                         width:150,alignment: Alignment.topRight,
                         margin:EdgeInsets.only(top: 20,left:20,right: 10),child:  _heading('سرعة وإتقان بالعمل'),
                       ),
                     ],
                   ),
                   SizedBox(height: 10.0,),
                   Row(
                     children: [
                       Container(margin:EdgeInsets.only(left: 10),child: _ratingBar(_ratingBarMode3),),
                       Container(
                         width:150,alignment: Alignment.topRight,
                         margin:EdgeInsets.only(top: 20,left: 20,right: 10),child:  _heading('الاحترام والانظباط'),
                       ),
                     ],
                   ),
                   SizedBox(height: 10.0,),
                   Row(
                     children: [
                       Container(margin:EdgeInsets.only(left: 10),child: _ratingBar(_ratingBarMode4),),
                       Container(
                         width:150,alignment: Alignment.topRight,
                         margin:EdgeInsets.only(top: 20,left:20,right: 10),child:  _heading('الإلتزام بالوقت'),
                       ),
                     ],
                   ),
                   SizedBox(height: 10.0,),
                   Row(
                     children: [
                       Container(margin:EdgeInsets.only(left: 10),child: _ratingBar(_ratingBarMode5),),
                       Container(
                         width:150,alignment: Alignment.topRight,
                         padding: EdgeInsets.only(right: 15),
                         margin:EdgeInsets.only(top: 20,left: 20,),child:  _heading('هل السعر مناسب؟'),
                       ),
                     ],
                      ),
                       Row(
                        children: [
                          Container(
                            height: 95,
                            width: 220,
                            margin:EdgeInsets.only(top: 30,left: 10),
                            alignment: Alignment.topLeft,
                           // margin: EdgeInsets.only(right: 150,left: 10),
                           // margin: EdgeInsets.only(right: 150,left: 10),
                            child:ReviewSlider(),

                          ),
                          Container(
                            width: 150,
                            alignment: Alignment.center,
                            margin:EdgeInsets.only(top: 0,left: 2,right: 0),
                            child:  _heading('مدى رضاك عن الخدمة؟'),
                          ),
                        ],
                       ),

                   //Container(margin:EdgeInsets.only(left: 10),child: _ratingBar(_ratingBarMode6),),
                 ],
               ),
             ),),
            Container(
            //  color: Colors.white,
              // decoration: BoxDecoration(
              //   border: Border.all(
              //     color: Colors.black,
              //   ),
              // ),
              child:  FlatButton(
                onPressed: ()async{
                  print(value);
                  await rate();
                  _showMyDialog();
                },
                child: Text('تسليم',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15.0,
                      fontFamily: 'Changa',
                      fontWeight: FontWeight.bold,),),
              ),
            ),
          ],),
      ),);
  }
  Widget _ratingBar(int mode) {
    switch (mode) {
      case 1:
        return RatingBar.builder(
          glowColor: Colors.orangeAccent,
          initialRating:0,
          minRating: 0,
          direction: _isVertical ? Axis.vertical : Axis.horizontal,
          allowHalfRating: true,
          unratedColor: Colors.amber.withAlpha(50),
          itemCount: 5,
          itemSize: 37.0,
          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
          itemBuilder: (context, _) => Icon(
            _selectedIcon ?? Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              _rating1 = rating;
              //_rating2=
            });
          },
          updateOnDrag: true,
        );
      case 2:
        return RatingBar.builder(
          glowColor: Colors.orangeAccent,
          initialRating: 0,
          minRating: 0,
          direction: _isVertical ? Axis.vertical : Axis.horizontal,
          allowHalfRating: true,
          unratedColor: Colors.amber.withAlpha(50),
          itemCount: 5,
          itemSize: 37.0,
          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
          itemBuilder: (context, _) => Icon(
            _selectedIcon ?? Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              _rating2 = rating;
              //_rating2=
            });
          },
          updateOnDrag: true,
        );
      case 3:
        return RatingBar.builder(
          glowColor: Colors.orangeAccent,
          initialRating: 0,
          minRating: 0,
          direction: _isVertical ? Axis.vertical : Axis.horizontal,
          allowHalfRating: true,
          unratedColor: Colors.amber.withAlpha(50),
          itemCount: 5,
          itemSize: 37.0,
          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
          itemBuilder: (context, _) => Icon(
            _selectedIcon ?? Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              _rating3 = rating;
              //_rating2=
            });
          },
          updateOnDrag: true,
        );
      case 4:
        return RatingBar.builder(
          glowColor: Colors.orangeAccent,
          initialRating: 0,
          minRating: 0,
          direction: _isVertical ? Axis.vertical : Axis.horizontal,
          allowHalfRating: true,
          unratedColor: Colors.amber.withAlpha(50),
          itemCount: 5,
          itemSize: 37.0,
          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
          itemBuilder: (context, _) => Icon(
            _selectedIcon ?? Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              _rating4 = rating;
              //_rating2=
            });
          },
          updateOnDrag: true,
        );
      case 5:
        return RatingBar.builder(
          glowColor: Colors.orangeAccent,
          initialRating: 0,
          minRating: 0,
          direction: _isVertical ? Axis.vertical : Axis.horizontal,
          allowHalfRating: true,
          unratedColor: Colors.amber.withAlpha(50),
          itemCount: 5,
          itemSize: 37.0,
          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
          itemBuilder: (context, _) => Icon(
            _selectedIcon ?? Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              _rating5 = rating;
              //_rating2=
            });
          },
          updateOnDrag: true,
        );
      case 6:
        return RatingBar.builder(
          glowColor: Colors.orangeAccent,
          initialRating: 0,
          direction: _isVertical ? Axis.vertical : Axis.horizontal,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return Icon(
                  Icons.sentiment_dissatisfied_outlined,
                  color: Colors.red,size: 37.0,
                );
              case 1:
                return Icon(
                  Icons.sentiment_dissatisfied,
                  color: Colors.redAccent,size: 37.0,
                );
              case 2:
                return Icon(
                  Icons.sentiment_neutral,
                  color: Colors.amber,size: 37.0,
                );
              case 3:
                return Icon(
                  Icons.sentiment_satisfied,
                  color: Colors.lightGreen,size: 37.0,
                );
              case 4:
                return Icon(
                  Icons.sentiment_very_satisfied,
                  color: Colors.green,size: 20.0,
                );
              default:
                return Container();
            }
          },
          onRatingUpdate: (rating) {
            setState(() {
              _rating6 = rating;
            });
          },
          updateOnDrag: true,
        );
      default:
        return Container();
    }
  }

  Widget _heading(String text) => Column(
    children: [
      Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
          fontFamily: 'Changa',
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
    ],
  );
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      //this means the user must tap a button to exit the Alert Dialog
      builder: (BuildContext context) {
        return AlertDialog(
          //titlePadding: EdgeInsets.only(right: 20,left: 30,top: 15),
          actions: <Widget>[
            Directionality(textDirection: ui.TextDirection.rtl,
              child: Container(
                width: 300,
                alignment: Alignment.topRight,
                padding:EdgeInsets.only(top:10,left: 10,right: 10),
                //margin: EdgeInsets.only(top:50,left: 50,right: 10),
                child:Text(' نشكرك على تقييم الحرفي',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontFamily: 'Changa',
                  ),),
              ),),
            Row(
              children: [
                Container(
                  width: 70,
                  margin: EdgeInsets.only(left: 10,right:120,bottom: 20,top: 10),
                  child:FlatButton(
                    child: Text('حسنا',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                        fontFamily: 'Changa',
                      ),),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),),
              ],
            ),

          ],
        );
      },
    );
  }
}
