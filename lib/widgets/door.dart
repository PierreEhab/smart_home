import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Door extends StatelessWidget {
  const Door({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.sensor_door,
      size: MediaQuery.of(context).size.width * 0.1,
      color: Colors.white,
    );
  }
}
