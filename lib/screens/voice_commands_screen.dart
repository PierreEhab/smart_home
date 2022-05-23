import 'package:flutter/material.dart';
import 'package:smart_home/services/speech_to_text.dart';
import 'package:avatar_glow/avatar_glow.dart';
import '../providers/bluetooth_provider.dart';
import '../widgets/my_home_scaffold.dart';
import 'package:provider/provider.dart';

class VoiceCommandsScreen extends StatefulWidget {
  const VoiceCommandsScreen({Key? key}) : super(key: key);

  @override
  State<VoiceCommandsScreen> createState() => _VoiceCommandsScreenState();
}

class _VoiceCommandsScreenState extends State<VoiceCommandsScreen> {
  String text = 'Press the button and start speaking';
  bool isListening = false;

  @override
  Widget build(BuildContext context) {
    return MyHomeScaffold(
      appBarTitle: "Voice Commands",
      body: SingleChildScrollView(
        reverse: true,
        padding: const EdgeInsets.all(30).copyWith(bottom: 150),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 200,),
          const Center(
            child: Text(
              "Available Commands:\n- turn the lights on\n- turn the lights off\n- open the door\n- close the door\n- what is the temperature",
            ),
          ),
        ]),
      ),
      floatingActionButton: AvatarGlow(
        animate: isListening,
        endRadius: 75,
        glowColor: Theme.of(context).primaryColor,
        child: FloatingActionButton(
          onPressed: toggleRecording,
          child: Icon(isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
    );
  }

  Future toggleRecording() => SpeechApi.toggleRecording(
        onResult: (text) => setState(() {
          this.text = text;
          if (text == "turn the lights on") {
            print("lights on");
            Provider.of<BluetoothProvider>(context, listen: false)
                .sendMessageToBluetooth(1);
          } else if (text == "turn the lights off") {
            print("lights off");
            Provider.of<BluetoothProvider>(context, listen: false)
                .sendMessageToBluetooth(0);
          } else if (text == "open the door") {
            print("door opened");
            Provider.of<BluetoothProvider>(context, listen: false)
                .sendMessageToBluetooth(3);
          } else if (text == "close the door") {
            print("door closed");
            Provider.of<BluetoothProvider>(context, listen: false)
                .sendMessageToBluetooth(6);
          } else if (text == "what is the temperature") {
            Provider.of<BluetoothProvider>(context, listen: false)
                .sendMessageToBluetooth(2);
          }
        }),
        onListening: (isListening) {
          setState(() => this.isListening = isListening);
        },
      );
}
