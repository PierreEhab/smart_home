import 'package:flutter/material.dart';
import 'package:smart_home/bluetooth/bluetooth_state.dart';
import 'package:smart_home/providers/bluetooth_provider.dart';
import 'package:smart_home/screens/home_screen.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: BluetoothProvider()),
      ],
      child: MaterialApp(
        title: 'Smart Home',
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        home: const BluetoothApp(),
      ),
    );
  }
}

