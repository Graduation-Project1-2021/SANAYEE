import 'package:flutter/material.dart';

class DismissibleWidget<T> extends StatelessWidget {
  final T item;
  final Widget child;
  final DismissDirectionCallback onDismissed;

  const DismissibleWidget({
    @required this.item,
    @required this.child,
    @required this.onDismissed,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Dismissible(
        key: ObjectKey(item),
         secondaryBackground:buildSwipeAction(),
         background: buildSwipeActionLeft(),
        child: child,
        //onDismissed: onDismissed,
      );

  Widget buildSwipeActionLeft() => Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.green,
        child: Icon(Icons.archive_sharp, color: Colors.white, size: 32),
      );

  Widget buildSwipeActionRight() => Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: Icon(Icons.delete_forever, color: Colors.white, size: 32),
      );
  Widget buildSwipeAction() => Container(
    color: Colors.red,
    alignment: Alignment.topLeft,
    padding: EdgeInsets.symmetric(horizontal: 0),
    child:Row(
    children: [
      GestureDetector(
        child: Icon(Icons.delete_forever, color: Colors.white, size: 32),
      ),
      GestureDetector(
        child: Icon(Icons.archive_sharp, color: Colors.white, size: 32),
      ),
    ],
    ),);
}
