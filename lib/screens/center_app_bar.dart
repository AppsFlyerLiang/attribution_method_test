import 'package:flutter/material.dart';

class CenterAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30, bottom: 30),
      child: Column(
        children: <Widget>[
          Image(image: AssetImage("assets/images/af_logo.png"), height: 40, fit: BoxFit.contain),
          Text(
            'Attribution Method\nTest App',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white,
                shadows: [Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 4)]),

          ),
        ],
      ),
    );
  }
}
