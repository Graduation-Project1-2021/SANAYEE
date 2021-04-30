import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutterphone/USER/user_Profile.dart';
import 'package:flutterphone/WORKER_SANAYEE/homepage.dart';
import 'package:flutterphone/WORKER_SANAYEE/odersperson_day.dart';
import 'package:flutterphone/components/already_have_an_account_acheck.dart';
import 'package:flutterphone/screens/signuser_screen.dart';
import 'package:flutterphone/WORKER_SANAYEE/Profile.dart';
import 'package:flutterphone/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
String IP4="192.168.1.8";

FocusNode myFocusNode = new FocusNode();

class Loginscreen extends StatefulWidget {
  @override

  _Body createState() => _Body();
}

class _Body extends State<Loginscreen> {
  final _formKey = GlobalKey<FormState>();


  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  var massage;
  bool Name_Null=true;
  bool Pass_Null=true;
  bool Pass_Mismatch=true;
  bool login_Sucsess=true;

  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }



  Future getdata()async{
    var url='https://'+IP4+'/testlocalhost/login.php';
    var ressponse=await http.get(url);
    return json.decode(ressponse.body);
  }




  Future senddata() async {
    print('hi hi hi');
    var url = 'https://'+IP4+'/testlocalhost/login.php';
    var ressponse = await http.post(url, body: {
      "name": nameController.text,
      "pass": passController.text,
    });
    massage = json.decode(ressponse.body);
    if (massage == 'userlogin') {
      print('login is sucssefully');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return U_PROFILE(name_Me:nameController.text,);
          },
        ),
      );
    }
    else if (massage == 'workerlogin') {
      print('worker login sucssefully');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return orderpperson_map(name_Me:nameController.text);
            //  return ProfilePage(nameController.text);

          },
        ),
      );
    }
    else {
      print('NO NO NO');
      setState(() {
        login_Sucsess = false;
        Pass_Null = true;
        Name_Null = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery
        .of(context)
        .size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child:Stack(
        children: [
      Container(
      decoration: BoxDecoration(
        color: Colors.black54.withOpacity(0.8),
      image: new DecorationImage(
        fit: BoxFit.cover,
        colorFilter:
        ColorFilter.mode(Colors.black54.withOpacity(0.35),
            BlendMode.dstATop),
        image: new AssetImage(
          'assets/work/cv.jpg',
        ),
      ),
    )
    ),
    Scaffold(
         backgroundColor: Colors.transparent,
        // appBar: PreferredSize(
        // preferredSize: Size.fromHeight(180.0),
        //  child:AppBar(
        //   flexibleSpace: Image(
        //     image: AssetImage('assets/icons/ho.jpg'),
        //     fit: BoxFit.cover,
        //   backgroundColor: Colors.transparent,
        // ),),
        body:Form(key: _formKey,
        child:SingleChildScrollView(
        child:Container(
            decoration: BoxDecoration(
              // color: Colors.yellowAccent,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                GestureDetector(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                    height: MediaQuery.of(context).size.height * 1.0,
                     child:Container(
                        height: 500,
                        decoration: BoxDecoration(
                          color:Colors.transparent,
                          // gradient: LinearGradient(
                          //     begin: Alignment.topCenter,
                          //     end: Alignment.bottomCenter,
                          //
                          //    // colors: [Y1,Y3,Y3,Y3,Y4,Y4,Y4]
                          //     colors: [Y1,Y3,X4,X4,X4]
                          // ),
                        ),
                        padding: EdgeInsets.only(bottom: 5),
                        child: Center(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 90,),
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color:Colors.transparent,
                                      image: DecorationImage(
                                        colorFilter:
                                        ColorFilter.mode(Colors.transparent,
                                            BlendMode.colorBurn),
                                        image: new AssetImage(
                                          'assets/work/output-onlinepngtools1.png',
                                        ),
                                      ),

                                    ),
                                  ),
                                  Container(
                                    child:Center(
                                      child:Text('صنايعي ',
                                        style: TextStyle(
                                          fontSize: 55,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                          fontFamily: 'vibes',
                                          //fontStyle: FontStyle.italic,
                                        ),)
                                  ),),
                                  Container(
                                    margin: EdgeInsets.only(top:30),
                                    padding: EdgeInsets.symmetric(horizontal: 0),
                                    width: size.width * 0.82,
                                    height: 55,
                                    child: TextFormField(
                                      controller: nameController,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          Name_Null=false;
                                          return null;
                                        } else {
                                          Name_Null=true;
                                          return null;
                                        }},
                                      onChanged: (content) {
                                        Name_Null=true;
                                        login_Sucsess=true;
                                        setState(() {

                                        });
                                      },
                                      cursorColor:Colors.grey[600],
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Color(0xFF1C1C1C),
                                        fontSize: 16.0,
                                        fontFamily: 'Changa',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        prefixIcon: Icon(Icons.person,color:Color(0xFF666360),),
                                        enabledBorder: new OutlineInputBorder(
                                          borderRadius: new BorderRadius.circular(30.0),
                                          borderSide:  BorderSide(color: Colors.grey[100],),

                                        ),
                                        focusedBorder: new OutlineInputBorder(
                                          borderRadius: new BorderRadius.circular(30.0),
                                          borderSide:  BorderSide(color: Colors.grey[100],),

                                        ),
                                        hintText: 'الاسم ',
                                        hintStyle: TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: 'Changa',
                                          color: Color(0xFF666360),
                                        ),
                                        floatingLabelBehavior: FloatingLabelBehavior.always,

                                      ),

                                    ),
                                  ),
                                  Name_Null ? Container(
                                    margin: EdgeInsets.fromLTRB(180, 0, 0, 0),
                                    child: Text('',textAlign:TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Changa',
                                        color: Colors.red,

                                      ),),
                                  ): Container(
                                    margin: EdgeInsets.fromLTRB(225, 0, 0, 0),
                                    child: Text('هذا الحقل مطلوب !',textAlign:TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Changa',
                                        color: Colors.red,

                                      ),),
                                  ),
                                  Container(height: 5,),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 0),
                                    padding: EdgeInsets.symmetric(horizontal: 0),
                                    width: size.width * 0.82,
                                    height: 55,
                                    child: TextFormField(
                                      controller: passController,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          Pass_Null=false;
                                          return null;
                                        } else{
                                          Pass_Null=true;
                                          return null;
                                        }},
                                      onChanged: (content) {
                                        Pass_Null=true;
                                        login_Sucsess=true;
                                        setState(() {

                                        });
                                      },
                                      obscureText: !_showPassword,
                                      cursorColor:Colors.grey[600],
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Changa',
                                        color: Color(0xFF1C1C1C),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          size:24,
                                          color:Color(0xFF666360),

                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off,size:24,  color:Color(0xFF666360),),
                                          color: B,
                                          onPressed:_togglevisibility,
                                        ),
                                        enabledBorder: new OutlineInputBorder(
                                          borderRadius: new BorderRadius.circular(30.0),
                                          borderSide:  BorderSide(color: Colors.grey[100]),

                                        ),
                                        focusedBorder: new OutlineInputBorder(
                                          borderRadius: new BorderRadius.circular(30.0),
                                          borderSide:  BorderSide(color:Colors.grey[100]),

                                        ),
                                        hintText: 'كلمة السر',
                                        hintStyle: TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: 'Changa',
                                          color: Color(0xFF666360),
                                        ),
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                      ),
                                    ),
                                  ),
                                  Pass_Null ? Container(
                                    margin: EdgeInsets.fromLTRB(180, 0, 0, 1),
                                    child: Text('',textAlign:TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Changa',
                                        color: Colors.red,

                                      ),),
                                  ): Container(
                                    margin: EdgeInsets.fromLTRB(225, 0, 0, 1),
                                    child: Text('هذا الحقل مطلوب !',textAlign:TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Changa',
                                        color: Colors.red,

                                      ),),
                                  ),

                                  login_Sucsess ? Container(
                                    margin: EdgeInsets.fromLTRB(110, 0,0, 1),
                                    child: Text('',textAlign:TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Changa',
                                        color: Colors.red,

                                      ),),
                                  ): Container(
                                    transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                                    margin: EdgeInsets.fromLTRB(140,0,0, 1),
                                    child: Text(' * اسم المستخدم أو كلمة المرور خاطئة',textAlign:TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Changa',
                                        color: Colors.red,

                                      ),),
                                  ),

                                  // SizedBox(height:5,),
                                  Column(
                                    children:[
                                      Container(
                                        width: size.width * 0.82,
                                        margin: EdgeInsets.only(top:0,),
                                        // decoration: BoxDecoration(
                                        //   color: Color(0xFF1C1C1C),
                                        //   borderRadius: BorderRadius.all(
                                        //     Radius.circular(25),
                                        //   ),
                                        //   boxShadow: [
                                        //     BoxShadow(
                                        //       color: Color(0xFF1C1C1C).withOpacity(0.2),
                                        //       spreadRadius: 3,
                                        //       blurRadius: 4,
                                        //       offset: Offset(0, 3),
                                        //     ),
                                        //   ],
                                        // ),
                                        child: FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(25.0),
                                              side: BorderSide(color: Colors.transparent)
                                          ),
                                          // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                                          color:Colors.black54,
                                          onPressed: (){
                                            if (_formKey.currentState.validate()) {print('validate');}
                                            else{print('not validate');}
                                            setState(() {
                                              // Name_Null=true;
                                              // Pass_Null=true;
                                            });
                                            if(Name_Null && Pass_Null) {
                                              senddata();
                                              print("send");
                                            }
                                            print(nameController.text);
                                            print(passController.text);
                                          },
                                          child: Text(
                                            "تسجيل الدخول",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 21.0,
                                              fontFamily: 'Changa',
                                            ),
                                          ),
                                        ),
                                      ),

                                      Container(height: 5,),
                                      AlreadyHaveAnAccountCheck(
                                        press: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return SignuserScreen();
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ],),
                                  // Container(
                                  //   height: 500,
                                  //   color: Colors.red,
                                  // ),
                                ],

                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                // ClipPath(
                //   clipper: WaveClipperOne(reverse: true),
                //   child: Container(
                //     height: 200,
                //     color: Colors.deepPurple,
                //     child: Center(child: Text("WaveClipperOne(reverse: true)")),
                //   ),
                // ),
               ],
            ),
          ),
        ),),),],),);
  }
}

class CurvePainter extends CustomPainter {

  bool outterCurve;

  CurvePainter(this.outterCurve);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.white;
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