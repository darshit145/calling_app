import 'dart:ffi';

import 'package:calling_app/screen/call_log/contact_info_page.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
String mobile="";
class CustomCallButton {
  static Widget customCallButton({required onTap, required redius}) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: redius.toDouble(),
        backgroundColor: Colors.green.shade400,
        child: Icon(
          Icons.phone,
          size: 4.toDouble() + redius.toDouble(),
          color: Colors.white,
        ),
      ),
    );
  }

  static Widget custonListTile(
      {required String displayName,
      required String givenName,
        required BuildContext context,
      required phone,
        shouldNavigate=false,
        obj2=null,
        // required PhoneNumbarModel obj,
        avtar,}) {
    String firstLetter=givenName[0];
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            mobile=phone;
            if(shouldNavigate){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ContactInfoPage( obj2:obj2??Contact(
                  givenName: "koko",
                  displayName: "okok",
                  // phones![0].value:
                  phones: [Item(label: "ok",value: "2030303")]
              ),   phone: phone,displayName: displayName,avtar:avtar==true?null:avtar,),));
            }

          },
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:avtar==true?  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.blueGrey.shade200,
                    child:   Text(
                      firstLetter,
                      style: TextStyle(fontSize: 20),
                    ),
                  ):CircleAvatar(
                    radius: 25,
                    backgroundImage:MemoryImage(avtar),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 150,
                        child: Text(
                          "$displayName",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        )),
                    Text("$phone"),
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
            top: 12,
            right: 16,
            child: CustomCallButton.customCallButton(onTap: () async{
                try{
                  await FlutterPhoneDirectCaller.callNumber(phone);

                }catch(w){
                  print("oooooooooooooooooo");
                }


            }, redius: 25))
      ],
    );
  }
}