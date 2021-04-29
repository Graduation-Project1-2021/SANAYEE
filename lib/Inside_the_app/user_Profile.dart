import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/ChatUuser/chatListUser.dart';
import 'package:flutterphone/Inside_the_app/user_order.dart';
import 'package:flutterphone/Worker/setting_worker.dart';
import 'package:flutterphone/Worker/worker_order.dart';
import 'package:flutterphone/screens/login_screen.dart';
import 'package:flutterphone/screens/welcome.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutterphone/constants.dart';
import '../constants.dart';
import '../database.dart';
import 'WORKER_PROFILE.dart';
import 'List_worker_group.dart';

String  name_Me="";
String  name="";
String  phone="";
String  image="";
String namefirst="";
String namelast="";
String Country="";
String  token="";
String IP4="192.168.1.8";

class U_PROFILE extends StatefulWidget {
  final name_Me;
  U_PROFILE({this.name_Me,});
  _U_PROFILE createState() =>  _U_PROFILE();
}
class  _U_PROFILE extends State<U_PROFILE> {
  // AnimationController _animationController;
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  final List1 = [];
  var ListDate1 = [];
  final List2 = [];
  var ListDate2 = [];
  var ListBlock=["8.00 - 9.00 ","9.00 - 10.00","","","",];

  Future getdata1() async {
    var url = 'https://' + IP4 + '/testlocalhost/count.php';
    var ressponse = await http.post(url, body: {
      "phone": phone,
    });
    var responsepody = json.decode(ressponse.body);
    for (int i = 0; i < responsepody.length; i++) {
      //L.add(responsepody[i]['count']);
      List1.add(responsepody[i]['id']);
      ListDate1.add(responsepody[i]['date']);
    }
    // print(List1);
    // print(ListDate1);
  }

  Future getdata2() async {
    var url = 'https://' + IP4 + '/testlocalhost/count2.php';
    var ressponse = await http.post(url, body: {
      "phone": phone,
    });
    var responsepody = json.decode(ressponse.body);
    for (int i = 0; i < responsepody.length; i++) {
      //L.add(responsepody[i]['count']);
      List2.add(responsepody[i]['id']);
      ListDate2.add(responsepody[i]['date']);
    }
    // print(List2);
    // print(ListDate2);
  }
  getChat(){
    databaseMethods.getChatsMe(widget.name_Me).then((val){
      setState(() {
        print(val.toString());
        chatsRoom=val;
      });
    });
  }
  void initState() {
    super.initState();
    getdata1();
    getdata2();
    getChat();
  }

  Future getUser() async {
    var url = 'https://' + IP4 + '/testlocalhost/getUser.php';
    var ressponse = await http.post(url, body: {
      "name": widget.name_Me,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  DatabaseMethods databaseMethods=new DatabaseMethods();
  Stream chatsRoom;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: CurvedNavigationBar(
          color:E,
          buttonBackgroundColor:E,
          backgroundColor: Colors.white,
          height: 48,
          key: _bottomNavigationKey,
          items: <Widget>[
            Icon(Icons.home, size: 25,color: Colors.white,),
            Icon(Icons.settings, size: 25,color: Colors.white,),
            Icon(Icons.playlist_add_check, size: 25,color: Colors.white,),
            Icon(Icons.mark_chat_unread, size: 25,color: Colors.white,),
            Icon(Icons.logout, size: 25,color: Colors.white,),
          ],
          onTap: (index) {
            setState(() {
              getChat();
              _page = index;
              if (_page == 0) {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,)));}
              if(_page==3){Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Chat(name_Me:widget.name_Me,chatsRoomList: chatsRoom,)));}
              if(_page==4){ Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>WelcomeScreen()));}

            });
          },
        ),
       // backgroundColor:PURPEL,
       //  appBar: PreferredSize(
       //      preferredSize: Size.fromHeight(1.0), // here the desired height
       //      child: AppBar(
       //        backgroundColor: A,
       //        elevation: 0.0,
       //        actions: [],
       //        titleSpacing: 0,
       //        automaticallyImplyLeading: false,
       //        //leading: I,
       //      )
       //  ),
        body: Container(
          decoration: BoxDecoration(
            // color:ca,
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [G,A,B]),
          ),
          // child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(child: Container(
                height: 800,
                // color:  Color(0xFFF3D657),
                margin: EdgeInsets.only(top: 0),
                decoration: BoxDecoration(
                  // color:Color(0xFF1C1C1C),
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(50),
                  //   topRight: Radius.circular(50),
                  // ),
                ),
                child: FutureBuilder(
                  future: getUser(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          name = snapshot.data[index]['name'];
                          phone = snapshot.data[index]['phone'];
                          image = snapshot.data[index]['image'];
                          namefirst = snapshot.data[index]['namefirst'];
                          namelast = snapshot.data[index]['namelast'];
                          token = snapshot.data[index]['token'];

                            return USER_PROFILE(country: snapshot.data[index]['country'],name_Me: snapshot.data[index]['name'], namefirst: snapshot.data[index]['namefirst'], namelast: snapshot.data[index]['namelast'], phone: snapshot.data[index]['phone'], image: snapshot.data[index]['image'], token: snapshot.data[index]['token']);

                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),),
            ],),),),);
  }
}
class USER_PROFILE  extends StatefulWidget {
  final  name_Me;
  final  namefirst;
  final  namelast;
  final  phone;
  final  image;
  final  token;
  final country;

  USER_PROFILE({this.country,this.name_Me,this.namelast,this.namefirst, this.phone, this.image,this.token,});

  @override
  _USER_PROFILE createState() => _USER_PROFILE();
}

class _USER_PROFILE extends State<USER_PROFILE> {
  bool uploading = false;
  double val = 0;
  File uploadimage;
  bool image =false;
  // File _file;
  List<File> _image = []; //هاي هي
  int counter = 0;
  File _file;
  final picker = ImagePicker();
  var Listsearch=[];

  Future getdata()async{
    var url='https://'+IP4+'/testlocalhost/all_worker.php';
    var ressponse=await http.get(url);
    var responsepody= json.decode(ressponse.body);
    for(int i=0;i<responsepody.length;i++){
      if(!Listsearch.contains(responsepody[i]['Work'])){ Listsearch.add(responsepody[i]['Work']);}

    }
  }
  DatabaseMethods databaseMethods=new DatabaseMethods();
  Stream chatsRoom;
  getChat(){
    databaseMethods.getChatsMe(widget.name_Me).then((val){
      setState(() {
        print(val.toString());
        chatsRoom=val;
      });
    });
  }
  @override
  void initState() {
    super.initState();
    getdata();
    // getChat();
  }

  @override
  Widget build(BuildContext context) {
     getChat();
    return Column(
        children:<Widget>[
          // Container(
          //   margin: EdgeInsets.only(top:10),
          //   child:IconButton(
          //   onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Chat(name_Me:widget.name_Me,chatsRoomList: chatsRoom,user: true)));},
          //   icon: Icon(Icons.chat_bubble),
          //   ),),
          Container(
            margin: EdgeInsets.only(top:37),
            //transform: Matrix4.translationValues(0, 5.0, 0),
            child:Center(
              child:CircleAvatar(backgroundImage: NetworkImage('https://'+IP4+'/testlocalhost/upload/'+widget.image),radius: 35.0,),),
          ),
          Container(
            margin: EdgeInsets.only(top:10),
            child:Center(
              child: Text(widget.namefirst+ " "+widget.namelast,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontFamily: 'Changa',
                  fontWeight: FontWeight.bold,),),
            ),),

          SingleChildScrollView(
              child: Container(
              margin: EdgeInsets.only(top:30),
             height: 521,
             width: 500,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: Column(
            children: [
              Container(
                //margin: EdgeInsets.only(bottom: 5),
                transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                child:GestureDetector(
                  onTap: (){showSearch(context: context, delegate: DataSearch(list: Listsearch,name_Me:widget.name_Me));},
                  child: Container(
                    width: 340,
                    alignment: Alignment.center,
                   // margin: EdgeInsets.symmetric(horizontal: 40),
                  //  padding: EdgeInsets.symmetric(horizontal: 40),
                    height: 54,
                    decoration: BoxDecoration(
                      color:D,
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
                          margin: EdgeInsets.only(left: 220,right: 20),
                          child:Text('ابحث',
                            style: TextStyle(
                              fontFamily: 'Changa',
                              color: Colors.white,
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
                                color:Colors.white,
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
              Container(
                color: Colors.white,
                margin: EdgeInsets.only(top:0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      RecomendPlantCard(
                        image: "assets/work/najar.jpg",
                        title: "نجّار",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => List_Worker(work: 'نجار',name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);
                        },
                      ),
                      RecomendPlantCard(
                        image: "assets/work/sapak.jpg",
                        title: "سبّاك",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => List_Worker(work: 'سباك',name_Me: widget.name_Me,location: widget.country,),),);
                        },
                      ),
                      RecomendPlantCard(
                        image: "assets/work/electric1.jpg",
                        title: "كهربائي",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => List_Worker(work: 'كهربائي',name_Me: widget.name_Me,location: widget.country,),),);
                        },
                      ),
                      RecomendPlantCard(
                        image: "assets/work/fix.jpg",
                        title: "تصليح",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => List_Worker(work: 'تصليح',name_Me: widget.name_Me,location: widget.country,),),);
                        },
                      ),
                      RecomendPlantCard(
                        image: "assets/work/lock.jpg",
                        title: "أقفال",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => List_Worker(work: 'أقفال',name_Me: widget.name_Me,location: widget.country,),),);
                        },
                      ),
                      RecomendPlantCard(
                        image: "assets/work/sapaak.jpg",
                        title: "سبّاك",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => List_Worker(work: 'سباك',name_Me: widget.name_Me,location: widget.country,),),);
                        },
                      ),
                      RecomendPlantCard(
                        image: "assets/work/dahan.jpg",
                        title: "دهّان",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => List_Worker(work: 'دهان',name_Me: widget.name_Me,location: widget.country,),),);
                        },
                      ),
                      RecomendPlantCard(
                        image: "assets/work/mec.jpg",
                        title: "ميكانيك",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => List_Worker(work: 'ميكانيك',name_Me: widget.name_Me,location: widget.country,),),);
                        },
                      ),
                      RecomendPlantCard(
                        image: "assets/work/baleet.jpg",
                        title: "بلييط",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => List_Worker(work: 'بلييط',name_Me: widget.name_Me,location: widget.country,),),);
                        },
                      ),
                      RecomendPlantCard(
                        image: "assets/work/repaier.jpg",
                        title: "إصلاح",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => List_Worker(work: 'إصلاح',name_Me: widget.name_Me,location: widget.country,),),);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),),
        ],
    );
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
      color: Colors.white,
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
                color:Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(29),
                // boxShadow: [
                //   BoxShadow(
                //     offset: Offset(0, 10),
                //     blurRadius: 50,
                //     color:Color(0xFF1C1C1C),
                //   ),
                // ],
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
                            color: Colors.black,
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
  final name_Me;
  DataSearch({this.list,this.name_Me});
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
          color: MY_BLACK,
          height: 700,
          padding: EdgeInsets.only(top:30),
          //  color:  Color(0xFF1C1C1C),
          child:FutureBuilder(
            future: getSearch(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Group(name_Me:name_Me,name:snapshot.data[index]['name'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],phone:snapshot.data[index]['phone'],image:snapshot.data[index]['image'],Work:snapshot.data[index]['Work'],Experiance:snapshot.data[index]['Experiance'],Information:snapshot.data[index]['Information'],token:snapshot.data[index]['token']);
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
  final name_Me;
  final  name;
  final  namefirst;
  final  namelast;
  final  phone;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;
  final country;

  Group({this.country,this.name_Me,this.name,this.namefirst,this.namelast, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token});

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
      child: Container(
        height: 230,
        width: 200,
        decoration: BoxDecoration(
          //color:Colors.white,
          color: Colors.white,
         // borderRadius: BorderRadius.circular(20),
          // boxShadow: [
          //   BoxShadow(
          //     offset: Offset(0, 1),
          //     blurRadius: 20,
          //     color: Color(0xFFECCB45),
          //   ),
          // ],
        ),
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),

        child: Column(
          children: <Widget>[
            Stack(children: [
              Container(
                margin: EdgeInsets.only(top: 50, right: 30),
                child: CircleAvatar(backgroundImage: NetworkImage(
                    'https://' + IP4 + '/testlocalhost/upload/' + widget.image),
                  radius: 37.0,),),
              Container(
                width: 200,
                //color: Colors.red,
                margin: EdgeInsets.only(top: 40, right: 120, left: 50),
                child: Text(widget.namefirst + " " + widget.namelast,
                  style: TextStyle(
                    fontSize: 21.0,
                    fontFamily: 'Changa',
                    color: Color(0xFF666360),
                    fontWeight: FontWeight.bold,
                  ),),),
              Container(
                width: 200,
                margin: EdgeInsets.only(top: 70, right: 120),
                child: Text(widget.Work,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Changa',
                    color: Color(0xFF666360),
                    fontWeight: FontWeight.bold,
                  ),
                ),),
              Row(
                children: [
                  Container(
                    width: 130,
                    margin: EdgeInsets.only(top: 100, right: 120),
                    child: Text(widget.phone,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Changa',
                        color: Color(0xFF666360),
                        fontWeight: FontWeight.bold,
                      ),
                    ),),
                  Container(
                    margin: EdgeInsets.only(top: 100, right: 3, left: 15,),
                    child: Icon(Icons.phone,
                      color: Color(0xFF666360),),
                  ),
                ],),
              //Container (margin: EdgeInsets.only(top: 20,left: 150),child:Text(widget.name),),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 150, right: 45),
                    child: Text("4.9",
                      style: TextStyle(
                        color: Color(0xFF666360),
                      ),),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 150, right: 3, left: 15,),
                    child: Icon(Icons.star,
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
                children: [
                  Container(
                    width: 80,
                    margin: EdgeInsets.only(left: 0, right: 120, top: 150),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.transparent)
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 2),
                      color: Color(0xFFECCB45),
                      onPressed: () async {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => user_order(phone:widget.phone,),));
                      },
                      child: Center(child: Text("طلب",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontFamily: 'Changa',
                          color: Color(0xFF1C1C1C),
                          fontWeight: FontWeight.bold,
                        ),),),),
                  ),
                  Container(
                    width: 120,
                    margin: EdgeInsets.only(left: 0, right: 10, top: 150),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.transparent)
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 3),
                      color: Color(0xFFECCB45),
                      onPressed: () async {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => user_worker(name_Me:widget.name_Me,name: widget.name, namefirst: widget.namefirst, namelast: widget.namelast, phone: widget.phone, image: widget.image, Work: widget.Work,Experiance: widget.Experiance,Information: widget.Information,token: widget.token)),);
                         },
                      child: Center(child: Text("عرض المزيد",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontFamily: 'Changa',
                          color: Color(0xFF1C1C1C),
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