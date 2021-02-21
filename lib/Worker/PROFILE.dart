import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/Worker/setting_worker.dart';
import 'package:flutterphone/commons/radial_progress.dart';
import 'package:flutterphone/screens/login_screen.dart';
import 'package:flutterphone/screens/welcome_screen.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

import 'IMG_BIG.dart';
import 'Show_IMG.dart';

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
List<Worker> WorkerFromJson(String str) => List<Worker>.from(json.decode(str).map((x) => Worker.fromJson(x)));

String WorkerToJson(List<Images> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Worker {
  String  name;
  String  phone;
  String  image;
  String  Work;
  String  Experiance;
  String  Information;
  String  token;

  Worker({this.name, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token});

  factory Worker.fromJson(Map<String, dynamic> json) => Worker(
    name: json["name"],
    phone: json["phone"],
    image: json["image"],
    Work: json["Work"],
    Experiance: json["Experiance"],
    Information: json["Information"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone" : phone,
    "image": image,
    "Work" : Work,
    "Experiance": Experiance,
    "Information" : Information,
    "token": token,
  };
}
class PROFILE extends StatefulWidget {
  final name;
  PROFILE({this.name});
  _PROFILE createState() =>  _PROFILE();
}
class  _PROFILE extends State< PROFILE> {

  // Future <List<Images>>getImages()async{
  //   var url='https://192.168.1.8/testlocalhost/Get_Images_EXP.php';
  //   var ressponse=await http.post(url,body: {
  //     "phone": '+978456',
  //   });
  //   // ignore: deprecated_member_use
  //   // var responsebody = json.decode(ressponse.body);
  //   // print(responsebody);
  //   final List<Images>image=imagesFromJson(ressponse.body);
  //   return image;
  // }
  Future getImages() async {
    var url = 'https://192.168.1.8/testlocalhost/Show_EXP.php';
    var ressponse = await http.post(url, body: {
      "phone": '+978456',
    });
    // ignore: deprecated_member_use
    // var responsebody = json.decode(ressponse.body);
    // print(responsebody);
    return json.decode(ressponse.body);
  }
  Future <List<Worker>>getWorker()async{
    var url='https://192.168.1.8/testlocalhost/getworker.php';
    var ressponse=await http.post(url,body: {
      "name": 'SAMAR',
    });
    // ignore: deprecated_member_use
    final List<Worker>worker=WorkerFromJson(ressponse.body);
    return worker;
  }
  List<Worker>_worker;
  List<Images>_image;
  bool loading;
  @override
  void initState() {
    super.initState();

    // loading=true;
    // getImages().then((image) {
    //   _image=image;
    //   loading=false;
    // });
    loading=true;
    getWorker().then((worker) {
      _worker=worker;
      loading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Directionality( textDirection: TextDirection.rtl,
    child:Scaffold(
      // backgroundColor: Colors.lightBlueAccent,
      body: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Stack(
                children:[Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/icons/ho.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

            //
            // Container(height: 20, margin: EdgeInsets.only(top: 1,bottom: 1) ,child:Text("HI")),
            Container(
              height: 400,
              child:FutureBuilder(
                future: getImages(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return myAlbum('https://192.168.1.8/testlocalhost/upload/'+snapshot.data[index]['images'],'https://192.168.1.8/testlocalhost/upload/'+snapshot.data[index+1]['images'],'https://192.168.1.8/testlocalhost/upload/'+snapshot.data[index+2]['images'],'https://192.168.1.8/testlocalhost/upload/'+snapshot.data[index+3]['images'],"vfff");
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            // Container(
            //   child:Column(
            // children:<Widget>[
            //   Container(
            //   height: 400,
            //   margin: EdgeInsets.only(top: 2,bottom: 10),
            //   child:ListView.builder(
            //       itemCount:_worker.length,
            //       itemBuilder: (context,index) {
            //         loading? CircularProgressIndicator():Profile_worker(name: _worker[index].name,phone: _worker[index].phone,image: _worker[index].image,Work: _worker[index].Work,Experiance: _worker[index].Experiance,Information: _worker[index].Information,token: _worker[index].token,);
            //          return Show(phone:'+978456');
            //
            //       }),
            //  ),
             ],),),
    ],),),),);
  }
  myAlbum(String asset1, String asset2, String asset3, String asset4, String more){
    return Stack(
     children:[
       Container(
         height: 200,
         decoration: BoxDecoration(
           image: DecorationImage(
             image: AssetImage('assets/icons/ho.jpg'),
             fit: BoxFit.cover,
           ),
         ),
       ),
       Container(
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
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>WelcomeScreen()));
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
          ],),),),],);
  }
}

class Profile_worker  extends StatefulWidget {
  final  name;
  final  phone;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;

  Profile_worker({this.name, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token});

  @override
  _Profile_woeker createState() => _Profile_woeker();
}

class _Profile_woeker extends State<Profile_worker> {
  bool uploading = false;
  double val = 0;
  File uploadimage;
  // File _file;
  List<File> _image = []; //هاي هي
  int counter = 0;
  File _file;
  final picker = ImagePicker();
  Future <List<Images>>getImages()async{
    var url='https://192.168.1.8/testlocalhost/Show_EXP.php';
    var ressponse=await http.post(url,body: {
      "phone": widget.phone,
    });
    final List<Images>image=imagesFromJson(ressponse.body);
    return image;
  }
  List<Images>_images;
  bool loading;
  @override
  void initState() {
    super.initState();
    loading=true;
    getImages().then((image) {
      _images=image;
      loading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 260,
      child:Text(widget.name),
      // child:ListView.builder(
      //     itemCount: null == _images?0:1,
      //     itemBuilder: (context,index) {
      //       int num = _images.length-4;
      //
      //       return myAlbum('https://192.168.1.8/testlocalhost/upload/'+_images[0].images, 'https://192.168.1.8/testlocalhost/upload/'+_images[1].images, 'https://192.168.1.8/testlocalhost/upload/'+_images[2].images, 'https://192.168.1.8/testlocalhost/upload/'+_images[3].images,num.toString()+"+");
      //     }),
    );
  }
  chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile?.path));
      uploadFile();
    });
    if (pickedFile.path == null) retrieveLostData();

    // uploadFile();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file.path));
      });
    } else {
      print(response.file);
    }
  }

  Future uploadFile() async {
    print("hiiii");
    _file = File(_image[counter].path);
    print("hiiii");
    counter++;
    // print(image_file.path);
    if (_file == Null) {
      return;
    }
    print("hiiii");
    String base64 = base64Encode(_file.readAsBytesSync());
    String imagename = _file.path.split('/').last;
    print("hiiii");
    print(imagename);
    var url = 'https://192.168.1.8/testlocalhost/EXP_Image.php';
    // final uri=Uri.parse("https://192.168.2.111/testlocalhost/signup.php");
    var response = await http.post(url, body: {

      "phone": widget.phone,
      "imagename": imagename,
      "image64": base64,
    });
    String massage= json.decode(response.body);
    print(massage);
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
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>WelcomeScreen()));
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