import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;


  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("StackoverFlow"),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _dialogCall(context);
        },
      ),
    );
  }

  Future<void> _dialogCall(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyDialog();
        });
  }
}

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {

  String imagePath;
  Image image;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            Container(
            width:200,
            height: 100,
            child: TextFormField(
            textAlign: TextAlign.right,
            maxLines: 20,
            style: TextStyle(
            color: Colors.grey.withOpacity(0.5),
            fontSize: 16.0,
            fontFamily: 'Changa',
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            hintText: 'أضف إعلاناتك هنا ',
            hintStyle: TextStyle(
              fontSize: 16.0,
              fontFamily: 'Changa',
              color: Colors.grey.withOpacity(0.5),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),
         ),
            Container(
              height: 200,
              width: 200,
              margin: EdgeInsets.only(top:20),
                child: image!= null? image:null),
            GestureDetector(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.image),
                    SizedBox(width: 5),
                  ],
                ),
                onTap: () async {
                  await getImageGallory();
                  setState(() {

                  });
                }),
            Padding(
              padding: EdgeInsets.all(8.0),
            ),
          ],
        ),
      ),
    );
  }


  Future getImageGallory() async {
    var x = await ImagePicker.pickImage(source: ImageSource.gallery);
    imagePath = x.path;
    image = Image(image: FileImage(x));
  }

}