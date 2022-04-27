import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LightBulb extends StatelessWidget {
  const LightBulb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.lightbulb,
      size: MediaQuery.of(context).size.width * 0.1,
      color: Colors.white,
    );
  }
}
