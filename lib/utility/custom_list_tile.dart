import 'package:calling_app/screen/calling_app/contact_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
class CustomListTile {
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

  static Widget customListTile({required Contact object,required BuildContext context}){
    return Padding(
      padding: const EdgeInsets.only(left: 4,right: 4),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>ContactInfoScreen(contacts: object),));
            },
            child: Card(
              // color: Colors.transparent,
              color: Colors.blueGrey.shade50,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: object.avatar!=null? object.avatar!.length<10?  CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.blueGrey.shade200,
                      child:   Text(
                        "${object.displayName![0]}",
                        style: TextStyle(fontSize: 20,color: Colors.black),
                      ),
                    ):CircleAvatar(
                      radius: 25,
                      backgroundImage:MemoryImage(object.avatar!),
                    ):CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.blueGrey.shade200,
                      child:   Text(
                        "${object.displayName![0]}",
                        style: TextStyle(fontSize: 20,color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 150,
                          child: Text(
                            object.displayName.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          )),
                      Text(object.phones!.isEmpty?"Null": object.phones![0].value.toString()),
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
              top: 12,
              right: 16,
              child: CustomListTile.customCallButton(onTap: () async{
                try{
                  await FlutterPhoneDirectCaller.callNumber(object.phones![0].value.toString());
                }catch(w){}
              }, redius: 25))
        ],
      ),
    );
  }
}

