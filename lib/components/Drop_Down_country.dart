import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String text;
  final width;
  const CustomDropdown({Key key, @required this.text,this.width}) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  GlobalKey actionKey;
  double height, width, xPosition, yPosition;
  bool isDropdownOpened = false;
  OverlayEntry floatingDropdown;

  @override
  void initState() {
    actionKey = LabeledGlobalKey(widget.text);
    super.initState();
  }

  void findDropdownData() {
    RenderBox renderBox = actionKey.currentContext.findRenderObject();
    height = renderBox.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
    print(height);
    print(width);
    print(xPosition);
    print(yPosition);
  }

  OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: xPosition,
        width: widget.width*0.8,
        top: yPosition + height,
        height: 500,
        child: DropDown(
          itemHeight: 30,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: actionKey,
      onTap: () {
        setState(() {
          if (isDropdownOpened) {
            floatingDropdown.remove();
          } else {
            findDropdownData();
            floatingDropdown = _createFloatingDropdown();
            Overlay.of(context).insert(floatingDropdown);
          }
          isDropdownOpened = !isDropdownOpened;
        });
      },
      child: Container(
        height: 60,
        width: widget.width*0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.grey[100],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
        child: Row(
          children: <Widget>[
            Text(
              'اختيار منطقة',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Changa',
                color: Color(0xFF666360),
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              Icons.location_on,
              color: Color(0xFF666360),
              size: 27,
            ),
          ],
        ),
      ),
    );
  }
}

class DropDown extends StatelessWidget {
  final double itemHeight;

  const DropDown({Key key, this.itemHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 5,
        ),
        Align(
           alignment: Alignment(-0.85, 0),
          child: ClipPath(
            clipper: ArrowClipper(),
            child: Container(
              height: 20,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
        ),
        Material(
          elevation: 5,
          //shape: ArrowShape(),
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child:SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // Text('SARAh'),
                DropDownItem("جنين"),
                DropDownItem("نابلس"),
                DropDownItem("طوباس"),
                DropDownItem("طولكرم"),
                DropDownItem("رام الله"),
                DropDownItem("بيت لحم"),
                DropDownItem("الخليل"),
                DropDownItem("قلقيلية"),
                DropDownItem("عكا"),
                DropDownItem("حيفا"),
                DropDownItem("يافا"),
              ],
            ),
          ),
        ),
        ),],
      );
  }
  Widget DropDownItem(String text) {

    return Directionality(textDirection: TextDirection.ltr,
    child:Container(
      width:300,
      height: 50,
      alignment: Alignment.topRight,
      decoration: BoxDecoration(
        color:Colors.white,
      ),
      //margin: EdgeInsets.only(right: 16,),
      padding: EdgeInsets.only(left: 50, top: 8,bottom: 8),
      child: Container(
        width: 100,
        margin: EdgeInsets.only(right: 5,),
        padding: EdgeInsets.only(right: 5,),
        alignment: Alignment.topRight,
        child:FlatButton(
         onPressed: (){
           print(text);
         },
        child: Text(text,
          style: TextStyle(
            fontSize: 16.0,
            fontFamily: 'Changa',
            color: Color(0xFF666360),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),),);
  }
}

class ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class ArrowShape extends ShapeBorder {
  @override
  // TODO: implement dimensions
  EdgeInsetsGeometry get dimensions => throw UnimplementedError();

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    // TODO: implement getInnerPath
    throw UnimplementedError();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    // TODO: implement getOuterPath
    return getClip(rect.size);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    // TODO: implement paint
  }

  @override
  ShapeBorder scale(double t) {
    // TODO: implement scale
    throw UnimplementedError();
  }

  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);

    return path;
  }
}