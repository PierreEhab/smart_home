import 'package:flutter/material.dart';
import 'package:smart_home/widgets/my_home_scaffold.dart';
import 'package:provider/provider.dart';
import '../providers/bluetooth_provider.dart';

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
      body: Center(
        child: Text("Your Heart Rate is : ${Provider.of<BluetoothProvider>(context, listen: true,)
            .heartRateReading}",style: TextStyle(fontSize: 30),),
      ),
    );
  }
}
