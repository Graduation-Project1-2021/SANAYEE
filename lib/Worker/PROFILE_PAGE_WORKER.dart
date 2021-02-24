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

import 'GET_IMGS.dart';
import 'IMG_BIG.dart';
String  name="";
String  phone="";
String  image="";
String  Work="";
String  Experiance="";
String  Information="";
String  token="";
String IP4="192.168.1.8";

class PROFILE extends StatefulWidget {
  final name;
   PROFILE({this.name});
  _PROFILE createState() =>  _PROFILE();
}
class  _PROFILE extends State< PROFILE> {
  void initState() {
    super.initState();
  }
  Future getWorker()async{
    var url='https://'+IP4+'/testlocalhost/getworker.php';
    var ressponse=await http.post(url,body: {
      "name": widget.name,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  @override

  Widget build(BuildContext context) {
    return  Directionality( textDirection: TextDirection.rtl,
       child:Scaffold(
         // appBar: PreferredSize(
         // preferredSize: Size.fromHeight(0.0), // here the desired height
         //  child: AppBar(
         //    flexibleSpace: Image(
         //      image: AssetImage('assets/icons/ho_top.jpg'),
         //      fit: BoxFit.cover,
         //    ),
         //  ),),
        // backgroundColor: Colors.lightBlueAccent,
        body: Form(
         // child: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Stack(
              children:[Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/icons/ho.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 40, 0, 30),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(100, 0, 1, 0),
                        child: IconButton(
                          alignment: Alignment.topRight,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));},
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                      ),
                      // Container(
                      //   child: SingleChildScrollView(
                      //     child:Text("ggff"),
                      //   ),
                      // )
                      Container(
                        margin: EdgeInsets.fromLTRB(1, 0, 210, 0),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SettingPage(name:name,phone:phone,image:image,Work:Work,Experiance:Experiance,Information:Information,token:token)));},
                          icon: Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 100,right: 20),
                  child: InkWell(
                    child: RadialProgress(
                      width: 4,
                      progressColor: Colors.white,
                      goalCompleted: 0.7,
                      child:CircleAvatar(
                        backgroundImage: NetworkImage('https://'+IP4+'/testlocalhost/upload/'+image),
                        radius: 45.0,
                      ),
                    ),
                  ),),
                  Container(
                    height: 500,
                    margin: EdgeInsets.only(top:240),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),

                   child:FutureBuilder(
                  future: getWorker(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          name=snapshot.data[0]['name'];
                          phone=snapshot.data[index]['phone'];
                          image=snapshot.data[index]['image'];
                          Work=snapshot.data[index]['Work'];
                          Experiance=snapshot.data[index]['Experiance'];
                          Information=snapshot.data[index]['Information'];
                          token=snapshot.data[index]['token'];
                             print(snapshot.data[index]['name']);
                          return Profile_worker(name:snapshot.data[index]['name'],phone:snapshot.data[index]['phone'],image:snapshot.data[index]['image'],Work:snapshot.data[index]['Work'],Experiance:snapshot.data[index]['Experiance'],Information:snapshot.data[index]['Information'],token:snapshot.data[index]['token']);
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
       ], ),],),),),);



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
  @override
  void initState() {
    super.initState();
  }
  Future getImages() async {
    var url = 'https://'+IP4+'/testlocalhost/Show_EXP.php';
    var ressponse = await http.post(url, body: {
      "phone": '+978456',
    });
    // ignore: deprecated_member_use
    // var responsebody = json.decode(ressponse.body);
    // print(responsebody);
    return json.decode(ressponse.body);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children:<Widget>[

        // Stack(children: [
        //   // Positioned(
        //   //   top: -20,
        //   //   bottom: 0.0,
        //   //   child:
        //   //   Container(
        //   //     margin: EdgeInsets.fromLTRB(100, 0, 1, 0),
        //   //     child: IconButton(
        //   //       alignment: Alignment.topRight,
        //   //       onPressed: () {
        //   //         Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));},
        //   //       icon: Icon(
        //   //         Icons.arrow_back,
        //   //         color: Colors.black,
        //   //         size: 30.0,
        //   //       ),
        //   //     ),
        //   //   ),
        //   // ),
        //
        // ],),

        SingleChildScrollView(
          child: Column(
          children: <Widget>[
        Container(
          height: 400,
          margin: EdgeInsets.only(top:50),
          child:FutureBuilder(
            future: getImages(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    int num =snapshot.data.length-4;
                    return myAlbum('https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+1]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+2]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+3]['images'],num.toString()+"+");
                  },
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),

      ],
    ),),], );
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
    var url = 'https://'+IP4+'/testlocalhost/EXP_Image.php';
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
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>Get_Images(phone:widget.phone,name:widget.name)));
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
