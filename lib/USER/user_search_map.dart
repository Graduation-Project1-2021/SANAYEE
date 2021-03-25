import 'dart:async';
import 'dart:convert';
import "dart:io";
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'List_worker_group.dart';
String IP4="192.168.1.8";
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

class MyApp1 extends StatefulWidget {
  final token;
  final name_Me;
  final namefirst;
  final namelast;
  final image;
  final phone;
  final country;
  final work;
  MyApp1({this.country,this.work,this.phone,this.name_Me,this.namelast,this.namefirst,this.image,this.token});
  _mState createState() => _mState();
}

class _mState extends State<MyApp1> {

  Future getMarker()async{
    var url='https://'+IP4+'/testlocalhost/markers.php';
    var ressponse=await http.get(url);
    print(json.decode(ressponse.body));
    print("vvxbccccccccccccccccccccccc");
    return json.decode(ressponse.body);


  }
  @override
  Widget build(BuildContext context) {
    print("000000000000000000000000000000000000000");
    return Scaffold(
      //appBar: ,
      body:Column(
        children:<Widget>[
          Container(
            child: Text("Ma ddddddddddddddddddddddddddddddddp"),
          ),
          Expanded(

            child:Container(
              height: 100,
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
                          return w(Location:Listr,);
                        },);
                    }
                    return Container(
                      //child:Text("hi"),
                    );

                  }
              ),
            ),),],),);


  }
}
class w extends StatefulWidget {
  List<dynamic>Location;
  final token;
  final name_Me;
  final namefirst;
  final namelast;
  final image;
  final phone;
  final country;
  final work;
  w({this.country,this.work,this.phone,this.name_Me,this.namelast,this.namefirst,this.image,this.token,this.Location});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<w> {
  PermissionStatus _permissionGranted;
  bool serviceEnabled;
  int i=0;
  var ListWorker=[];
  List<Marker> markers=[];
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
  bool S=false;
  Fetch()async{
    for(;i<widget.Location.length;i++){
      await checkLocationServicesInDevice(double.parse(widget.Location[i]['lat']),double.parse(widget.Location[i]['lng']));
    }
    setState(() {
      S=true;
    });
  }
  @override
  Widget build(BuildContext context) {
    Fetch();
    Navigator.push(context, MaterialPageRoute(builder: (context) => List_Worker(token_Me:widget.token,work: widget.work,name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,)));

    return S?Container(
      height: 700,
      child:showgooglemap(markers),):Center(child: CircularProgressIndicator());

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
  Future <double>checkLocationServicesInDevice(double lat1,double lng1) async {
    print("i am in location");
    Location location = new Location();
    LocationData _location ;
    serviceEnabled = await location.serviceEnabled();

    if(serviceEnabled)
    {

      _permissionGranted = await location.hasPermission();

      if(_permissionGranted == PermissionStatus.granted)
      {
        _location = await location.getLocation();
        print(_location.latitude.toString() + " " + _location.longitude.toString());
        double lat=_location.latitude;
        double log=_location.longitude;
        Marker m=new Marker(markerId: MarkerId("User Location"),infoWindow: InfoWindow(title:"your current location"), position: LatLng(32.460000
            ,35.300000));
        markers.add(m);
        double d= calculateDistance(32.460000,35.300000,lat1,lng1);
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
      }

      else{

        _permissionGranted = await location.requestPermission();

        if(_permissionGranted == PermissionStatus.granted)
        {
          //ONCE
          _location = await location.getLocation();

          print(_location.latitude.toString() + " " + _location.longitude.toString());


          print('user allowed');

        }
        else{
          //Here
          // SystemNavigator.pop();
          // Navigator.push(context, MaterialPageRoute(builder: (context) => List_Worker));
          //Navigator.push(context, MaterialPageRoute(builder: (context) => List_Worker(token_Me:widget.token,work: widget.work,name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,)));
        }

      }

    }else{

      serviceEnabled = await location.requestService();

      if(serviceEnabled)
      {

        _permissionGranted = await location.hasPermission();

        if(_permissionGranted == PermissionStatus.granted)
        {

          print('user allowed before');

        }else{

          _permissionGranted = await location.requestPermission();

          if(_permissionGranted == PermissionStatus.granted)
          {

            print('user allowed');

          }else{
            //SystemNavigator.pop();

          }

        }


      }else{

        //Navigator.push(context, MaterialPageRoute(builder: (context) => List_Worker(token_Me:widget.token,work: widget.work,name_Me: widget.name_Me,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phone,image_Me: widget.image,)));
        //SystemNavigator.pop();

      }

    }

  }

  double calculateDistance(lat1, lon1, lat2, lon2){
    print("distance calculation ");
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    print(12742 * asin(sqrt(a)));
    double distance=12742 * asin(sqrt(a));

    if(distance<10000){
      ListWorker.add(widget.Location[i]);
      var random = new Random();
      int id =random.nextInt(100000);
      Marker m=new Marker(markerId: MarkerId(id.toString()), infoWindow: InfoWindow(title:widget.Location[i]['namefirst']+" "+widget.Location[i]['namelast']+"على بعد "+distance.toString()), position: LatLng(double.parse(widget.Location[i]['lat']),double.parse(widget.Location[i]['lng'])),);
      markers.add(m);
      print("marker=================================================");
    }
    return distance;
  }
  Widget showgooglemap(List<Marker>mark){
    print(mark.length);print("=========================================================================================================");
    return Container(
      height: 700,
      child:Stack(
        children: <Widget>[
          GoogleMap(initialCameraPosition: CameraPosition(target:
          LatLng(31.9474,35.2272),
              zoom: 12),
            markers:markers.toSet(),
          ),
        ],
      ),
    );

  }

}