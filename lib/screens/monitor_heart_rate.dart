import 'package:flutter/material.dart';
import 'package:smart_home/widgets/my_home_scaffold.dart';
import 'package:provider/provider.dart';
import '../providers/bluetooth_provider.dart';
import 'package:avatar_glow/avatar_glow.dart';

class MonitorHeartRate extends StatefulWidget {
  const MonitorHeartRate({Key? key}) : super(key: key);

  @override
  State<MonitorHeartRate> createState() => _MonitorHeartRateState();
}

class _MonitorHeartRateState extends State<MonitorHeartRate> {
  @override
  void initState() {
    Provider.of<BluetoothProvider>(context, listen: false)
        .sendMessageToBluetooth(7);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyHomeScaffold(
      appBarTitle: "Monitor Heart Rate",
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        AvatarGlow(
            animate: true,
            glowColor: Theme.of(context).primaryColor,
            endRadius: 75,
            child: Icon(
              Icons.favorite,
              color: Colors.red,
              size: MediaQuery.of(context).size.width * 0.2,
            )),
        Center(
          child: Text(
            "Your Heart Rate is : ${Provider.of<BluetoothProvider>(
              context,
              listen: true,
            ).heartRateReading}",
            style: const TextStyle(fontSize: 30),
          ),
        ),
      ]),
    );
  }
}
