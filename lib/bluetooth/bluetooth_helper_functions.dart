import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothHelperFunctions {
  static Future<List<BluetoothDevice>> enableBluetooth(BluetoothState bluetoothState,FlutterBluetoothSerial bluetooth,List<BluetoothDevice> devicesList) async {
    // Retrieving the current Bluetooth state
    bluetoothState = await FlutterBluetoothSerial.instance.state;

    // If the Bluetooth is off, then turn it on first
    // and then retrieve the devices that are paired.
    if (bluetoothState == BluetoothState.STATE_OFF) {
      await FlutterBluetoothSerial.instance.requestEnable();
      devicesList = await getPairedDevices(bluetooth);
      return devicesList;
    } else {
      devicesList = await getPairedDevices(bluetooth);
      return devicesList;
    }
    return devicesList;
  }
  static Future<List<BluetoothDevice>> getPairedDevices(FlutterBluetoothSerial bluetooth) async {
    List<BluetoothDevice> devices = [];

    // To get the list of paired devices
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {
      print("Error");
    }
    // Store the [devices] list in the [_devicesList] for accessing
    // the list outside this class
      return devices;
  }
  static void handleBluetoothConnection(){

  }
}