import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


class Screen extends StatefulWidget {
  @override
  _Screen createState() => _Screen();
}

class _Screen extends State<Screen> {
  int _currentIndex = 0;

  CarouselSlider cslider;
  @override
  int current = 0;
  bool item1=true,item2=false,item3=false;
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Card Carousel App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
              title: Text("Flutter Card Carousel")
          ),
          body: Column(
            children: <Widget>[
             item1? Container(
                height: 300,
                width: 300,
                child: Item1(),
              ):Container(),
              item2? Container(
                height: 300,
                width: 300,
                child: Item2(),
              ):Container(),
              item3? Container(
                height: 300,
                width: 300,
                child: Item3(),
              ):Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   Container(
                    width: 10.0,
                    height: 10.0,
                    margin: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == current ? Colors.blueAccent : Colors
                          .grey,
                    ),
                  ),
                ],),
              Row(
                children: <Widget>[
                  Container(
                    child: FlatButton(
                      child: Icon(Icons.arrow_forward_outlined),
                      onPressed: () {
                        setState(() {
                          if (current < 2) {
                            current =current+ 1;
                            print(current);
                            if(current==0){item1=true;item2=false;item3=false;}
                            if(current==1){item1=false;item2=true;item3=false;}
                            if(current==2){item1=false;item2=false;item3=true;}
                          }
                        });
                        },
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      child: Icon(Icons.arrow_forward_outlined),
                      onPressed: (){
                        setState(() {
                          if (current >0) {
                            current =current- 1;
                            print(current);
                            if(current==0){item1=true;item2=false;item3=false;}
                            if(current==1){item1=false;item2=true;item3=false;}
                            if(current==2){item1=false;item2=false;item3=true;}
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          )
      ),
    );
  }

  getnext() {
    setState(() {
      if (current < 2) {
        current += current;
        print(current);
        if (current == 0) {Item1();}
      if(current==1){Item2();}
      if(current==2){Item3();}
    }
    });
  }

  getprev() {
    if (current > 0) {
      current -= current;
      print(current);
      if (current == 0) {Item1();}
    if(current==1){Item2();}
    if(current==2){Item3();}
  }
  }
}
class Item1 extends StatelessWidget {
  const Item1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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