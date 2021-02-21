import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutterphone/constants.dart';
import 'package:hexagon/hexagon.dart';

class Screen extends StatefulWidget {
  @override
  _Screen createState() => _Screen();
}

class _Screen extends State<Screen> {
  int _currentIndex=0;

  List cardList=[
    Item1(),
    Item2(),
    Item3(),
    Item4()
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
  CarouselSlider cslider;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size.height;
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
             child:Column(
            children: <Widget>[
              Container(
              child:Stack(
               children:[
              cslider = CarouselSlider(
                options: CarouselOptions(
                  // height: height,
                   autoPlay: true,
                   pauseAutoPlayOnTouch: true,
                   pauseAutoPlayInFiniteScroll: true,
                   pauseAutoPlayOnManualNavigate: true,
                  // autoPlayInterval: Duration(seconds: 3),
                  // autoPlayAnimationDuration: Duration(milliseconds: 800),
                   autoPlayCurve: Curves.fastOutSlowIn,
                  //  pauseAutoPlayOnTouch: true,
                  // aspectRatio: 2.0,
                   onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: cardList.map((card){
                  return Builder(
                      builder:(BuildContext context){
                        return Container(
                          height: MediaQuery.of(context).size.height*0.30,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            color: Colors.blueAccent,
                            child: card,
                          ),
                        );
                      }
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: map<Widget>(cardList, (index, url) {
                  return Container(
                    width: 10.0,
                    height: 10.0,
                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
                    ),
                  );

                }),
              ),
              Container(
               margin: EdgeInsets.only(top:270),
                child:SizedBox(
                  width: 200.0,
                  height: 100.0,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[600],
                    highlightColor: Camone,
                    child: Text(
                      'صنايعي',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        // fontWeight: FontWeight.bold,
                          fontFamily: 'Changa',
                          fontSize: 70.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        shadows: <Shadow>[
                          Shadow(
                            blurRadius: 12.0,
                            color: Colors.grey,
                            offset: Offset.fromDirection(120,12),
                          )
                        ]
                      ),
                    ),
                  ),
                ),
              ),
                 GestureDetector(
                   // onTap: () => onProfileClick(context), // choose image on click of profile
                   child: Container(
                     width: 150,
                     height: 150,
                     decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         image: DecorationImage(
                           image: AssetImage('assets/icons/ho.jpg'),
                           fit: BoxFit.cover,
                         ),
                     ),),),
                 GestureDetector(
                   // onTap: () => onProfileClick(context), // choose image on click of profile
                   child: Container(
                     width: 150,
                     height: 150,
                     decoration: BoxDecoration(
                       shape: BoxShape.rectangle,
                       image: DecorationImage(
                         image: AssetImage('assets/icons/ho.jpg'),
                         fit: BoxFit.cover,
                       ),
                     ),),),
                           Container(
                             margin: EdgeInsets.only(top:300),
                             child: HexagonWidget.flat(
                               width: 200,
                               child: AspectRatio(
                                 aspectRatio: HexagonType.FLAT.ratio,
                                 child: Image.asset('assets/icons/ho.jpg', fit: BoxFit.fitHeight,),
                               ),
                           ),),
              Row(
                children: <Widget>[
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: getnext(),
                    ),
                  ),

                ],
              ),
            ],
          )
      ),
    ],),
    ),), );
  }
  getnext(){

  }
}

class Item1 extends StatelessWidget {
  const Item1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top:200),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xffff4000),Color(0xffffcc66),]
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
              "Data",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold
              )
          ),
          Text(
              "Data",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600
              )
          ),
        ],
      ),
    );
  }
}

class Item2 extends StatelessWidget {
  const Item2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xff5f2c82), Color(0xff49a09d)]
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
              "Data",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold
              )
          ),
          Text(
              "Data",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600
              )
          ),
        ],
      ),
    );
  }
}

class Item3 extends StatelessWidget {
  const Item3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/icons/ho.jpg',
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }
}

class Item4 extends StatelessWidget {
  const Item4({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
              "Data",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold
              )
          ),
          Text(
              "Data",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600
              )
          ),
        ],
      ),
    );
  }
}