import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/Inside_the_app/WORKER_PROFILE.dart';
import 'package:flutterphone/Inside_the_app/user_Profile.dart';
import 'package:flutterphone/screens/login_screen.dart';
import '../constants.dart';
import '../database.dart';
import 'Conversation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String IP4="192.168.1.8";

class Chat extends StatefulWidget{
  final name_Me;
  Stream chatsRoomList;
  final bool user;
  @override
  Chat({this.name_Me,this.chatsRoomList,this.user});
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
    return Container(
      height: 500,
      color: Colors.white,
      margin: EdgeInsets.only(top: 50),
      child:StreamBuilder(stream: widget.chatsRoomList,
          builder: (context,snapshot){
            return snapshot.hasData?ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context,index){
                  print("ddd");
                  return ChatRooTile(name: widget.user?snapshot.data.docs[index].data()["users"][1]:snapshot.data.docs[index].data()["users"][0],name_Me:widget.name_Me,user:widget.user);
                }
            ):Container();
          }
      ),);
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
    //getChat();
    super.initState();
  }
  int _page=3;
  GlobalKey _bottomNavigationKey = GlobalKey();
  Stream chatsRoom;
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
      return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
      bottomNavigationBar: CurvedNavigationBar(
        index: _page,
        color:L_ORANGE,
        buttonBackgroundColor:L_ORANGE,
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
            _page  = index;
           if (_page == 0) {Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,)));}
           if(_page==3){Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => Chat(name_Me:widget.name_Me,chatsRoomList: chatsRoom,user: true)));}
           if(_page==4){ Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>Loginscreen()));}

          });
        },
      ),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.0), // here the desired height
            child:AppBar(
              elevation: 0.0,
              backgroundColor:L_ORANGE.withOpacity(0.75),
              leading:   IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,)));
              }),
            ),
        ),
      // appBar: AppBar(
      //   backgroundColor:L_ORANGE.withOpacity(0.75),
      //   leading:   IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
      //     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,)));
      //   }),
      // ),
      body: Stack(
       children:[
         Container(
           margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
           height: 180,
           decoration: BoxDecoration(
             color: L_ORANGE.withOpacity(0.75),
           ),
         ),
      Container(
        height: 700,
        width: 500,
        //transform: Matrix4.translationValues(0.0, -30.0, 0.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ChatsRoomList(),
            ],
          ),
        ),
      ),],),),);
  }


}

class ChatRooTile extends StatefulWidget {
  final name;
  final name_Me;
  final bool user;
  ChatRooTile({this.name,this.name_Me,this.user});
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
                // color:  Color(0xFFF3D657),
                margin: EdgeInsets.only(top:0),
                decoration: BoxDecoration(
                ),
                child:FutureBuilder(
                  future: widget.user?getWorker():getUser(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                         return ChatBlock(user:widget.user,image:snapshot.data[index]['image'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],name:widget.name,name_Me:widget.name_Me);
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
  final bool user;
  ChatBlock({this.name,this.name_Me,this.namefirst,this.namelast,this.image,this.user});
  _ChatBlock createState() =>  _ChatBlock();
}
class  _ChatBlock extends State<ChatBlock> {

  DatabaseMethods databaseMethods=new DatabaseMethods();
  CreatChatRoom (){
    print(widget.name_Me);
    print(widget.name);
    String chatRoomId= widget.user?getChatRoomId(widget.name,widget.name_Me):getChatRoomId(widget.name_Me,widget.name);
    List<String>Users= widget.user?[widget.name_Me,widget.name]:[widget.name,widget.name_Me];
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
  return  GestureDetector(
          onTap: (){
            CreatChatRoom();
          },
      child:Container(
        width:300,
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
          width: 100,
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(top: 5,bottom: 5,left: 170,right:30),
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