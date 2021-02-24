import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'GET_IMGS.dart';
String IP4="192.168.1.8";

class IMG extends StatefulWidget {
  final  imageName;
  final  int index;
  final  phone;
  final  id;
  IMG({this.imageName,this.index,this.phone,this.id});

  _Get_Images createState() =>  _Get_Images();
}
class  _Get_Images extends State<IMG> {

  Future Delete()async{
    var url='https://'+IP4+'/testlocalhost/delete_IMG.php';
    var ressponse=await http.post(url,body: {
      "id": widget.id,
    });
    String massage = json.decode(ressponse.body);
    print(massage);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(10, 50, 360, 10),
              child: IconButton(
                alignment: Alignment.topRight,
                onPressed: () { Navigator.pop(context);},
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 35.0,
                ),
              ),
            ),
            Expanded(
              child: Hero(
                tag: 'logo$widget.index',
                child: Container(margin:EdgeInsets.symmetric(vertical:100),
                  height: 100,
                  decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage('https://'+IP4+'/testlocalhost/upload/'+widget.imageName),
                        fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.fromLTRB(310, 0, 10, 20),
              child: IconButton(
                alignment: Alignment.topRight,
                onPressed: () {
                  _showMyDialog();
                  print(widget.id);
                  print(widget.imageName);
                  //Delete();
                   },
                icon: Icon(
                  Icons.delete_forever_rounded,
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
            ),
                  //  Row(
                  //   children: <Widget>[
                  //
                  //     Container(
                  //       margin: EdgeInsets.fromLTRB(20, 0, 10, 20),
                  //       child: IconButton(
                  //         alignment: Alignment.topRight,
                  //         onPressed: () { Navigator.pop(context);},
                  //         icon: Icon(
                  //           Icons.arrow_back,
                  //           color: Colors.red,
                  //           size: 30.0,
                  //         ),
                  //       ),
                  //     ),
                  //     Container(
                  //       margin: EdgeInsets.fromLTRB(270, 0, 10, 20),
                  //       child: IconButton(
                  //         alignment: Alignment.topRight,
                  //         onPressed: () { Navigator.pop(context);},
                  //         icon: Icon(
                  //           Icons.arrow_forward,
                  //           color: Colors.red,
                  //           size: 30.0,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
    );
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      //this means the user must tap a button to exit the Alert Dialog
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.only(right: 10,left: 30,top: 30),
          title: Text('        هل تريد حذف هذه الصورة ؟    ',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
              fontFamily: 'Changa',
            ),),
           actions: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10,bottom: 20,top: 30),
            child:FlatButton(
              child: Text('إلغاء',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                  fontFamily: 'Changa',
                ),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),),
            Container(
              margin: EdgeInsets.only(left: 20,right: 90,bottom: 20,top: 30),
             child:FlatButton(
              child: Text('حذف ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                  fontFamily: 'Changa',
                ),),
              onPressed: () {
                Delete();
                print("dsd");
                Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>Get_Images(phone:widget.phone)));
              },
            ),),
          ],
        );
      },
    );
  }
}
