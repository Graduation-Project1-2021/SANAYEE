import 'package:flutterphone/Worker/PROFILE_PAGE_WORKER.dart';
import 'package:flutterphone/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/components/already_have_an_account_acheck.dart';
import 'package:flutterphone/Inside_the_app/inside.dart';
import 'package:flutterphone/screens/signuser_screen.dart';
import 'package:flutterphone/screens/welcome_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
String IP4="192.168.1.8";

FocusNode myFocusNode = new FocusNode();

class LoginScreen extends StatefulWidget {
  @override

  _Body createState() => _Body();
}

class _Body extends State<LoginScreen> {
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
            return InsideAPP();
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
        // appBar: PreferredSize(
        // preferredSize: Size.fromHeight(180.0),
        //  child:AppBar(
        //   flexibleSpace: Image(
        //     image: AssetImage('assets/icons/ho.jpg'),
        //     fit: BoxFit.cover,
        //   ),
        //   backgroundColor: Colors.transparent,
        // ),),
        body: Form(key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[


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
                        margin: EdgeInsets.fromLTRB(100, 40, 1, 0),
                        child: IconButton(
                          alignment: Alignment.topRight,
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>WelcomeScreen()));
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.fromLTRB(20, 130, 20, 0),
                        height: 570,
                        child: Card(
                          elevation: 5,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),),
                          shadowColor: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // Container(height: 50,),
                              Container(
                                margin: EdgeInsets.only(top:0,bottom:80),
                                child: Text('صنايعي',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontFamily: 'Changa',
                                    fontSize: 30.0,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                          margin: EdgeInsets.only(top:0),
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          width: size.width * 0.82,
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
                              fontSize: 16.0,
                              fontFamily: 'Changa',
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(prefixIcon: Icon(Icons.person,color:Colors.grey[600],),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.grey),
                                  borderRadius: const BorderRadius.all(const Radius.circular(30))
                              ),
                              focusedBorder:OutlineInputBorder(
                                borderSide: const BorderSide(color: Camone),
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                              ),
                              labelText: ('الاسم'),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelStyle: TextStyle(fontSize: 22.0,fontFamily: 'Changa',color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],),
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
                          margin: EdgeInsets.fromLTRB(180, 0, 0, 0),
                          child: Text('هذا الحقل مطلوب !',textAlign:TextAlign.end,
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Changa',
                              color: Colors.red,

                            ),),
                        ),
                              Container(height: 20,),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 0),
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                width: size.width * 0.82,
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
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.grey[600],

                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off, color: Colors.grey[600],),
                                      color: Colors.cyan,
                                      onPressed:_togglevisibility,
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.grey),
                                        borderRadius: const BorderRadius.all(const Radius.circular(30))
                                    ),
                                    focusedBorder:OutlineInputBorder(
                                      borderSide: const BorderSide(color:Camone),
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                    ),
                                    labelText: ('كلمة السر'),
                                    labelStyle: TextStyle(fontSize: 22.0,fontFamily: 'Changa',color: myFocusNode.hasFocus ? Colors.grey[600] : Colors.grey[600],),
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
                                margin: EdgeInsets.fromLTRB(180, 0, 0, 1),
                                child: Text('هذا الحقل مطلوب !',textAlign:TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Changa',
                                    color: Colors.red,

                                  ),),
                              ),

                              login_Sucsess ? Container(
                                margin: EdgeInsets.fromLTRB(110, 5,15, 1),
                                child: Text('',textAlign:TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Changa',
                                    color: Colors.red,

                                  ),),
                              ): Container(
                                margin: EdgeInsets.fromLTRB(110, 5,15, 1),
                                child: Text(' * اسم المستخدم أو كلمة المرور خاطئة',textAlign:TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Changa',
                                    color: Colors.red,

                                  ),),
                              ),

                              SizedBox(height:15,),
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
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height:70,),
                      Container(
                        margin: EdgeInsets.only(top:655,left: 100,right: 100),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(29),
                          child: FlatButton(
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                            color: Camone,
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
                      ),


                    ],
                  ),

                ),
              ],

            ),
          ),

        ),
      ),
    );
  }
}
