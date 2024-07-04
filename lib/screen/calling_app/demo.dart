import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

import 'demo2.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          // final List<Contact> li=await ContactsService.getContacts();
          // print(li[0].avatar.toString());
          // print(li[0].avatar?.isEmpty);

          Navigator.push(context, MaterialPageRoute(builder: (context) => Demo2(),));
        },
      ),
    );
  }
}




/*

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  SpeechToText _speechToText = SpeechToText();
  String wordSpoken = "";
  bool isMicEnabled = false;
  bool isListening = false;

  @override
  void initState() {
    super.initState();
    initOfListening();
  }

  void initOfListening() async {
    isMicEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void startListening() async {
    if (isMicEnabled && !_speechToText.isListening) {
      await _speechToText.listen(onResult: onResult);
      setState(() {
        isListening = true;
      });
    }
  }

  void onResult(result) {
    setState(() {
      wordSpoken = result.recognizedWords;
    });
  }

  void stopListening() async {
    if (_speechToText.isListening) {
      await _speechToText.stop();
      setState(() {
        isListening = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_speechToText.isListening) {
            stopListening();
          } else {
             startListening();
          }
          print(wordSpoken);
        },
        child: Icon(_speechToText.isListening ? Icons.mic : Icons.mic_none),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Press the button and start speaking...',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              wordSpoken,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
*/
