import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/Worker/setting_worker.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

import '../constants.dart';


FocusNode myFocusNode = new FocusNode();
bool Pass_Null=true;
bool Pass_R=true;
bool Pass_Mismatch=true;
bool Pass_S=true;
bool Pass_old=true;
bool Pass_old_notC=true;
String pass="";

bool _showPassword1 = false;
bool _showPassword2 = false;
bool _showPassword3 = false;


List<Images> imagesFromJson(String str) => List<Images>.from(json.decode(str).map((x) => Images.fromJson(x)));

String imagesToJson(List<Images> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Images {
  String images;
  String phone;

  Images({
    this.images,
    this.phone,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    images: json["images"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "images": images,
    "phone": phone,
  };
}
class Get_Images extends StatefulWidget {


  _Get_Images createState() =>  _Get_Images();
}
class  _Get_Images extends State< Get_Images> {

  Future <List<Images>>getImages()async{
    var url='https://192.168.1.8/testlocalhost/Get_Images_EXP.php';
    var ressponse=await http.post(url,body: {
      "phone": '+978456',
    });
    // ignore: deprecated_member_use
    // var responsebody = json.decode(ressponse.body);
    // print(responsebody);
    final List<Images>image=imagesFromJson(ressponse.body);
    return image;
  }
  List<Images>_image;
  bool loading;
  @override
  void initState() {
    super.initState();
    loading=true;
    getImages().then((image) {
      _image=image;
      loading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    // nameController.text=widget.name;
    // workcontroller.text=widget.Work;
    // experController.text=widget.Experiance;
    // infoController.text=widget.Information;

    return Scaffold(
      appBar: AppBar(
        title: Text(loading?'loading':'Users'),
      ),
    body:
    Container(
      child:ListView.builder(
        itemCount: null == _image?0:_image.length,
          itemBuilder: (context,index) {
          Images image = _image[index];

        return ListTile(
          title: Text(image.images),
          subtitle: Text(image.phone),
        );

      }),
    ),

    //     body: Expanded(
    //     child: Container(
    //       child:Column(
    //        children:<Widget>[
    //          GridView.builder(
    // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    // crossAxisCount: 3,
    // crossAxisSpacing: 10,
    // mainAxisSpacing: 10,
    // ),),
    // Container(child:FutureBuilder(
    //       future: getImages(),
    //       builder: (BuildContext context, AsyncSnapshot snapshot) {
    //         if (snapshot.hasData) {
    //           return ListView.builder(
    //             itemCount: snapshot.data.length,
    //             itemBuilder: (context , index){
    //               print(snapshot.data[index]['images']);
    //               // image.add(snapshot.data[index]['images']);
    //               return Container(child:Image.network("https://192.168.1.8/testlocalhost/upload/"+snapshot.data[index]['images']),);
    //
    //               // return PostList(phone:snapshot.data[index]['phone'],images:snapshot.data[index]['images']);
    //               // child: Container(
    //               //   decoration: BoxDecoration(
    //               //     borderRadius: BorderRadius.circular(15),
    //               //     image: DecorationImage(
    //               //       image: NetworkImage('https://192.168.1.8/testlocalhost/upload/'+snapshot.data[index]['images']),
    //               //       fit: BoxFit.cover,
    //               //     ),
    //               //   ),
    //               // );
    //
    //                return Container();
    //             },
    //           );
    //         }
    //
    //         Column(
    //           children: [
    //             Container(
    //               child:Text('HI EVERY BODY'),
    //             ),
    //           ],
    //         );
    //
    //         return Center(child:CircularProgressIndicator()) ;
    //
    //       },
    //
    //     ),
    // ),],),),),);
    );
}


}
class PostList extends StatelessWidget{
  final phone;
  final images;
  PostList({this.phone,this.images});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child:Column(
        children: <Widget>[
          Container(
            child: Text(phone),
          ),
    // Container(
    // decoration: BoxDecoration(
    // borderRadius: BorderRadius.circular(15),
    // image: DecorationImage(
    // image:NetworkImage("https://192.168.1.8/testlocalhost/upload/$images"),
    // fit: BoxFit.cover,
    // ),
    // ),),
          // Container(child:Image.network("https://192.168.1.8/testlocalhost/upload/$images"),),
        ],
      ),
    );
  }
}


