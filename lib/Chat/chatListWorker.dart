import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/Inside_the_app/WORKER_PROFILE.dart';
import '../database.dart';
import 'Conversation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String IP4="192.168.1.8";

class Chat extends StatefulWidget{
  final name_Me;
  Stream chatsRoomList;
  @override
  Chat({this.name_Me,this.chatsRoomList,});
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
      height: 100,
      color: Colors.white,
      child:StreamBuilder(
          stream: widget.chatsRoomList,
          builder: (context,snapshot){
            return snapshot.hasData?ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context,index){
                  return ChatRooTile(name: snapshot.data.docs[index].data()["users"][0],name_Me:widget.name_Me,);
                }
            ):Container(
              height: 200,
              color: Colors.cyan,
            );
          }
      ),);
  }
  initeState(){
    // initiateSearch();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
      ),
      body: Form(
        child: SingleChildScrollView(
          // height: 700,
          child: Column(
            children: <Widget>[
              ChatsRoomList(),
            ],
          ),
        ),
      ),);
  }

  addData() {
    Map<String, dynamic>data = {
      "name": "SARAH",
      "id": "174",
    };
    // CollectionReference collection=
    CollectionReference collection = Firestore.instance.collection('users');
    collection.add(data);
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
      height: 100,
      // color:  Color(0xFFF3D657),
      margin: EdgeInsets.only(top:0),
      decoration: BoxDecoration(
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
  ChatBlock({this.name,this.name_Me,this.namefirst,this.namelast,this.image});
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
      return Conversation(chatRoomId: chatRoomId,name_Me: widget.name_Me,name: widget.name,);
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
        margin: EdgeInsets.only(top: 15,bottom: 15),
        child: Row(
          children: [
            Divider(color:Colors.black,thickness: 2,),
            Container(
              width: 350,
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(top: 5,bottom: 5,),
              child: Text(widget.namefirst + " " + widget.namelast,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontFamily: 'Changa',
                  fontWeight: FontWeight.bold,),
              ),),
            Container(
              margin: EdgeInsets.only(top: 5,bottom: 5,right: 5),
              child:CircleAvatar(backgroundImage: NetworkImage(
                  'https://' + IP4 + '/testlocalhost/upload/' + widget.image),
                radius: 25.0,),
            ),
            Divider(color:Colors.black,thickness: 2,),

          ],
        ),),);
  }
}