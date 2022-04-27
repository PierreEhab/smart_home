import 'package:flutter/material.dart';
import 'package:smart_home/widgets/rounded_inkwell.dart';

import '../widgets/light_bulb.dart';

class LedControllerScreen extends StatelessWidget {
  const LedControllerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Led Controller"),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedInkwell(
            child: const LightBulb(),
            text: "Turn On",
            onTap: () {},
            color: Colors.green,
          ),
          RoundedInkwell(
            child: const LightBulb(),
            text: "Turn Off",
            onTap: () {},
            color: Colors.red,
          ),
        ],
      )),
    );
  }
}
