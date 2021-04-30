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

  Directionality order_user(int index,String namefirst,String namelast,String image,String timestart,String timeend,String Am_Pm,String id){
    return Directionality( textDirection: ui.TextDirection.rtl,
    child:Container(
      height: 100,
      margin: EdgeInsets.only(bottom:20),
      decoration: BoxDecoration(
        color:Colors.grey[50],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
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
                                    Text(timestart +" - " +timeend, style: TextStyle(
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
                    height: 50,
                    width: 120,
                    child:FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.transparent)
                        ),
                        // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                        color:Colors.green,
                        onPressed: (){
                        },
                        child:Row(
                          children: [
                            Text('تم الانتهاء',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontFamily: 'Changa',
                                //fontStyle: FontStyle.italic,
                              ),),
                            SizedBox(width:5,),
                            Icon(Icons.check,color:Colors.white,size:24,),
                          ],
                        )
                    ),
                  ),
                ),
                SizedBox(width:15,),
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

