// TODO Implement this library.
import 'package:flutter/material.dart';

class TextToSpeech extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text to Speech'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          'Text to Speech Screen',
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
