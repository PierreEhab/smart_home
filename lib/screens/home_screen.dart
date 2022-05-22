import 'package:flutter/material.dart';
import 'package:smart_home/screens/door_controller_screen.dart';
import 'package:smart_home/screens/leds_controller_screen.dart';
import 'package:smart_home/screens/monitor_heart_rate.dart';
import 'package:smart_home/widgets/door.dart';
import 'package:smart_home/widgets/light_bulb.dart';
import 'package:smart_home/widgets/my_home_scaffold.dart';
import 'package:smart_home/widgets/rounded_inkwell.dart';
import '../providers/bluetooth_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyHomeScaffold(
      appBarTitle: "Smart Home",
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
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
                RoundedInkwell(
                  onTap: () {
                    Provider.of<BluetoothProvider>(context, listen: false)
                        .sendMessageToBluetooth(2);
                  },
                  child: Icon(
                    Icons.thermostat_rounded,
                    size: MediaQuery.of(context).size.width * 0.1,
                    color: Colors.white,
                  ),
                  text: "Check Temperature",
                ),
                RoundedInkwell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DoorControllerScreen(),
                      ),
                    );
                  },
                  child: const Door(),
                  text: "Control The Door",
                ),
                RoundedInkwell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MonitorHeartRate(),
                      ),
                    ).then((value) => Provider.of<BluetoothProvider>(context, listen: false)
                        .sendMessageToBluetooth(8));
                  },
                  child: Icon(
                    Icons.favorite,
                    size: MediaQuery.of(context).size.width * 0.1,
                    color: Colors.white,
                  ),
                  text: "Monitor Heart Rate",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
