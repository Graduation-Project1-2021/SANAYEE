import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

import 'IMG_BIG.dart';

List<Images> imagesFromJson(String str) => List<Images>.from(json.decode(str).map((x) => Images.fromJson(x)));

String imagesToJson(List<Images> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Images {
  String images;
  String phone;
  String id;

  Images({
    this.images,
    this.phone,
    this.id,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    images: json["images"],
    phone: json["phone"],
    id   :  json["id"],
  );

  Map<String, dynamic> toJson() => {
    "images": images,
    "phone" : phone,
    "id"    : id,
  };
}
class Get_Images extends StatefulWidget {
    // final phone;
    // Get_Images({this.phone});
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
    return Scaffold(
      // backgroundColor: Colors.lightBlueAccent,
      body: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Stack(
               children:[
                 Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icons/ho_but.jpg'),
                  fit: BoxFit.cover,
                ),

              ),
                 ),
                 Container(
                   child:Text(
                   'Gallery',
                   style: TextStyle(
                     fontSize: 25,
                     fontWeight: FontWeight.w600,
                     color: Colors.white,
                   ),
                   textAlign: TextAlign.center,
                 ),),
                 SingleChildScrollView(
                   child: Container(
                      height:595,
                     margin: EdgeInsets.only(top:180),
                     padding: EdgeInsets.only(top:30,right: 15,left: 15),
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.only(
                         topLeft: Radius.circular(30),
                         topRight: Radius.circular(30),
                       ),
                     ),
                     child: GridView.builder(
                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                         crossAxisCount: 3,
                         crossAxisSpacing: 15,
                         mainAxisSpacing: 15,
                       ),
                       itemCount: null == _image?0:_image.length,
                       itemBuilder: (context, index) {
                         return RawMaterialButton(
                           onPressed: () {
                             Navigator.push(context,MaterialPageRoute(
                                 builder: (BuildContext context) =>IMG(imageName:_image[index].images,index:index,phone:_image[index].phone,id:_image[index].id)));},
                           // Navigator.push(
                           //   context,
                           //   MaterialPageRoute(
                           //     builder: (context) => DetailsPage(
                           //       imagePath: _images[index].imagePath,
                           //       title: _images[index].title,
                           //       photographer: _images[index].photographer,
                           //       price: _images[index].price,
                           //       details: _images[index].details,
                           //       index: index,
                           //     ),
                           //   ),
                           // );

                           child: Hero(
                             tag: 'logo$index',
                             child: Container(
                               // print(_image[index].id+"");
                               //  child: Text(_image[inde),
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(15),
                                 image: DecorationImage(image: NetworkImage('https://192.168.1.8/testlocalhost/upload/'+_image[index].images),
                                   fit: BoxFit.cover,
                                 ),
                               ),
                             ),
                           ),
                         );
                       },
                       // itemCount: _image.length,
                     ),
                   ),
                 )
               ],),),


          ],
        ),
      ),
    );
  }
}

