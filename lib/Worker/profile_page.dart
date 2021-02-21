import 'dart:convert';
import 'package:flutterphone/commons/my_info.dart';
import 'package:flutterphone/commons/opaque_image.dart';
import 'package:flutterphone/commons/profile_info_big_card.dart';
import 'package:flutterphone/commons/profile_info_card.dart';
import 'package:flutterphone/styleguide/colors.dart';
import 'package:flutterphone/styleguide/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/commons/radial_progress.dart';
import 'package:flutterphone/commons/rounded_image.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:collection';

import 'Profile_worker.dart';
double Hight=0;
class ProfilePage extends StatefulWidget {
  final String name;
  ProfilePage(this.name);
  _ProfilePage createState() => _ProfilePage(this.name);
}
class _ProfilePage extends State<ProfilePage> {
  String name;
  _ProfilePage(this.name);
  Future getWorker()async{
      var url='https://192.168.1.8/testlocalhost/getworker.php';
      var ressponse=await http.post(url,body: {
        "name": name,
      });
     // ignore: deprecated_member_use
      var responsebody = json.decode(ressponse.body);
      return responsebody;
  }

  Widget build(BuildContext context) {
    setState(() {
    });
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          // appBar: PreferredSize(
          // preferredSize: Size.fromHeight(0.0), // here the desired height
          //  child: AppBar(
          //    flexibleSpace: Image(
          //      image: AssetImage('assets/icons/ho_top.jpg'),
          //      fit: BoxFit.cover,
          //    ),
          //  ),),
           body: FutureBuilder(
            future: getWorker(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                     return ListView.builder(
                   itemCount: snapshot.data.length,
                       itemBuilder: (context , index){
                    return Profile_worker(name:snapshot.data[index]['name'],phone:snapshot.data[index]['phone'],image:snapshot.data[index]['image'],Work:snapshot.data[index]['Work'],Experiance:snapshot.data[index]['Experiance'],Information:snapshot.data[index]['Information'],token:snapshot.data[index]['token']);
                  },
                );
              }
              return Center(child:CircularProgressIndicator()) ;
            },
          ),
        ));
  }
}


// class Worker extends StatelessWidget {
//   final name;
//   final phone;
//   final image;
//   final Work;
//   final Experiance;
//   final Information;
//   final token;
//
//   Worker({this.name, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token});
//
//   @override
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//         children: [
//           Container(
//             height: 800,
//             child: Column(
//               children: <Widget>[
//                 Expanded(
//                   flex: 4,
//                   child: Stack(
//                     children: <Widget>[
//                       Container(child: Text(phone)),
//                       Container(
//                         margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                          height: Hight / 3.6,
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage('assets/icons/ho.jpg'),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.fromLTRB(0, 40, 0, 30),
//                         child: Row(
//                           children: <Widget>[
//                             Container(
//                               margin: EdgeInsets.fromLTRB(1, 0, 210, 0),
//                               child: IconButton(
//                                 onPressed: () {
//                                   Navigator.of(context).push(
//                                       MaterialPageRoute(
//                                           builder: (BuildContext context) =>
//                                               SettingsPage(name)));
//                                 },
//                                 icon: Icon(
//                                   Icons.settings,
//                                   color: Colors.white,
//                                   size: 30.0,
//                                 ),
//                               ),),
//                             Container(
//                               margin: EdgeInsets.fromLTRB(100, 0, 1, 0),
//                               child: IconButton(
//                                 alignment: Alignment.topRight,
//                                 onPressed: () {
//                                   Navigator.of(context).push(
//                                       MaterialPageRoute(
//                                           builder: (BuildContext context) =>
//                                               SettingsPage(name)));
//                                 },
//                                 icon: Icon(
//                                   Icons.arrow_forward_outlined,
//                                   color: Colors.white,
//                                   size: 30.0,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       //
//                       // Container(
//                       //   child: Column(
//                       //     children: <Widget>[
//                       //       Image.network(
//                       //           "https://192.168.1.8/testlocalhost/upload/$image"),
//                       //     ],
//                       //   ),
//                       // ),image
// //                       Positioned(
// //                         top: 150,
// //                         right: 20,
// //                         child: InkWell(
// //                           child: RadialProgress(
// //                             width: 4,
// //                             progressColor: Colors.grey,
// //                             goalCompleted: 1,
// //                             child: RoundedImage(
// // // imagePath: 'https://192.168.1.8/testlocalhost/upload/$image',
// // // imagePath:'https://192.168.1.8/testlocalhost/upload/$image',
// //                               size: Size.fromWidth(120.0),
// //                             ),
// //                           ),),
// //                       ),
// // OpaqueImage(
// //   imageUrl: "assets/icons/ho.jpg",
// // ),
//                       SafeArea(
//                         child: Padding(
//                           padding: const EdgeInsets.all(16),
//                           child: Column(
//                             children: [
//                               Align(
//
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(name,
//                                   textAlign: TextAlign.left,
//                                   style: headingTextStyle,
//                                 ),
//                               ),
// // MyInfo(),
//
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
// // Expanded(
// //   flex: 5,
// //   child: Container(
// //     padding: const EdgeInsets.only(top: 50),
// //     color: Colors.white,
// //   ),
// // ),
//               ],
//             ),),
//         ],
//       );
// // Positioned(
// //   top: screenHeight * (4 / 9) - 80 / 2,
// //   left: 16,
// //   right: 16,
// //   child: Container(
// //     height: 80,
// //     child: Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //       mainAxisSize: MainAxisSize.max,
// //       children: <Widget>[
// //         ProfileInfoCard(firstText: "54%", secondText: "Progress"),
// //         SizedBox(
// //           width: 10,
// //         ),
// //         ProfileInfoCard(
// //           hasImage: true,
// //           imagePath: "assets/icons/pulse.png",
// //         ),
// //         SizedBox(
// //           width: 10,
// //         ),
// //         ProfileInfoCard(firstText: "152", secondText: "Level"),
// //       ],
// //     ),
// //   ),
// // ),Level
//   }
// }
