
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterphone/screens/login_screen.dart';
import 'dart:convert';
import 'WORKER_PROFILE.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

String IP4="192.168.1.8";
class InsideAPP extends StatefulWidget {
    final name;
    InsideAPP({this.name});
  _Body createState() => _Body();
}

class _Body extends State<InsideAPP> {

  var Listsearch=[];

  Future getdata()async{
    var url='https://'+IP4+'/testlocalhost/all_worker.php';
    var ressponse=await http.get(url);
    var responsepody= json.decode(ressponse.body);
    for(int i=0;i<responsepody.length;i++){
      if(!Listsearch.contains(responsepody[i]['Work'])){ Listsearch.add(responsepody[i]['Work']);}

    }
    print(Listsearch);
  }
  void initState(){
    getdata();
    super.initState();
  }
  @override
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            color:  Color(0xFFECCB45),
            buttonBackgroundColor: Color(0xFFECCB45),
            backgroundColor: MY_BLACK,
            height: 48,
            key: _bottomNavigationKey,
            items: <Widget>[
              Icon(Icons.home, size: 25),
              Icon(Icons.settings, size: 25),
              Icon(Icons.playlist_add_check, size: 25),
              Icon(Icons.notifications, size: 25),
              Icon(Icons.logout, size: 25),
            ],
            onTap: (index) {
              setState(() {
                _page = index;
                if(_page==0){
                  // print(List2);
                  Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>InsideAPP(name: widget.name,)));
                }
                // if(_page==1){
                //   Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>SettingPage(name: widget.name,phone: phone,image: image,Work: Work,Experiance: Experiance,Information: Information,token: token,)));
                // }
              });
            },
          ),
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
                  // color: Color(0xFFF3D657),
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
                child:GestureDetector(
                  onTap: (){showSearch(context: context, delegate: DataSearch(list: Listsearch));},
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
                         Container(
                           margin: EdgeInsets.only(left: 240),
                          child:Text('ابحث',
                            style: TextStyle(
                              fontFamily: 'Changa',
                              color: Color(0xFFECCB45),
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),),
                         ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child:RotatedBox(
                          quarterTurns: 1,
                          child: IconButton(
                            icon: Icon(
                              Icons.search,
                              color:  Color(0xFF1C1C1C),
                              size: 40.0,
                            ),
                            onPressed: null,
                          ),
                        ),

                      ),
                    ],
                  ),),
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
class DataSearch extends SearchDelegate<String>{
  List<dynamic>list;
  var recentList=[];
  DataSearch({this.list});
  Future getSearch()async{
    var url='https://'+IP4+'/testlocalhost/groupsearch.php';
    var ressponse=await http.post(url,body: {
      "Work":query,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [IconButton(icon: Icon(Icons.clear), onPressed: (){query="";})];
    throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    //return IconButton(icon: Icon(Icons.arrow_back), onPressed: (){});
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,

        ),
        onPressed: (){
          close(context, null);
        },);
    // return AppBar(
    //   backgroundColor: Colors.yellow,
    //   actions: [
    //   IconButton(
    //       icon: AnimatedIcon(
    //         icon: AnimatedIcons.menu_arrow,
    //         progress: transitionAnimation,
    //
    //       ),
    //       onPressed: (){
    //         close(context, null);
    //       },),
    //   ],
    // );
    throw UnimplementedError();
  }

  //String get searchFieldLabel => "احثوو,";
  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
     return Directionality(textDirection: TextDirection.rtl,
         child:SingleChildScrollView(
           child:Container(
             color: Colors.white,
             height: 700,
           //  color:  Color(0xFF1C1C1C),
         child:FutureBuilder(
      future: getSearch(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Group(name:snapshot.data[index]['name'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],phone:snapshot.data[index]['phone'],image:snapshot.data[index]['image'],Work:snapshot.data[index]['Work'],Experiance:snapshot.data[index]['Experiance'],Information:snapshot.data[index]['Information'],token:snapshot.data[index]['token']);
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    ),),),);
    return Text("SARA");
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    var search =query.isEmpty?recentList:list.where((p) => p.startsWith(query)).toList();
    return Directionality(
        textDirection: TextDirection.rtl,
        child:Container(
        height: 200,
        margin: EdgeInsets.only(top: 50),
       child:ListView.builder(itemCount:search.length,itemBuilder: (context,i){
         return ListTile(leading: Icon(Icons.people_sharp),
             title: Text(search[i],
             style: TextStyle(
              fontSize: 18.0,
              fontFamily: 'Changa',
              color: Color(0xFF666360),
              fontWeight: FontWeight.bold,),
             ),

           onTap:(){
           query=search[i];
           recentList.add(query);
           showResults(context);
         }
         );
         }),),);
    throw UnimplementedError();
  }
  
}
class Group  extends StatefulWidget {
  final  name;
  final  namefirst;
  final  namelast;
  final  phone;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;

  Group({this.name,this.namefirst,this.namelast, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token});

  @override
  _Group createState() => _Group();
}

class _Group extends State<Group> {
  @override
  void initState() {
    super.initState();
  }

  Future getImages() async {
    var url = 'https://' + IP4 + '/testlocalhost/Show_EXP.php';
    var ressponse = await http.post(url, body: {
      "phone": widget.phone,
    });
    // ignore: deprecated_member_use
    // var responsebody = json.decode(ressponse.body);
    // print(responsebody);
    return json.decode(ressponse.body);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child:Container(
        height: 230,
        width: 200,
        decoration: BoxDecoration(
          //color:Colors.white,
          color:  Color(0xFF1C1C1C),
          borderRadius: BorderRadius.circular(20),
          // boxShadow: [
          //   BoxShadow(
          //     offset: Offset(0, 1),
          //     blurRadius: 20,
          //     color: Color(0xFFECCB45),
          //   ),
          // ],
        ),
        margin:EdgeInsets.symmetric(horizontal: 20,vertical: 10) ,

        child: Column(
        children: <Widget>[
          Stack(children: [
            Container (
              margin: EdgeInsets.only(top: 50,right: 30),
              child:CircleAvatar(backgroundImage: NetworkImage('https://'+IP4+'/testlocalhost/upload/'+widget.image),radius: 46.0,),),
            Container (
              width: 200,
              //color: Colors.red,
              margin: EdgeInsets.only(top: 40,right: 150,left: 50),child:Text(widget.namefirst+ " "+widget.namelast,
              style: TextStyle(
                fontSize: 21.0,
                fontFamily: 'Changa',
                color: Color(0xFF666360),
                fontWeight: FontWeight.bold,
              ),),),
            Container (
              width: 200,
              margin: EdgeInsets.only(top: 70,right: 150),
              child:Text(widget.Work,
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Changa',
                  color: Color(0xFF666360),
                  fontWeight: FontWeight.bold,
                ),
              ),),
          Row(
            children: [
            Container (
              width: 120,
              margin: EdgeInsets.only(top: 100,right: 150),
              child:Text(widget.phone,
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Changa',
                  color: Color(0xFF666360),
                  fontWeight: FontWeight.bold,
                ),
              ),),
              Container(
                margin: EdgeInsets.only(top: 100,right: 3,left: 15,),
                child:Icon(Icons.phone,
               color: Color(0xFF666360),),
              ),
            ],),
            //Container (margin: EdgeInsets.only(top: 20,left: 150),child:Text(widget.name),),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 170,right: 55),
                  child:Text("4.9",
                  style: TextStyle(
                    color: Color(0xFF666360),
                  ),),
                ),
                Container(
                  margin: EdgeInsets.only(top: 170,right: 3,left: 15,),
                  child:Icon(Icons.star,
                  color: Color(0xFFECCB45),),
                ),

              ],
            ),
            // Row(
            //   children: [
            //     Container(
            //       margin: EdgeInsets.only(top: 125,right: 150),
            //       child:Text("4.9"),
            //     ),
            //     Container(
            //       margin: EdgeInsets.only(top: 120,right: 3,left: 15,),
            //       child:Icon(Icons.star),
            //     ),
            //     Container(
            //       margin: EdgeInsets.only(top: 120,left: 0,right: 5),
            //       child:Text(" 123 تعليق"),
            //     ),
            //     Container(
            //       margin: EdgeInsets.only(top: 120,right: 3,left: 90),
            //       child:Icon(Icons.comment),
            //     ),
            //
            //   ],
            // ),
            Row(
            children:[
              Container(
                width: 80,
                margin: EdgeInsets.only(left: 0,right: 150,top: 150),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.transparent)
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                  color: Color(0xFFECCB45),
                  onPressed: () async {},
                  child: Center(child:Text("طلب",
                    style: TextStyle(
                      fontSize: 17.0,
                      fontFamily: 'Changa',
                      color:  Color(0xFF1C1C1C),
                      fontWeight: FontWeight.bold,
                    ),),),),
              ),
            Container(
            width: 120,
            margin: EdgeInsets.only(left: 0,right: 10,top: 150),
             child: FlatButton(
              shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.transparent)
              ),
             padding: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
             color: Color(0xFFECCB45),
             onPressed: () async {
               Navigator.push(context,
                   MaterialPageRoute(builder: (context) =>user_worker(name:widget.name,namefirst:widget.namefirst,namelast:widget.namelast,phone:widget.phone,image:widget.image,Work:widget.Work,Experiance:widget.Experiance,Information:widget.Information,token:widget.token)),);},

               child: Center(child:Text("عرض المزيد",
               style: TextStyle(
                 fontSize: 17.0,
                 fontFamily: 'Changa',
                 color:  Color(0xFF1C1C1C),
                 fontWeight: FontWeight.bold,
               ),),),),
            ),

          ],),
      ],),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: 300,
            // child:Divider(
            //   color: Color(0xFF666360),
            //   thickness: 2,
            // ),
          ),

    ],),
      ),);

  }
}