import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/Worker/PROFILE_PAGE_WORKER.dart';
import 'package:flutterphone/Worker/setting_worker.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

import '../constants.dart';
String IP4="192.168.1.8";
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
class ChangePass extends StatefulWidget{
  final  name;
  final  phone;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;

  ChangePass({this.name, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token});
  _change createState() => _change();
}

class _change extends State<ChangePass> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            children:[
            Scaffold(
            backgroundColor: Colors.transparent,
            // appBar: new AppBar(
            //   backgroundColor:Y,
            //   leading:GestureDetector(
            //     onTap: (){
            //       Navigator.pop(context);
            //       // Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => PROFILE(name: widget.name,)));
            //     },
            //     child:Icon(Icons.arrow_back,color: Colors.white,),
            //   ),
            //   title: new Text('',
            //     style: TextStyle(
            //       fontSize: 16.0,
            //       fontWeight: FontWeight.bold,
            //       fontFamily: 'Changa',
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
           body: Container(
             height: 800,
             color: Colors.white,
             child: Stack(
             children:[
               Container(
                 // transform: Matrix4.translationValues(0, -100.0, 0),
                 margin:EdgeInsets.only(top:0),
                 width: double.infinity,
                 height: 200,
                 decoration: BoxDecoration(
                   color: Colors.grey[50],
                 ),
                 child: Image.asset('assets/work/intro3.jpg',width:500,fit: BoxFit.fitWidth,),
               ),
               Container(
                 margin:EdgeInsets.only(top:70,right:10),
                 child: GestureDetector(
                   onTap: (){
                     Navigator.pop(context);
                     // Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => PROFILE(name: widget.name,)));
                   },
                   child:Icon(Icons.arrow_back,color: Colors.black,),
                 ),
               ),
               Editpassword(name:widget.name,phone:widget.phone,image:widget.image,Work:widget.Work,Experiance:widget.Experiance,Information:widget.Information,token:widget.token),
             ],
           ),
          ),

        ),],),);
      },

      // localizationsDelegates: [
      // GlobalCupertinoLocalizations.delegate,
      // GlobalMaterialLocalizations.delegate,
      // GlobalWidgetsLocalizations.delegate,
      // ],
      // supportedLocales: [
      // Locale("en", "US"),
      // Locale('ar', 'AE')
      // ],
      debugShowCheckedModeBanner: false,
      // title: "Profile"
    );
  }


}
class Editpassword extends StatefulWidget {
  final  name;
  final  phone;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;

  Editpassword({this.name, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token});

  _Editpasswordpage createState() =>  _Editpasswordpage();
}
class  _Editpasswordpage extends State< Editpassword> {
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


  final formKey = new GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return  Container(
        color: Colors.white,
        height: 550,
        margin: EdgeInsets.only(top: 220),
        child:SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 0,),
                child:Text('تغيير كلمة السر',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontFamily: 'vibes',
                    //fontStyle: FontStyle.italic,
                  ),)
            ),
            Container(
              height: 500,
              child:Column(
                children:[

                  Container(
                    margin: EdgeInsets.only(top: 50,left: 40,right: 40),
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
                        fillColor: Colors.grey[100],
                        enabledBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide:  BorderSide(color: Colors.grey[100]),

                        ),
                        focusedBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide:  BorderSide(color: Colors.grey[100]),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "كلمة السر القديمة",
                        labelStyle:  TextStyle(fontSize: 18.0,fontFamily: 'Changa',color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],),
                        suffixIcon: IconButton(
                          icon: Icon(_showPassword1 ? Icons.visibility : Icons.visibility_off, color: Colors.grey[600],size: 22,),
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
                        fillColor:Colors.grey[100],
                        enabledBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide:  BorderSide(color: Colors.grey[100]),

                        ),
                        focusedBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide:  BorderSide(color: Colors.grey[100]),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "كلمة السر الجديدة",
                        labelStyle:  TextStyle(fontSize: 18.0,fontFamily: 'Changa',color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],),
                        suffixIcon: IconButton(
                          icon: Icon(_showPassword2 ? Icons.visibility : Icons.visibility_off, color:Colors.grey[600],size: 22,),
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
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide:  BorderSide(color:Colors.grey.withOpacity(0.1)),

                        ),
                        focusedBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide:  BorderSide(color:Colors.grey.withOpacity(0.1)),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "تأكيد كلمة السر",
                        labelStyle:  TextStyle(fontSize: 18.0,fontFamily: 'Changa',color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],),
                        suffixIcon: IconButton(
                          icon: Icon(_showPassword3 ? Icons.visibility : Icons.visibility_off, color: Colors.grey[600],size: 22,),
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 130),
                        width: 150,
                        child:FlatButton(
                          onPressed: () {
                            setState(() {});
                            if( Pass_Null &&  Pass_Mismatch && Pass_S &&  Pass_old){
                              editpassword();
                            }
                            if (formKey.currentState.validate()) {print('validate');}
                            else{print('not validate');}
                          },
                          // backgroundColor:MY_YELLOW ,
                          // elevation: 2,
                          // shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(25)),
                          // child: Icon(Icons.check_circle),
                          child:Text("حفظ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: MY_YELLOW,
                              fontFamily: 'Changa',
                            ),
                          ),
                        ),
                      ),
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
        ),),);
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
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );}
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
      Pass_old=false;
    }
  }
}