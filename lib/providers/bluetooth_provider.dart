import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothProvider extends ChangeNotifier{
  // Initializing the Bluetooth connection state to be unknown
  BluetoothState bluetoothState = BluetoothState.UNKNOWN;

  // Get the instance of the Bluetooth
  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;

  // Track the Bluetooth connection with the remote device
  BluetoothConnection? connection;

  // To track whether the device is still connected to Bluetooth
  bool get isConnected => connection != null && connection!.isConnected;

  int? deviceState;

  bool isDisconnecting = false;

  // for storing the devices list
  List<BluetoothDevice> devicesList = [];

  // the current device connectivity status
  bool connected = false;

  bool isButtonUnavailable = false;
  BluetoothDevice? device;

  Future<void> enableBluetooth() async {
    // Retrieving the current Bluetooth state
    bluetoothState = await FlutterBluetoothSerial.instance.state;

    // If the Bluetooth is off, then turn it on first
    // and then retrieve the devices that are paired.
    if (bluetoothState == BluetoothState.STATE_OFF) {
      await FlutterBluetoothSerial.instance.requestEnable();
      await getPairedDevices();
    } else {
      await getPairedDevices();
    }
  }

  Future<void> getPairedDevices() async {
    List<BluetoothDevice> devices = [];

    // To get the list of paired devices
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {
      print("Error");
    }

    // Store the [devices] list in the [devicesList] for accessing
    // the list outside this class
      devicesList = devices;
  }


  void sendOnMessageToBluetooth() async {
    String message = "1\r\n";
    List<int> list = message.codeUnits;
    Uint8List bytes = Uint8List.fromList(list);
    connection!.output.add(bytes);
    await connection!.output.allSent;
    // show('Device Turned On');
    deviceState = 1; // device on
  }

// Method to send message
// for turning the Bluetooth device off
  void sendOffMessageToBluetooth() async {
    String message = "0\r\n";
    List<int> list = message.codeUnits;
    Uint8List bytes = Uint8List.fromList(list);
    connection!.output.add(bytes);
    await connection!.output.allSent;
    print("turned off");
    // show('Device Turned Off');
    deviceState = -1; // device off
  }


  void connect() async {
    if (device == null) {
      // show('No device selected');
    } else {
      // If a device is selected from the
      // dropdown, then use it here
      if (!isConnected) {
        // Trying to connect to the device using
        // its address
        await BluetoothConnection.toAddress(device!.address)
            .then((connection) {
          print('Connected to the device');
          connection = connection;

          // Updating the device connectivity
          // status to [true]
            connected = true;

          // This is for tracking when the disconnecting process
          // is in progress which uses the [isDisconnecting] variable
          // defined before.
          // Whenever we make a disconnection call, this [onDone]
          // method is fired.
          connection!.input!.listen(null).onDone(() {
            if (isDisconnecting) {
              print('Disconnecting locally!');
            } else {
              print('Disconnected remotely!');
            }
          });
        }).catchError((error) {
          print('Cannot connect, exception occurred');
          print(error);
        });
        // show('Device connected');
      }
    }
  }

  void disconnect() async {
    // Closing the Bluetooth connection
    await connection!.close();
    // show('Device disconnected');

    // Update the [connected] variable
    if (!connection!.isConnected) {
        connected = false;
    }
  }
}