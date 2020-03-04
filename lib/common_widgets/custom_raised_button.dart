import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final Function onPressed;
  final double borderRadius;
  final double height;
  CustomRaisedButton(
      {this.child, this.color, this.borderRadius: 4, this.onPressed,this.height:50});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
        child: child,
        color: color,
      ),
    );
  }
}
