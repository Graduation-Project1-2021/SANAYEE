
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/USER/user_slot.dart';
import 'package:flutterphone/USER/viewreservation.dart';
import '../constants.dart';
import '../Inside_the_app/user_order.dart';
import 'WORKER_PROFILE.dart';
class choose extends StatefulWidget {
  final name;
  final country;
  final namefirst;
  final namelast;
  final image;
  final phone;
  final work;
  final DateTime time;
  final phoneworker;
  final username;
  final tokenuser;
  final tokenworker;
  final  Experiance;
  final  Information;
  final client_num;
  final comment;
  choose({this.client_num,this.comment,this.Experiance,this.Information,this.tokenworker,this.tokenuser,this.phoneworker,this.username,this.time,this.phone,this.image,this.country,this.work,this.name,this.namelast,this.namefirst});
  _chooseState createState() => _chooseState();
}

class _chooseState extends State<choose> {
  @override
  bool c1=false;
  bool c2=false;
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor:Colors.black.withOpacity(0.75),
      //   leading:   IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
      //     Navigator.pop(context);
      //   }), ),
      body:
      // return Directionality(
      //   textDirection: TextDirection.rtl,

      Stack(
        children: [
          // Container(
          //  // margin: EdgeInsets.only(top:0,),
          //
          //   color:Colors.black.withOpacity(0.75),
          //      child: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
          //       Navigator.pop(context);
          //     }), ),
//}
          Scaffold(
            backgroundColor: Colors.grey[50],
            //backgroundColor:Colors.white,
            body: Form(
              child: SingleChildScrollView(

                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: [

                        // Container(
                        //     height: 200,
                        //     width: 500,
                        //     margin: EdgeInsets.only(top:0,),
                        //     decoration: BoxDecoration(
                        //       color: Colors.grey.withOpacity(0.3),
                        //       image: new DecorationImage(
                        //         fit: BoxFit.cover,
                        //         // colorFilter:
                        //         // ColorFilter.mode(Colors.blue.withOpacity(0.3),
                        //         //     BlendMode.dstATop),
                        //         image: new AssetImage(
                        //           'assets/work/intro3.jpg',
                        //         ),
                        //       ),
                        //     )),
                        GestureDetector(
                            onTap:(){
                              // Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => user_worker(client_num: widget.client_num,comment: widget.comment,country:widget.country,phoneuser:widget.phone,tokenuser:widget.tokenuser,Work:widget.work,image:widget.image,phone:widget.phoneworker,name: widget.name,namelast:widget.namelast,name_Me: widget.username,namefirst: widget.namefirst,token: widget.tokenworker,Information: widget.Information,Experiance:widget.Experiance,)));
                            },
                            child:Container(
                              margin: EdgeInsets.only(top: 70,left: 370),
                              child:Icon(Icons.arrow_forward,color: Colors.black,),
                            )
                        ),
                      ],
                    ),

                    //Image.asset('assets/icons/ho.jpg',fit: BoxFit.cover,) ,
                    GestureDetector(
                      // onTap: () {
                      //   setState(() {
                      //     login = true;
                      //   });
                      // },
                      child:Container(
                              color: Colors.transparent,
                              padding: EdgeInsets.only(top: 0),
                              child: Center(
                                child: SingleChildScrollView(
                                  child:Stack(
                                    children: [
                                      Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(top: 50,),
                                          child:Text('الخدمة التي تريدها ',
                                            style: TextStyle(
                                              fontSize: 35,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                              fontFamily: 'vibes',
                                              //fontStyle: FontStyle.italic,
                                            ),)
                                      ),

                                    Container(
                                     child:Row(
                                       children: [
                                         Container(
                                           //color: Color(0xFF1C1C1C),
                                           margin: EdgeInsets.only(left: 15, top: 170, bottom: 0,right:15),
                                           width: 180,
                                           height: 140,
                                           child: Column(
                                             children: <Widget>[
                                               GestureDetector(
                                                 onTap: (){
                                                   c1=true;
                                                   c2=false;
                                                   setState(() {

                                                   });
                                                   //_showMyDialog("أثاث بيت جديد ");

                                                 },
                                                 child: Container(
                                                   height: 130,
                                                   // padding: EdgeInsets.all(5),
                                                   decoration: BoxDecoration(
                                                     color: Colors.white,
                                                     //border: Border.all(color: box2?Y:Colors.white, width:3),
                                                     borderRadius: BorderRadius.circular(15),
                                                   ),
                                                   child: Container(
                                                     decoration: BoxDecoration(
                                                       borderRadius: BorderRadius.circular(15),
                                                       image: DecorationImage(image: AssetImage('assets/work/intro3.jpg'),
                                                         fit: BoxFit.cover,
                                                       ),
                                                     ),
                                                     child:Stack(
                                                       children:<Widget>[
                                                         // ClipRRect(
                                                         //   borderRadius: BorderRadius.circular(29),
                                                         //   child:Image.asset(image,width: 200,height: 100,),
                                                         // ),
                                                         ClipRRect(
                                                           borderRadius: BorderRadius.circular(15),
                                                           child: Container(
                                                             color:c1?Y.withOpacity(0.7):Colors.black.withOpacity(0.3),
                                                             margin: EdgeInsets.only(top: 85),
                                                             child:Center(
                                                               child:Text('طقات خفيفة',
                                                                 textAlign: TextAlign.center,
                                                                 style: TextStyle(
                                                                   fontFamily: 'Changa',
                                                                   color: Colors.white,
                                                                   fontSize: 20.0,
                                                                   fontWeight: FontWeight.bold,
                                                                 ),
                                                               ),),),
                                                         ), ],),
                                                   ),
                                                 ),
                                               )
                                             ],
                                           ),
                                         ),
                                         Container(
                                           //color: Color(0xFF1C1C1C),
                                           margin: EdgeInsets.only(left: 5, top: 170, bottom: 0,right:10),
                                           width: 180,
                                           height: 140,
                                           child: Column(
                                             children: <Widget>[
                                               GestureDetector(
                                                 onTap: (){
                                                   c1=false;
                                                   c2=true;
                                                   setState(() {

                                                   });
                                                 },
                                                 child: Container(
                                                   height: 130,
                                                   // padding: EdgeInsets.all(5),
                                                   decoration: BoxDecoration(
                                                     color: Colors.white,
                                                     //border: Border.all(color: box2?Y:Colors.white, width:3),
                                                     borderRadius: BorderRadius.circular(15),
                                                   ),
                                                   child: Container(
                                                     decoration: BoxDecoration(
                                                       borderRadius: BorderRadius.circular(15),
                                                       image: DecorationImage(image: AssetImage('assets/work/intro1.jpg'),
                                                         fit: BoxFit.cover,
                                                       ),
                                                     ),
                                                     child:Stack(
                                                       children:<Widget>[
                                                         // ClipRRect(
                                                         //   borderRadius: BorderRadius.circular(29),
                                                         //   child:Image.asset(image,width: 200,height: 100,),
                                                         // ),
                                                         ClipRRect(
                                                           borderRadius: BorderRadius.circular(15),
                                                           child: Container(
                                                             color:c2?Y.withOpacity(0.7):Colors.black.withOpacity(0.3),
                                                             margin: EdgeInsets.only(top: 85),
                                                             child:Center(
                                                               child:Text('ورشات عمل',
                                                                 textAlign: TextAlign.center,
                                                                 style: TextStyle(
                                                                   fontFamily: 'Changa',
                                                                   color: Colors.white,
                                                                   fontSize: 20.0,
                                                                   fontWeight: FontWeight.bold,
                                                                 ),
                                                               ),),),
                                                         ), ],),
                                                   ),
                                                 ),
                                               )
                                             ],
                                           ),
                                         ),
                                       ],
                                     )
                                    ),
                                      Container(
                                          alignment: Alignment.center,

                                          margin: EdgeInsets.only(top: 400,),
                                          child:Text(' هناك نوعان من العمل طقات خفيفة تستغرق يوم واحد فقط *'+'\n'+'                  والعديد من الورشات التي قد تستغرق أيام و أسابيع',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                              fontFamily: 'Changa',
                                              //fontStyle: FontStyle.italic,
                                            ),)
                                      ),
                                    Container(
                                      height: 55,
                                      margin: EdgeInsets.only(top:649,),
                                      color:Y,
                                      width:600,
                                      // margin: EdgeInsets.only(left: 8,right: 15),
                                      child: FlatButton(
                                        onPressed: (){
                                          DateTime date=DateTime.now();
                                          print(date);
                                          if(c2){
                                            if(widget.work=="نجار")
                                              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => user()));
                                            else  if(widget.work=="كهربائي")
                                              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => sabak()));

                                          }
                                          else if(c1){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => My_SLot(tokenworker:widget.tokenworker,token_Me:widget.tokenuser,comment:widget.comment,client_count:widget.client_num,Experiance:widget.Experiance,Information:widget.Information,date:widget.time,country:widget.country,namelast:widget.namelast,namefirst:widget.namefirst,image:widget.image,nameworker:widget.name,work:widget.work,name_Me:widget.username,phoneworker: widget.phoneworker,phone: widget.phone,),),);
                                          }
                                          // Navigator.push(context, MaterialPageRoute(builder: (context) =>choose()));
                                        },
                                        color:Y,
                                        child: Text(
                                          "التالي",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 21.0,
                                            fontFamily: 'Changa',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                      ),
                  ],

                ),),
            ),),],),);
  }
}
