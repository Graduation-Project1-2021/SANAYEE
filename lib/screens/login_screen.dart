import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutterphone/Inside_the_app/user_Profile.dart';
import 'package:flutterphone/components/already_have_an_account_acheck.dart';
import 'package:flutterphone/screens/signuser_screen.dart';
import 'package:flutterphone/Worker/PROFILE_PAGE_WORKER.dart';
import 'package:flutterphone/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/Inside_the_app/inside.dart';
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
            return PROFILE(name:nameController.text);
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
      child: Scaffold(
        backgroundColor:Color(0xF0B67CFB),
        // appBar: PreferredSize(
        // preferredSize: Size.fromHeight(180.0),
        //  child:AppBar(
        //   flexibleSpace: Image(
        //     image: AssetImage('assets/icons/ho.jpg'),
        //     fit: BoxFit.cover,
        //   backgroundColor: Colors.transparent,
        // ),),
        body: Form(key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                GestureDetector(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: CustomPaint(
                      painter: CurvePainter(true),
                      child: Container(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Center(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 45,bottom: 5),
                                    height: 100,
                                    decoration: BoxDecoration(
                                      // color:Color(0xFF1C1C1C),
                                      image: DecorationImage(
                                        image: new AssetImage(
                                          'assets/icons/vb.png',
                                        ),
                                      ),),),
                                  Container(
                                    margin: EdgeInsets.only(top:0,bottom:40),
                                    child:Center(
                                      child: Text('صنايعي',
                                        style: TextStyle(
                                          color: Color(0xFF1C1C1C),
                                          fontFamily: 'Changa',
                                          fontSize: 30.0,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),),
                                  Container(
                                    margin: EdgeInsets.only(top:0),
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
                                        prefixIcon: Icon(Icons.person,color: Colors.orangeAccent.withOpacity(0.5),),
                                        enabledBorder: new OutlineInputBorder(
                                          borderRadius: new BorderRadius.circular(30.0),
                                          borderSide:  BorderSide(color: Colors.orangeAccent),

                                        ),
                                        focusedBorder: new OutlineInputBorder(
                                          borderRadius: new BorderRadius.circular(30.0),
                                          borderSide:  BorderSide(color: Colors.orangeAccent ),

                                        ),
                                        hintText: 'الاسم ',
                                        hintStyle: TextStyle(
                                          fontSize: 16.0,
                                          fontFamily: 'Changa',
                                          color: Colors.black26,
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
                                          color: Colors.orangeAccent.withOpacity(0.5),

                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off,  color:Colors.orangeAccent.withOpacity(0.5),),
                                          color: Colors.cyan,
                                          onPressed:_togglevisibility,
                                        ),
                                        enabledBorder: new OutlineInputBorder(
                                          borderRadius: new BorderRadius.circular(30.0),
                                          borderSide:  BorderSide(color: Colors.orangeAccent),

                                        ),
                                        focusedBorder: new OutlineInputBorder(
                                          borderRadius: new BorderRadius.circular(30.0),
                                          borderSide:  BorderSide(color: Colors.orangeAccent),

                                        ),
                                        hintText: 'كلمة السر',
                                        hintStyle: TextStyle(
                                          fontSize: 16.0,
                                          fontFamily: 'Changa',
                                          color: Colors.black26,
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
                                          color: Colors.orangeAccent,
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
                                ],
                              ),
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
        ),),);
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