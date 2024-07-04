import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:direct_caller_sim_choice/direct_caller_sim_choice.dart';
import '../../screen/call_log/call_log.dart';
class CustomDialPad{
  static ShoeCustomDilar(BuildContext context,bool forLog){

    TextEditingController _textEditingController=TextEditingController();
    TextEditingController _textEditingController2;
    if(forLog){
      _textEditingController2=controller;
    }else{
      _textEditingController2=_textEditingController;
    }

    return showModalBottomSheet(backgroundColor: Colors.black54,

      // shape: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      context: context, builder: (context) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10)
          ),
          image: DecorationImage(


            image:imagePath==null? NetworkImage("https://cubanvr.com/wp-content/uploads/2023/07/ai-image-generators.webp"):
              FileImage(imagePath!)
              ,
            fit: BoxFit.fill
          )
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(
              // enabled: false,
              showCursor: false,
              keyboardType: TextInputType.none,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,color: Colors.white
              ),

              controller:_textEditingController2,
              enableInteractiveSelection: true,
              enabled: true,
              decoration: InputDecoration(
                prefixIcon: Text("+91",style: TextStyle(color: Colors.white,fontSize: 30),),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none
                ),
                suffixIcon: GestureDetector(
                  onLongPress: () {
                     _textEditingController2.clear();
                  },
                  onTap: () {
                   if(_textEditingController2.text.toString().length>0){
                     String str=_textEditingController2.text;
                     str=str.substring(0,str.length-1);
                     _textEditingController2.text=str;
                   }
                  },
                    child: Icon(Icons.backspace_rounded,color: Colors.white,))
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _customButtonForDialPad(num: "1",onTap: (){
                  String num= _textEditingController2.text;
                  _textEditingController2.text=num +"1";
                }),
                _customButtonForDialPad(num: "2",onTap: (){
                  String num= _textEditingController2.text;
                  _textEditingController2.text=num +"2";
                }),
                _customButtonForDialPad(num: "3",onTap: (){
                  String num= _textEditingController2.text;
                  _textEditingController2.text=num +"3";
                })
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _customButtonForDialPad(num: "4",onTap: (){
                  String num= _textEditingController2.text;
                  _textEditingController2.text=num +"4";
                }),
                _customButtonForDialPad(num: "5",onTap: (){
                  String num= _textEditingController2.text;
                  _textEditingController2.text=num +"5";
                }),
                _customButtonForDialPad(num: "6",onTap: (){
                  String num= _textEditingController2.text;
                  _textEditingController2.text=num +"6";
                })
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _customButtonForDialPad(num: "7",onTap: (){
                  String num= _textEditingController2.text;
                  _textEditingController2.text=num +"7";
                }),
                _customButtonForDialPad(num: "8",onTap: (){
                  String num= _textEditingController2.text;
                  _textEditingController2.text=num +"8";
                }),
                _customButtonForDialPad(num: "9",onTap: (){
                  String num= _textEditingController2.text;
                  _textEditingController2.text=num +"9";
                })
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [
                _customButtonForDialPad(onTap: (){
                  String num= _textEditingController2.text;
                  _textEditingController2.text=num +"#";
                }, num: "#"),
                _customButtonForDialPad(onTap: (){
                  String num= _textEditingController2.text;
                  _textEditingController2.text=num +"0";
                }, num: "0"),

                _customButtonForDialPad(onTap: (){
                  String num= _textEditingController2.text;
                  _textEditingController2.text=num +"*";
                }, num: "*"),

            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                  child:  _customButtonForDialPad(onTap: (){
                    print("okokko");
                    // FlutterPhoneDirectCaller.callNumber(_textEditingController2.text.toString());
                    final DirectCaller directCaller = DirectCaller();
                    directCaller.makePhoneCall('9574893293', simSlot: 2);

                  }, num: "*",col: Colors.green.shade400,widh: 150),

                ),
                Center(
                  child:  _customButtonForDialPad(onTap: (){
                    print("okokko");
                    // FlutterPhoneDirectCaller.callNumber(_textEditingController2.text.toString());
                    final DirectCaller directCaller = DirectCaller();
                    directCaller.makePhoneCall('9574893293', simSlot: 1);

                  }, num: "*",col: Colors.green.shade400,widh: 150),

                ),
              ],
            ),



          ],
        ),
      );
    },);
  }
  static _customButtonForDialPad({required onTap,required String num,Color col=Colors.black54,double widh=95 }){
    return Padding(
      padding: const EdgeInsets.all(1),
      child: GestureDetector(
        onTap:onTap,
        child: Container(
          height: 70,
          width: widh,
          decoration: BoxDecoration(
              color:col,
              borderRadius: BorderRadius.all(
                  Radius.circular(12)
              )
          ),
          child: Center(child:widh==95? Text("$num",style: TextStyle(fontSize: 25,color: Colors.white),):
              Icon(Icons.call,size: 39,color: Colors.white,)
          ),
        ),
      ),
    );

  }

}

/*
Note: C:\Users\Asus\AppData\Local\Pub\Cache\hosted\pub.dev\android_intent_plus-4.0.3\android\src\main\java\dev\fluttercommunity\plus\androidintent\IntentSender.java uses or overrides a deprecated API.
Note: Recompile with -Xlint:deprecation for details.
Note: C:\Users\Asus\AppData\Local\Pub\Cache\hosted\pub.dev\android_intent_plus-4.0.3\android\src\main\java\dev\fluttercommunity\plus\androidintent\MethodCallHandlerImpl.java uses unchecked or unsafe operations.
Note: Recompile with -Xlint:unchecked for details.
*/
