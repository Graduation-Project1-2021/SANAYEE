import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class FullScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    var getScreenHeight = MediaQuery.of(context).size.height;

    // TODO: implement build
    return Scaffold(
        body: Center(
          child: CarouselSlider(
              options: CarouselOptions(height: getScreenHeight,autoPlay: true,viewportFraction: 1.0),
              items: [
                MyImageView("assets/icons/ho.jpg"),
                MyImageView("assets/icons/ho.jpg"),
                MyImageView("assets/icons/ho.jpg"),
                MyImageView("assets/icons/ho.jpg"),
                MyImageView("assets/icons/ho.jpg"),
                MyImageView("assets/icons/ho.jpg"),
              ]
          ),
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