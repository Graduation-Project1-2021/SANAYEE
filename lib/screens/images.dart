import 'package:flutter/material.dart';

void main() => runApp(new Demo());

class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> with TickerProviderStateMixin {


  String image1 = "assets/icons/ho.jpg";
  String image2 = "assets/icons/ho.jpg";
  String image3 = "assets/icons/ho.jpg";
  String currentMainImage = "assets/icons/ho.jpg" ;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: new Text("table demo"),
            ),
            body: new Container(
                child: new Column(
                  children: <Widget>[
                    Container(
                        height:150.0,
                        child: new  Image.asset(currentMainImage)
                    ),
                    new Row(
                      children: <Widget>[
                        Expanded(
                            child: InkWell(
                                onTap : (){
                                  setState(() {
                                    currentMainImage = image1;
                                  });
                                },
                                child: new Image.asset(image1)
                            )
                        ),
                        Expanded(
                            child: InkWell(
                                onTap : (){
                                  setState(() {
                                    currentMainImage = image2;
                                  });
                                },
                                child: new  Image.asset(image2)
                            )
                        ),
                        Expanded(
                            child: InkWell(
                                onTap : (){
                                  setState(() {
                                    currentMainImage = image3;
                                  });
                                },
                                child: new  Image.asset(image3)
                            )
                        ),
                      ],
                    )
                  ],

                )
            )
        )
    );
  }
}