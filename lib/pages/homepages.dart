import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sound_stream/sound_stream.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:lottie/lottie.dart';

import 'package:flutter_application_11/main.dart';
import 'package:flutter_application_11/pages/texttospeech.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final RecorderStream _recorder = RecorderStream();
  final PlayerStream _player = PlayerStream();
  bool _isLive = false;
  StreamSubscription<List<int>>? _audioStreamSubscription;

  @override
  void initState() {
    super.initState();
    _initAudioStreams();
  }

  Future<void> _initAudioStreams() async {

    await Permission.microphone.request();
    await Permission.bluetoothConnect.request();


    await _recorder.initialize();
    await _player.initialize();
  }

  void _toggleLiveMic() async {
    if (_isLive) {

      await _recorder.stop();
      await _player.stop();
      await _audioStreamSubscription?.cancel();
      _audioStreamSubscription = null;
    } else {

      await _player.start();

      _audioStreamSubscription = _recorder.audioStream.listen((data) {
        _player.writeChunk(data);
      });

      await _recorder.start();
    }

    setState(() {
      _isLive = !_isLive;
    });
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AudioRecorderScreen()));
  }

  void _textToSpeech(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => TextToSpeech()));
  }

  void _openBluetoothSettings() async {
    if (Platform.isAndroid) {
      try {
        final intent = AndroidIntent(
          action: 'android.settings.BLUETOOTH_SETTINGS',
          flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
        );
        await intent.launch();
      } catch (e) {
        print('Error opening Bluetooth settings: $e');
      }
    } else if (Platform.isIOS) {
      print('Cannot open Bluetooth settings on iOS programmatically.');
    }
  }

  @override
  void dispose() {
    _recorder.dispose();
    _player.dispose();
    _audioStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 13, 13, 13),
      appBar: AppBar(
        title: Text(
          "N E U R O  V I B E S",
          style: TextStyle(color: Color.fromARGB(255, 252, 253, 252)),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 15, 15, 15),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  "     P E R S O N A L I Z E   Y O U R   S O U N D          E X P E R I E N C E",
                  style: TextStyle(
                    color: Color.fromARGB(182, 238, 240, 238),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 100),
              GestureDetector(
                onTap: () {
                  _openBluetoothSettings();
                },
                child: Lottie.asset(
                  'lib/GIF/bluetooth.json',
                  width: 150,
                  height: 150,
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 83, 120, 255),
                      Color.fromARGB(255, 134, 53, 255),
                       Color.fromARGB(255, 255, 92, 170),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: GestureDetector(
                        onTap: () {
                          _textToSpeech(context);
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.black,
                          ),
                          child: Center(
                            child: Text(
                              "T E X T   T O   S P E E C H",
                              style: TextStyle(
                                color: Color.fromARGB(182, 241, 242, 241),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () {
                          _navigateToNextScreen(context);
                        },
                        child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          child: Text(
                            "R  E  C  O  R  D",
                            style: TextStyle(
                              color: Color.fromARGB(255, 242, 243, 242),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: _isLive ? Colors.red : Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () {
                          _toggleLiveMic();
                        },
                        child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          child: Text(
                            _isLive ? "STOP LIVE MIC" : "L I V E   M I C",
                            style: TextStyle(
                              color: Color.fromARGB(255, 246, 248, 246),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
