import 'package:carousel_pro/carousel_pro.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/ChatUuser/chatListUser.dart';
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
import 'menue_Page.dart';

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
  // _U_PROFILE() {
  //   //Register a closure to be called when the object changes.
  //   _searchview.addListener(() {
  //     if (_searchview.text.isEmpty) {
  //       //Notify the framework that the internal state of this object has changed.
  //       setState(() {
  //         _firstSearch = true;
  //         _query = "bvn";
  //       });
  //     } else {
  //       setState(() {
  //         _firstSearch = false;
  //         _query = _searchview.text;
  //       });
  //     }
  //   });
  // }
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
        backgroundColor: Colors.grey[50],
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
                      icon: Icons.menu,
                      text: 'القائمة',
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
                      if(index==0){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,)));
                      }
                      if(index==1){
                        print(phone+"PHONE");
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => user_reserve_order(username: widget.name_Me,phoneuser: phone,namelast:namelast,image:image,token:token,namefirst:namefirst)));
                      }
                      if(index==2){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Chat(name_Me:widget.name_Me,chatsRoomList: chatsRoom,phone:phone,namelast:namelast,image:image,token:token,namefirst:namefirst)));
                      }
                      if(index==3){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => favarate(username: widget.name_Me,phoneuser: phone,namelast:namelast,image:image,token:token,namefirst:namefirst)));
                      }
                      if(index==4){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MenuePage(namelast:namelast,name:widget.name_Me,phone:phone,image:image,token:token,namefirst:namefirst)));
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
                    boxFit: BoxFit.cover,
                    indicatorBgPadding: 10,
                    images: [
                      ExactAssetImage("assets/work/intro4.jpg"),
                      ExactAssetImage("assets/work/intro1.jpg"),
                      ExactAssetImage("assets/work/intro3.jpg")
                    ],
                  )
              ),
             Container(
                height: 500,
                margin: EdgeInsets.only(top: 210),
                decoration: BoxDecoration(
                  color:  Colors.grey[50],
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

  bool _firstSearch = true;
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
    return Stack(
        children:<Widget>[
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
                transform: Matrix4.translationValues(0.0, -50.0, 0.0),
              margin: EdgeInsets.only(top:0),
             height: 521,
             width: 500,
             child: Stack(
              children: [
              Container(
                margin: EdgeInsets.only(top:110),
              child:Column(
              children:[
              // Container(
              //   child:Row(
              //     children: [
              //       Container(
              //         margin: EdgeInsets.only(right: 35,),
              //         child: Text('اختر خدمة',
              //           style: TextStyle(
              //           fontFamily: 'Changa',
              //           color: Colors.black87,
              //           fontSize: 15.0,
              //           fontWeight: FontWeight.bold,
              //         ),),
              //       ),
              //     ],
              //   ),
              //   ),
              Container(
                color: Colors.grey[50],
                margin: EdgeInsets.only(top: 0,right: 22,left: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      RecomendPlantCard1(
                        image: "assets/work/mec.png",
                        title: "ميكانيكي",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work: 'أقفال',name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);
                        },
                      ),
                      SizedBox(width: 3,),
                      RecomendPlantCard2(
                        image: "assets/work/najar.png",
                        title: "نجّار",
                        press: () {
                          print(widget.phone); print(widget.name_Me); print(widget.phone);
                          print(widget.token);
                          print(widget.country);
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp1()));
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work: 'نجار',name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);
                        },
                      ),
                      SizedBox(width: 3,),
                      RecomendPlantCard3(
                        image: "assets/work/ele.png",
                        title: "كهربائي",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work: 'كهربائي',name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);
                        },
                      ),
                      SizedBox(width: 3,),
                      RecomendPlantCard4(
                        image: "assets/work/bal.png",
                        title: "بلييط",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work: 'بلييط',name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);
                        },
                      ),
                      SizedBox(width: 5,),
                      RecomendPlantCard5(
                        image: "assets/work/sabak.png",
                        title: "سبّاك",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work: 'سباك',name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);
                        },
                      ),

                    ],
                  ),

                ),
              ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => All_Service(token:widget.token,name_Me: widget.name_Me,phone: widget.phone,country: widget.country,namefirst:widget.namefirst,namelast:widget.namelast,image: widget.image)));
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 300,),
                    child: Text('عرض المزيد',
                      style: TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.black54,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                ),
            ],
          ),
        ),
                new Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 0),
                  child: new Column(
                    children: <Widget>[
                      _createSearchView(),
                      _firstSearch ? Text('') : _performSearch()
                    ],
                  ),
                ),
              ],),
    ),
    ),],);
  }
  Widget _createSearchView() {

    return new Container(
      height: 55,
      width: 410,
      margin: EdgeInsets.only(top: 30,left: 10),
      padding: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.5),
        //     blurRadius: 2.0,
        //     spreadRadius: 0.0,
        //     offset: Offset(1.0,1.0), // shadow direction: bottom right
        //   )
        // ],
      ),
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
          hintText: "ابحث",
          hintStyle: new TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Changa',
          ),
          enabledBorder: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15.0),
            borderSide:  BorderSide(color:Colors.grey[300]),

          ),
          focusedBorder: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15.0),
            borderSide:  BorderSide(color:Colors.grey[300]),

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
      var item = widget.Search[i]['Work'];

      if (item.toLowerCase().contains(_query.toLowerCase())) {
        if(!_filterList.contains(item)){_filterList.add(item);}
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work:_filterList[index],name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,),),);MaterialPageRoute(builder: (context) => user_worker(phoneuser:widget.phone,tokenuser:widget.token,Work:Listsearch[index]['Work'],image:Listsearch[index]['image'],phone:Listsearch[index]['phone'],name: Listsearch[index]['name'],namelast:Listsearch[index]['namelast'],name_Me: widget.name_Me,namefirst:Listsearch[index]['namefirst'],token:Listsearch[index]['token'],Information:Listsearch[index]['Information'],Experiance:Listsearch[index]['Experiance'],),);
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
      width: 111,
      height: 130,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child: Container(
              height: 130,
              // padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color:Colors.grey[50],
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
                            fontSize: 18.0,
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

class RecomendPlantCard1 extends StatelessWidget {
  RecomendPlantCard1({
    Key key,
    this.image,
    this.title,
    this.press,
  }) : super(key: key);

  final String image, title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    List<Colors> Color=[];
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
      width: 110,
      height: 105,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child:Stack(
              children:<Widget>[
                // Icon(Icons.paint),
                Container(
                  width: 160,
                 height: 101,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomRight:  Radius.circular(5),
                      bottomLeft:  Radius.circular(5),
                    ),
                    color: Colors.grey[100],
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [X1,X3]
                    ),
                  ),
                 child:  Center(
                   child:Column(
                     children: [
                       Container(
                         height: 70,
                         width: 80,
                         margin: EdgeInsets.only(top: 0),
                         child:ClipRRect(
                           borderRadius: BorderRadius.circular(5),
                           child: Image.asset(
                             image, height: 90,
                             width: 100,
                             // color: Colors.white,
                             fit: BoxFit.contain,),
                         ),),
                       Container(
                         margin: EdgeInsets.only(top: 2),
                         child:Center(
                           child:Text(title,
                             textAlign: TextAlign.center,
                             style: TextStyle(
                               fontFamily: 'Changa',
                               color: Colors.white,
                               fontSize: 16.0,
                               fontWeight: FontWeight.bold,
                             ),
                           ),),),
                     ],
                   ),),
                ),
              ],),
          ),
        ],),
    );
  }
}

class RecomendPlantCard2 extends StatelessWidget {
  RecomendPlantCard2({
    Key key,
    this.image,
    this.title,
    this.press,
  }) : super(key: key);

  final String image, title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    List<Colors> Color=[];
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
      width: 110,
      height: 105,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child:Stack(
              children:<Widget>[
                // Icon(Icons.paint),
              Container(
              height: 101,
              width: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomRight:  Radius.circular(5),
                    bottomLeft:  Radius.circular(5),
                  ),
                  color: Colors.grey[100],
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [red1,red2]
                  ),
                ),
              child:Center(
                child:Column(
                  children: [
                    Container(
                      height: 60,
                      width: 70,
                      margin: EdgeInsets.only(top: 10),
                      child:ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          image, height: 90,
                          width: 100,
                          // color: Colors.white,
                          fit: BoxFit.contain,),
                      ),),
                    Container(
                      margin: EdgeInsets.only(top: 2),
                      child:Center(
                        child:Text(title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Changa',
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),),),
                  ],
                ),
              ),),
              ],),
          ),
        ],),
    );
  }
}

class RecomendPlantCard3 extends StatelessWidget {
  RecomendPlantCard3({
    Key key,
    this.image,
    this.title,
    this.press,
  }) : super(key: key);

  final String image, title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    List<Colors> Color=[];
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
      width: 110,
      height: 105,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child:Stack(
              children:<Widget>[
                // Icon(Icons.paint),
              Container(
              height: 101,
              width: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomRight:  Radius.circular(5),
                    bottomLeft:  Radius.circular(5),

                  ),
                  color: Colors.grey[100],
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [blue1,blue2]
                  ),
                ),
              child:Center(
                child:Column(
                  children: [
                    Container(
                      height: 60,
                      width: 70,
                      margin: EdgeInsets.only(top: 10),
                      child:ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          image, height: 90,
                          width: 100,
                          // color: Colors.white,
                          fit: BoxFit.contain,),
                      ),),
                    Container(
                      margin: EdgeInsets.only(top: 2),
                      child:Center(
                        child:Text(title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Changa',
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),),),
                  ],
                ),
              ),),
              ],),
          ),
        ],),
    );
  }
}

class RecomendPlantCard4 extends StatelessWidget {
  RecomendPlantCard4({
    Key key,
    this.image,
    this.title,
    this.press,
  }) : super(key: key);

  final String image, title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    List<Colors> Color=[];
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
      width: 110,
      height: 105,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child:Stack(
              children:<Widget>[
                // Icon(Icons.paint),
              Container(
              height: 101,
              width: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),

                ),
                color: Colors.grey[100],
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [green1,green2]
                ),
              ),
              child:Center(
                  child:Column(
                    children: [
                      Container(
                        height: 60,
                        width: 70,
                        margin: EdgeInsets.only(top: 10),
                        child:ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            image, height: 90,
                            width: 100,
                            // color: Colors.white,
                            fit: BoxFit.contain,),
                        ),),
                      Container(
                        margin: EdgeInsets.only(top: 2),
                        child:Center(
                          child:Text(title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Changa',
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),),),
                    ],
                  ),
                 ),),
              ],),
          ),
        ],),
    );
  }
}

class RecomendPlantCard5 extends StatelessWidget {
  RecomendPlantCard5({
    Key key,
    this.image,
    this.title,
    this.press,
  }) : super(key: key);

  final String image, title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    List<Colors> Color=[];
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 10, top: 10, bottom: 10,),
      width: 110,
      height: 105,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child:Stack(
              children:<Widget>[
                // Icon(Icons.paint),
                Container(
                  height: 101,
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    color: Colors.grey[100],
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [perp1,perp2]
                    ),
                  ),
                child:Center(
                  child:Column(
                    children: [
                      Container(
                        height: 60,
                        width: 70,
                        margin: EdgeInsets.only(top: 10),
                        child:ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            image, height: 90,
                            width: 100,
                            // color: Colors.white,
                            fit: BoxFit.contain,),
                        ),),
                      Container(
                        margin: EdgeInsets.only(top: 2),
                        child:Center(
                          child:Text(title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Changa',
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),),),
                    ],
                  ),
                ),
                ),
              ],),
          ),
        ],),
    );
  }
}