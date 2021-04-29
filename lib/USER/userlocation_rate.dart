import 'dart:async';
import 'dart:convert';
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
import '../Inside_the_app/List_worker_group.dart';
import '../constants.dart';
import 'WORKER_PROFILE.dart';
import 'search_user.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

class Search_map_rate extends StatefulWidget {
  final work;
  final name_Me;
  final namefirst_Me;
  final nameLast_Me;
  final phone_Me;
  final image_Me;
  final token_Me;
  final location;
  final country;
  Search_map_rate({this.country,this.token_Me,this.image_Me,this.namefirst_Me,this.nameLast_Me,this.phone_Me,this.work,this.name_Me,this.location});
  // final location;
  //   final work;
  //  final name_Me;
  //MyApp1({this.location,this.work,this.name_Me});
  _mState createState() => _mState();
}

class _mState extends State<Search_map_rate> {

  Future getMarker()async{
    var url='https://'+IP4+'/testlocalhost/markers_rate.php';
    var ressponse=await http.post(url, body: {
      //"phone":list_ [i],
      "Work":widget.work,

    });
    return json.decode(ressponse.body);(url);
    print(json.decode(ressponse.body));
    print("vvxbccccccccccccccccccccccc");
    return json.decode(ressponse.body);

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children:<Widget>[
        Expanded(

          child:Container(
            height: 500,
            color: Colors.white,
            child: FutureBuilder(
                future: getMarker(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    print("has data================================================================================================");
                    //_MyHomePageState c= new _MyHomePageState();
                    return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        var Listr=snapshot.data;
                        print(Listr[0]['lng']);
                        return w(Location:Listr,work:widget.work,name_Me:widget.name_Me,country:widget.country,token_Me:widget.token_Me,image_Me:widget.image_Me,phone_Me:widget.phone_Me,nameLast_Me:widget.nameLast_Me,namefirst_Me:widget.namefirst_Me);
                      },);
                  }
                  return Container(
                    child:Text(""),
                  );

                }
            ),
          ),),],);


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

  final country;
  w({this.country,this.token_Me,this.image_Me,this.namefirst_Me,this.nameLast_Me,this.phone_Me,this.work,this.name_Me,this.Location});
  //w({this.Location,this.work});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
Completer<GoogleMapController> _controller = Completer();
_onMapCreated(GoogleMapController controller) {
  _controller.complete(controller);
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
    zoom: 14.4746,
  );

  get url => null;

  @override
  void initState() {
    super.initState();
  }

  Set<Circle> circles;
  bool S = false;

  Fetch() async {
    for (; i < widget.Location.length; i++) {
      await checkLocationServicesInDevice(
          double.parse(widget.Location[i]['lat']),
          double.parse(widget.Location[i]['lng']));
    }
    list_distance.sort((a,b)=>a.distance.compareTo(b.distance));
    setState(() {
      S = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Fetch();
    return  Container(
      height: 540,
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
  Future <double> checkLocationServicesInDevice(double lat1,
      double lng1) async {
    print("i am in location");
    Location location = new Location();
    LocationData _location;
    serviceEnabled = await location.serviceEnabled();

    if (serviceEnabled) {
      _permissionGranted = await location.hasPermission();

      if (_permissionGranted == PermissionStatus.granted) {
        circles = Set.from([Circle(
          strokeColor: Colors.blue.withOpacity(0.2),
          strokeWidth: 1,
          fillColor: Colors.blue.withOpacity(0.1),
          circleId: CircleId('1'),
          center: LatLng(32.464634,  35.293858),
          radius: 16000,
        )]);
        final Uint8List markerIcon = await getBytesFromAsset('assets/icons/current.png', 100);
        final Uint8List markerIconworker= await getBytesFromAsset('assets/icons/worker.png', 200);

        _location = await location.getLocation();
        print(_location.latitude.toString() + " " +
            _location.longitude.toString());
        double lat = _location.latitude;
        double log = _location.longitude;
        Marker m = new Marker(markerId: MarkerId("User Location"),
          infoWindow: InfoWindow(title: "your current location"),
          position: LatLng(32.464634
              , 35.293858),

          icon:BitmapDescriptor.fromBytes(markerIcon),
        );
        markers.add(m);
        double d = calculateDistance(32.464634, 35.293858, lat1, lng1,markerIconworker);
        print(lat1);
        print(lng1);
        print(d);
        print("Now you are registered in the system");
        return d;


//for more  than one location(continuous taking of the location)

        // location.onLocationChanged.listen((LocationData currentLocation) {
        //   print(currentLocation.latitude.toString() + " " +
        //       currentLocation.longitude.toString());
        // });
      } else {
        _permissionGranted = await location.requestPermission();

        if (_permissionGranted == PermissionStatus.granted) {
          _location = await location.getLocation();

          print(_location.latitude.toString() + " " +
              _location.longitude.toString());


          print('user allowed');
        } else {
          SystemNavigator.pop();
        }
      }
    } else {
      serviceEnabled = await location.requestService();

      if (serviceEnabled) {
        _permissionGranted = await location.hasPermission();

        if (_permissionGranted == PermissionStatus.granted) {
          print('user allowed before');
        } else {
          _permissionGranted = await location.requestPermission();

          if (_permissionGranted == PermissionStatus.granted) {
            print('user allowed');
          } else {
            SystemNavigator.pop();
          }
        }
      } else {
        SystemNavigator.pop();
      }
    }
  }
  double calculateDistance(lat1, lon1, lat2, lon2,Uint8List markerIconworker){
    print("distance calculation ");
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p)) / 2;
    print(12742 * asin(sqrt(a)));
    double distance = 12742 * asin(sqrt(a));
    if (distance < 12000) {
      list_.add(widget.Location[i]['phoneworker']);
      print("Duaa");
      print(list_.toString());
      // print(list_[1]);
      List_Worker.add(widget.Location[i]);
      var random = new Random();
      List_button.add(widget.Location[i]);
      list_distance.add(Distance(widget.Location[i]['phoneworker'],distance));
      int id = i;
      Marker m = new Marker(markerId: MarkerId(id.toString()),
        infoWindow: InfoWindow(title: widget.Location[i]['namefirst'] + " " +
            widget.Location[i]['namelast'],onTap: (){
          print('vvvvvvvvvv');
          print(id);
          print("SARAHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
          // print(List_button[id].toString());
          double Rate;
          if(List_button[id]['AVG']==null){Rate=0.0;}
          else{ Rate =roundDouble(double.parse(List_button[id]['AVG']),1);}
          String dis;
          if(distance>=1){dis=distance.toInt().toString()+"كم";}
          else{distance=distance*1000;dis=distance.toInt().toString()+"م";}

          _onButtonPressed(List_button[id]['Client'],dis,List_button[id]['namefirst'],List_button[id]['namelast'],List_button[id]['phoneworker'],Rate,List_button[id]['image'],widget.token_Me,List_button[id]['token'],widget.phone_Me,widget.namefirst_Me,widget.nameLast_Me,widget.image_Me);
          // var  bottomSheetController;
          // bottomSheetController=Scaffold.of(scaffoldKey.currentContext).
          // showBottomSheet((context) => Container(
          //   height: 250,
          //   color: Colors.green,
          //   child:Text('lllllllllllll')
          // ));
        }),
        position: LatLng(double.parse(widget.Location[i]['lat'],),
            double.parse(widget.Location[i]['lng'])), icon:BitmapDescriptor.fromBytes(markerIconworker),
      );
      markers.add(m);
      print("marker=================================================");

    }
    return distance;
  }
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec =
    await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }

  void _onButtonPressed(String client_num,String dis,String namefirst,String namelast,String phoneworker,double Rate,String image,String token_Me,String token,String phoneuser,String namefirst_Me,String lastname_Me,String image_Me) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.white,
            height: 170,
            child: Container(
              child: _buildBottomNavigationMenu(client_num,dis,namefirst,namelast,phoneworker,Rate,image,token_Me,token,phoneuser,namefirst_Me,lastname_Me,image_Me),
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
  Container _buildBottomNavigationMenu(String clientnum,String dis,String namefirst,String namelast,String phoneworker,double Rate,String image,String token_Me,String token,String phoneuser,String namefirst_Me,String lastname_Me,String image_Me) {
    return Container(
      height:170,
      child:Column(
        children: <Widget>[
          GroupButtom(client_num:clientnum,distance:dis,image:image,namelast: namelast,namefirst: namefirst,Rate: Rate,Work:widget.work,phone:phoneworker,phone_Me:phoneuser,token:token,token_Me:token_Me,image_Me:image_Me,namefirst_Me:namefirst_Me,nameLast_Me:lastname_Me,),
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

  void _selectItem(String name) {
    Navigator.pop(context);
    setState(() {
    });
  }
  Widget showgooglemap(List<Marker>mark) {
    print(mark.length);
    print(
        "=========================================================================================================");
    return Container(
      // height: 700,
      color: Colors.grey[50],
      child: Stack(
        children: <Widget>[
          showmap == false ? Container(
            height: 700,
            width: 500,
            // color:  Color(0xFFF3D657),
            margin: EdgeInsets.only(top: 50),
            //padding:EdgeInsets.only(right:25,left: 25),
            decoration: BoxDecoration(
            ),
            child: FutureBuilder(
              future: getWorkers(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  print('ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd');
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var Listslot = snapshot.data;
                      double Rate;
                      print(snapshot.data.length);
                      print(snapshot.data[index]['name']);
                      if (snapshot.data[index]['name'] == null &&
                          snapshot.data[index]['namefirst'] == null &&
                          snapshot.data[index]['namelast'] == null && snapshot
                          .data[index]['phone'] == null && snapshot
                          .data[index]['image'] == null && snapshot
                          .data[index]['Work'] == null && snapshot
                          .data[index]['Experiance'] == null &&
                          snapshot.data[index]['Information'] == null &&
                          snapshot.data[index]['token'] == null) {
                        return Container();
                      }
                      if (snapshot.data[index]['AVG'] == null) {
                        Rate = 0.0;
                      }
                      else {
                        Rate = roundDouble(double.parse(
                            snapshot.data[index]['AVG']), 1);
                      }

                      if (list_.any((item) =>
                          snapshot.data[index]['phone'].contains(item))) {
                        int j=list_.indexOf( snapshot.data[index]['phone']);
                        String dis;
                        double distance=list_distance[j].distance;
                        if(distance>=1){dis=distance.toInt().toString()+"كم";}
                        else{distance=distance*1000;dis=distance.toInt().toString()+"م";}
                        return Group(distance:dis.toString(),namefirst_Me: widget.namefirst_Me,
                          nameLast_Me: widget.nameLast_Me,
                          phone_Me: widget.phone_Me,
                          image_Me: widget.image_Me,
                          Rate: Rate,
                          name_Me: widget.name_Me,
                          name: snapshot.data[index]['name'],
                          namefirst: snapshot.data[index]['namefirst'],
                          namelast: snapshot.data[index]['namelast'],
                          phone: snapshot.data[index]['phone'],
                          image: snapshot.data[index]['image'],
                          Work: snapshot.data[index]['Work'],
                          Experiance: snapshot.data[index]['Experiance'],
                          Information: snapshot.data[index]['Information'],
                          token: snapshot.data[index]['token'],
                          client_num: snapshot.data[index]['Client'],
                        );
                      }
                      return Center(child: Text(''));
                    },
                  );
                }
                // Lists have at least one common element
                else {
                  // Li
                  print('noooooooooooooooooooooooooooooooooooooot');
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),)
              :
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(target:
            LatLng(32.464634, 35.293858),
                zoom: 10.65),
            markers: markers.toSet(),
            circles: circles,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            myLocationButtonEnabled: false,
            gestureRecognizers: Set()
              ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer())),
          ),
          Container(
            width: 55,
            margin: EdgeInsets.only(top:10,right:10),
            child: FlatButton(
              onPressed: () {
                setState(() {
                  showmap = !showmap;
                });
              },
              child: new Icon(
                showmap?Icons.person:Icons.location_on,
                color: Colors.white,
                size: 23.0,
              ),
              shape: new CircleBorder(),
              color: Y,
            ),
          ),
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
        ],
      ),

    );
  }

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  getWorkers() async {
    var url = 'https://' + IP4 + '/testlocalhost/workerlocation.php';
    // for(int i=0;i<list_.length;i++){
    var ressponse = await http.post(url, body: {
      //"phone":list_ [i],
      "Work": widget.work,

    });
    return json.decode(ressponse.body);
  }
}
//}



// getshowWorkers( ) {
//   Container(
//     height: 100,
//     child: FutureBuilder(
//         future: getWorkers(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.hasData) {
//             print("HasData");
//             //_MyHomePageState c= new _MyHomePageState();
//             return ListView.builder(
//               itemCount: 1,
//               //itemBuilder: (context, index) {
//               itemBuilder: (context, index) {
//                 //=snapshot.data[index]['name'];
//
//
//
//                 // print(Listr[0]['lng']);
//                // return show(name:snapshot.data[index]['name'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],phone:snapshot.data[index]['phone'],image:snapshot.data[index]['image'],Work:snapshot.data[index]['Work'],Experiance:snapshot.data[index]['Experiance'],Information:snapshot.data[index]['Information'],token:snapshot.data[index]['token']);
//               },);
//           }
//           return Container(
//             //child:Text("hi"),
//           );
//
//
//         }),);
//
// }}

class Group  extends StatefulWidget {
  final name_Me;
  final  name;
  final  namefirst;
  final  namelast;
  final  phone;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;
  final double Rate;
  final namefirst_Me;
  final nameLast_Me;
  final phone_Me;
  final image_Me;
  final token_Me;
  final distance;
  final client_num;

  Group({this.client_num,this.distance,this.token_Me,this.phone_Me,this.nameLast_Me,this.namefirst_Me,this.image_Me,this.Rate,this.name_Me,this.name,this.namefirst,this.namelast, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token});

  @override
  _Group createState() => _Group();
}

class _Group extends State<Group> {
  @override
  void initState() {
    super.initState();
  }
  var ma;
  Future getImages() async {
    var url = 'https://' + IP4 + '/testlocalhost/Show_EXP.php';
    var ressponse = await http.post(url, body: {
      "phone": widget.phone,
    });
    // ignore: deprecated_member_use
    // var responsebody = json.decode(ressponse.body);
    // print(responsebody);
    return json.decode(ressponse.body);
  }

  @override
  Widget build(BuildContext context) {

    print(widget.phone); print(widget.name_Me); print(widget.phone_Me);
    print('ddddddddddddddddddddddddddddd'); print(widget.image);
    return GestureDetector(
      onTap: (){
        print(widget.phone); print(widget.name_Me); print(widget.phone_Me);
        print(widget.token); print(widget.image);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => user_worker(phoneuser:widget.phone_Me,tokenuser:widget.token_Me,Work:widget.Work,image:widget.image,phone:widget.phone,name: widget.name,namelast:widget.namelast,name_Me: widget.name_Me,namefirst: widget.namefirst,token: widget.token,Information: widget.Information,Experiance:widget.Experiance,),));
      },
      child:Directionality(
        textDirection: TextDirection.rtl,
        child:Container(
          height: 155,
          width: 450,
          decoration: BoxDecoration(
            color:Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 1),
                blurRadius: 1,
                color: Colors.grey,
              ),
            ],
          ),
          margin: EdgeInsets.only(left: 20, right: 20,top: 20),
          child: FutureBuilder(
              future: getComment(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  print(
                      "SARAHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHhhhhhhhhh");
                  //_MyHomePageState c= new _MyHomePageState();
                  return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      ma = snapshot.data[index]['count'];
                      return Row_worker();
                    },);
                }
                return Container(
                  child: Text(''),
                );
              }
          ),
        ),),);
  }
  Widget Row_worker(){
    return Column(
      children: <Widget>[
        Stack(children: [
          Row(
            children: [
              Container(
                // print(_image[index].id+"");
                width: 110,
                height: 110,
                margin: EdgeInsets.only(right: 10,top:20),
                decoration: BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(image: NetworkImage('https://'+IP4+'/testlocalhost/upload/'+widget.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                margin: EdgeInsets.only(top: 0),
                child:Column(
                  children: [
                    Container(
                      width: 150,
                      height: 22,
                      //color: Colors.red,
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only(right: 10,top: 0),
                      child: Text(widget.namefirst + " " + widget.namelast,
                        style: TextStyle(
                          fontSize: 15.5,
                          fontFamily: 'Changa',
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),),),
                    Container(
                      width: 150,
                      height: 22,
                      //color: Colors.red,
                      margin: EdgeInsets.only(right: 10,bottom:25,top: 5),
                      child: Row(
                        children: [
                          Text(widget.Work,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'Changa',
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),),
                        ],
                      ),),
                  ],
                ),
              ),
              Container(
                  color: Colors.white,
                  height: 60,
                  transform: Matrix4.translationValues(0.0, -14.0, 0.0),
                  margin: EdgeInsets.only(right:30),
                  child:Text(
                    widget.distance,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18.0,
                      fontFamily: 'Changa',
                      fontWeight: FontWeight.bold,

                    ),
                  )
              ),
            ],
          ),
          Container(
            width: 240,
            margin: EdgeInsets.only(right: 130,top: 90),
            child:  Row(
              children: [
                Text('العملاء',
                  style: TextStyle(
                    color: Color(0xFF666360),
                    fontSize: 13.0,
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.bold,

                  ),),
                SizedBox(width: 44.5,),
                Text('التعليقات',
                  style: TextStyle(
                    color: Color(0xFF666360),
                    fontSize: 13.0,
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.bold,
                  ),),
                SizedBox(width: 54.5,),
                Text('الريت',
                  style: TextStyle(
                    color: Color(0xFF666360),
                    fontSize: 13.0,
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.bold,
                  ),),
              ],
            ),
          ),
          Container(
            width: 240,
            margin: EdgeInsets.only(right: 130,top: 110),
            child:  Row(
              children: [
                SizedBox(width: 10,),
                Text(widget.client_num,
                  style: TextStyle(
                    color: Color(0xFF666360),
                    fontSize: 13.0,
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.bold,
                  ),),
                SizedBox(width: 85.5,),
                Text(ma.toString(),
                  style: TextStyle(
                    color: Color(0xFF666360),
                    fontSize: 13.0,
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.bold,
                  ),),
                SizedBox(width: 80.5,),
                Text(widget.Rate.toString(),
                  style: TextStyle(
                    color: Color(0xFF666360),
                    fontSize: 13.0,
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.bold,
                  ),),
                Icon(Icons.star, color: Colors.yellow,),
              ],
            ),
          ),

        ],),
      ],);
  }
  Future getComment() async {
    var url = 'https://' + IP4 + '/testlocalhost/getcomment.php';
    var ressponse = await http.post(url, body: {
      "phone": widget.phone,
    });
    // ignore: deprecated_member_use
    // var responsebody = json.decode(ressponse.body);
    // print(responsebody);

    return json.decode(ressponse.body);
  }

}



class GroupButtom  extends StatefulWidget {
  final name_Me;
  final  name;
  final  namefirst;
  final  namelast;
  final  phone;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;
  final double Rate;
  final namefirst_Me;
  final nameLast_Me;
  final phone_Me;
  final image_Me;
  final token_Me;
  final distance;
  final client_num;

  GroupButtom({this.client_num,this.distance,this.token_Me,this.phone_Me,this.nameLast_Me,this.namefirst_Me,this.image_Me,this.Rate,this.name_Me,this.name,this.namefirst,this.namelast, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token});

  @override
  _GroupButtom createState() => _GroupButtom();
}

class _GroupButtom extends State<GroupButtom> {
  @override
  void initState() {
    super.initState();
  }
  var ma;
  Future getImages() async {
    var url = 'https://' + IP4 + '/testlocalhost/Show_EXP.php';
    var ressponse = await http.post(url, body: {
      "phone": widget.phone,
    });
    // ignore: deprecated_member_use
    // var responsebody = json.decode(ressponse.body);
    // print(responsebody);
    return json.decode(ressponse.body);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.phone);
    print(widget.name_Me);
    print(widget.phone_Me);
    print('ddddddddddddddddddddddddddddd');
    print(widget.image);
    return GestureDetector(
      onTap: () {
        print(widget.phone);
        print(widget.name_Me);
        print(widget.phone_Me);
        print(widget.token);
        print(widget.image);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>
                user_worker(phoneuser: widget.phone_Me,
                  tokenuser: widget.token_Me,
                  Work: widget.Work,
                  image: widget.image,
                  phone: widget.phone,
                  name: widget.name,
                  namelast: widget.namelast,
                  name_Me: widget.name_Me,
                  namefirst: widget.namefirst,
                  token: widget.token,
                  Information: widget.Information,
                  Experiance: widget.Experiance,),));
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          height: 155,
          width: 550,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Column(
            children: <Widget>[
              Stack(children: [
                Container(
                  height: 155,
                  color: Colors.white,
                  child: FutureBuilder(
                      future: getComment(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          print(
                              "SARAHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHhhhhhhhhh");
                          //_MyHomePageState c= new _MyHomePageState();
                          return ListView.builder(
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              ma = snapshot.data[index]['count'];
                              return Row_Worker();
                            },);
                        }
                        return Container(
                          child: Text(''),
                        );
                      }
                  ),
                ),
              ],),
              // Container(
              //   height: 10,
              //   margin: EdgeInsets.only(top: 5),
              //   child:Divider(
              //     color: Color(0xFF666360),
              //     thickness: 1,
              //   ),),

            ],),
        ),),);
  }

  Future getComment() async {
    var url = 'https://' + IP4 + '/testlocalhost/getcomment.php';
    var ressponse = await http.post(url, body: {
      "phone": widget.phone,
    });
    // ignore: deprecated_member_use
    // var responsebody = json.decode(ressponse.body);
    // print(responsebody);

    return json.decode(ressponse.body);
  }

  Widget Row_Worker(){
    return Stack(
      children: [
        Row(
          children: [
            Container(
              // print(_image[index].id+"");
              width: 110,
              height: 110,
              margin: EdgeInsets.only(right: 10, top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(image: NetworkImage(
                    'https://' + IP4 + '/testlocalhost/upload/' +
                        widget.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -10.0, 0.0),
              margin: EdgeInsets.only(top: 0),
              child: Column(
                children: [
                  Container(
                    width: 150,
                    height: 22,
                    //color: Colors.red,
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(right: 10, top: 0),
                    child: Text(
                      widget.namefirst + " " + widget.namelast,
                      style: TextStyle(
                        fontSize: 15.5,
                        fontFamily: 'Changa',
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),),),
                  Container(
                    width: 150,
                    height: 22,
                    //color: Colors.red,
                    margin: EdgeInsets.only(
                        right: 10, bottom: 25, top: 5),
                    child: Row(
                      children: [
                        Text(widget.Work,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Changa',
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),),
                      ],
                    ),),
                ],
              ),
            ),
            Container(
                color: Colors.white,
                height: 60,
                transform: Matrix4.translationValues(0.0, -18.0, 0.0),
                margin: EdgeInsets.only(right: 40),
                child: Text(
                  widget.distance,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20.0,
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.bold,

                  ),
                )
            ),
          ],
        ),
        Container(
          width: 250,
          margin: EdgeInsets.only(right: 130, top: 90),
          child: Row(
            children: [
              Text('العملاء',
                style: TextStyle(
                  color: Color(0xFF666360),
                  fontSize: 13.0,
                  fontFamily: 'Changa',
                  fontWeight: FontWeight.bold,

                ),),
              SizedBox(width: 54.5,),
              Text('التعليقات',
                style: TextStyle(
                  color: Color(0xFF666360),
                  fontSize: 13.0,
                  fontFamily: 'Changa',
                  fontWeight: FontWeight.bold,
                ),),
              SizedBox(width: 64.5,),
              Text('الريت',
                style: TextStyle(
                  color: Color(0xFF666360),
                  fontSize: 13.0,
                  fontFamily: 'Changa',
                  fontWeight: FontWeight.bold,
                ),),
            ],
          ),
        ),
        Container(
          width: 250,
          margin: EdgeInsets.only(right: 130, top: 110),
          child: Row(
            children: [
              SizedBox(width: 10,),
              Text(widget.client_num.toString(),
                style: TextStyle(
                  color: Color(0xFF666360),
                  fontSize: 13.0,
                  fontFamily: 'Changa',
                  fontWeight: FontWeight.bold,
                ),),
              SizedBox(width: 90.5,),
              Text(widget.client_num.toString(),
                style: TextStyle(
                  color: Color(0xFF666360),
                  fontSize: 13.0,
                  fontFamily: 'Changa',
                  fontWeight: FontWeight.bold,
                ),),
              SizedBox(width: 85.5,),
              Text(widget.Rate.toString(),
                style: TextStyle(
                  color: Color(0xFF666360),
                  fontSize: 13.0,
                  fontFamily: 'Changa',
                  fontWeight: FontWeight.bold,
                ),),
              Icon(Icons.star, color: Colors.yellow,),
            ],
          ),
        ),
      ],
    );

  }


}
class Distance{
  String phone;
  double distance;

  Distance(this.phone, this.distance);

  @override
  String toString() {
    return '{ ${this.phone}, ${this.distance} }';
  }
}
