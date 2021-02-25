import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'change_pass.dart';
import 'edit_profile.dart';
import 'PROFILE_PAGE_WORKER.dart';

//import 'edit_profile.dart';
//import 'changePassword.dart';

class SettingPage extends StatefulWidget {

  final  name;
  final  phone;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;

  SettingPage({this.name, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token});

  @override
  _SettingsPageState createState() => _SettingsPageState();

}
class _SettingsPageState extends State<SettingPage> {
  final formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
      body: Form(key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
        Container(
        child: Stack(
          children: [

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
          margin: EdgeInsets.fromLTRB(100, 40, 1, 100),
          child: IconButton(
            alignment: Alignment.topRight,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => PROFILE(name:widget.name)));

            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30.0,
            ),
          ),
        ),
            // Container(
            //   margin: EdgeInsets.fromLTRB(1, 40, 300, 1),
            //   child: Text(
            //     'الإعدادت',
            //     style:TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold,fontFamily: 'Changa',color: Colors.white,),
            //   ),
            // ),
            Container(
              margin: EdgeInsets.fromLTRB(80, 130, 50, 1),
              child: Text(
                'حسابي',
                style:TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold,fontFamily: 'Changa',color: Colors.white,),
              ),
            ),
          Container(
            margin: EdgeInsets.fromLTRB(100, 130, 1, 1),
            child:Icon(
              Icons.person,
              color: Colors.white,
              size: 50.0,
            ),
          ),
          ],),),
            SizedBox(
              height: 40,
            ),
            changepassword(context, "تغيير كلمة السر"),
            update(context, "تعديل المعلومات الشخصية"),
            buildAccountOptionRow(context, "معلومات الاتصال"),
            buildAccountOptionRow(context, "طلبات الحجوزات"),
            buildAccountOptionRow(context, "اضافة اعمال جديدة "),
            SizedBox(
              height: 40,
            ),
            Container(margin: EdgeInsets.symmetric(horizontal: 20),
            child:Row(
              children: [
                Icon(
                  Icons.volume_up_outlined,
                  color: Colors.purple,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "الإشعارات",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildNotificationOptionRow("New for you", true),
            buildNotificationOptionRow("Account activity", true),
            buildNotificationOptionRow("Opportunity", false),
            SizedBox(
              height: 10,
            ),
            Center(
              child: OutlineButton(
                padding: EdgeInsets.symmetric(horizontal: 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {},
                child: Text("تسجيل الخروج",
                    style: TextStyle(
                        fontSize: 16, letterSpacing: 2.2, color: Colors.black)),
              ),
            )
          ],),
      ),),),);
  }
  Container buildNotificationOptionRow(String title, bool isActive) {

    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child:Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: isActive,
              onChanged: (bool val) {},
            ))
      ],
        ),);
  }

  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Option 1"),
                    Text("Option 2"),
                    Text("Option 3"),
                  ],
                ),
                actions: [
                  FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),

                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SettingPage(name:widget.name,phone:widget.phone,image:widget.image,Work:widget.Work,Experiance:widget.Experiance,Information:widget.Information,token:widget.token)),
                        );
                      },
                      // Navigator.of(context).();

                      child: Text("Close",style: TextStyle(fontSize: 24.0))),

                ],
              );
            });
      },
      child: Padding(
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
    );
  }

  GestureDetector update(BuildContext context, String title) {

    return GestureDetector(
      onTap: () {Navigator.push(context,
        MaterialPageRoute(builder: (context) => SettingsUI(name:widget.name,phone:widget.phone,image:widget.image,Work:widget.Work,Experiance:widget.Experiance,Information:widget.Information,token:widget.token)),
      );},
      child: Padding(
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
    );
  }

  GestureDetector changepassword(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {Navigator.push(context,
        MaterialPageRoute(builder: (context) => ChangePass(name:widget.name,phone:widget.phone,image:widget.image,Work:widget.Work,Experiance:widget.Experiance,Information:widget.Information,token:widget.token)),
      );},

      child: Padding(
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