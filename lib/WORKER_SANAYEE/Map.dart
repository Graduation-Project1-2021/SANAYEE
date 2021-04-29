// import 'dart:async';
// import 'dart:convert';
// import "dart:io";
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:http/http.dart' as http;
// String IP4="192.168.2.108";
// // var url = "http://maps.google.com/mapfiles/ms/icons/";
// // url + = "blue";
// int count =0;
// List<dynamic>Worker;
// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
// }
//
// class MyApp1 extends StatefulWidget {
//   _mState createState() => _mState();
// }
//
// class _mState extends State<MyApp1> {
//
//   Future getMarker()async{
//     print("Yes from getmarker");
//     var url='https://'+IP4+'/testlocalhost/PHP/markers.php';
//     var ressponse=await http.get(url);
//     print(json.decode(ressponse.body));
//     print("vvxbccccccccccccccccccccccc");
//     return json.decode(ressponse.body);
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     print("000000000000000000000000000000000000000");
//     return Scaffold(
//       //appBar: ,
//       body:Column(
//         children:<Widget>[
//           Container(
//             child: Text("Ma ddddddddddddddddddddddddddddddddp"),
//           ),
//           Expanded(
//
//             child:Container(
//               height: 100,
//               child: FutureBuilder(
//                   future: getMarker(),
//                   builder: (BuildContext context, AsyncSnapshot snapshot) {
//                     if (snapshot.hasData) {
//                       print("has data================================================================================================");
//                       //_MyHomePageState c= new _MyHomePageState();
//                       return ListView.builder(
//                         itemCount: 1,
//                         itemBuilder: (context, index) {
//                           var Listr=snapshot.data;
//                           print(Listr[0]['lng']);
//                           return w(Location:Listr,);
//                         },);
//                     }
//                     return Container(child:CircularProgressIndicator(),
//                       //child:Text("hi"),
//                     );
//
//                   }
//               ),
//             ),),],),);
//
//
//   }
// }
// class w extends StatefulWidget {
//   List<dynamic>Location;
//   w({this.Location});
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<w> {
//   PermissionStatus _permissionGranted;
//   bool serviceEnabled;
//   int i=0;
//   var List_Worker=[];
//   List<Marker> markers=[];
//   Completer<GoogleMapController> _controller = Completer();
//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );
//
//   get url => null;
//   @override
//   void initState() {
//     super.initState();
//   }
//   bool S=false;
//   Fetch()async{
//     for(;i<widget.Location.length;i++){
//       await checkLocationServicesInDevice(double.parse(widget.Location[i]['lat']),double.parse(widget.Location[i]['lng']));
//     }
//     setState(() {
//       S=true;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     Fetch();
//     return S?Container(
//       height: 700,
//       child:showgooglemap(markers),):Center(child: CircularProgressIndicator());
//     //  child:FutureBuilder(
//     //    future: checkLocationServicesInDevice(),
//     //      builder: (BuildContext context, AsyncSnapshot <double>snapshot) {
//     //        if (snapshot.hasData) {
//     //          print("================================================111111");
//     //              return Container(child:Text(snapshot.data.toString()),);
//     //        }
//     //        return Center(child: CircularProgressIndicator());
//     //
//     //      }
//     //
//     // ),
//   }
//   // @override
//   Future <double>checkLocationServicesInDevice(double lat1,double lng1) async {
//     print("i am in location");
//     Location location = new Location();
//     LocationData _location ;
//     serviceEnabled = await location.serviceEnabled();
//
//     if(serviceEnabled)
//     {
//
//       _permissionGranted = await location.hasPermission();
//
//       if(_permissionGranted == PermissionStatus.granted)
//       {
//         _location = await location.getLocation();
//         print(_location.latitude.toString() + " " + _location.longitude.toString());
//         double lat=_location.latitude;
//         double log=_location.longitude;
//         Marker m=new Marker(markerId: MarkerId("User Location"),infoWindow: InfoWindow(title:"your current location"), position: LatLng(32.464634
//             ,35.293858));
//         markers.add(m);
//         double d= calculateDistance(lat,log,lat1,lng1);
//         print(lat1);
//         print(lng1);
//         print(d);
//         print("Now you are registered in the system");
//         return d;
//
//
//
// //for more  than one location(continuous taking of the location)
//
//         // location.onLocationChanged.listen((LocationData currentLocation) {
//         //   print(currentLocation.latitude.toString() + " " +
//         //       currentLocation.longitude.toString());
//         // });
//       }else{
//
//         _permissionGranted = await location.requestPermission();
//
//         if(_permissionGranted == PermissionStatus.granted)
//         {
//           _location = await location.getLocation();
//
//           print(_location.latitude.toString() + " " + _location.longitude.toString());
//
//
//           print('user allowed');
//
//         }else{
//
//           SystemNavigator.pop();
//
//         }
//
//       }
//
//     }else{
//
//       serviceEnabled = await location.requestService();
//
//       if(serviceEnabled)
//       {
//
//         _permissionGranted = await location.hasPermission();
//
//         if(_permissionGranted == PermissionStatus.granted)
//         {
//
//           print('user allowed before');
//
//         }else{
//
//           _permissionGranted = await location.requestPermission();
//
//           if(_permissionGranted == PermissionStatus.granted)
//           {
//
//             print('user allowed');
//
//           }else{
//
//             SystemNavigator.pop();
//
//           }
//
//         }
//
//
//       }else{
//
//         SystemNavigator.pop();
//
//       }
//
//     }
//
//   }
//
//   double calculateDistance(lat1, lon1, lat2, lon2){
//     print("distance calculation ");
//     var p = 0.017453292519943295;
//     var c = cos;
//     var a = 0.5 - c((lat2 - lat1) * p)/2 +
//         c(lat1 * p) * c(lat2 * p) *
//             (1 - c((lon2 - lon1) * p))/2;
//     print(12742 * asin(sqrt(a)));
//     double distance=12742 * asin(sqrt(a));
//     if(distance<12000){
//       List_Worker.add(widget.Location[i]);
//       var random = new Random();
//       int id =random.nextInt(100000);
//       Marker m=new Marker(markerId: MarkerId(id.toString()), infoWindow: InfoWindow(title:widget.Location[i]['namefirst']+" "+widget.Location[i]['namelast']+"على بعد "+distance.toString()), position: LatLng(double.parse(widget.Location[i]['lat']),double.parse(widget.Location[i]['lng'])),);
//       markers.add(m);
//       print("marker=================================================");
//     }
//     return distance;
//   }
//   Widget showgooglemap(List<Marker>mark){
//     print(mark.length);print("=========================================================================================================");
//     return Container(
//       height: 700,
//       child:Stack(
//         children: <Widget>[
//           GoogleMap(initialCameraPosition: CameraPosition(target:
//           LatLng(31.9474,35.2272),
//               zoom: 12),
//             markers:markers.toSet(),
//           ),
//         ],
//       ),
//     );
//
//   }
//
// }
//
import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import "dart:io";
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

String IP4="192.168.1.8";
bool showmap=true;
// var url = "http://maps.google.com/mapfiles/ms/icons/";
// url + = "blue";
int count =0;
List<dynamic>Worker;
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class order_map extends StatefulWidget {
  final work;
  final name_Me;
  final namefirst_Me;
  final nameLast_Me;
  final phone_Me;
  final image_Me;
  final token_Me;
  final country;
  final lat;
  final lng;
  order_map({this.lat,this.lng,this.country,this.token_Me,this.image_Me,this.namefirst_Me,this.nameLast_Me,this.phone_Me,this.work,this.name_Me});
  // final location;
  //   final work;
  //  final name_Me;
  //MyApp1({this.location,this.work,this.name_Me});
  _mState createState() => _mState();
}

class _mState extends State<order_map> {

  today() async {
    DateTime date=DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(date);
    var url = 'https://' + IP4 + '/testlocalhost/userlocation.php';
    // for(int i=0;i<list_.length;i++){
    var ressponse = await http.post(url, body: {
      //"phone":list_ [i],
      "phoneworker": widget.phone_Me,
      "date":formattedDate,

    });
    return json.decode(ressponse.body);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
            height: 650,
            color: Colors.grey[50],
            child: FutureBuilder(
                future: today(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data.length);
                    //_MyHomePageState c= new _MyHomePageState();
                    return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        var Listr=snapshot.data;
                        return w(lng:widget.lng,lat:widget.lat,Location:Listr,work:widget.work,name_Me:widget.name_Me,country:widget.country,token_Me:widget.token_Me,image_Me:widget.image_Me,phone_Me:widget.phone_Me,nameLast_Me:widget.nameLast_Me,namefirst_Me:widget.namefirst_Me);
                      },);
                  }
                  return Container(
                    child:Text(""),
                  );

                }
            ),
          );


  }
}
class w extends StatefulWidget {
  List<dynamic>Location;
  final work;
  final name_Me;
  final namefirst_Me;
  final nameLast_Me;
  final phone_Me;
  final image_Me;
  final token_Me;
  final lat;
  final lng;
  final country;
  w({this.lat,this.lng,this.country,this.token_Me,this.image_Me,this.namefirst_Me,this.nameLast_Me,this.phone_Me,this.work,this.name_Me,this.Location});
  //w({this.Location,this.work});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
Completer<GoogleMapController> _controller = Completer();
_onMapCreated(GoogleMapController controller) {
  // _controller.complete(controller);
}
class _MyHomePageState extends State<w> {
  PermissionStatus _permissionGranted;
  bool serviceEnabled;
  int i = 0;
  var List_Worker = [];
  var list_ = [];
  var list_distance = [];
  var List_button=[];
  List<Marker> markers = [];
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 11,
  );

  get url => null;

  @override
  void initState() {
    super.initState();
  }

  Set<Circle> circles;
  bool S = false;

  Fetch() async {
    await addworker();
    for (; i < widget.Location.length; i++) {
      await add();
    }
    setState(() {

    });
  }
  addworker()async{
    final Uint8List markerIcon= await getBytesFromAsset('assets/icons/current.png',100);
    int id = i;
    Marker m = new Marker(markerId: MarkerId(id.toString()),
      infoWindow: InfoWindow(title:"ME",onTap: (){
      }),
      position: LatLng(double.parse(widget.lat,),
          double.parse(widget.lng)), icon:BitmapDescriptor.fromBytes(markerIcon),
    );
    markers.add(m);
  }
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec =
    await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }
  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
  void _onButtonPressed(int index,String namefirst,String namelast,String image,String timestart,String timeend,String Am_Pm,String id) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.white,
            height: 135,
            child: Container(
              child: _buildBottomNavigationMenu(index,namefirst,namelast,image,timestart,timeend,Am_Pm,id),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                ),
              ),
            ),
          );
        });
  }
  Container _buildBottomNavigationMenu(int index,String namefirst,String namelast,String image,String timestart,String timeend,String Am_Pm,String id) {
    return Container(
      height:100,
      child:Column(
        children: <Widget>[
          order_user(index,namefirst,namelast,image,timestart,timeend,Am_Pm,id),
          //   ListTile(
          //   leading: Icon(Icons.ac_unit),
          //   title: Text('Flutter'),
          //   onTap: () => _selectItem('Flutter'),
          // ),
          // ListTile(
          //   leading: Icon(Icons.accessibility_new),
          //   title: Text('Android'),
          //   onTap: () => _selectItem('Android'),
          // ),
          // ListTile(
          //   leading: Icon(Icons.assessment),
          //   title: Text('Kotlin'),
          //   onTap: () => _selectItem('Kotlin'),
          // ),
        ],
      ),);
  }

  Widget showgooglemap(List<Marker>mark) {
    return Stack(
          children:[
            Container(
              margin: EdgeInsets.only(top: 0),
              height: 650,
              child:GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(target:
                LatLng(double.parse(widget.lat),double.parse(widget.lng)),
                    zoom: 11),
                markers: mark.toSet(),
                scrollGesturesEnabled: true,
                zoomGesturesEnabled: true,
                myLocationButtonEnabled: false,
                gestureRecognizers: Set()
                  ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer())),
              ),
            ),
          ],);
          // SizedBox(width: 5,),
          // IconButton(
          //   icon: showmap?Icon(Icons.person,color:Colors.black,):Icon(Icons.location_on,color: Colors.black87,),
          //   onPressed: () {
          //     // showmap=true;
          //     print(showmap);
          //     setState(() {
          //       showmap = !showmap;
          //     });
          //   },
          // ),
          // showmap == false ? Container(
          //   height: 700,
          //   width: 500,
          //   // color:  Color(0xFFF3D657),
          //   margin: EdgeInsets.only(top: 50),
          //   //padding:EdgeInsets.only(right:25,left: 25),
          //   decoration: BoxDecoration(
          //     color:  Color(0xFFF3D657),
          //   ),
          //  child: ListView.builder(
          //           itemCount: widget.Location.length,
          //           itemBuilder: (context, index) {
          //             return order_user(index,widget.Location[index]['namefirst'],widget.Location[index]['namelast'],widget.Location[index]['image'],widget.Location[index]['timestart'],widget.Location[index]['timeend'],widget.Location[index]['Am_Pm'],widget.Location[index]['id']);
          //             },
          //         ),)
          //
          //     :
  }
  finished_order(String id) async {
    print(id);
    DateTime date=DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(date);
    var formattedTime = DateFormat('HH:mm:ss').format(date);
    var url = 'https://' + IP4 + '/testlocalhost/finishedorder.php';
    var ressponse = await http.post(url, body: {
      //"phone":list_ [i],
      "id":id,
      "datefinished":formattedDate,
      "timefinished":formattedTime,

    });
    return json.decode(ressponse.body);
  }
  delete_order(String id) async {
    DateTime date=DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(date);
    var formattedTime = DateFormat('HH:mm:ss').format(date);
    var url = 'https://' + IP4 + '/testlocalhost/delete_accept_order.php';
    var ressponse = await http.post(url, body: {
      "id": id,
      "datecancel":formattedDate,
      "timecancel":formattedTime,
      "who":'worker',
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }

  Container order_user(int index,String namefirst,String namelast,String image,String timestart,String timeend,String Am_Pm,String id){
    return Container(
      height: 100,
      margin: EdgeInsets.only(top:20),
      decoration: BoxDecoration(
        color:Colors.grey[50],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Directionality(
        textDirection: ui.TextDirection.rtl,
        child:Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child:Row(
              children: [
                SizedBox(width: 10,),
                Container(
                  // print(_image[index].id+"");
                  width: 70,
                  height: 70,
                  margin: EdgeInsets.only(right: 10,top:0),
                  decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image: NetworkImage('https://'+IP4+'/testlocalhost/upload/'+image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 240,
                  height: 100,
                  margin: EdgeInsets.only(right:0,top:0),
                  child:  Column(
                    children: [
                      SizedBox(height:15,),
                      Container(
                        width: 200,
                        height: 30,
                        //color: Colors.green,
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(top: 0,bottom: 0,left: 50,right:10),
                        child: Text(namefirst + " " + namelast,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16.0,
                            fontFamily: 'Changa',
                            fontWeight: FontWeight.bold,),
                        ),),
                      SizedBox(height:10,),
                      Container(
                        height:40,
                        child:Row(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width:10,),
                                    Text("الوقت ", style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                      fontFamily: 'Changa',
                                    ),),
                                    Text(timeend +" - " +timestart, style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black54,
                                      fontFamily: 'Changa',
                                    ),),
                                    Text(" "),
                                    Text(Am_Pm=="am"?"صباحا":"مساء", style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black54,
                                      fontFamily: 'Changa',
                                    ),),
                                    SizedBox(width: 5,),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 55,
                  // margin: EdgeInsets.only(top:10),
                  child: FlatButton(
                    onPressed: () {
                      // UrlLauncher.launch("tel://0595320479");
                    },
                    child: new Icon(
                      Icons.phone,
                      color: Colors.white,
                      size: 23.0,
                    ),
                    shape: new CircleBorder(),
                    color: Y,
                  ),
                ),

                SizedBox(width:30,),
                GestureDetector(
                  onTap: () async{
                    await finished_order(id);
                    widget.Location.removeAt(index);
                    setState(() {

                    });
                  },
                  child:Container(
                    height: 90,
                    width: 90,
                    color: Colors.greenAccent[700],
                    child: Icon(Icons.check,color:Colors.white,size:30,),
                  ),
                ),
                GestureDetector(
                  onTap: () async{
                    await delete_order(id);
                    widget.Location.removeAt(index);
                    setState(() {

                    });
                  },
                  child:Container(
                    height: 90,
                    width: 90,
                    color: Colors.red,
                    child: Icon(Icons.delete,color:Colors.white,size:30),
                  ),
                ),
              ],
            ),),
        ],),
    ),);
  }
  @override
  Widget build(BuildContext context) {
    Fetch();

    return  Container(
      height: 690,
      width: 500,
      child: showgooglemap(markers),);
    //  child:FutureBuilder(
    //    future: checkLocationServicesInDevice(),
    //      builder: (BuildContext context, AsyncSnapshot <double>snapshot) {
    //        if (snapshot.hasData) {
    //          print("================================================111111");
    //              return Container(child:Text(snapshot.data.toString()),);
    //        }
    //        return Center(child: CircularProgressIndicator());
    //
    //      }
    //
    // ),
  }

  // @override
  Future <double> add() async {
        final Uint8List markerIconuser= await getBytesFromAsset('assets/icons/worker.png',200);
      int index = i;
      Marker m = new Marker(markerId: MarkerId(index.toString()),
        infoWindow: InfoWindow(title: widget.Location[i]['namefirst'] + " " +
            widget.Location[i]['namelast'],onTap: (){
          _onButtonPressed(index,widget.Location[index]['namefirst'],widget.Location[index]['namelast'],widget.Location[index]['image'],widget.Location[index]['timestart'],widget.Location[index]['timeend'],widget.Location[index]['Am_Pm'],widget.Location[index]['id'],);
        }),
        position: LatLng(double.parse(widget.Location[i]['lat'],),
            double.parse(widget.Location[i]['lng'])), icon:BitmapDescriptor.fromBytes(markerIconuser),
      );
      markers.add(m);
      print("marker=================================================");

    }

}
//}

