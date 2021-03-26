import 'package:carousel_pro/carousel_pro.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/Chat/chatListUser.dart';
import 'package:flutterphone/USER/List_worker_group.dart';
import 'package:flutterphone/USER/WORKER_PROFILE.dart';
import 'package:flutterphone/Inside_the_app/user_order.dart';
import 'package:flutterphone/USER/search_user.dart';
import 'package:flutterphone/USER/user_reserve_order.dart';
import 'package:flutterphone/Worker/setting_worker.dart';
import 'package:flutterphone/Worker/worker_order.dart';
import 'package:flutterphone/screens/login_screen.dart';
import 'package:flutterphone/screens/welcome.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutterphone/constants.dart';
import '../constants.dart';
import '../database.dart';
import 'ALL_SERVICE.dart';
import 'favarate.dart';

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
  int _selectedIndex = 0;
  List<String> _filterList;
  var _searchview = new TextEditingController();

  bool _firstSearch = false;
  String _query = "";
  GlobalKey _bottomNavigationKey = GlobalKey();
  final List1 = [];
  var ListDate1 = [];
  final List2 = [];
  var ListDate2 = [];
  var ListBlock=["8.00 - 9.00 ","9.00 - 10.00","","","",];
  var Search=[];
  Future getSearchall()async{
    var url='https://'+IP4+'/testlocalhost/all_worker.php';
    var ressponse=await http.post(url,body: {
    });
    // ignore: deprecated_member_use
    Search= await json.decode(ressponse.body);
    return json.decode(ressponse.body);
  }
  getChat(){
    databaseMethods.getChatsMe(widget.name_Me).then((val){
      setState(() {
        print(val.toString());
        chatsRoom=val;
      });
    });
  }
  void initState(){
    super.initState();
    getChat();
    getSearchall();
  }

  Future getUser() async {
    var url = 'https://' + IP4 + '/testlocalhost/getUser.php';
    var ressponse = await http.post(url, body: {
      "name": widget.name_Me,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  _U_PROFILE() {
    //Register a closure to be called when the object changes.
    _searchview.addListener(() {
      if (_searchview.text.isEmpty) {
        //Notify the framework that the internal state of this object has changed.
        setState(() {
          _firstSearch = true;
          _query = "bvn";
        });
      } else {
        setState(() {
          _firstSearch = false;
          _query = _searchview.text;
        });
      }
    });
  }
  DatabaseMethods databaseMethods=new DatabaseMethods();
  Stream chatsRoom;
  @override
  Widget build(BuildContext context) {
    print(Search.toString());
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Directionality(textDirection: TextDirection.rtl,
      child:Stack(
        children: [
      Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        bottomNavigationBar:Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
          ]),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                  rippleColor: Colors.grey[300],
                  hoverColor: Colors.grey[100],
                  gap: 8,
                  activeColor: Colors.black,
                  iconSize: 24,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  duration: Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.grey[100],
                  tabs: [
                    GButton(
                      icon: Icons.home,
                      text: 'الرئيسية',
                      textStyle:TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.black,
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GButton(
                      icon: Icons.person,
                      text: 'حسابي',
                      textStyle:TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.black,
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GButton(
                      icon: Icons.favorite_border,
                      text: 'المفضلة',
                      textStyle:TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.black,
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GButton(
                      onPressed: (){
                      },
                      icon: Icons.calendar_today,
                      text: 'طلباتي',
                      textStyle:TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.black,
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GButton(
                      onPressed: (){

                      },
                      icon: Icons.mark_chat_unread,
                      text: 'شات',
                      textStyle:TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.black,
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      _selectedIndex = index;
                      if(index==2){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => favarate(username: widget.name_Me,phoneuser: phone,)));
                      }
                      if(index==3){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => user_reserve_order(username: widget.name_Me,phoneuser: phone,)));
                      }
                      if(index==4){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Chat(name_Me:widget.name_Me,chatsRoomList: chatsRoom,user: true,phone:phone,)));
                      }


                    });
                  }
                  ),
            ),
          ),),
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
        body: Form(
         child:SingleChildScrollView(
          child: Stack(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Container(
                  height: 210.0,
                  width: 450.0,
                  child: Carousel(
                    indicatorBgPadding: 10,
                    images: [
                      NetworkImage('https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg',),
                      NetworkImage('https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
                      ExactAssetImage("assets/icons/ho.jpg")
                    ],
                  )
              ),
              Image.asset(
                "assets/icons/ho.jpg",
                height:250,
                width:450,
                fit: BoxFit.fill,
              ),
             Container(
                height: 500,
                // color:  Color(0xFFF3D657),
                margin: EdgeInsets.only(top: 260),
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

                            return USER_PROFILE(Search:Search,country: snapshot.data[index]['country'],name_Me: snapshot.data[index]['name'], namefirst: snapshot.data[index]['namefirst'], namelast: snapshot.data[index]['namelast'], phone: snapshot.data[index]['phone'], image: snapshot.data[index]['image'], token: snapshot.data[index]['token']);

                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],),),),),],),);
  }
  Widget _createSearchView() {

    return new Container(
      height: 55,
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.only(right: 10),
      // decoration: BoxDecoration(border: Border.all(width: 1.0)),
      child: new TextField(
        controller: _searchview,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Changa',
        ),
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: "البحث عن مقدم خدمة",
          hintStyle: new TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Changa',
          ),
          enabledBorder: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15.0),
            borderSide:  BorderSide(color:Colors.grey[100]),

          ),
          focusedBorder: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15.0),
            borderSide:  BorderSide(color:Colors.grey[100]),

          ),
          suffixIcon: GestureDetector(
            onTap: () {
            },
            child:  Container(
              // margin: EdgeInsets.only(top: 5),
              child:RotatedBox(
                quarterTurns: 1,
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color:Colors.black54,
                    size: 25.0,
                  ),
                  onPressed: null,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _performSearch() {
    _filterList = new List<String>();
    for (int i = 0; i < Search.length; i++) {
      var item = Search[i]['namefirst']+" ";

      if (item.toLowerCase().contains(_query.toLowerCase())) {
        _filterList.add(item);
      }
    }
    return _createFilteredListView();
  }
  //Create the Filtered ListView
  Widget _createFilteredListView() {

    return new Stack(
      children:[
        SingleChildScrollView(
          child:Directionality(textDirection: TextDirection.ltr,
            child:Container(
              width: 370,
              height: 200,
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0,0.5),
                    blurRadius: 0.01,
                    color: Colors.black54,
                  ),],
              ),
              child: new ListView.builder(
                  itemCount: _filterList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new GestureDetector(
                      onTap: (){
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => user_worker(phoneuser:widget.phone_Me,tokenuser:widget.token_Me,Work:Listsearch[index]['Work'],image:Listsearch[index]['image'],phone:Listsearch[index]['phone'],name: Listsearch[index]['name'],namelast:Listsearch[index]['namelast'],name_Me: widget.name_Me,namefirst:Listsearch[index]['namefirst'],token:Listsearch[index]['token'],Information:Listsearch[index]['Information'],Experiance:Listsearch[index]['Experiance'],),));
                      },
                      child:  Container(
                        alignment: Alignment.topRight,
                        color: Colors.white,
                        width: 200,
                        margin: EdgeInsets.only(right: 20,top:10),
                        padding:EdgeInsets.only(right: 5,),
                        child: new Text("${_filterList[index]}",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Changa',
                            color: Colors.black54,
                          ),),
                      ),
                    );
                  }),
            ),),),],);
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
  List<dynamic>Search;
  USER_PROFILE({this.Search,this.country,this.name_Me,this.namelast,this.namefirst, this.phone, this.image,this.token,});

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
  List<String> _filterList;
  var _searchview = new TextEditingController();

  bool _firstSearch = false;
  String _query = "";
  _USER_PROFILE() {
    //Register a closure to be called when the object changes.
    _searchview.addListener(() {
      if (_searchview.text.isEmpty) {
        //Notify the framework that the internal state of this object has changed.
        setState(() {
          _firstSearch = true;
          _query = "bvn";
        });
      } else {
        setState(() {
          _firstSearch = false;
          _query = _searchview.text;
        });
      }
    });
  }
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
          new Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 170),
            child: new Column(
              children: <Widget>[
                _createSearchView(),
                _firstSearch ? Text('hhhhhhhhhhhhhhhhhhhhhhhhhhhhh') : _performSearch()
              ],
            ),
          ),
          // Container(
          //   margin: EdgeInsets.only(top:10),
          //   child:IconButton(
          //   onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Chat(name_Me:widget.name_Me,chatsRoomList: chatsRoom,user: true)));},
          //   icon: Icon(Icons.chat_bubble),
          //   ),),
          // Container(
          //   margin: EdgeInsets.only(top:20,left: 300),
          //   //transform: Matrix4.translationValues(0, 5.0, 0),
          //     child:CircleAvatar(backgroundImage: NetworkImage('https://'+IP4+'/testlocalhost/upload/'+widget.image),radius: 25.0,),
          // ),
          // Container(
          //   margin: EdgeInsets.only(top:20,left: 100),
          //   child:Center(
          //     child: Text(widget.namefirst+ " "+widget.namelast,
          //       style: TextStyle(
          //         color: Colors.black,
          //         fontSize: 15.0,
          //         fontFamily: 'Changa',
          //         fontWeight: FontWeight.bold,),),
          //   ),),

          // Container(
          //   //margin: EdgeInsets.only(bottom: 5),
          //   transform: Matrix4.translationValues(0.0, -20.0, 0.0),
          //   child:GestureDetector(
          //     onTap: (){showSearch(context: context, delegate: DataSearch(list: Listsearch,name_Me:widget.name_Me));},
          //     child: Container(
          //       width: 360,
          //       alignment: Alignment.center,
          //       // margin: EdgeInsets.symmetric(horizontal: 40),
          //       //  padding: EdgeInsets.symmetric(horizontal: 40),
          //       height: 54,
          //       decoration: BoxDecoration(
          //         color:D,
          //         borderRadius: BorderRadius.circular(20),
          //         // boxShadow: [
          //         //   BoxShadow(
          //         //     offset: Offset(0, 1),
          //         //     blurRadius: 20,
          //         //     color: Color(0xFFECCB45),
          //         //   ),
          //         // ],
          //       ),
          //       child: Row(
          //         children: <Widget>[
          //           Container(
          //             margin: EdgeInsets.only(left: 240,right: 20),
          //             child:Text('ابحث',
          //               style: TextStyle(
          //                 fontFamily: 'Changa',
          //                 color: Colors.white,
          //                 fontSize: 20.0,
          //                 fontWeight: FontWeight.bold,
          //               ),),
          //           ),
          //           Container(
          //             margin: EdgeInsets.only(top: 10),
          //             child:RotatedBox(
          //               quarterTurns: 1,
          //               child: IconButton(
          //                 icon: Icon(
          //                   Icons.search,
          //                   color:Colors.white,
          //                   size: 40.0,
          //                 ),
          //                 onPressed: null,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),),
          //   ),
          // ),
          SingleChildScrollView(
              child: Container(
              margin: EdgeInsets.only(top:0),
             height: 521,
             width: 500,
             child: Column(
              children: [
              Container(
              child:Column(
              children:[
              Container(
                child:Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 35,),
                      child: Text('اختر خدمة',
                        style: TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ],
                ),
                ),
              Container(
                color: Colors.white,
                margin: EdgeInsets.only(top: 10,right: 22,left: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      RecomendPlantCard(
                        image: "assets/work/najar.jpg",
                        title: "نجّار",
                        press: () {
                          print(widget.phone); print(widget.name_Me); print(widget.phone);
                          print(widget.token);
                          print(widget.country);
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp1()));
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work: 'نجار',name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);
                        },
                      ),
                      RecomendPlantCard(
                        image: "assets/work/sapak.jpg",
                        title: "سبّاك",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(token_Me:widget.token,work: 'سباك',name_Me: widget.name_Me,location: widget.country,),),);
                        },
                      ),
                      RecomendPlantCard(
                        image: "assets/work/electric1.jpg",
                        title: "كهربائي",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(work: 'كهربائي',name_Me: widget.name_Me,location: widget.country,),),);
                        },
                      ),
                      RecomendPlantCard(
                        image: "assets/work/fix.jpg",
                        title: "تصليح",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(work: 'تصليح',name_Me: widget.name_Me,location: widget.country,),),);
                        },
                      ),
                      RecomendPlantCard(
                        image: "assets/work/lock.jpg",
                        title: "أقفال",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(work: 'أقفال',name_Me: widget.name_Me,location: widget.country,),),);
                        },
                      ),
                      RecomendPlantCard(
                        image: "assets/work/sapaak.jpg",
                        title: "سبّاك",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(work: 'سباك',name_Me: widget.name_Me,location: widget.country,),),);
                        },
                      ),
                      RecomendPlantCard(
                        image: "assets/work/dahan.jpg",
                        title: "دهّان",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(work: 'دهان',name_Me: widget.name_Me,location: widget.country,),),);
                        },
                      ),
                      RecomendPlantCard(
                        image: "assets/work/mec.jpg",
                        title: "ميكانيك",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(work: 'ميكانيك',name_Me: widget.name_Me,location: widget.country,),),);
                        },
                      ),
                      RecomendPlantCard(
                        image: "assets/work/baleet.jpg",
                        title: "بلييط",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(work: 'بلييط',name_Me: widget.name_Me,location: widget.country,),),);
                        },
                      ),
                      RecomendPlantCard(
                        image: "assets/work/repaier.jpg",
                        title: "إصلاح",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(work: 'إصلاح',name_Me: widget.name_Me,location: widget.country,),),);
                        },
                      ),
                    ],
                  ),

                ),
              ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => All_Service(name_Me: widget.name_Me,)));
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 200,),
                    child: Text('عرض جميع الخدمات',
                      style: TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                ),
            ],
          ),
        ),],),
    ),
    ),],);
  }
  Widget _createSearchView() {

    return new Container(
      height: 55,
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.only(right: 10),
      // decoration: BoxDecoration(border: Border.all(width: 1.0)),
      child: new TextField(
        controller: _searchview,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Changa',
        ),
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: "البحث عن مقدم خدمة",
          hintStyle: new TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Changa',
          ),
          enabledBorder: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15.0),
            borderSide:  BorderSide(color:Colors.grey[100]),

          ),
          focusedBorder: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15.0),
            borderSide:  BorderSide(color:Colors.grey[100]),

          ),
          suffixIcon: GestureDetector(
            onTap: () {
            },
            child:  Container(
              // margin: EdgeInsets.only(top: 5),
              child:RotatedBox(
                quarterTurns: 1,
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color:Colors.black54,
                    size: 25.0,
                  ),
                  onPressed: null,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _performSearch() {
    _filterList = new List<String>();
    for (int i = 0; i < widget.Search.length; i++) {
      var item = widget.Search[i]['namefirst']+" ";

      if (item.toLowerCase().contains(_query.toLowerCase())) {
        _filterList.add(item);
      }
    }
    return _createFilteredListView();
  }
  //Create the Filtered ListView
  Widget _createFilteredListView() {

    return new Stack(
      children:[
        SingleChildScrollView(
          child:Directionality(textDirection: TextDirection.ltr,
            child:Container(
              width: 370,
              height: 200,
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0,0.5),
                    blurRadius: 0.01,
                    color: Colors.black54,
                  ),],
              ),
              child: new ListView.builder(
                  itemCount: _filterList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new GestureDetector(
                      onTap: (){
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => user_worker(phoneuser:widget.phone_Me,tokenuser:widget.token_Me,Work:Listsearch[index]['Work'],image:Listsearch[index]['image'],phone:Listsearch[index]['phone'],name: Listsearch[index]['name'],namelast:Listsearch[index]['namelast'],name_Me: widget.name_Me,namefirst:Listsearch[index]['namefirst'],token:Listsearch[index]['token'],Information:Listsearch[index]['Information'],Experiance:Listsearch[index]['Experiance'],),));
                      },
                      child:  Container(
                        alignment: Alignment.topRight,
                        color: Colors.white,
                        width: 200,
                        margin: EdgeInsets.only(right: 20,top:10),
                        padding:EdgeInsets.only(right: 5,),
                        child: new Text("${_filterList[index]}",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Changa',
                            color: Colors.black54,
                          ),),
                      ),
                    );
                  }),
            ),),),],);
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
      margin: EdgeInsets.only(left: 10, top: 10, bottom: 10,right: 0),
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