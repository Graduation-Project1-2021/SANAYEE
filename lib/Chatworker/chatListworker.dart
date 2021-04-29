import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/WORKER_SANAYEE/homepage.dart';
import 'package:flutterphone/WORKER_SANAYEE/menue_Page.dart';
import 'package:flutterphone/WORKER_SANAYEE/orders_workers.dart';
import 'package:flutterphone/WORKER_SANAYEE/Profile.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../constants.dart';
import '../database.dart';
import 'Conversation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String IP4="192.168.1.8";

class Chat extends StatefulWidget{
  final name_Me;
  final phone;
  Stream chatsRoomList;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;
  final namefirst;
  final namelast;
  final lat;
  final lng;
  @override
  Chat({this.lat,this.lng,this.phone,this.name_Me,this.chatsRoomList,this.namefirst,this.namelast,this.image, this.Work, this.Experiance, this.Information, this.token});
  _Chat createState() =>  _Chat();
}
class  _Chat extends State<Chat> {

  DatabaseMethods databaseMethods=new DatabaseMethods();
  TextEditingController searchControler=TextEditingController();
  QuerySnapshot searchResultSnapshot;

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  Widget ChatsRoomList(){
    return Column(
    children:[
      Container(
        // transform: Matrix4.translationValues(0, -100.0, 0),
        margin:EdgeInsets.only(top:0),
        width: double.infinity,
        height: 170,
        decoration: BoxDecoration(
          color: Colors.grey[50],
        ),
        child: Image.asset('assets/work/intro3.jpg',width:500,fit: BoxFit.fitWidth,),
      ),
     Container(
      height: 500,
      margin: EdgeInsets.only(top: 0),
      transform: Matrix4.translationValues(0.0, -60, 0.0),
      child:StreamBuilder(stream: widget.chatsRoomList,
          builder: (context,snapshot){
            return snapshot.hasData?ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context,index){
                  print("ddd");
                  return ChatRooTile(name: snapshot.data.docs[index].data()["users"][0],name_Me:widget.name_Me);
                }
            ):Container();
          }
      ),),],);
  }
  getChat(){
    databaseMethods.getChatsMe(widget.name_Me).then((val){
      setState(() {
        print(val.toString());
        chatsRoom=val;
      });
    });
  }
  initeState(){
    // initiateSearch();
    getChat();
    super.initState();
  }
  int _selectedIndex=2;
  GlobalKey _bottomNavigationKey = GlobalKey();
  Stream chatsRoom;
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
      return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
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
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Home_Page(name: widget.name_Me)));
                      }
                      if(index==1){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => order_worker(lat:widget.lat,lng:widget.lng,Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,name:widget.name_Me,phone:widget.phone,image:widget.image,token:widget.token,namefirst:widget.namefirst,)));
                      }
                      if(index==3){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PROFILE(lat:widget.lat,lng:widget.lng,name:widget.name_Me,phone:widget.phone,)));
                      }
                      if(index==4){
                        DateTime date=DateTime.now();
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MenuePage(Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,name:widget.name_Me,phone:widget.phone,image:widget.image,token:widget.token,namefirst:widget.namefirst,)));
                      }


                    });
                  }
              ),
            ),
          ),),
        // appBar: PreferredSize(
        //     preferredSize: Size.fromHeight(80.0), // here the desired height
        //     child:AppBar(
        //       elevation: 0.0,
        //       backgroundColor:G,
        //       leading:   IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
        //         Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,)));
        //       }),
        //     ),
        // ),
      // appBar: AppBar(
      //   backgroundColor:L_ORANGE.withOpacity(0.75),
      //   leading:   IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
      //     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,)));
      //   }),
      // ),
      body: Stack(
       children:[
      Container(
        height: 850,
        width: 500,
        //transform: Matrix4.translationValues(0.0, -30.0, 0.0),
        margin: EdgeInsets.only(top: 0,bottom: 0),
        child:SingleChildScrollView(
          // child: Column(
          //   children: <Widget>[
          child:Container(
            child: ChatsRoomList(),),
          ),
        ),

      ],),),);
  }


}

class ChatRooTile extends StatefulWidget {
  final name;
  final name_Me;
  ChatRooTile({this.name,this.name_Me,});
  _ChatRooTile createState() =>  _ChatRooTile();
}
class  _ChatRooTile extends State<ChatRooTile> {

  Future getWorker()async{
    var url='https://'+IP4+'/testlocalhost/getworker.php';
    var ressponse=await http.post(url,body: {
      "name": widget.name,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  Future getUser() async {
    var url = 'https://' + IP4 + '/testlocalhost/getUser.php';
    var ressponse = await http.post(url, body: {
      "name": widget.name,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  @override

  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Container(
               height: 80,
                decoration: BoxDecoration(
                  color:  Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child:FutureBuilder(
                  future: getUser(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                         return ChatBlock(image:snapshot.data[index]['image'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],name:widget.name,name_Me:widget.name_Me);
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
    );

  }}


class ChatBlock extends StatefulWidget {
  final name;
  final name_Me;
  final image;
  final namefirst;
  final namelast;
  ChatBlock({this.name,this.name_Me,this.namefirst,this.namelast,this.image,});
  _ChatBlock createState() =>  _ChatBlock();
}
class  _ChatBlock extends State<ChatBlock> {

  DatabaseMethods databaseMethods=new DatabaseMethods();
  CreatChatRoom (){
    print(widget.name_Me);
    print(widget.name);
    String chatRoomId= getChatRoomId(widget.name_Me,widget.name);
    List<String>Users=[widget.name,widget.name_Me];
    Map<String,dynamic>ChatRoom={
      "users":Users,
      "chatroomid":chatRoomId
    };
    databaseMethods.createChat(chatRoomId, ChatRoom);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Conversation(chatRoomId: chatRoomId,name_Me: widget.name_Me,name: widget.name,namefirst: widget.namefirst,namelast: widget.namelast,image: widget.image,);
    },
    ),
    );

  }
  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  Widget build(BuildContext context) {
  return GestureDetector(
          onTap: (){
            CreatChatRoom();
          },
      child:Container(
        width:300,
        color:Colors.white,
        //color: PURPEL,
     margin: EdgeInsets.only(top: 10,bottom: 5),
       child: Row(
      children: [
        Container(
          margin: EdgeInsets.only(top: 5,bottom: 5,right: 30),
          child:CircleAvatar(backgroundImage: NetworkImage(
              'https://' + IP4 + '/testlocalhost/upload/' + widget.image),
            radius: 25.0,),
        ),
        Container(
          width: 250,
          //color: Colors.green,
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(top: 5,bottom: 5,left: 50,right:10),
          child: Text(widget.namefirst + " " + widget.namelast,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontFamily: 'Changa',
              fontWeight: FontWeight.bold,),
          ),),

       // Divider(color:Colors.black,thickness: 2,),

      ],
    ),),);
  }
}