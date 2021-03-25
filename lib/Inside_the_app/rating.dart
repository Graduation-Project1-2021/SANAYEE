import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyApp5 extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp5> {
  final _ratingController = TextEditingController();
  double _rating1;
  double _rating2;
  double _rating3;
  double _userRating = 3.0;
  int _ratingBarMode1 = 1;
  int _ratingBarMode2 = 2;
  int _ratingBarMode3 = 3;
  int _ratingBarMode4 = 4;
  bool _isRTLMode = false;
  bool _isVertical = false;
  IconData _selectedIcon;

  @override
  void initState() {
    _ratingController.text = '3.0';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            headline6: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.white),
          ),
        ),
      ),

      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor:Colors.yellow.withOpacity(0.75),
            leading:   IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
              //Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>U_PROFILE(name_Me: widget.name_Me,)));

              // Navigator.pop(context);
            }),
          ),
          body: Directionality(
            textDirection: TextDirection.ltr,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  Container(
                    height: 170,
                    width: 500,
                    color: Colors.yellow,
                     child:Column(
                       children: [
                         Container(
                           margin:EdgeInsets.only(left: 250,top: 10),
                           height: 50,
                           child:IconButton(
                             icon: Icon(Icons.arrow_back,
                             color: Colors.white,),
                           ),
                         ),
                         Container(
                           width:200,
                           margin: EdgeInsets.only(left: 250,top: 70),
                           child: Text('تقييم الصنايعي',
                             style: TextStyle(
                             fontSize: 20,
                             fontWeight: FontWeight.bold,
                             color: Colors.white,
                             fontFamily: 'Changa',
                           ),),
                         ),

                         Container(
                           margin: EdgeInsets.only(left:20,top: 10),
                           height: 50,
                           width: 400,
                           alignment: Alignment.topRight,
                           child:Row(
                             children: [
                               Text(' نأمل منك أن تقوم بتقييم الصنايعي بناء على المصداقية',
                                 style: TextStyle(
                                   fontSize: 14,
                                   fontWeight: FontWeight.bold,
                                   color: Colors.grey[600],
                                   fontFamily: 'Changa',
                                 ),),
                               Icon(Icons.info,size:27,),
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
                  SizedBox(height: 40.0,),
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
                      Container(margin:EdgeInsets.only(left: 10),child: _ratingBar(_ratingBarMode1),),
                      Container(
                        width:150,alignment: Alignment.topRight,
                        margin:EdgeInsets.only(top: 20,left:20,right: 10),child:  _heading('سرعة وإتقان بالعمل'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    children: [
                      Container(margin:EdgeInsets.only(left: 10),child: _ratingBar(_ratingBarMode1),),
                      Container(
                        width:150,alignment: Alignment.topRight,
                        margin:EdgeInsets.only(top: 20,left: 20,right: 10),child:  _heading('الاحترام والانظباط'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    children: [
                      Container(margin:EdgeInsets.only(left: 10),child: _ratingBar(_ratingBarMode2),),
                      Container(
                        width:150,alignment: Alignment.topRight,
                        margin:EdgeInsets.only(top: 20,left:20,right: 10),child:  _heading('الإلتزام بالوقت'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    children: [
                      Container(margin:EdgeInsets.only(left: 10),child: _ratingBar(_ratingBarMode3),),
                      Container(
                        width:130,alignment: Alignment.topRight,
                        margin:EdgeInsets.only(top: 20,left: 20,right: 10),child:  _heading('هل السعر مناسب؟'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    children: [
                      Container(margin:EdgeInsets.only(left: 10),child: _ratingBar(_ratingBarMode4),),
                      Container(
                        margin:EdgeInsets.only(top: 20,left:20,right: 10),child:  _heading('مدى رضاك عن الخدمة؟'),
                      ),
                    ],
                  ),
                  // _rating != null
                  //     ? Text(
                  //   'Rating: $_rating',
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // )
                  //     : Container(),
                  // _rating2 != null
                  //     ? Text(
                  //   'Rating: $_rating2',
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // )
                  //     : Container(),
                  // _rating3 != null
                  //     ? Text(
                  //   'Rating: $_rating3',
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // )
                  //     : Container(),
                  SizedBox(
                    height: 40.0,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //***********************
                  const SizedBox(height: 30),
                  RaisedButton(
                    onPressed: () {},
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF1A1316),
                            Color(0xFFE4E0E8),
                            Color(0xFFDB3620),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child:
                      const Text('Gradient Button', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                  //],
                  // *****************
                  SizedBox(
                    height: 40.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _ratingBar(int mode) {
    switch (mode) {
      case 1:
        return RatingBar.builder(
          initialRating: 2,
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
          initialRating: 2,
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
          initialRating: 2,
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
          initialRating: 3,
          direction: _isVertical ? Axis.vertical : Axis.horizontal,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return Icon(
                  Icons.sentiment_very_dissatisfied,
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
              _rating1 = rating;
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
}
class IconAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Select Icon',
        style: TextStyle(
          fontWeight: FontWeight.w300,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      titlePadding: EdgeInsets.all(12.0),
      contentPadding: EdgeInsets.all(0),
      content: Wrap(
        children: [
          _iconButton(context, Icons.home),
          _iconButton(context, Icons.airplanemode_active),
          _iconButton(context, Icons.euro_symbol),
          _iconButton(context, Icons.beach_access),
          _iconButton(context, Icons.attach_money),
          _iconButton(context, Icons.music_note),
          _iconButton(context, Icons.android),
          _iconButton(context, Icons.toys),
          _iconButton(context, Icons.language),
          _iconButton(context, Icons.landscape),
          _iconButton(context, Icons.ac_unit),
          _iconButton(context, Icons.star),
        ],
      ),
    );
  }

  Widget _iconButton(BuildContext context, IconData icon) => IconButton(
    icon: Icon(icon),
    onPressed: () => Navigator.pop(context, icon),
    splashColor: Colors.amberAccent,
    color: Colors.amber,
  );
}