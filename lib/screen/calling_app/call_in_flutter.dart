import 'package:calling_app/component/widget/custom_call_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as uri;
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
class CallInFlutter extends StatefulWidget {
  final Uri url;
  final String number;

   CallInFlutter({super.key,required this.url,required this.number});

  @override
  State<CallInFlutter> createState() => _CallInFlutterState(url: url,number: number);
}

class _CallInFlutterState extends State<CallInFlutter> {
  final Uri url;
  final String number;

  _CallInFlutterState({required this.url,required this.number});
  callNumber()async{
      try{
          uri.launchUrl(url);
          print("ok");

      }catch(e){
        print(e.toString());
      }
  }
  directCall()async{
    try{
      await FlutterPhoneDirectCaller.callNumber(number);

    }catch(w){
      print("oooooooooooooooooo");
    }
  }
  void initState(){
    super.initState();
    directCall();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomCallButton.customCallButton(redius: 35,onTap: directCall),
      ),

    );
  }
}
