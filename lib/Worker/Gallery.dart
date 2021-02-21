
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/Worker/setting_worker.dart';
import 'package:flutterphone/commons/radial_progress.dart';
import 'package:flutterphone/commons/rounded_image.dart';
import 'package:flutterphone/screens/login_screen.dart';
import 'package:flutterphone/styleguide/text_style.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'IMG_BIG.dart';

List<Images> imagesFromJson(String str) => List<Images>.from(json.decode(str).map((x) => Images.fromJson(x)));

String imagesToJson(List<Images> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Images {
  String images;
  String phone;

  Images({
    this.images,
    this.phone,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    images: json["images"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "images": images,
    "phone": phone,
  };
}

class Gallery  extends StatefulWidget {
  // final  name;
  //  final  phone;
  // final  image;
  // final  Work;
  // final  Experiance;
  // final  Information;
  // final  token;
  //
  // Profile_worker({this.name, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token});
  //  Gallery({this.phone});
  @override
  _Gallery createState() => _Gallery();
}

class _Gallery extends State<Gallery> {
  bool uploading = false;
  double val = 0;
  File uploadimage;
  // File _file;
  List<File> _image = []; //هاي هي
  int counter = 0;
  File _file;
  final picker = ImagePicker();
  @override
  Future <List<Images>>getImages()async{
    var url='https://192.168.1.8/testlocalhost/Get_Images_EXP.php';
    var ressponse=await http.post(url,body: {
      "phone": '+978456',
    });
    // ignore: deprecated_member_use
    // var responsebody = json.decode(ressponse.body);
    // print(responsebody);
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
      print(_images.length);
    });
  }
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child:Scaffold(
        body:Column(
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    height: 200,
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
                        ),],),),
                ],),),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    child: Container(
                      height: 400,
                      margin: EdgeInsets.only(top: 200),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: null == _images?0:_images.length,
                        itemBuilder: (context, index) {
                          return RawMaterialButton(
                            onPressed: () {
                              Navigator.push(context,MaterialPageRoute(
                                  builder: (BuildContext context) =>IMG(imageName:_images[index].images,index:index)));},
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => DetailsPage(
                            //       imagePath: _images[index].imagePath,
                            //       title: _images[index].title,
                            //       photographer: _images[index].photographer,
                            //       price: _images[index].price,
                            //       details: _images[index].details,
                            //       index: index,
                            //     ),
                            //   ),
                            // );

                            child: Hero(
                              tag: 'logo$index',
                              child: Container(
                                // child: Text(_image[index].images),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(image: NetworkImage('https://192.168.1.8/testlocalhost/upload/'+_images[index].images),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        // itemCount: _image.length,
                      ),
                    ),
                  ),],),),
               ],),),);
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

      // "phone": widget.phone,
      "imagename": imagename,
      "image64": base64,
    });
    String massage= json.decode(response.body);
    print(massage);
  }
}