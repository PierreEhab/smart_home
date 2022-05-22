import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bluetooth_provider.dart';

class PasswordPopUp extends StatelessWidget {
  PasswordPopUp({Key? key}) : super(key: key);
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Please Enter The Password."),
          TextField(
            controller: passwordController,
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Cancel",
          ),
          style: TextButton.styleFrom(
            primary: Colors.red,
          ),
        ),
        TextButton(
          onPressed: () {
            if(passwordController.text == "1234") {
              Provider.of<BluetoothProvider>(context, listen: false).sendMessageToBluetooth(3);
            } else{
              if(Provider.of<BluetoothProvider>(context, listen: false).wrongPasswordCount >= 3){
                Provider.of<BluetoothProvider>(context, listen: false).sendMessageToBluetooth(5);
                Provider.of<BluetoothProvider>(context, listen: false).wrongPasswordCount = 0;
              }
              else{
                Provider.of<BluetoothProvider>(context, listen: false).sendMessageToBluetooth(4);
                print(Provider.of<BluetoothProvider>(context, listen: false).wrongPasswordCount);
                Provider.of<BluetoothProvider>(context, listen: false).wrongPasswordCount +=1;
                print(Provider.of<BluetoothProvider>(context, listen: false).wrongPasswordCount);
              }
            }
              Navigator.pop(context);
          },
          child: const Text(
            "Open",
          ),
          style: TextButton.styleFrom(
            primary: Colors.green,
          ),
        ),
      ],
    );
  }
}
