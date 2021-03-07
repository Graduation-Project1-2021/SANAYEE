import 'package:flutterphone/screens/signuser_screen.dart';
import 'package:flutterphone/screens/welcome_screen.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_cloud_messaging/firebase_cloud_messaging.dart';
import 'package:flutterphone/Inside_the_app/inside.dart';
import 'package:flutterphone/components/already_have_an_account_acheck.dart';
import 'package:flutterphone/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/components/pin_entry_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

import 'PROFILE_PAGE_WORKER.dart';
String IP4="192.168.1.8";
String _verificationCode;
String smscode ;
FocusNode myFocusNode = new FocusNode();
String country_id;
List<String>country=["جنين","نابلس","طولكرم","رام الله","طوباس",""];
class SettingsUI extends StatefulWidget {

  final  name;
  final  phone;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;
  SettingsUI({this.name, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token});

  _ProfilePage createState() => _ProfilePage();
}
class _ProfilePage extends State<SettingsUI> {

  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child,
        );
      },

      // localizationsDelegates: [
      // GlobalCupertinoLocalizations.delegate,
      // GlobalMaterialLocalizations.delegate,
      // GlobalWidgetsLocalizations.delegate,
      // ],
      // supportedLocales: [
      //   Locale("en", "US"),
      //   Locale('ar', 'AE')
      // ],

      debugShowCheckedModeBanner: false,
      title: "Profile",
      home: EditProfilePage(name:widget.name,phone:widget.phone,image:widget.image,Work:widget.Work,Experiance:widget.Experiance,Information:widget.Information,token:widget.token),
    );
  }

}

class EditProfilePage extends StatefulWidget {
  final  name;
  final  phone;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;

  EditProfilePage({this.name, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController phone_Num = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController workcontroller = TextEditingController();
  TextEditingController experController = TextEditingController();
  TextEditingController infoController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  void initState() {
    super.initState();
  }

  bool showPassword = false;
  PickedFile image_file;
  File _file;
  bool choose=false;
  final ImagePicker image_picker =ImagePicker();
  final formKey = new GlobalKey<FormState>();
  Widget build(BuildContext context) {
    nameController.text=widget.name;
    workcontroller.text=widget.Work;
    experController.text=widget.Experiance;
    infoController.text=widget.Information;
    debugShowCheckedModeBanner: false;
    Size size = MediaQuery.of(context).size;
    bool _value1 = false;
    bool _value2 = false;
    String code = "";
    String pass="";
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor:Color(0xFF1C1C1C),
        // appBar:AppBar(
        //   backgroundColor:Color(0xFFF3D657),
        //   // elevation: 0,
        //   // leading:
        //     // IconButton(
        //     // alignment: Alignment.topRight,
        //     // onPressed: () {
        //     //   Navigator.of(context).push(
        //     //       MaterialPageRoute(
        //     //           builder: (BuildContext context) =>
        //     //               PROFILE(name:widget.name)));
        //     //
        //     // },
        //     // icon: Icon(
        //     //   Icons.arrow_back,
        //     //   color: Colors.white,
        //     //   size: 30.0,
        //     // ),
        //   ),
        body: Form(key: formKey,
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                  GestureDetector(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                      height:MediaQuery.of(context).size.height * 0.3,
                      child: CustomPaint(
                        painter: CurvePainter(false),
                        // child:Column(children: [
                        //
                        // ],)

                            child:Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top:40),
                                child:IconButton(
                                    alignment: Alignment.topRight,
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  PROFILE(name:widget.name)));

                                    },
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: 30.0,
                                    ),),),
                            Container(margin:EdgeInsets.only(top:100),child: image_profile(),),
                ],),),),),
                GestureDetector(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Container(
                        height: 100,
                        color: Colors.transparent,
                        padding: EdgeInsets.only(top: 5),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0,),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                      children: <Widget>[

                                        Container(
                                          margin: EdgeInsets.fromLTRB(0,40,40,15),
                                          width: size.width * 0.33,
                                          height: 60,
                                          child: TextFormField(
                                            onChanged: (value) {
                                              nameController.text=value;
                                              print(nameController.text);
                                            },
                                            controller: nameController,
                                            cursorColor: Colors.grey[600],
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Changa',
                                            ),
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey.withOpacity(0.1),
                                              enabledBorder: new OutlineInputBorder(
                                                borderRadius: new BorderRadius.circular(28.0),
                                                borderSide:  BorderSide(color:Colors.grey.withOpacity(0.1)),

                                              ),
                                              focusedBorder: new OutlineInputBorder(
                                                borderRadius: new BorderRadius.circular(28.0),
                                                borderSide:  BorderSide(color:Colors.grey.withOpacity(0.1)),

                                              ),
                                              labelText: ('الاسم الأول'),
                                              floatingLabelBehavior: FloatingLabelBehavior.always,
                                              labelStyle: TextStyle(fontSize: 22.0,fontFamily: 'Changa',color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],),
                                            ),
                                          ),
                                        ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0,40,10,15),
                                        width: size.width * 0.44,
                                        height: 60,
                                        child: TextFormField(
                                          onChanged: (value) {
                                              nameController.text=value;
                                            print(nameController.text);
                                          },
                                          controller: nameController,
                                          cursorColor: Colors.grey[600],
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Changa',
                                          ),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.grey.withOpacity(0.1),
                                            enabledBorder: new OutlineInputBorder(
                                              borderRadius: new BorderRadius.circular(28.0),
                                              borderSide:  BorderSide(color:Colors.grey.withOpacity(0.1)),

                                            ),
                                            focusedBorder: new OutlineInputBorder(
                                              borderRadius: new BorderRadius.circular(28.0),
                                              borderSide:  BorderSide(color:Colors.grey.withOpacity(0.1)),

                                            ),
                                            labelText: ('اسم العائلة '),
                                            floatingLabelBehavior: FloatingLabelBehavior.always,
                                            labelStyle: TextStyle(fontSize: 22.0,fontFamily: 'Changa',color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],),
                                          ),
                                        ),
                                      ),
                                      ],),
                                      Container(
                                        height: 70,
                                        margin: EdgeInsets.fromLTRB(0,10,0,15),
                                        padding: EdgeInsets.symmetric(horizontal:0,),
                                        width: size.width * 0.8,
                                        child: TextFormField(
                                          onChanged: (value) {
                                            infoController.text=value;
                                            print(infoController.text);
                                          },
                                          controller: infoController,
                                          maxLines: 20,
                                          cursorColor: Colors.grey[600],
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Changa',
                                          ),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.grey.withOpacity(0.1),
                                            enabledBorder: new OutlineInputBorder(
                                              borderRadius: new BorderRadius.circular(30.0),
                                              borderSide:  BorderSide(color:Colors.grey.withOpacity(0.1)),

                                            ),
                                            focusedBorder: new OutlineInputBorder(
                                              borderRadius: new BorderRadius.circular(30.0),
                                              borderSide:  BorderSide(color:Colors.grey.withOpacity(0.1)),

                                            ),
                                            labelText: ('المعلومات'),
                                            floatingLabelBehavior: FloatingLabelBehavior.always,
                                            labelStyle: TextStyle(fontSize: 22.0,fontFamily: 'Changa',color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 100,
                                        margin: EdgeInsets.fromLTRB(0,10,0,0),
                                        width: size.width * 0.8,
                                        child: TextFormField(
                                          onChanged: (value) {
                                            experController.text=value;
                                            print(experController.text);
                                          },
                                          maxLines: 20,
                                          cursorColor: Colors.grey[600],
                                          textAlign: TextAlign.right,
                                          controller: experController,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Changa',
                                          ),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.grey.withOpacity(0.1),
                                            enabledBorder: new OutlineInputBorder(
                                              borderRadius: new BorderRadius.circular(40.0),
                                              borderSide:  BorderSide(color:Colors.grey.withOpacity(0.1)),

                                            ),
                                            focusedBorder: new OutlineInputBorder(
                                              borderRadius: new BorderRadius.circular(40.0),
                                              borderSide:  BorderSide(color:Colors.grey.withOpacity(0.1)),

                                            ),
                                            labelText: ('خبرة وتجارب سابقة'),
                                            floatingLabelBehavior: FloatingLabelBehavior.always,
                                            labelStyle: TextStyle(fontSize: 22.0,fontFamily: 'Changa',color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 130,right: 130,top:50),
                                  width: 150,
                                  child: FloatingActionButton(
                                    backgroundColor:Color(0xFFECCB45),
                                    splashColor: Colors.transparent,
                                  onPressed: (){
                                    editpersonalinfo();
                                    _showMyDialog();
                                  },
                                  tooltip: 'Increment',
                                  child: Icon(Icons.edit),
                                   ),
                                  // child:RaisedButton(
                                  //   onPressed: () {
                                  //     editpersonalinfo();
                                  //     _showMyDialog();
                                  //   },
                                  //   color:Color(0xFFECCB45),
                                  //   padding: EdgeInsets.symmetric(vertical: 10),
                                  //   elevation: 2,
                                  //   //shape: ,
                                  //   // shape: RoundedRectangleBorder(
                                  //   //     borderRadius: BorderRadius.circular(25)),
                                  //   child:Icon(Icons.edit),
                                  //   // child: Text(
                                  //   //   "حفظ التعديل",
                                  //   //   style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600,fontFamily: 'Changa',color: Colors.white,),
                                  //   // ),
                                  // ),
                                ),
                              ],
                            ),
                          ),),
                      ),
                    )
                 ],),),
        ),),);
  }
  Future editpersonalinfo ()async{


    // var url = 'https://192.168.2.100/testlocalhost/edit.php';
    var url = 'https://'+IP4+'/testlocalhost/edit.php';
    if(image_file==null){
      print("image null");
      var response = await http.post(url, body: {

        //"phone":phone_Num.text,
        "name":nameController.text,
        // "Work":workcontroller.text,
        "Information":infoController.text,
        "Experiance":experController.text,
        "imagename": widget.image,
        "image64": "",

      });
      String massage = json.decode(response.body);
      print(massage);}
    else{
      String base64;
      String imagename;
      _file = File(image_file.path);
      base64 = base64Encode(_file.readAsBytesSync());
      imagename = _file.path.split('/').last;
      var response = await http.post(url, body: {
        //"phone":phone_Num.text,
        "name":nameController.text,
        // "Work":workcontroller.text,
        "Information":infoController.text,
        "Experiance":experController.text,
        "imagename": imagename,
        "image64": base64,
      });
      print("update with image");
    }}

  Widget image_profile(){
    return Center(
      child:Stack (children: <Widget>[
        CircleAvatar(
          backgroundImage: image_file==null? NetworkImage('https://'+IP4+'/testlocalhost/upload/'+widget.image):FileImage(File(image_file.path)),
          radius: 60.0,
        ),
        Positioned(
          bottom:10.0,
          right:3.0,
          child: InkWell(
            onTap:(){
              showModalBottomSheet(context: context, builder: (builder) => buttom_camera(),);
            },
            child:Icon(Icons.camera_alt,color: Colors.grey,size: 35.0,),),),
      ],
      ),);
  }
  Widget buttom_camera(){
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
      child: Column(children: <Widget>[
        Text('Choose Profile Photo'),
        SizedBox(height: 20.0,),
        Row(mainAxisAlignment:MainAxisAlignment.center,children: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.camera_alt),
            onPressed: (){
              takePhoto(ImageSource.camera);
            },
            label: Text("Camera"),),
          FlatButton.icon(
            icon: Icon(Icons.image),
            onPressed: (){
              takePhoto(ImageSource.gallery);
            },
            label: Text("Gallery"),),
        ],),
      ],),
    );
  }
  void takePhoto(ImageSource source)async{
    final file =await image_picker.getImage(
      source:source,
    );
    setState(() {
      if(file==Null){image_file=Image.asset("assets/icons/signup.png") as PickedFile;}
      else{image_file=file;}
    });
  }
  //SignIn
  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            // FirebaseAuth.instance.signOut();
            print(snapshot.data.toString());
            return InsideAPP();
          } else {
            return SignuserScreen();
          }
        });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      //this means the user must tap a button to exit the Alert Dialog
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(right: 40,left:10,top: 30),
          titlePadding: EdgeInsets.only(right: 50,left:50,top: 30),
          content: Text('تم تعديل المعلومات بنجاح ',
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
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text('حسنا',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontFamily: 'Changa',
                  ),),

              ),),
          ],
        );
      },
    );
  }

}
class CurvePainter extends CustomPainter {

  bool outterCurve;

  CurvePainter(this.outterCurve);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(0xFFF3D657);
    paint.style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.5, outterCurve ? size.height + 110 : size.height - 110, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}