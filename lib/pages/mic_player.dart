// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:permission_handler/permission_handler.dart';

// class MicPlayerPage extends StatefulWidget {
//   @override
//   _MicPlayerPageState createState() => _MicPlayerPageState();
// }

// class _MicPlayerPageState extends State<MicPlayerPage> {
//   FlutterSoundRecorder? _soundRecorder;
//   FlutterSoundPlayer? _soundPlayer;
//   bool isRecording = false;

//   @override
//   void initState() {
//     super.initState();
//     _soundRecorder = FlutterSoundRecorder();
//     _soundPlayer = FlutterSoundPlayer();
//     _initAudio();
//   }

//   Future<void> _initAudio() async {
//     await Permission.microphone.request();
//     await _soundRecorder!.openAudioSession();
//     await _soundPlayer!.openAudioSession();
//   }

//   Future<void> _toggleRecording() async {
//     if (isRecording) {
//       await _stopRecording();
//     } else {
//       await _startRecording();
//     }
//   }

//   Future<void> _startRecording() async {
//     await _soundRecorder!.startRecorder(
//       toStream: (Stream<List<int>> data) {
//         _soundPlayer!.startPlayerFromStream(
//           stream: data,
//           codec: Codec.pcm16,
//         );
//       },
//     );
//     setState(() {
//       isRecording = true;
//     });
//   }

//   Future<void> _stopRecording() async {
//     await _soundRecorder!.stopRecorder();
//     await _soundPlayer!.stopPlayer();
//     setState(() {
//       isRecording = false;
//     });
//   }

//   @override
//   void dispose() {
//     _soundRecorder!.closeAudioSession();
//     _soundPlayer!.closeAudioSession();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Live Microphone to Speaker'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _toggleRecording,
//           child: Text(isRecording ? 'Stop' : 'Start'),
//         ),
//       ),
//     );
//   }
// }
