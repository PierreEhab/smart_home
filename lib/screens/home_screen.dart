import 'package:flutter/material.dart';
import 'package:smart_home/screens/leds_controller_screen.dart';
import 'package:smart_home/widgets/light_bulb.dart';
import 'package:smart_home/widgets/rounded_inkwell.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Home"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedInkwell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LedControllerScreen(),
                    ),
                  );
                },
                child: const LightBulb(),
                text: "Control Leds",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
