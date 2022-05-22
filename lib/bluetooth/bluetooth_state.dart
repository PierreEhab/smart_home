import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:smart_home/providers/bluetooth_provider.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/screens/home_screen.dart';
import 'package:provider/provider.dart';

class BluetoothApp extends StatefulWidget {
  const BluetoothApp({Key? key}) : super(key: key);

  @override
  _BluetoothAppState createState() => _BluetoothAppState();
}

class _BluetoothAppState extends State<BluetoothApp> {

  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (Provider.of<BluetoothProvider>(context, listen: false)
        .devicesList.isEmpty) {
      items.add(const DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      Provider.of<BluetoothProvider>(context, listen: false)
          .devicesList.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name.toString()),
          value: device,
        ));
      });
    }
    return items;
  }

  @override
  void initState() {
    super.initState();

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      Provider.of<BluetoothProvider>(context, listen: false)
      .bluetoothState = state;
    });

    Provider.of<BluetoothProvider>(context, listen: false)
    .deviceState = 0; // neutral

    // If the Bluetooth of the device is not enabled,
    // then request permission to turn on Bluetooth
    // as the app starts up
    Provider.of<BluetoothProvider>(context, listen: false)
        .enableBluetooth();
    // Listen for further state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        Provider.of<BluetoothProvider>(context, listen: false)
        .bluetoothState = state;

        // For retrieving the paired devices list
        Provider.of<BluetoothProvider>(context, listen: false)
            .getPairedDevices();
      });
    });


  }

  @override
  void dispose() {
    if ( Provider.of<BluetoothProvider>(context, listen: false)
        .isConnected) {
      Provider.of<BluetoothProvider>(context, listen: false)
          .isDisconnecting = true;
      Provider.of<BluetoothProvider>(context, listen: false)
          .connection!.dispose();
      Provider.of<BluetoothProvider>(context, listen: false)
          .connection = null;
    }
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    bool isBluetoothOn =  Provider.of<BluetoothProvider>(context, listen: false)
        .bluetoothState.isEnabled;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Connect To Home"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Provider.of<BluetoothProvider>(context, listen: false)
                        .bluetoothState.isEnabled ? Text("Bluetooth (On)") : const Text(
                        "Bluetooth (Off)"),
                    Switch(
                      value:  Provider.of<BluetoothProvider>(context, listen: false)
                          .bluetoothState.isEnabled,
                      onChanged: (bool value) {
                        future() async {
                          if (value) {
                            // Enable Bluetooth
                            await FlutterBluetoothSerial.instance
                                .requestEnable();
                          } else {
                            // Disable Bluetooth
                            await FlutterBluetoothSerial.instance
                                .requestDisable();
                          }

                          // In order to update the devices list
                          await  Provider.of<BluetoothProvider>(context, listen: false)
                              .getPairedDevices();
                          Provider.of<BluetoothProvider>(context, listen: false)
                              .isButtonUnavailable = false;

                          // Disconnect from any device before
                          // turning off Bluetooth
                          if ( Provider.of<BluetoothProvider>(context, listen: false)
                              .connected) {
                            Provider.of<BluetoothProvider>(context, listen: false)
                                .disconnect();
                          }
                        }

                        future().then((_) {
                          setState(() {});
                        });
                      },
                    ),
                  ],

                ),
              ),
              DropdownButton(
                items: _getDeviceItems(),
                onChanged: (BluetoothDevice? value) =>
                    setState(() =>  Provider.of<BluetoothProvider>(context, listen: false)
                        .device = value),
                value:  Provider.of<BluetoothProvider>(context, listen: false)
                    .devicesList.isNotEmpty ?  Provider.of<BluetoothProvider>(context, listen: false)
                    .device : null,
              ),
              RaisedButton(
                onPressed:(){
                  print( Provider.of<BluetoothProvider>(context, listen: false)
        .isButtonUnavailable);
                  print( Provider.of<BluetoothProvider>(context, listen: false)
        .connected);
                  if (! Provider.of<BluetoothProvider>(context, listen: false)
        .isButtonUnavailable){
                    if( Provider.of<BluetoothProvider>(context, listen: false)
        .connected){
    Provider.of<BluetoothProvider>(context, listen: false)
        .disconnect();
                    }else{
    Provider.of<BluetoothProvider>(context, listen: false)
        .connect();
                    }
                  }
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                },

                child:
                Text( Provider.of<BluetoothProvider>(context, listen: false)
        .connected ? 'Disconnect' : 'Connect'),
              ),
             //  // ON button
             //  FlatButton(
             //    onPressed: _connected
             //        ? _sendOnMessageToBluetooth
             //        : null,
             //    child: Text("ON"),
             //  ),
             // // OFF button
             //  FlatButton(
             //    onPressed: _connected
             //        ? _sendOffMessageToBluetooth
             //        : null,
             //    child: Text("OFF"),
             //  )

            ],
          ),
        ),
      ),
    );
  }
}
