import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/Worker/setting_worker.dart';
import 'package:flutterphone/Worker/worker_order.dart';
import 'package:flutterphone/commons/radial_progress.dart';
import 'package:flutterphone/screens/login_screen.dart';
import 'package:flutterphone/screens/welcome_screen.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutterphone/constants.dart';
import '../constants.dart';
import 'GET_IMGS.dart';
import 'accept_order.dart';
import 'edit.dart';
import 'change_pass.dart';

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
  int profile;
   PROFILE({this.name,this.profile});
  _PROFILE createState() =>  _PROFILE();
}
class  _PROFILE extends State< PROFILE> {
  // AnimationController _animationController;
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  final List1=[];
  var ListDate1=[];
  final List2=[];
  var ListDate2=[];
  List<dynamic>L;
  Future getdata1()async{
    var url='https://'+IP4+'/testlocalhost/count.php';
    var ressponse=await http.post(url,body: {
      "phone": phone,
    });
    var responsepody= json.decode(ressponse.body);
    for(int i=0;i<responsepody.length;i++){
      //L.add(responsepody[i]['count']);
      List1.add(responsepody[i]['id']);
      ListDate1.add(responsepody[i]['date']);
    }
    // print(List1);
    // print(ListDate1);
  }
  Future getdata2()async{
    var url='https://'+IP4+'/testlocalhost/count2.php';
    var ressponse=await http.post(url,body: {
      "phone": phone,
    });
    var responsepody= json.decode(ressponse.body);
    for(int i=0;i<responsepody.length;i++){
      //L.add(responsepody[i]['count']);
      List2.add(responsepody[i]['id']);
      ListDate2.add(responsepody[i]['date']);
    }
    // print(List2);
    // print(ListDate2);
  }
  void initState() {
    super.initState();
    getdata1();
    getdata2();

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
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return  Directionality( textDirection: TextDirection.rtl,
       child:Scaffold(
         key: _scaffoldKey,
         bottomNavigationBar: CurvedNavigationBar(
           color:  Color(0xFFECCB45),
           buttonBackgroundColor: Color(0xFFECCB45),
           backgroundColor: MY_BLACK,
           height: 48,
           key: _bottomNavigationKey,
           items: <Widget>[
             Icon(Icons.home, size: 25),
             Icon(Icons.settings, size: 25),
             Icon(Icons.playlist_add_check, size: 25),
             Icon(Icons.notifications, size: 25),
             Icon(Icons.logout, size: 25),
           ],
           onTap: (index) {
             setState(() {
               _page = index;
                 if(_page==0){
                  // print(List2);
                   Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>PROFILE(name: widget.name,)));
                }

               if(_page==4){ Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>Loginscreen()));}               // if(_page==1){
               //   Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>SettingPage(name: widget.name,phone: phone,image: image,Work: Work,Experiance: Experiance,Information: Information,token: token,)));
               // }
             });
           },
         ),
          backgroundColor: Color(0xFFECCB45),
         appBar: PreferredSize(
             preferredSize: Size.fromHeight(40.0), // here the desired height
             child: AppBar(
               backgroundColor: Color(0xFFECCB45),
               elevation: 0.0,
               //leading: I,
             )
         ),
         // appBar: PreferredSize(
         //  //referredSize: 50.0,      child: AppBar(
         //   automaticallyImplyLeading: false, // this will hide Drawer hamburger icon
         //   elevation: 0,
         //   backgroundColor:  Color(0xFFECCB45),
         // ),),
        // backgroundColor: Colors.lightBlueAccent,
        body: Form(
          // child:SingleChildScrollView(
         child:Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Container(
              //   height: 300,
              //   decoration: BoxDecoration(
              //     color:  Color(0xFFF3D657),
              //     // borderRadius: BorderRadius.only(
              //     //   bottomLeft: Radius.circular(100),
              //     //   bottomRight: Radius.circular(100),
              //     // ),
              //   ),
              //    ),
             Expanded(child:Container(
                    height: 700,
                    // color:  Color(0xFFF3D657),
                    margin: EdgeInsets.only(top:0),
                    decoration: BoxDecoration(
                     // color:Color(0xFF1C1C1C),
                      // borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(50),
                      //   topRight: Radius.circular(50),
                      // ),
                    ),
                   child:FutureBuilder(
                  future: getWorker(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          name=snapshot.data[index]['name'];
                          phone=snapshot.data[index]['phone'];
                          image=snapshot.data[index]['image'];
                          Work=snapshot.data[index]['Work'];
                          Information=snapshot.data[index]['Information'];
                          Experiance=snapshot.data[index]['Experiance'];
                          token=snapshot.data[index]['token'];

                          if(_page==0){return Profile_worker(name:snapshot.data[index]['name'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],phone:snapshot.data[index]['phone'],image:snapshot.data[index]['image'],Work:snapshot.data[index]['Work'],Experiance:snapshot.data[index]['Experiance'],Information:snapshot.data[index]['Information'],token:snapshot.data[index]['token']);}
                          if(_page==1){return SettingPage(name:snapshot.data[index]['name'],phone:snapshot.data[index]['phone'],image:snapshot.data[index]['image'],Work:snapshot.data[index]['Work'],Experiance:snapshot.data[index]['Experiance'],Information:snapshot.data[index]['Information'],token:snapshot.data[index]['token']);}
                          if(_page==2){ return accept_order(phone: phone,List1:List2,ListDate: ListDate2,);}
                          if(_page==3){return work_order(phone: phone,List1:List1,ListDate: ListDate1,);}


                          return Container();
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
             ),),],),),),);



}
  GestureDetector odrers (BuildContext context, String title) {
    return GestureDetector(
      onTap: () {Navigator.push(context,
        MaterialPageRoute(builder: (context) => work_order(phone: phone,List1:List1,ListDate: ListDate1,)),
      );},
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Colors.grey[600],
                fontFamily: 'Changa',
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
  GestureDetector accept_orders (BuildContext context, String title) {

    return GestureDetector(
      onTap: () {Navigator.push(context,
        MaterialPageRoute(builder: (context) => accept_order(phone: phone,List1:List2,ListDate: ListDate2,)),
      );},
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Colors.grey[600],
                fontFamily: 'Changa',
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
  GestureDetector update(BuildContext context, String title) {

    return GestureDetector(
      onTap: () {Navigator.push(context,
        MaterialPageRoute(builder: (context) => SettingsUI(name:name,phone:phone,image:image,Work:Work,Experiance:Experiance,Information:Information,token:token)),
      );},
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Colors.grey[600],
                fontFamily: 'Changa',
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector Albume(BuildContext context, String title) {

    return GestureDetector(
      onTap: () {Navigator.push(context,
        MaterialPageRoute(builder: (context) => Get_Images(name:widget.name,phone:phone),));},
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Colors.grey[600],
                fontFamily: 'Changa',
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
  GestureDetector changepassword(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {return Editpassword(name:name,phone:phone,image:image,Work:Work,Experiance:Experiance,Information:Information,token:token);
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Colors.grey[600],
                fontFamily: 'Changa',
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );}
}
class Profile_worker  extends StatefulWidget {
  final  name;
  final  namefirst;
  final  namelast;
  final  phone;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;
  final page;

  Profile_worker({this.name,this.namelast,this.namefirst, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token,this.page});

  @override
  _Profile_woeker createState() => _Profile_woeker();
}

class _Profile_woeker extends State<Profile_worker> {
  bool uploading = false;
  double val = 0;
  File uploadimage;
  bool image =false;
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
      "phone": widget.phone,
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
              Container(
                margin: EdgeInsets.only(top:0),
                //transform: Matrix4.translationValues(0, 5.0, 0),
                child:Center(
                  child:CircleAvatar(backgroundImage: NetworkImage('https://'+IP4+'/testlocalhost/upload/'+widget.image),radius: 35.0,),),
              ),
              Container(
                margin: EdgeInsets.only(top:10),
                child:Center(
                  child: Text(widget.namefirst+ " "+widget.namelast,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontFamily: 'Changa',
                      fontWeight: FontWeight.bold,),),
                ),),
              Row(children: [
                GestureDetector(

                  child:Container(
                    child:Column(
                      children: [
                        Container(
                          height: 20,
                          width: 40,
                          margin: EdgeInsets.only(right: 50,top:30),
                          child: IconButton(
                            icon:Icon(Icons.person),
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 25,
                          margin: EdgeInsets.only(right: 50,top:10),
                          child: Text('حول',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.3,
                              fontFamily: 'Changa',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  child:Container(
                    child:Column(
                      children: [
                        Container(
                          height: 20,
                          width: 40,
                          margin: EdgeInsets.only(right: 50,top:30),
                          child: IconButton(
                            icon:Icon(Icons.my_library_books_sharp),
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 60,
                          margin: EdgeInsets.only(right: 50,top:10),
                          child: Text('منشورات',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.3,
                              fontFamily: 'Changa',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    setState(() {
                      image=true;
                    });
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => PROFILE(name: widget.name,profile:1,)),);
                  },
                  child:Container(
                    child:Column(
                      children: [
                        Container(
                          height: 20,
                          width: 40,
                          margin: EdgeInsets.only(right: 50,top:30),
                          child: IconButton(
                            icon:Icon(Icons.image,
                            color: image==true?MY_BLACK:Color(0xFF716C10),),
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 25,
                          margin: EdgeInsets.only(right: 50,top:10),
                          child: Text('صور',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.3,
                              fontFamily: 'Changa',
                              fontWeight: FontWeight.bold,
                            ),),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  child:Container(
                    child:Column(
                      children: [
                        Container(
                          height: 20,
                          width: 40,
                          margin: EdgeInsets.only(right: 50,top:30),
                          child: IconButton(
                            icon:Icon(Icons.comment),
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 50,
                          margin: EdgeInsets.only(right: 50,top:10),
                          child: Text('تعليقات',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.3,
                              fontFamily: 'Changa',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],),


              //bodyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy

              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top:30),
                  height: 700,
                  width: 500,
                  decoration: BoxDecoration(
                    color: MY_BLACK,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child:Column(
                    children: [
                      GestureDetector(
                        child:Container(
                          child:Column(
                            children: [
                              Container(
                                height: 20,
                                width: 40,
                                // margin: EdgeInsets.only(top: 250,right: 50),
                                // child: IconButton(
                                //   icon:Icon(Icons.comment),
                                // ),
                              ),
                              // Container(
                              //   height: 150,
                              //   width: 300,
                              //   margin: EdgeInsets.only(top: 10,right: 50),
                              //   child: Text(widget.Information +"\n"+"\n"+widget.Experiance,
                              //     style: TextStyle(
                              //       color: Colors.yellow,
                              //       fontSize: 13.3,
                              //       fontFamily: 'Changa',
                              //       fontWeight: FontWeight.bold,
                              //     ),
                              //   ),
                              // ),
                             Container(
                                      height: 400,
                                      margin: EdgeInsets.only(top:15),
                                      child:FutureBuilder(
                                        future: getImages(),
                                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                                          if(snapshot.hasData){
                                            return ListView.builder(
                                              itemCount: 1,
                                              itemBuilder: (context, index) {
                                                int num =snapshot.data.length-4;
                                                if(image==true){
                                                if(snapshot.data.length==0){
                                                   return myAlbum0();
                                                }
                                                if(snapshot.data.length==1){
                                                  return myAlbum1('https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index]['images']);
                                                }
                                                if(snapshot.data.length==2){
                                                  return myAlbum2('https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+1]['images']);
                                                }
                                                if(snapshot.data.length==3){
                                                  return myAlbum3('https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+1]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+2]['images']);
                                                }
                                                return myAlbum('https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+1]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+2]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+3]['images'],num.toString()+"+");
                                              }
                                              return Container();
                                              }
                                            );
                                          }
                                          return Center(child: CircularProgressIndicator());
                                        },
                                      ),
                                    )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),),
              //   Container(
              //     height: 50,
              //     width: 60,
              //     margin: EdgeInsets.only(top: 130,right: 50),
              //     child: IconButton(
              //       icon:Icon(Icons.image),
              //     ),
              //     ),
              // Container(
              //   height: 50,
              //   width: 60,
              //   margin: EdgeInsets.only(top: 130,right: 50),
              //   child: IconButton(
              //     icon:Icon(Icons.comment),
              //   ),
              // ),

              // Container(
              //   margin: EdgeInsets.only(top: 1,right: 90),
              //   child: Text('نجار',
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 16.0,
              //       fontFamily: 'Changa',
              //       fontWeight: FontWeight.bold,
              //     ),),
              // ),
        // Container(
        //   margin: EdgeInsets.only(top: 10,right: 20),
        //   child: InkWell(
        //     child:IconButton(
        //       icon: Icon(Icons.cloud_upload),
        //       color: Colors.black,
        //     ),
        //   ),),

        //     SingleChildScrollView(
        //       child: Column(
        //       children: <Widget>[
        //     Container(
        //       height: 400,
        //       margin: EdgeInsets.only(top:1),
        //       child:FutureBuilder(
        //         future: getImages(),
        //         builder: (BuildContext context, AsyncSnapshot snapshot) {
        //           if(snapshot.hasData){
        //             return ListView.builder(
        //               itemCount: 1,
        //               itemBuilder: (context, index) {
        //                 int num =snapshot.data.length-4;
        //                 if(snapshot.data.length==0){
        //                    return myAlbum0();
        //                 }
        //                 if(snapshot.data.length==1){
        //                   return myAlbum1('https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index]['images']);
        //                 }
        //                 if(snapshot.data.length==2){
        //                   return myAlbum2('https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+1]['images']);
        //                 }
        //                 if(snapshot.data.length==3){
        //                   return myAlbum3('https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+1]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+2]['images']);
        //                 }
        //                 return myAlbum('https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+1]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+2]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+3]['images'],num.toString()+"+");
        //               },
        //             );
        //           }
        //           return Center(child: CircularProgressIndicator());
        //         },
        //       ),
        //     ),
        //         Container(
        //           height: 500,
        //         ),
        //   ],
        // ),),
      ], );
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
       margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
      // padding:EdgeInsets.fromLTRB(5, 0, 5, 0),
      height:290,
      width:370,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40.0),
          border: Border.all(color: MY_BLACK, width: 1.2)
      ),
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
            Container(
              margin: EdgeInsets.only(left: 10),
             padding: EdgeInsets.only(left: 230),
             child:Text("ألبومي ",
               style: TextStyle(
                 color: Colors.black87,
                 fontSize: 16.0,
                 fontFamily: 'Changa',
                 fontWeight: FontWeight.bold,
               ),),
            ),
          ],),);
  }

  myAlbum0(){
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
                            child: Image.asset(
                              'assets/icons/signup.jpg', height: 110,
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
                                child: Text("انقر لإضافة صور", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),),
                              ),
                            ),
                          )
                        ],
                      ),),),
                ],),
            ),
            // Container(
            //  child:Text("ألبومي "),
            // ),
          ],),),);
  }
  myAlbum1(String asset){
    return Container(
      margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
      padding:EdgeInsets.fromLTRB(15, 0, 15, 0),
      height:130,
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
              child:Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>Get_Images(phone:widget.phone,name:widget.name)));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 190,bottom: 10,top:10),
                      child:Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              asset, height: 110,
                              width: 150,
                              fit: BoxFit.cover,),
                          ),
                          Positioned(
                            child: Container(
                              height: 110,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Center(
                                child: Text("+0", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),),
                              ),
                            ),
                          )
                        ],
                      ),),),
                ],),
            ),
            // Container(
            //  child:Text("ألبومي "),
            // ),
          ],),),);
  }
  myAlbum2(String asset1,String asset2){
    return Container(
      margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
      padding:EdgeInsets.fromLTRB(15, 0, 15, 0),
      height:130,
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
              child:Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>Get_Images(phone:widget.phone,name:widget.name)));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10,bottom: 10,top:10),
                      child:Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              asset1, height: 110,
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
                                child: Text("+0", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),),
                              ),
                            ),
                          )
                        ],
                      ),),),
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 10),
                    child:ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        asset2, height: 110,
                        width:209,
                        fit: BoxFit.cover,),
                    ),),
                ],),
            ),
                ],),
            ),
            // Container(
            //  child:Text("ألبومي "),
            // ),
          );
  }
  myAlbum3(String asset1, String asset2, String asset3){
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
                      margin: EdgeInsets.only(right: 130,bottom: 10),
                      child:Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              asset3, height: 110,
                              width: 209,
                              fit: BoxFit.cover,),
                          ),
                          Positioned(
                            child: Container(
                              height: 110,
                              width: 209,
                              decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Center(
                                child: Text("+0", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),),
                              ),
                            ),
                          )
                        ],
                      ),),),
                ],),
            ),
            // Container(
            //  child:Text("ألبومي "),
            // ),
          ],),),);
  }

}
class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
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

