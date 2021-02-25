
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterphone/screens/login_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants.dart';


class InsideAPP extends StatelessWidget {
  const InsideAPP({
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Color(0xFF1C1C1C),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xFFECCB45),
            actions: [
              IconButton(
                onPressed: (){},
                icon: Icon(Icons.menu),)
            ],
          ),
        body: Form(key: _formKey,
        child: SingleChildScrollView(
        child: Column(
        children: <Widget>[
        Container(
        margin: EdgeInsets.only(bottom: 20 * 2.5),
          // It will cover 20% of our total height
          height: 160,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 56,
                ),
                height: size.height * 0.2 - 27,
                decoration: BoxDecoration(
                  color: Color(0xFFECCB45),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Hi Uishopy!',
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    // Image.asset("assets/images/logo.png")
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    // boxShadow: [
                    //   BoxShadow(
                    //     offset: Offset(0, 1),
                    //     blurRadius: 20,
                    //     color: Color(0xFFECCB45),
                    //   ),
                    // ],
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          onChanged: (value) {},
                          decoration: InputDecoration(
                            hintText: "ابحث",
                            hintStyle: TextStyle(
                              color: Color(0xFFECCB45),
                              fontSize: 22.0,fontFamily: 'Changa',
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,

                            suffixIcon: RotatedBox(
                              quarterTurns: 1,
                              child: IconButton(
                              icon:Icon(Icons.search),
                              color: Color(0xFFECCB45),
                              iconSize: 40,
                            ),)
                            // surffix isn't working properly  with SVG
                            // thats why we use row
                            // suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
                          ),
                        ),
                      ),
                      //SvgPicture.asset("assets/icons/search.svg"),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
          Container(
            color: Color(0xFF1C1C1C),
            margin: EdgeInsets.only(top:0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  RecomendPlantCard(
                    image: "assets/work/najar.jpg",
                    title: "نجّار",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          // builder: (context) => DetailsScreen(),
                        ),
                      );
                    },
                  ),
                  RecomendPlantCard(
                    image: "assets/work/sapak.jpg",
                    title: "سبّاك",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          // builder: (context) => DetailsScreen(),
                        ),
                      );
                    },
                  ),
                  RecomendPlantCard(
                    image: "assets/work/electric1.jpg",
                    title: "كهربائي",
                    press: () {},
                  ),
                  RecomendPlantCard(
                    image: "assets/work/fix.jpg",
                    title: "تصليح",
                    press: () {},
                  ),
                  RecomendPlantCard(
                    image: "assets/work/lock.jpg",
                    title: "أقفال",
                    press: () {},
                  ),
                  RecomendPlantCard(
                    image: "assets/work/sapaak.jpg",
                    title: "سبّاك",
                    press: () {},
                  ),
                  RecomendPlantCard(
                    image: "assets/work/dahan.jpg",
                    title: "دهّان",
                    press: () {},
                  ),
                  RecomendPlantCard(
                    image: "assets/work/mec.jpg",
                    title: "ميكانيك",
                    press: () {},
                  ),
                  RecomendPlantCard(
                    image: "assets/work/baleet.jpg",
                    title: "بلييط",
                    press: () {},
                  ),
                  RecomendPlantCard(
                    image: "assets/work/repaier.jpg",
                    title: "إصلاح",
                    press: () {},
                  ),
                ],
              ),
            ),
          ),
          ],
        ),
    ),),),);
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
      color: Color(0xFF1C1C1C),
      margin: EdgeInsets.only(left: 10, top: 10, bottom: 10,right: 10),
      width: 100,
      height: 130,
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
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color:Color(0xFF1C1C1C),
                  ),
                ],
              ),
              child: Container(
                child:Stack(
                  children:<Widget>[
                   ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: Image.asset(
                      image, height: 90,
                      width: 100,
                      fit: BoxFit.contain,),
                  ),
                    Container(
                      margin: EdgeInsets.only(top: 85),
                    child:Center(
                      child:Text(title,
                        textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Changa',
                        color: Color(0xFFECCB45),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),),),
                ],),
              ),
            ),
          )
        ],
      ),
    );
  }
}
// Container(
// child:IconButton(
// icon: Icon(Icons.logout),
// onPressed: ()async{
// await FirebaseAuth.instance.signOut();
// Navigator.pushAndRemoveUntil(
// context,
// MaterialPageRoute(builder: (context) => LoginScreen()),
// (route) => false);
// },
// )
// )