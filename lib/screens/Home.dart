import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutterphone/constants.dart';
import 'package:hexagon/hexagon.dart';

class Home extends StatefulWidget {
  @override
  _Screen createState() => _Screen();
}

class _Screen extends State<Home> {
  int _currentIndex=0;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size.height;
    final width = MediaQuery.of(context).size.width;
    return MaterialApp(
      title: 'Flutter Card Carousel App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        // appBar: AppBar(
        //     title:Text("Flutter Card Carousel")
        // ),
        body: Container(
          child:Stack(
            children: <Widget>[

                      // Container(
                      //   margin: EdgeInsets.only(top:270),
                      //   child:SizedBox(
                      //     width: 200.0,
                      //     height: 100.0,
                      //     child: Shimmer.fromColors(
                      //       baseColor: Colors.grey[600],
                      //       highlightColor: Camone,
                      //       child: Text(
                      //         'صنايعي',
                      //         textAlign: TextAlign.center,
                      //         style: TextStyle(
                      //           // fontWeight: FontWeight.bold,
                      //             fontFamily: 'Changa',
                      //             fontSize: 70.0,
                      //             fontStyle: FontStyle.italic,
                      //             fontWeight: FontWeight.bold,
                      //             shadows: <Shadow>[
                      //               Shadow(
                      //                 blurRadius: 12.0,
                      //                 color: Colors.grey,
                      //                 offset: Offset.fromDirection(120,12),
                      //               )
                      //             ]
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
              Positioned(
                top: 350,
                right: 120,
                child:Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/icons/ho.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),),),
                      Positioned(
                        top: 3,
                        right:3,
                        child: Container(
                        margin: EdgeInsets.only(top:300),
                        child: HexagonWidget.flat(
                          width: 120,
                          child: AspectRatio(
                            aspectRatio: HexagonType.FLAT.ratio,
                            child: Image.asset('assets/icons/ho.jpg', fit: BoxFit.fitHeight,),
                          ),
                        ),),),

              Positioned(
                top: 2,
                bottom: 100,
                right:20,
                child: Container(
                margin: EdgeInsets.only(top:300),
                child: HexagonWidget.flat(
                  width: 120,
                  child: AspectRatio(
                    aspectRatio: HexagonType.FLAT.ratio,
                    child: Image.asset('assets/icons/ho.jpg', fit: BoxFit.fitHeight,),
                  ),
                ),),),

              Positioned(child: Container(
                margin: EdgeInsets.only(top:300),
                child: HexagonWidget.flat(
                  width: 200,
                  child: AspectRatio(
                    aspectRatio: HexagonType.FLAT.ratio,
                    child: Image.asset('assets/icons/ho.jpg', fit: BoxFit.fitHeight,),
                  ),
                ),),),

              Positioned(child: Container(
                margin: EdgeInsets.only(top:300),
                child: HexagonWidget.flat(
                  width: 200,
                  child: AspectRatio(
                    aspectRatio: HexagonType.FLAT.ratio,
                    child: Image.asset('assets/icons/ho.jpg', fit: BoxFit.fitHeight,),
                  ),
                ),),),

              Positioned(child: Container(
                margin: EdgeInsets.only(top:300),
                child: HexagonWidget.flat(
                  width: 200,
                  child: AspectRatio(
                    aspectRatio: HexagonType.FLAT.ratio,
                    child: Image.asset('assets/icons/ho.jpg', fit: BoxFit.fitHeight,),
                  ),
                ),),),

              Positioned(child: Container(
                margin: EdgeInsets.only(top:300),
                child: HexagonWidget.flat(
                  width: 200,
                  child: AspectRatio(
                    aspectRatio: HexagonType.FLAT.ratio,
                    child: Image.asset('assets/icons/ho.jpg', fit: BoxFit.fitHeight,),
                  ),
                ),),),

                    ],
                  )
              ),),);

  }
}