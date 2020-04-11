import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final EdgeInsetsGeometry margin;
  final BoxDecoration decoration;
  GradientButton({
    this.buttonText,
    this.onPressed,
    this.width,
    this.height,
    this.margin,
    this.decoration = const BoxDecoration(
      gradient:  LinearGradient(colors: [Colors.lightBlueAccent, Colors.indigo, Colors.indigo],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: RaisedButton(
        color: Colors.transparent,
        padding: EdgeInsets.all(0.0),
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))
        ),

        child: Ink(
          decoration: decoration,
          child: Container(
            constraints: const BoxConstraints(minWidth: 80.0, minHeight: 50.0),
            // min sizes for Material buttons
            alignment: Alignment.center,
            child: Text(buttonText, textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.white.withAlpha(212), fontWeight: FontWeight.bold, shadows: [Shadow(color: Colors.black87, offset: Offset(1, 1), blurRadius: 2)]),),
          ),
        ),
        onPressed: () { onPressed(); }
      ),
    );
  }
}
