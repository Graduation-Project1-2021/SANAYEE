import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/Chatworker/chatListworker.dart';
import 'package:flutterphone/Worker/change_pass.dart';
import 'package:flutterphone/Worker/edit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import '../constants.dart';
import 'package:flutterphone/Worker/PROFILE_PAGE_WORKER.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

import 'orders_workers.dart';
String IP4="192.168.1.8";
//import 'edit_profile.dart';
//import 'changePassword.dart';
FocusNode myFocusNode = new FocusNode();
bool Pass_Null=true;
bool Pass_R=true;
bool Pass_Mismatch=true;
bool Pass_S=true;
bool Pass_old=true;
bool Pass_old_notC=true;
String pass="";

bool _showPassword1 = false;
bool _showPassword2 = false;
bool _showPassword3 = false;

class SettingPage extends StatefulWidget {

  final  name;
  final  phone;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;
  final lat;
  final lng;

  SettingPage({this.lat,this.lng,this.name, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token});

  get username => null;

  @override
  _SettingsPageState createState() => _SettingsPageState();

}
class _SettingsPageState extends State<SettingPage> {
  @override
  bool isSwitched1 = false;
  bool isSwitched2 = false;
  bool setting=true;
  bool change_pass=false;
  TextEditingController password = TextEditingController();
  TextEditingController newpass = TextEditingController();
  TextEditingController confirmpass = TextEditingController();
  bool showPassword = false;

  @override
  void _togglevisibility1() {
    setState(() {
      _showPassword1 = !_showPassword1;
    });
  }

  void _togglevisibility2() {
    setState(() {
      _showPassword2 = !_showPassword2;
    });
  }

  void _togglevisibility3() {
    setState(() {
      _showPassword3 = !_showPassword3;
    });
  }
  int _selectedIndex=0;
  final formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    return  Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        bottomNavigationBar:Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
          ]),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                  rippleColor: Colors.grey[300],
                  hoverColor: Colors.grey[100],
                  gap: 8,
                  activeColor: Colors.black,
                  iconSize: 24,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  duration: Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.grey[100],
                  tabs: [
                    GButton(
                      icon: Icons.home,
                      text: 'الرئيسية',
                      textStyle:TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.black,
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GButton(
                      icon: Icons.person,
                      text: 'حسابي',
                      textStyle:TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.black,
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GButton(
                      onPressed: (){
                      },
                      icon: Icons.calendar_today,
                      text: 'طلباتي',
                      textStyle:TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.black,
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GButton(
                      onPressed: (){

                      },
                      icon: Icons.mark_chat_unread,
                      text: 'شات',
                      textStyle:TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.black,
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GButton(
                      icon: Icons.settings,
                      text: 'الإعدادت',
                      textStyle:TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.black,
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      _selectedIndex = index;
                      if(index==2){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => order_worker()));
                      }
                      // if(index==3){
                      //   DateTime date=DateTime.now();
                      //  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => accept_order(phone: phone,time:date,)));
                      // }
                      if(index==4){
                        DateTime date=DateTime.now();
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SettingPage()));
                      }


                    });
                  }
              ),
            ),
          ),),
        body: Form(
          // child:SingleChildScrollView(
            child: Column(
            children: [
              SizedBox(height: 200,),
              update(context,'تعديل المعلومات الشخصية'),
              change(context,'تغيير كلمة السر'),

              SizedBox(height: 10,),
              // Container(
              //   child: Divider(
              //     thickness: 1.0,
              //     color: Colors.black54.withOpacity(0.2),
              //   ),
              // ),
              SizedBox(height: 10,),
              statues(context,'الحالة'),
              _notification(context,'الإشعارات'),
              // Container(
              //   child: Divider(
              //     thickness: 1.0,
              //     color: Colors.black54.withOpacity(0.2),
              //   ),
              // ),
              SizedBox(height: 30,),
              logout(context, 'تسجيل الخروج'),

            ],
         ),

        ),),);
  }
  Directionality notification(BuildContext context, String title){
    return Directionality(textDirection: TextDirection.ltr,
      child:GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 40,top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 0),
                margin: EdgeInsets.symmetric(horizontal: 0),
                width: 95,
                height: 40,
                child:LiteRollingSwitch(
                  //initial value
                  value: false,
                  // textOn: 'disponible',
                  // textOff: 'ocupado',
                  colorOn: Colors.green,
                  colorOff: Colors.grey.withOpacity(0.3),
                  iconOn: Icons.done,
                  iconOff: Icons.notifications_off_rounded,
                  onChanged: (bool state) {
                  },
                ),),
              Text(
                title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[600],
                  fontFamily: 'Changa',
                ),
              ),
            ],
          ),),
      ),);
  }
  Directionality Dark(BuildContext context, String title) {
    return Directionality(textDirection: TextDirection.ltr,
      child:GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 30,top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 0),
                margin: EdgeInsets.symmetric(horizontal: 0),
                width: 95,
                height: 40,
                child:LiteRollingSwitch(
                  //initial value
                  value: false,
                  // textOn: 'disponible',
                  // textOff: 'ocupado',
                  colorOn: MY_YELLOW,
                  colorOff: Colors.grey.withOpacity(0.3),
                  iconOn: Icons.wb_sunny_outlined,
                  iconOff: Icons.brightness_2_rounded,
                  onChanged: (bool state) {
                  },
                ),),
              Text(
                title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[600],
                  fontFamily: 'Changa',
                ),
              ),
            ],
          ),),
      ),);

  }
  GestureDetector logout(BuildContext context, String title){
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(left: 250,right: 30,top: 10,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.logout,
              color: Colors.grey,
              size: 25,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.grey[600],
                fontFamily: 'Changa',
              ),
            ),
          ],
        ),),
    );
  }
  Directionality _notification(BuildContext context, String title){
    return Directionality(textDirection: TextDirection.ltr,
      child:GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 30,top:10,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Switch(
                value: isSwitched2,
                onChanged: (value) {
                  setState(() {
                    isSwitched2 = value;
                  });
                },
                activeTrackColor:Colors.green,
                activeColor:Colors.white,
                inactiveTrackColor: Colors.grey.withOpacity(0.3),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[600],
                  fontFamily: 'Changa',
                ),
              ),
            ],
          ),),
      ),);
  }
  Directionality statues(BuildContext context, String title){
    return Directionality(textDirection: TextDirection.ltr,
      child:GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 30,top:10,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Switch(
                value: isSwitched1,
                onChanged: (value) async{
                  print(value);
                  isSwitched1 = value;
                  await updatestate();
                  setState(() {
                  });
                },
                activeTrackColor:Colors.green,
                activeColor:Colors.white,
                inactiveTrackColor: Colors.grey.withOpacity(0.3),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[600],
                  fontFamily: 'Changa',
                ),
              ),
            ],
          ),),
      ),);
  }
  Directionality argent(BuildContext context, String title){
    return Directionality(textDirection: TextDirection.ltr,
      child:GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 40,top: 10,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Switch(
                value: isSwitched2,
                onChanged: (value) {
                  setState(() {
                    isSwitched2 = value;
                  });
                },
                activeTrackColor:Colors.green,
                activeColor:Colors.white,
                inactiveTrackColor: Colors.grey.withOpacity(0.3),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[600],
                  fontFamily: 'Changa',
                ),
              ),
            ],
          ),),
      ),
    );
  }
  GestureDetector update(BuildContext context, String title) {
    return GestureDetector(
      // onTap: () {Navigator.push(context,
      //   MaterialPageRoute(builder: (context) => SettingsUI(name:name,phone:phone,image:image,Work:Work,Experiance:Experiance,Information:Information,token:token)),
      // );},
      child: Padding(
        padding: const EdgeInsets.only(left: 160,right: 30,top: 5,bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.person,
              color: Colors.grey,
              size: 25,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.grey[600],
                fontFamily: 'Changa',
              ),
            ),
          ],
        ),
      ),
    );
  }
  GestureDetector change(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          change_pass=true;
          setting=false;
        });
      },

      child: Padding(
        padding: const EdgeInsets.only(left: 240,right: 30,top: 5,bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.lock,
              color: Colors.grey,
              size: 25,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.grey[600],
                fontFamily: 'Changa',
              ),
            ),
          ],
        ),
      ),
    );
  }
  Column changePass(BuildContext context, String title) {
  }
  Future editpassword() async {
    print(widget.name);
    print(password.text);
    print(newpass.text);
    var url = 'https://'+IP4+'/testlocalhost/edit_pass.php';
    var response = await http.post(url, body: {
      "name":widget.name,
      "pass":password.text,
      "newpass": newpass.text,
    });
    //print(response);
    String massage= json.decode(response.body);
    print(massage);
    if(massage=='old pass not correct'){
      setState(() {
        Pass_old_notC=false;
        Pass_old=true;
      });
    }
    else{
      Pass_old_notC=true;
    }
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      //this means the user must tap a button to exit the Alert Dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(""),
          actions: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(100, 40, 1, 100),
                        child: IconButton(
                          alignment: Alignment.topRight,
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PROFILE(name:widget.name)));

                          },
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                      ),


                      Container(
                        margin: EdgeInsets.fromLTRB(80, 130, 10, 1),

                      ),
                      Container(
                        height: 627.5,
                        margin: EdgeInsets.only(top:170),
                        decoration: BoxDecoration(
                          color: Color(0xFF1C1C1C),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        child:Column(
                          children:[
                            Container(
                              margin: EdgeInsets.only(top: 140,left: 40,right: 40),
                              height: 60,
                              child:TextFormField(
                                // textDirection: TextDirection.rtl,
                                controller: password,
                                obscureText: !_showPassword1,
                                validator: (value) {
                                  pass=value;
                                  if (value.isEmpty) {
                                    Pass_old=false;
                                    Pass_old_notC=true;
                                    return null;
                                  } else {
                                    Pass_old=true;
                                    return null;
                                  }
                                },
                                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600,fontFamily: 'Changa',color: Colors.grey[600],),
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
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  labelText: "كلمة السر القديمة",
                                  labelStyle:  TextStyle(fontSize: 22.0,fontFamily: 'Changa',color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],),
                                  suffixIcon: IconButton(
                                    icon: Icon(_showPassword1 ? Icons.visibility : Icons.visibility_off, color: Colors.grey[600],),
                                    color: Colors.cyan,
                                    onPressed:_togglevisibility1,
                                  ),//
                                ),
                                cursorColor:Colors.grey[600],
                              ),),
                            Pass_old ? Container(
                              margin: EdgeInsets.fromLTRB(255, 0, 0, 0),
                              child: Text('',textAlign:TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Changa',
                                  color: Colors.red,

                                ),),
                            ): Container(
                              margin: EdgeInsets.fromLTRB(230, 0, 0, 0),
                              child: Text('هذا الحقل مطلوب !',textAlign:TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Changa',
                                  color: Colors.red,

                                ),),
                            ),

                            Container(margin: EdgeInsets.symmetric(vertical: 5)),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              height: 60,
                              child:TextFormField(
                                validator: (value) {
                                  pass=value;
                                  if (value.isEmpty) {
                                    Pass_Null=false;
                                    Pass_S=true;
                                    return null;
                                  } else if (value.length < 8) {
                                    Pass_S=false;
                                    Pass_Null=true;
                                    return null;
                                  }
                                  Pass_Null=true;
                                  Pass_S=true;
                                  return null;
                                },
                                // textDirection: TextDirection.rtl,
                                controller: newpass,
                                obscureText: !_showPassword2,
                                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600,fontFamily: 'Changa',color: Colors.grey[600],),
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
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  labelText: "كلمة السر الجديدة",
                                  labelStyle:  TextStyle(fontSize: 22.0,fontFamily: 'Changa',color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],),
                                  suffixIcon: IconButton(
                                    icon: Icon(_showPassword2 ? Icons.visibility : Icons.visibility_off, color:Colors.grey[600],),
                                    color: Colors.cyan,
                                    onPressed:_togglevisibility2,
                                  ),//

                                ),
                                cursorColor:Colors.grey[600],
                              ),),
                            Pass_Null ? Container(
                              margin: EdgeInsets.fromLTRB(255, 0, 0, 0),
                              child: Text('',textAlign:TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Changa',
                                  color: Colors.red,

                                ),),
                            ): Container(
                              margin: EdgeInsets.fromLTRB(230, 0, 0, 0),
                              child: Text(' هذا الحقل مطلوب !',textAlign:TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Changa',
                                  color: Colors.red,

                                ),),
                            ),
                            Container(margin: EdgeInsets.symmetric(vertical: 5.0),),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              height: 60,
                              child:TextFormField(
                                obscureText: !_showPassword3,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    Pass_R=false;
                                    Pass_Mismatch=true;
                                    return null;
                                  }else if (value==pass) {
                                    Pass_Mismatch=true;
                                    Pass_R=true;
                                    return null;
                                  } else {
                                    Pass_R=true;
                                    Pass_Mismatch=false;
                                    return null;
                                  }
                                  Pass_Null=true;
                                  return null;
                                },
                                // textDirection: TextDirection.rtl,
                                controller: confirmpass,
                                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600,fontFamily: 'Changa',color: Colors.grey[600],),
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
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  labelText: "تأكيد كلمة السر",
                                  labelStyle:  TextStyle(fontSize: 22.0,fontFamily: 'Changa',color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],),
                                  suffixIcon: IconButton(
                                    icon: Icon(_showPassword3 ? Icons.visibility : Icons.visibility_off, color: Colors.grey[600],),
                                    color: Colors.cyan,
                                    onPressed:_togglevisibility3,
                                  ),//
                                ),
                                cursorColor:Colors.grey[600],
                              ),),
                            Pass_R ? Container(
                              margin: EdgeInsets.fromLTRB(135, 0, 0, 0),
                              child: Text('',textAlign:TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Changa',
                                  color: Colors.red,

                                ),),
                            ): Container(
                              margin: EdgeInsets.fromLTRB(230, 0, 0, 0),
                              child: Text(' هذا الحقل مطلوب !',textAlign:TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Changa',
                                  color: Colors.red,

                                ),),
                            ),Container(height: 1,),
                            Pass_old_notC ? Container(
                              margin: EdgeInsets.fromLTRB(255, 0, 0, 0),
                              child: Text('',textAlign:TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Changa',
                                  color: Colors.red,

                                ),),
                            ): Container(
                              margin: EdgeInsets.fromLTRB(175, 0, 0, 0),
                              child: Text('* كلمة السر القديمة غير صحيحة'
                                ,textAlign:TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Changa',
                                  color: Colors.red,

                                ),),
                            ),
                            Pass_S ? Container(
                              margin: EdgeInsets.fromLTRB(135, 0, 0, 0),
                              child: Text('',textAlign:TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Changa',
                                  color: Colors.red,

                                ),),
                            ): Container(
                              margin: EdgeInsets.fromLTRB(110, 0, 0, 0),
                              child: Text('* يجب أن تحتوي كلمة السر 8 أحرف على الأقل',textAlign:TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Changa',
                                  color: Colors.red,

                                ),),
                            ),
                            Pass_Mismatch ? Container(
                              margin: EdgeInsets.fromLTRB(120, 0, 0, 0),
                              child: Text('',textAlign:TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Changa',
                                  color: Colors.red,

                                ),),
                            ): Container(
                              margin: EdgeInsets.fromLTRB(210, 0,0, 0),
                              child: Text('* كلمة السر غير متطابقة',textAlign:TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Changa',
                                  color: Colors.red,

                                ),),
                            ),


                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 130),
                                  width: 150,
                                  child:RaisedButton(
                                    onPressed: () {
                                      setState(() {});
                                      if( Pass_Null &&  Pass_Mismatch && Pass_S &&  Pass_old){
                                        editpassword();
                                      }
                                      if (formKey.currentState.validate()) {print('validate');}
                                      else{print('not validate');}
                                    },
                                    color:Color(0xFFECCB45),
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25)),
                                    child: Text(
                                      "حفظ التعديل",
                                      style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600,fontFamily: 'Changa',color: Colors.white,),
                                    ),
                                  ),),
                                // OutlineButton(
                                //   padding: EdgeInsets.symmetric(horizontal: 50),
                                //   shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(20)),
                                //   onPressed: () {
                                //
                                //
                                //   },
                                //   child: Text("الغاء",
                                //       style: TextStyle(
                                //           fontSize: 14,
                                //           letterSpacing: 2.2,
                                //           color: Colors.purple)),
                                // ),

                              ],
                            )

                          ],), ), ],
                  ),),
              ],),],
        );
      },
    );
  }


  Future updatestate()async{
    var url='https://'+IP4+'/testlocalhost/updatestate.php';
    var ressponse=await http.post(url,body: {
      "state": isSwitched1.toString(),
      "phoneworker":'+970595320479',
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
}
