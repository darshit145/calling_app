import 'package:calling_app/component/widget/custom_texts.dart';
import 'package:calling_app/utility/custom_list_tile.dart';
import 'package:calling_app/utility/resources.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';


class CallSaveList extends StatefulWidget {
  const CallSaveList({super.key});
  @override
  State<CallSaveList> createState() => _CallSaveListStaate();
}


class _CallSaveListStaate extends State<CallSaveList> {
  bool callPermition=false;
  SpeechToText _speechToText = SpeechToText();
  bool isMickIsEnabled = false;
  bool isListening = false;
  String nameForSearch = "";
  String spokenWord = "";
  TextEditingController _controller = TextEditingController();
  List<Contact> _contactzForThisPage = [];

  @override
  void dispose() {
    print("okokkookok");
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _contactzForThisPage = finalContact;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.blueGrey.shade600,
        automaticallyImplyLeading: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Container(
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              borderRadius: BorderRadius.all(Radius.circular(26))),
          child: Stack(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search_sharp)),
              const Positioned(
                  left: 49,
                  top: 10,
                  child: Text(
                    "",
                    // "Enter Name","
                    style: TextStyle(fontSize: 15),
                  )),
              Positioned(
                  // top: 1,
                  bottom: 1,
                  left: 40,
                  child: SizedBox(
                    width: WIDTH * 75 / 100,
                    // height: 45,

                    child: TextField(
                      autofocus: false,
                      controller: _controller,
                      cursorColor: Colors.black,
                      onChanged: (value) {
                        nameForSearch = value;
                        callPermition=false;
                        nameForSearch = nameForSearch.toLowerCase();
                        searchName();
                      },

                      // controller: _controller,

                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 1, horizontal: 12),
                          constraints: BoxConstraints(maxWidth: 120),
                          hintText: "Enter Name To ",
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    ),
                  )),
              Positioned(
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {},
                  )),
              Positioned(
                  right: 40,
                  child: IconButton(
                    onPressed: () {
                      voiceSearch(context);
                    },
                    icon: const Icon(Icons.mic),
                  ))
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            // image: DecorationImage(
            //   image: NetworkImage("https://cdn.wallpapersafari.com/24/55/cXtpE4.gif"),
            //   fit: BoxFit.fill
            // )
            ),
        child: ListView.builder(
          itemCount: _contactzForThisPage.length,
          itemBuilder: (context, index) {
            return CustomListTile.customListTile(
              context: context,
                object: _contactzForThisPage[index]);
          },
        ),
      ),
    );
  }

  Future<void> searchName() async {
    if (nameForSearch == "") {
      setState(() {
        _contactzForThisPage = finalContact;
      });
    } else if (nameForSearch.contains("call")&&callPermition) {
      var num = _contactzForThisPage.firstWhere((_element) {
        String Name = _element.displayName.toString().toLowerCase();
        return Name.contains("${nameForSearch.substring(5)}");
      });
      print(num.phones![0].value.toString());
      await FlutterPhoneDirectCaller.callNumber(
          num.phones![0].value.toString());
    } else {
      Iterable<Contact> r = _contactzForThisPage.where((_element) {
        String Name = _element.displayName.toString().toLowerCase();
        return Name.contains(nameForSearch);
      });
      _contactzForThisPage = r.toList();
      setState(() {});
      // print(r.first.displayName);
    }
  }

  Future<void> voiceSearch(BuildContext context) async {
    initOfListening();
    CustomAlert.alertDialogCustom(
        context,
        "Listening..",
        Container(
          height: HEIGHT * 20 / 100,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/R.gif"))),
        ));
    await Future.delayed(Duration(seconds: 4));
    Navigator.pop(context);
  }

  Future initOfListening() async {
    callPermition=true;
    isMickIsEnabled = await _speechToText.initialize();
    if (isMickIsEnabled) {
      statrListening();
    }
  }

  Future statrListening() async {
    await _speechToText.listen(onResult: onResult);
  }

  void onResult(SpeechRecognitionResult result) {
    setState(() {
      spokenWord = result.recognizedWords;
      _controller.clear();
      nameForSearch = spokenWord.toLowerCase();
      searchName();
      _controller.text = spokenWord;
    });

    print("Recognized words: $spokenWord");
  }
}
