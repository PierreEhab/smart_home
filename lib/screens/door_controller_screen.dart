import 'package:flutter/material.dart';
import 'package:smart_home/widgets/password_pop_up.dart';
import 'package:smart_home/widgets/rounded_inkwell.dart';
import 'package:provider/provider.dart';
import '../providers/bluetooth_provider.dart';
import '../widgets/door.dart';

class DoorControllerScreen extends StatelessWidget {
  const DoorControllerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Door Controller"),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedInkwell(
                child: const Door(),
                text: "Open The Door",
                onTap: () {
                  showDialog(context: context, builder: (context)=>PasswordPopUp());
                },
                color: Colors.green,
              ),
              RoundedInkwell(
                child: const Door(),
                text: "Close The Door",
                onTap: () {
                  Provider.of<BluetoothProvider>(context, listen: false)
                      .sendMessageToBluetooth(6);
                },
                color: Colors.red,
              ),
            ],
          )),
    );
  }
}
