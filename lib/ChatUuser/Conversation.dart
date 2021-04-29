
import 'package:flutter/material.dart';
import 'package:flutterphone/Inside_the_app/user_Profile.dart';
import 'package:image_picker/image_picker.dart';
import '../constants.dart';
import '../database.dart';
import 'Conversation.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'chatListUser.dart';
String IP4="192.168.1.8";

class Conversation extends StatefulWidget{
  final String chatRoomId;
  final name_Me;
  final name;
  final namefirst;
  final namelast;
  final image;
  Conversation({this.name_Me,this.name,this.chatRoomId,this.image,this.namelast,this.namefirst});
  @override
  _Conversation createState() =>  _Conversation();
}
class  _Conversation extends State<Conversation> {
  String imagePath;
  Image image;
  File image_file;
  DatabaseMethods databaseMethods=new DatabaseMethods();
  TextEditingController massageControler=TextEditingController();
  sendMassage(){
    if(massageControler.text.isNotEmpty){
    Map<String,dynamic>MassegeMap={
      "massege":massageControler.text,
      "sendBy":widget.name_Me,
      "time":DateTime.now().microsecondsSinceEpoch,
      "type":"text",
    };
    databaseMethods.addChats(widget.chatRoomId, MassegeMap);
    massageControler.text="";
  }
  }
  sendIMage(){
      Map<String,dynamic>MassegeMap={
        "massege":image_file.path.split('/').last,
        "sendBy":widget.name_Me,
        "time":DateTime.now().microsecondsSinceEpoch,
        "type":"image",
      };
      databaseMethods.addChats(widget.chatRoomId, MassegeMap);
     // massageControler.text="";
  }
  Stream chatMaasegesstream;
  Widget chatMassegeList(){
    print("dfgdg");
    return Container(
      height: 600,
      transform: Matrix4.translationValues(0.0,-10.0, 0.0),
        child:StreamBuilder(
        stream: chatMaasegesstream,
        builder: (context,snapshot){
          return snapshot.hasData?ListView.builder(
               itemCount: snapshot.data.documents.length,
              itemBuilder: (context,index){
               return MessageTile(massege: snapshot.data.docs[index].data()["massege"],
               isSendByMe: snapshot.data.docs[index].data()["sendBy"]==widget.name_Me,
               text_img: snapshot.data.docs[index].data()["type"]=="text",);
              }
          ):Container();
        }
        ),);
  }
  // Widget Emojeselected(){
  //   return Container(
  //       child:EmojiPicker(
  //       rows: 4,
  //       columns: 7,
  //       onEmojiSelected:(emoji,category){
  //       print(emoji);
  //   }),);
  // }
  Stream chatsRoom;
  getChat(){
    databaseMethods.getChatsMe(widget.name_Me).then((val){
      setState(() {
        print(val.toString());
        chatsRoom=val;
      });
    });
  }
  initState(){
    databaseMethods.getChats(widget.chatRoomId).then((val){
      setState(() {
        chatMaasegesstream=val;
      });
    });
    getChat();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
    child:Scaffold(
      backgroundColor: chat,
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor:L_ORANGE.withOpacity(0.75),
      //   leading:   IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
      //     Navigator.pop(context);
      //   }),
      // ),
      body:SingleChildScrollView(
          child:Column(
               children: [
              Positioned(
                  top: 10,
                  child: Container(
                    margin: EdgeInsets.only(top: 70),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            //Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Chat(name_Me:widget.name_Me,chatsRoomList: chatsRoom,phone:phone,)));
                          },
                          child:  Container(
                            margin: EdgeInsets.only(right: 10,left:0),
                            child:Icon(Icons.arrow_back_ios,color: Colors.black54,size:18,),
                          ),
                        ),
                        Container(
                          // margin: EdgeInsets.only(right:50,top: 75),
                          child:CircleAvatar(backgroundImage: NetworkImage('https://'+IP4+'/testlocalhost/upload/'+widget.image),radius: 25.0,),
                        ),
                        SizedBox(width:10,),
                        Container(
                          // margin: EdgeInsets.only(top:85,right:115),
                          child: Text(widget.namefirst+ " "+widget.namelast,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'Changa',
                              fontWeight: FontWeight.bold,),),
                        ),
                      ],
                    ),),
              ),
                 Container(
                   width: 450,
                   // margin: EdgeInsets.only(top: 135,),
                   child: Divider(
                     thickness: 1.0,
                     color: Colors.black26.withOpacity(0.1),
                   ),
                 ),
                Container(
                  height:662,
                  child: SingleChildScrollView(
                    child:Column(
                      children: [
                        Container(
                          height: 600,
                          child:chatMassegeList(),
                        ),
                        Container(
                          margin: EdgeInsets.only(top:0),
                          //alignment: Alignment.bottomCenter,
                          width: 520,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          // color: Colors.red,
                          //margin: EdgeInsets.only(right: 50),
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                margin: EdgeInsets.only(left:5,right: 10), padding: EdgeInsets.only(left:2.5,right: 5),
                                child:Directionality(textDirection: TextDirection.ltr,
                                  child: FlatButton(
                                    onPressed: () {
                                      sendMassage();
                                    },
                                    child: new Icon(
                                      Icons.send,
                                      color: Colors.white,
                                      // size: 26.0,
                                    ),
                                    shape: new CircleBorder(),
                                    color: Y,
                                  ),),),
                              Container(
                                width: 275,
                                height: 40,
                                margin:EdgeInsets.only(left:0,right:0),
                                child: TextFormField(
                                  controller: massageControler,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.withOpacity(0.5),
                                    enabledBorder: new OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(10.0),
                                      borderSide:  BorderSide(color:Colors.grey.withOpacity(0.1)),

                                    ),
                                    focusedBorder: new OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(10.0),
                                      borderSide:  BorderSide(color:Colors.grey.withOpacity(0.1)),

                                    ),
                                  ),
                                ),),
                              Container(
                                margin: EdgeInsets.only(left: 5,right:5),
                                child:IconButton(
                                  onPressed: () async {
                                    await getImageGallory();
                                    print("image");
                                    sendIMage();
                                  },

                                  icon: Icon(Icons.image,
                                    color: Colors.black87,),
                                ),),
                            ],),
                        ),
                      ],
                    ),
                  ),
                ),
            ],),
            ),
            // image!= null? Container(
            //   // width:400,
            //   // height:200,
            //   //padding: EdgeInsets.all(50),
            //     margin: EdgeInsets.only(right:0,left:0,top: 10,bottom: 10),
            //     child: Container(
            //       height: 200,width: 400,
            //       child:image,)
            // ):Container(),

     ),);
  }
  // PickedFile image_file;
  Future getImageGallory() async {
    final x = await ImagePicker.pickImage(source: ImageSource.gallery);
    imagePath = x.path;
    image_file = x;
    image = Image(image: FileImage(x),width: 400,height: 200,);
    await saveChatImg();
  }
  Future saveChatImg()async{
    String base64;
    String imagename;
    File _file = File(image_file.path);
    base64 = base64Encode(_file.readAsBytesSync());
    imagename = _file.path.split('/').last;
    print(imagename);
    print(base64);
    var url = 'https://'+IP4+'/testlocalhost/save_ChatIMG.php';
    var ressponse = await http.post(url, body: {
      "imagename": imagename,
      "image64": base64,
    });
    }
  }
class MessageTile extends StatelessWidget {
  final String massege;
  final bool isSendByMe;
  final bool text_img;
  MessageTile({this.massege,this.isSendByMe,this.text_img});

  @override
  Widget build(BuildContext context) {
    return text_img?

    Container(
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe?Alignment.centerRight:Alignment.centerLeft,
      padding: EdgeInsets.only(left:isSendByMe?0:24,right:isSendByMe?24:0,),
      margin:  EdgeInsets.symmetric(vertical: 7),
        child:Container(
              // width: MediaQuery.of(context).size.width*0.5,
              padding: EdgeInsets.symmetric(horizontal: 24,vertical: 11),
              decoration: BoxDecoration(
                  color:isSendByMe?Y.withOpacity(0.8):Colors.grey.withOpacity(0.5),
                  borderRadius: isSendByMe?BorderRadius.only(
                  topRight:Radius.circular(19),
                  topLeft: Radius.circular(19),
                  bottomLeft: Radius.circular(19),
                  bottomRight: Radius.circular(0),)
                 :BorderRadius.only(
                  topRight:Radius.circular(19),
                  topLeft: Radius.circular(19),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(19),)),

                  child: Text(massege,
                  style: TextStyle(
                      color: isSendByMe?Colors.white:Colors.black,
                      fontSize: 15,
                      fontFamily: 'Changa',
                      fontWeight: FontWeight.bold)),
                 ),):
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 130,
                    alignment: isSendByMe?Alignment.centerRight:Alignment.centerLeft,
                    margin:  EdgeInsets.symmetric(vertical: 7),
                    padding: EdgeInsets.only(left:isSendByMe?0:24,right:isSendByMe?24:0,),
                    //color: Colors.cyan,
                    child:ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network('https://' + IP4 + '/testlocalhost/chat/' + massege,width:180,height:130,fit: BoxFit.cover,),),);
                     // child: Image.asset('assest/2.jpg',),),);
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 0),
                //   margin: EdgeInsets.symmetric(horizontal: 0),
                //  //  child:ClipRRect(
                //  //    borderRadius: BorderRadius.circular(10.0),
                //  //    child: Image.network('https://' + IP4 + '/testlocalhost/chat/' + massege,width: 300,),),
                //  // ),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(20),
                //       color: Colors.yellow,
                //   ),
                // child:Image.network('https://' + IP4 + '/testlocalhost/chat/' + massege,),);
  }
}

// class ChatRoomsTile extends StatelessWidget {
//   final String userName;
//   final String chatRoomId;
//
//   ChatRoomsTile({this.userName,@required this.chatRoomId});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: (){
//         Navigator.push(context, MaterialPageRoute(
//             builder: (context) => Chat(
//               chatRoomId: chatRoomId,
//             )
//         ));
//       },
//       child: Container(
//         color: Colors.black26,
//         padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//         child: Row(
//           children: [
//             Container(
//               height: 30,
//               width: 30,
//               decoration: BoxDecoration(
//                   color: CustomTheme.colorAccent,
//                   borderRadius: BorderRadius.circular(30)),
//               child: Text(userName.substring(0, 1),
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontFamily: 'OverpassRegular',
//                       fontWeight: FontWeight.w300)),
//             ),
//             SizedBox(
//               width: 12,
//             ),
//             Text(userName,
//                 textAlign: TextAlign.start,
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontFamily: 'OverpassRegular',
//                     fontWeight: FontWeight.w300))
//           ],
//         ),
//       ),
//     );
//   }
// }