import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutterphone/screens/slider.dart';

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


class Show extends StatefulWidget {
  // final  imageName;
  // final  int index;
  final  phone;
  Show({this.phone});
  // final  id;
  // IMG({this.imageName,this.index,this.phone,this.id});

  _Show createState() =>  _Show();
}
class  _Show extends State<Show> {


  Future <List<Images>>getImages()async{
    var url='https://192.168.1.8/testlocalhost/Show_EXP.php';
    var ressponse=await http.post(url,body: {
      "phone": widget.phone,
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
  int index=0;
  @override
  Widget build(BuildContext context) {
    // String asset1='https://192.168.1.8/testlocalhost/upload/'+_image[1].images;
    // String asset2='https://192.168.1.8/testlocalhost/upload/'+_image[1].images;
    // String asset3='https://192.168.1.8/testlocalhost/upload/'+_image[2].images;
    // String asset4='https://192.168.1.8/testlocalhost/upload/'+_image[3].images;
    //  getImages().then((image) {
    //   _image=image;
    //   loading=false;
    // });
    // Images im=_image[index];
     return Container(
       margin: EdgeInsets.only(top: 10),
       height: 250,
         child: Column(
             children: <Widget>[

               // Container(
               //   margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
               //   child:ClipRRect(
               //     borderRadius: BorderRadius.circular(10.0),
               //     child: Image.network('https://192.168.1.8/testlocalhost/upload/'+im.images, height: 110,
               //       width:209,
               //       fit: BoxFit.cover,),
               //   ),),
               // Container(
               //   margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
               //   child:ClipRRect(
               //     borderRadius: BorderRadius.circular(10.0),
               //     child: Image.network('https://192.168.1.8/testlocalhost/upload/'+_image[1].images, height: 110,
               //       width:209,
               //       fit: BoxFit.cover,),
               //   ),),
               Container(
                 height: 260,
                 child:ListView.builder(
                     itemCount: null == _image?0:1,
                     itemBuilder: (context,index) {
                       int num = _image.length-4;

                       return myAlbum('https://192.168.1.8/testlocalhost/upload/'+_image[0].images, 'https://192.168.1.8/testlocalhost/upload/'+_image[1].images, 'https://192.168.1.8/testlocalhost/upload/'+_image[2].images, 'https://192.168.1.8/testlocalhost/upload/'+_image[3].images,num.toString()+"+");
                     }),
               ),
             ],
         ),);

  }
   myAlbum(String asset1, String asset2, String asset3, String asset4, String more){
     return Container(
         margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
          padding:EdgeInsets.fromLTRB(15, 0, 15, 0),
           height:250,
           width:400,
           child: Card(
           elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 0),
            color: Colors.yellow,
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),),
            shadowColor: Colors.white,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             // ClipRRect(
             //   borderRadius: BorderRadius.circular(10.0),
             //   child: Image.asset(
             //     'assets/icons/ho.jpg', height: 80,
             //     width: 80,
             //     fit: BoxFit.cover,),
             // ),
             // Container(
             //   margin: EdgeInsets.only(top:5,bottom: 200),
             //   padding: EdgeInsets.only(top:5,),
             //   child:ClipRRect(
             //     borderRadius: BorderRadius.circular(10.0),
             //     child: Image.asset(
             //       'assets/icons/ho.jpg', height: 80,
             //       width: 80,
             //       fit: BoxFit.cover,),
             //   ),),
              Container(
                // margin: EdgeInsets.only(top:5,right: 30,),
             child:Row(
               children: <Widget>[
                 Container(
                   margin: EdgeInsets.only(right: 10,bottom: 10,top: 10),
                   // margin:  EdgeInsets.only(left:15,right: 15),
                 child:ClipRRect(
                   borderRadius: BorderRadius.circular(10.0),
                   child: Image.network(
                     asset2, height: 110,
                     width: 159,
                     fit: BoxFit.cover,),
                 ),),
                 Container(
                   margin: EdgeInsets.all(10),
                   // margin:  EdgeInsets.only(left:10,),
                   child:ClipRRect(
                     borderRadius: BorderRadius.circular(10.0),
                     child: Image.network(
                       asset1, height: 110,
                       width:159,
                       fit: BoxFit.cover,),
                   ),),
               ],
             ),),
             Container(
               child:Row(
                 children: <Widget>[
                   // Container(
                   //   margin: EdgeInsets.only(right: 10,bottom: 10),
                   //   child:ClipRRect(
                   //     borderRadius: BorderRadius.circular(10.0),
                   //     child: Image.asset(
                   //       'assets/icons/ho.jpg', height: 110,
                   //       width: 110,
                   //       fit: BoxFit.cover,),
                   //   ),),
                         GestureDetector(
                           onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>Screen()));
                           },
                         child: Container(
                            margin: EdgeInsets.only(right: 10,bottom: 10),
                         child:Stack(
                         overflow: Overflow.visible,
                         children: <Widget>[
                          ClipRRect(
                             borderRadius: BorderRadius.circular(10.0),
                             child: Image.network(
                               asset4, height: 110,
                               width: 110,
                               fit: BoxFit.cover,),
                           ),
                           Positioned(
                             child: Container(
                               height: 110,
                               width: 110,
                               decoration: BoxDecoration(
                                   color: Colors.black38,
                                   borderRadius: BorderRadius.circular(10.0)
                               ),
                               child: Center(
                                 child: Text(more, style: TextStyle(
                                   color: Colors.white,
                                   fontSize: 20,
                                 ),),
                               ),
                             ),
                           )
                         ],
                       ),),),
                   Container(
                     margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                     child:ClipRRect(
                       borderRadius: BorderRadius.circular(10.0),
                       child: Image.network(
                         asset4, height: 110,
                         width:209,
                         fit: BoxFit.cover,),
                     ),),
                 ],),
              ),
             // Container(
             //  child:Text("ألبومي "),
             // ),
           ],),),);
  }
}