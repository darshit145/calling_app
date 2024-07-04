//
// import 'package:contacts_service/contacts_service.dart' as cs;
// import 'package:contacts_service/contacts_service.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_to_text.dart';
// import '../../component/widget/custom_call_button.dart';
// import 'package:calling_app/screen/calling_app/call_save_list.dart';
//
// import '../../utility/phone_numbar_model.dart';
//
// //globalListForContacts
// class SearchContactOnText extends StatefulWidget {
//   bool isMike;
//   SearchContactOnText({super.key,required this.isMike});
//
//   @override
//   State<SearchContactOnText> createState() => _SearchContactOnTextState();
// }
//
// class _SearchContactOnTextState extends State<SearchContactOnText> {
//   TextEditingController controller=TextEditingController();
//   SpeechToText _speechToText=SpeechToText();
//   bool isListening=false;
//   bool isMickIsEnabled=false;
//   String spokenWord='';
//
//
//   List<PhoneNumbarModel> searchedList = [];
//
//   void initState() {
//     super.initState();
//     searchedList = globalListForContacts;
//     if(widget.isMike){
//       initOfListening();
//     }
//
//   }
//   Future initOfListening()async{
//     isMickIsEnabled= await _speechToText.initialize();
//     if(isMickIsEnabled){
//       statrListening();
//     }
//
//   }
//
//   calling()async{
//      if (_speechToText.isListening) {
//        await stopListening();
//      } else {
//        await statrListening();
//      }
//     print(spokenWord);
//   }
//   Future statrListening()async{
//     await _speechToText.listen(onResult: onResult);
//     setState(() {
//       isListening = true;
//     });
//   }
//   void onResult(SpeechRecognitionResult result) {
//     setState(() {
//       spokenWord = result.recognizedWords;
//       controller.clear();
//       controller.text=spokenWord;
//       serchingContact(spokenWord);
//     });
//     print("Recognized words: $spokenWord");
//
//   }
//
//   Future stopListening()async{
//     await _speechToText.stop();
//     setState(() {
//       isListening = false;
//     });
//   }
//
//   serchingContact(value){
//     setState(() {
//       if (value == "") {
//         searchedList = globalListForContacts;
//       } else {
//         searchedList = [];
//         // Iterable<cs.Contact> results = contactsList.where((_element) {
//         //   var r = _element.givenName!.toLowerCase().toString();
//         //   return r.contains("${value.toLowerCase()}");
//         // });
//         Iterable<PhoneNumbarModel> result=globalListForContacts.where((_element){
//           var r= _element.displayName.toLowerCase().toString();
//           return r.contains("${value.toString().toLowerCase()}");
//         });
//
//         searchedList.addAll(result);
//       }
//     });
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: TextField(
//             controller: controller,
//             onChanged: (value) {
//               serchingContact(value);
//             },
//             decoration: InputDecoration(
//                 hintText: "Enter Name",
//                 border: OutlineInputBorder(borderSide: BorderSide.none)),
//           ),
//           toolbarHeight: 70,
//           backgroundColor: Colors.green.shade50,
//           actions: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: IconButton(onPressed: () {
//                   statrListening();
//
//                 }, icon: Icon(Icons.mic)),
//               )
//           ],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ListView.builder(
//             itemCount: searchedList.length,
//             itemBuilder: (context, index) {
//               return CustomCallButton.custonListTile(
//                 // obj: searchedList[index],
//                 displayName: searchedList[index].displayName,
//                 givenName: searchedList[index].name,
//                 context: context,
//                 phone: searchedList[index].phone,
//                 avtar: searchedList[index].image!.isEmpty?true:searchedList[index].image
//               );
//             }),
//         ));
//   }
// }
//
//
//
//  /*
// import 'package:contacts_service/contacts_service.dart' as cs;
// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_to_text.dart';
//
// import 'call_save_list.dart';
//
// class CustomCallButton {
//   static Widget custonListTile({
//     required BuildContext context,
//     required dynamic avtar,
//     required String? phone,
//     required String givenName,
//     required String displayName,
//   }) {
//     return ListTile(
//       leading: avtar is String && avtar.isNotEmpty
//           ? Image.memory(
//         Uri.parse(avtar).data!.contentAsBytes(),
//         errorBuilder: (context, error, stackTrace) => Icon(Icons.person),
//       )
//           : Icon(Icons.person),
//       title: Text(givenName),
//       subtitle: Text(phone ?? 'No phone number'),
//     );
//   }
// }
//
// class SearchContactOnText extends StatefulWidget {
//   const SearchContactOnText({super.key});
//
//   @override
//   State<SearchContactOnText> createState() => _SearchContactOnTextState();
// }
//
// class _SearchContactOnTextState extends State<SearchContactOnText> {
//   SpeechToText _speechToText = SpeechToText();
//   bool isListening = false;
//   bool isMicEnabled = false;
//   String spokenWord = '';
//
//   List<cs.Contact> searchedList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     searchedList = contactsList;
//     initializeSpeechRecognition();
//   }
//
//   Future<void> initializeSpeechRecognition() async {
//     isMicEnabled = await _speechToText.initialize();
//     if (isMicEnabled) {
//       startListening();
//     }
//   }
//
//   Future<void> startListening() async {
//     await _speechToText.listen(onResult: onResult);
//     setState(() {
//       isListening = true;
//     });
//   }
//
//   void onResult(SpeechRecognitionResult result) {
//     setState(() {
//       spokenWord = result.recognizedWords;
//     });
//     print("Recognized words: $spokenWord");
//   }
//
//   Future<void> stopListening() async {
//     await _speechToText.stop();
//     setState(() {
//       isListening = false;
//     });
//   }
//
//   Future<void> toggleListening() async {
//     if (_speechToText.isListening) {
//       await stopListening();
//     } else {
//       await startListening();
//     }
//   }
//
//   @override
//   void dispose() {
//     _speechToText.stop();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: TextField(
//           onChanged: (value) {
//             setState(() {
//               if (value.isEmpty) {
//                 searchedList = contactsList;
//               } else {
//                 searchedList = contactsList.where((contact) {
//                   var name = contact.givenName?.toLowerCase() ?? '';
//                   return name.contains(value.toLowerCase());
//                 }).toList();
//               }
//             });
//           },
//           decoration: InputDecoration(
//             hintText: "Enter Name",
//             border: OutlineInputBorder(borderSide: BorderSide.none),
//           ),
//         ),
//         toolbarHeight: 70,
//         backgroundColor: Colors.green.shade50,
//         actions: [
//           IconButton(
//             icon: Icon(isListening ? Icons.mic : Icons.mic_off),
//             onPressed: toggleListening,
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: ListView.builder(
//           itemCount: searchedList.length,
//           itemBuilder: (context, index) {
//             var contact = searchedList[index];
//             return CustomCallButton.custonListTile(
//               context: context,
//               avtar: contact.avatar != null && contact.avatar!.isNotEmpty
//                   ? contact.avatar
//                   : true,
//               phone: contact.phones?.isNotEmpty == true
//                   ? contact.phones!.first.value
//                   : 'No phone number',
//               givenName: contact.givenName ?? 'No name',
//               displayName: contact.displayName ?? 'No display name',
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
// */