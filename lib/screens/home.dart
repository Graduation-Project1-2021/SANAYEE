

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp1 extends StatefulWidget {
  _Body createState() => _Body();
}


class _Body extends State<MyApp1> {
  int _currentIndex=0;
    @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Stack(
              children: [
                Container(
                    constraints: BoxConstraints.expand(),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/icons/ho.jpg"),
                            fit: BoxFit.cover)
                    ),
                ),
                 Container(
                 margin: EdgeInsets.only(top: 150,left: 20,right: 20),
                 height: 500,
                 width: 400,
                 child:Card(
                   color: Colors.white,
                   elevation: 5,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(40),),
                   shadowColor: Color(0xFFECCB45),
                 child:CarouselSlider(
                    options: CarouselOptions(autoPlay: true,viewportFraction: 1.0),
                    items: [
                      MyImageView("assets/icons/come.jpg"),
                      MyImageView("assets/icons/ho.jpg"),
                      MyImageView("assets/icons/ho.jpg"),
                      MyImageView("assets/icons/ho.jpg"),
                      MyImageView("assets/icons/ho.jpg"),
                      MyImageView("assets/icons/ho.jpg"),
                    ]
                ),),),
            ],)
        )
    );
  }
}

class MyImageView extends StatelessWidget{

  String imgPath;

  MyImageView(this.imgPath);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: FittedBox(
          fit: BoxFit.cover,
          child: Image.asset(imgPath,),
        )
    );
  }

}