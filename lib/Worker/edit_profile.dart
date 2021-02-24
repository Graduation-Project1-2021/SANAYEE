import 'package:flutter/material.dart';
import 'package:flutterphone/Worker/setting_worker.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

var nameController = "";
String IP4="192.168.1.8";

FocusNode myFocusNode = new FocusNode();
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


  bool showPassword = false;
  PickedFile image_file;
  File _file;
  bool choose=false;
  final ImagePicker image_picker =ImagePicker();
  TextEditingController phone_Num = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController workcontroller = TextEditingController();
  TextEditingController experController = TextEditingController();
  TextEditingController infoController = TextEditingController();
  TextEditingController aboutController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // nameController.text=widget.name;
    // workcontroller.text=widget.Work;
    // experController.text=widget.Experiance;
    // infoController.text=widget.Information;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => SettingPage(name:widget.name,phone:widget.phone,image:widget.image,Work:widget.Work,Experiance:widget.Experiance,Information:widget.Information,token:widget.token)));
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.purple,
          ),
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(
        //       Icons.settings,
        //       color: Colors.purple,
        //     ),
        //     onPressed: () {
        //       Navigator.of(context).push(MaterialPageRoute(
        //           builder: (BuildContext context) => SettingsPage()));
        //     },
        //   ),
        // ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: <Widget>[
              Text(
                "تعديل المعلومات الشخصية",

                  textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold,fontFamily: 'Changa',color: Colors.grey[600],),
              ),
              SizedBox(
                height: 15,
              ),
              image_profile(),
              SizedBox(
                height: 40,
              ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
          child:TextFormField(
            textDirection: TextDirection.rtl,
            controller: nameController,
            focusNode: myFocusNode,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,fontFamily: 'Changa',color: Colors.grey[600]),
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(const Radius.circular(20))
                ),
                focusedBorder:OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              labelText: "الاسم",
                labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],
                )
            ),
            cursorColor:Colors.grey[600],
          ),),

              SizedBox(
                height: 15,
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                height: 110,
              child:TextFormField(
                maxLines: 10,
                textDirection: TextDirection.rtl,
                controller: infoController,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,fontFamily: 'Changa',color: Colors.grey[600]),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(const Radius.circular(20))
                  ),
                  focusedBorder:OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  labelText: "المعلومات",
                    labelStyle: TextStyle(
                      color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],
                    )
                ),
                cursorColor:Colors.grey[600],
              ),),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                // padding: EdgeInsets.symmetric(horizontal: 10, vertical:2),
                height: 130,
               child:FocusScope(
                 node: new FocusScopeNode(),
              child:TextFormField(
                enableInteractiveSelection: false, // will disable paste operation
                enabled: true,
                // obscureText: widget.Experiance,
                maxLines: 10,
                textDirection: TextDirection.rtl,
                controller:experController,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,fontFamily: 'Changa',color: Colors.grey[600]),
                decoration: InputDecoration(
                      // border:InputBorder.none,
                    border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(const Radius.circular(20))
                    ),
                  focusedBorder:OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  labelText: "الخبرة",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    // prefixText: widget.Experiance,
                    labelStyle: TextStyle(
                      color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],
                    )
                ),
                cursorColor:Colors.grey[600],
              ),),),
              // TextField(
              //   textDirection: TextDirection.rtl,
              //   controller:workcontroller ,
              //   style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,fontFamily: 'Changa',color: Colors.grey[600],),
              //   decoration: InputDecoration(
              //     hintText: "المهنة",
              //   ),
              // ),
             // buildTextField("Full Name", "Dor Alex", false),
             // buildTextField("E-mail", "alexd@gmail.com", false),
             // buildTextField("Password", "********", true),
             // buildTextField("Location", "TLV, Israel", false),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    onPressed: () {
                       editpersonalinfo();
                    },
                    color: Colors.purple,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "حفظ التعديل",
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,fontFamily: 'Changa',color: Colors.grey[600],),
                    ),
                  ),
                  OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {


                    },
                    child: Text("الغاء",
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,fontFamily: 'Changa',color: Colors.grey[600],),
                  ),),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
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
     print("update without image");}
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
}
