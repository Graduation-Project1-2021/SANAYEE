
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/Worker/setting_worker.dart';
import 'package:flutterphone/commons/radial_progress.dart';
import 'package:flutterphone/commons/rounded_image.dart';
import 'package:flutterphone/screens/login_screen.dart';
import 'package:flutterphone/screens/welcome_screen.dart';
import 'package:flutterphone/styleguide/text_style.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:image_picker/image_picker.dart';
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
    // ignore: deprecated_member_use
    // var responsebody = json.decode(ressponse.body);
    // print(responsebody);
    if(ressponse.statusCode==200) {
      final List<Images>image = imagesFromJson(ressponse.body);
      return image;
    }
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
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
     return Directionality(
        textDirection: TextDirection.rtl,
        child:InkWell(
         child:Column(
          children: <Widget>[
             Container(
               child: Stack(
             children: <Widget>[
               Container(
                 margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  height: 150,
                 decoration: BoxDecoration(
                   image: DecorationImage(
                     image: AssetImage('assets/icons/ho_but.jpg'),
                     fit: BoxFit.cover,
                   ),
                 ),
               ),
               Container(
                 margin: EdgeInsets.fromLTRB(0, 5, 0, 30),
                 child: Row(
                   children: <Widget>[
                     Container(
                       margin: EdgeInsets.fromLTRB(100, 0, 1, 0),
                       child: IconButton(
                         alignment: Alignment.topRight,
                         onPressed: () {
                           Navigator.of(context).push(
                               MaterialPageRoute(
                                   builder: (BuildContext context) =>
                                       // LoginScreen(name:widget.name,phone:widget.phone,image:widget.image,Work:widget.Work,Experiance:widget.Experiance,Information:widget.Information,token:widget.token)));
                                          LoginScreen()));},
                         icon: Icon(
                           Icons.arrow_back,
                           color: Colors.white,
                           size: 30.0,
                         ),
                       ),
                     ),
                     Container(
                       margin: EdgeInsets.fromLTRB(1, 0, 210, 0),
                       child: IconButton(
                         onPressed: () {
                           Navigator.of(context).push(
                               MaterialPageRoute(
                                   builder: (BuildContext context) =>
                                       SettingPage(name:widget.name,phone:widget.phone,image:widget.image,Work:widget.Work,Experiance:widget.Experiance,Information:widget.Information,token:widget.token)));
                         },
                         icon: Icon(
                           Icons.settings,
                           color: Colors.white,
                           size: 30.0,
                         ),
                       ),),
                   ],
                 ),
               ),
             Positioned(
               top: 70,
               right: 120,
               child: InkWell(
                          child: RadialProgress(
                            width: 4,
                            progressColor: Colors.white,
                            goalCompleted: 0.7,
                            child:CircleAvatar(
                                  backgroundImage: NetworkImage('https://192.168.1.8/testlocalhost/upload/'+widget.image),
                                  radius: 60.0,
                            ),
                          ),
             ),),
             // Positioned(
             //   child:CircleAvatar(
             //     backgroundImage: NetworkImage('https://192.168.1.8/testlocalhost/upload/'+widget.image),
             //     radius: 60.0,
             //   ),
             //   ),
             Container(
               margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
             height: 300,
              // child: Text(widget.name,),
          ),
             ],),),
            Show(phone:'+978456'),
            // Container(
            //
            //   margin: EdgeInsets.only(top: 2,bottom: 100),
            //   height: 260,
            //   child:ListView.builder(
            //       itemCount: null == _images?0:_images.length,
            //       itemBuilder: (context,index) {
            //         int num = _images.length-4;
            //         return myAlbum('https://192.168.1.8/testlocalhost/upload/'+_images[0].images, 'https://192.168.1.8/testlocalhost/upload/'+_images[1].images, 'https://192.168.1.8/testlocalhost/upload/'+_images[2].images, 'https://192.168.1.8/testlocalhost/upload/'+_images[3].images,num.toString()+"+");
            //       }),
            // ),
            Container(
              padding: EdgeInsets.all(4),

              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: _image.length + 1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return index == 0 ? Center(
                      child: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () =>
                              chooseImage()),
                    )
                        : GestureDetector(
                        onTap: (){print("Container clicked");},
                    child:Container(
                      margin: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(_image[index - 1]),
                              fit: BoxFit.cover)),
                    ),);
                  }),

            )
          ],
    ),),);
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
                itemCount:1,
                itemBuilder: (context,index) {
                  int num = _image.length-4;
                   if(_image.length==0|| _image==null){
                     return CircularProgressIndicator();
                   }

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
                    // onTap: (){
                    //   Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>Screen()));
                    // },
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