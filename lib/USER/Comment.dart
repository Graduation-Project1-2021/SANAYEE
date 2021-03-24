import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
TextEditingController comment = TextEditingController();
String IP4="192.168.1.8";
String  name_Me="";
String  name="";
String  phone="";
String  image="";
String namefirst="";
String namelast="";
String Country="";
String  token="";
//worker data
class v extends StatefulWidget {
  final work;
  final name_Me;
  final image;
  final namelast;
  final namefirst;
  final phone;
  final token;
  // final username;
  final location;
  v({this.work,this.name_Me,this.location,this.image,this.namefirst,this.namelast,this.phone,this.token});
  @override
  _Body createState() => _Body();
}
class _Body extends State<v> {
  @override
  void initState() {

    super.initState();
  }
  // Future getUser() async {
  //   var url = 'https://' + IP4 + '/testlocalhost/PHP/getUser.php';
  //   var ressponse = await http.post(url, body: {
  //     "name": widget.name_Me,
  //   });
  //   // ignore: deprecated_member_use
  //   return json.decode(ressponse.body);
  // }
  Widget build(BuildContext context) {
    // return Container(
    //
    //
    //       height: 700,
    //       padding: EdgeInsets.only(top:30),
    //     child: FutureBuilder(
    //     future: getUser(),
    // builder: (BuildContext context, AsyncSnapshot snapshot) {
    // if (snapshot.hasData) {
    // return ListView.builder(
    // itemCount: 1,
    // itemBuilder: (context, index) {
    // name = snapshot.data[index]['name'];
    // phone = snapshot.data[index]['phone'];
    // image = snapshot.data[index]['image'];
    // namefirst = snapshot.data[index]['namefirst'];
    // namelast = snapshot.data[index]['namelast'];
    // token = snapshot.data[index]['token'];
    //
    // return comments (name_Me: snapshot.data[index]['name'], namefirst: snapshot.data[index]['namefirst'], namelast: snapshot.data[index]['namelast'], phone: snapshot.data[index]['phone'], image: snapshot.data[index]['image'], token: snapshot.data[index]['token']);
    //
    // },
    // );
    // }
    // return Center(child: CircularProgressIndicator());
    // },
    // ),
    // );


  }}
class comments extends StatefulWidget {
  // final lat;
  // final lng;
  //
  final Phoneworker;
  final Phoneuser;
  final namelast;
  final namefirst;
  //final name_Me;
  final image;
  final token;
  comments({this.Phoneuser,this.Phoneworker,this.namefirst,this.namelast,this.image,this.token});
  // w({this.lat, this.lng});

  @override

  _commentsState createState() => _commentsState();
}

class _commentsState extends State<comments> {
  bool showcomment=false;
  // // Future senddata() async {
  // //   var mesaage;
  // //   print('hi hi hi');
  // //   var url = 'https://'+IP4+'/testlocalhost/PHP/login.php';
  // //   var ressponse = await http.post(url, body: {
  // //     "comment": comment.text,
  // //     "namefirst":widget.namefirst,
  // //     "namelast":widget.namelast,
  // //     "name_user": widget.name_Me,
  // //   });
  //
  //   mesaage= json.decode(ressponse.body);}
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(border:Border(top:BorderSide(color: Colors.grey))),
      padding: EdgeInsets.symmetric(horizontal:0,vertical: 5),
      child :Directionality(textDirection:TextDirection.rtl,
        // child :
        child:Scaffold(
          body:SingleChildScrollView(
         // height: 500,
           child:Column(
            children:<Widget> [
             // showcommentt("kkkk", ",,,,,,,,,,",",,jh", "gggggggg",),
             //  showcomment?Container(
             //    margin:EdgeInsets.only(top:50),
             //    child: showcommentt(widget.namefirst, widget.namelast, widget.image, comment.text,),):Container(
             //    child:Text("mmmm"),
             //  ),
              Container(
                margin: EdgeInsets.only(top:50),
                color: Colors.white,height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,),
              Positioned(bottom:0,child: Container(
                height:60,
                width: MediaQuery.of(context).size.width,
                child:Column(children: [
                  Row(
                    children: [
                      IconButton(icon:Icon(Icons.camera_alt_outlined),onPressed: (){},),
                      Container(
                          width:MediaQuery.of(context).size.width-50,
                          child:
                          TextFormField(
                            controller :comment,

                            decoration: InputDecoration(
                              hintText: "   اكتب تعليقا",
                              filled:true,

                              fillColor: Colors.grey[200],
                              suffixIcon:IconButton(icon:Icon(Icons.send),onPressed:() {
                                showcomment=true;
                                print(widget.namelast);
                                print(widget.namefirst);
                                print(widget.Phoneuser); print(widget.Phoneworker);print(comment.text);
                                addComment(widget.namefirst, widget.namelast,widget.image,comment.text,widget.Phoneuser,widget.Phoneworker);
                                setState(() {
                                });
                              },),

                              // s(Icons.send),
                              contentPadding: EdgeInsets.all(5),
                              focusedBorder:   OutlineInputBorder
                                (borderRadius:BorderRadius.circular(60),borderSide: BorderSide(style: BorderStyle.none),),
                              enabledBorder:   OutlineInputBorder
                                (borderRadius:BorderRadius.circular(60),borderSide: BorderSide(style: BorderStyle.none)),
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,),

                            //   border: OutlineInputBorder(
                            // borderSide:BorderSide(color: Colors.grey),
                            //
                            //     borderRadius: BorderRadius.circular(30),
                          )
                      ),

                      //         Container(
                      //
                      //
                      //           height: 700,
                      //           padding: EdgeInsets.only(top:30),
                      //           child: FutureBuilder(
                      //             future: getUser(),
                      //             builder: (BuildContext context, AsyncSnapshot snapshot) {
                      //               if (snapshot.hasData) {
                      //                 return ListView.builder(
                      //                   itemCount: 1,
                      //                   itemBuilder: (context, index) {
                      //                     name = snapshot.data[index]['name'];
                      //                     phone = snapshot.data[index]['phone'];
                      //                     image = snapshot.data[index]['image'];
                      //                     namefirst = snapshot.data[index]['namefirst'];
                      //                     namelast = snapshot.data[index]['namelast'];
                      //                     token = snapshot.data[index]['token'];
                      //
                      //                     return v (name_Me: snapshot.data[index]['name'], namefirst: snapshot.data[index]['namefirst'], namelast: snapshot.data[index]['namelast'], phone: snapshot.data[index]['phone'], image: snapshot.data[index]['image'], token: snapshot.data[index]['token']);
                      //
                      //                   },
                      //                 );
                      //               }
                      //               return Center(child: CircularProgressIndicator());
                      //             },
                      //           ),
                      //         ),
                      //
                      //         //Icon(Icons.send),
                      //
                      //       ],
                      //     )
                      //   ],) ,
                      //   //color: Colors.blue,
                      //
                      // )),
                      // Positioned(top:30,child:Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height-70,
                      //   child: SingleChildScrollView(
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children:<Widget> [
                      //         ListTile(leading:CircleAvatar(child: Icon(Icons.person),),
                      //
                      //             title: Container(margin:EdgeInsets.only(top:15),child:Text("Duaa Aqel"),),
                      //             subtitle:Container(padding:EdgeInsets.all(15),color:Colors.grey[100],margin:EdgeInsets.only(top: 15),child:Text("ddddddddddd"),
                      //             )
                      //         ),
                      //         ListTile(leading:CircleAvatar(child: Icon(Icons.person),),
                      //
                      //             title: Container(margin:EdgeInsets.only(top:15),child:Text("Duaa Aqel"),),
                      //             subtitle:Container(padding:EdgeInsets.all(15),color:Colors.grey[100],margin:EdgeInsets.only(top: 15),child:Text("ddddddddddd"),
                      //             )
                      //         ),
                      //         ListTile(leading:CircleAvatar(child: Icon(Icons.person),),
                      //
                      //             title: Container(margin:EdgeInsets.only(top:15),child:Text("Duaa Aqel"),),
                      //             subtitle:Container(padding:EdgeInsets.all(15),color:Colors.grey[100],margin:EdgeInsets.only(top: 15),child:Text("ddddddddddd"),
                      //             )
                      //         ),





                      // ],
                      //  ),


                      // ),
                      // ),

                      //)

                      // ],

                      // )
                      //   )
                      // )
                    ],),],),),),],),),),
      ),);

  }
  // Future getUser() async {
  //   var url = 'https://' + IP4 + '/testlocalhost/PHP/getUser.php';
  //   var ressponse = await http.post(url, body: {
  //     "name": widget.name_Me,
  //   });
  //   // ignore: deprecated_member_use
  //   return json.decode(ressponse.body);
  // }
  Future addComment( String namefirst, String namelast, String image, String comment,String com_user,String com_worker)async{
    print("hi");
    var url='https://'+IP4+'/testlocalhost/comment.php';
    var ressponse = await http.post(url, body: {
      "comuserfirstname": namefirst,
      "comlastname":namelast,
      "comment":comment,
      "image":image,
      "com_worker":com_worker,
      "com_user":com_user,
    });

  }
  Widget  showcommentt(String namefirst, String namelast,String image,String comment ){
    //String name= namefirst+" "+namelast;
    print("hi you are showing comments now");
    print(namefirst);
    print(namelast);
    print(image);
    print(comment);
    return Container(
      width: 400,
      height: 300,
      decoration: BoxDecoration(border:Border(top:BorderSide(color: Colors.grey))),
      padding: EdgeInsets.symmetric(horizontal:0,vertical: 5),
      child:Directionality(textDirection:TextDirection.rtl,
        child:Scaffold
          (
          body:Stack(children:<Widget> [
            Container(
              color: Colors.white,height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,),
            Positioned(top:30,child:Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height-70,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:<Widget> [
                    ListTile(leading:CircleAvatar(child: Icon(Icons.person),),

                        title: Container(margin:EdgeInsets.only(top:15),child:Text(namefirst),),
                        subtitle:Container(padding:EdgeInsets.all(15),color:Colors.grey[100],margin:EdgeInsets.only(top: 15),child:Text(comment),
                        )
                    ),],),),),),],),),),);
  }
}