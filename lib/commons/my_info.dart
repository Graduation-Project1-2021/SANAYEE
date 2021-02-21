import 'package:flutterphone/commons/radial_progress.dart';
import 'package:flutterphone/commons/rounded_image.dart';
import 'package:flutterphone/styleguide/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Container(
            alignment: Alignment.topRight,
            // margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            child:RadialProgress(
            width: 4,
            goalCompleted: 1,
            child: RoundedImage(
              imagePath: "assets/icons/signup.jpg",
              size: Size.fromWidth(120.0),
            ),
          ),),
          SizedBox(height: 10,),
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                child:IconTheme(
                  data: IconThemeData(
                    color: Colors.yellowAccent,
                    size: 35.0,
                  ),
                  child: StarDisplay(value: 3),
                ),),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0,0),
              child:Text(
                "النجار محمد",
                style:TextStyle(
                  color: Colors.white,
                  fontSize: 35.0,
                  fontWeight: FontWeight.w900,
                ),
              ),),
              Text(
                "",
                style: whiteNameTextStyle,
              ),
            ],
          ),
          SizedBox(height: 10,),
          // Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       Image.asset(
          //         "assets/icons/location_pin.png",
          //         width: 20.0,
          //         color: Colors.white,
          //       ),
          //       Text(
          //         "  34 kilometers",
          //         style: whiteSubHeadingTextStyle,
          //       )
          //     ],
          // ),
        ],
      ),
    );
  }
}
class StarDisplay extends StatelessWidget {
  final int value;

  const StarDisplay({Key key, this.value = 0})
      : assert(value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
        );
      }),
    );
  }
}
