// TODO Implement this library.
import 'package:flutter/material.dart';

class AudioRecorderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Recorder'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          'Audio Recorder Screen',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 33, 211, 17),
          ),
        ),
      ),
    );
  }
}
