import 'package:contacts_service/contacts_service.dart';
import 'dart:typed_data';
class PhoneNumbarModel{
  int? id;
  String name;
  String displayName;
  String phone;
  Uint8List? image;
  PhoneNumbarModel({required this.name,required this.displayName,required this.phone,required this.image});

    //Object to Map
  Map<String,dynamic> toMap(){
    return {'id':id,"name":name,"phone":phone,'displayName':displayName,'image':image};
  }
    //A Single Object From Map
   factory PhoneNumbarModel.fromMap(Map<String, dynamic> json){
    return PhoneNumbarModel(name: json['name'], phone: json['phone'],displayName: json['displayName'],image: json['image']);
  }
  // Single Object From Data
  factory PhoneNumbarModel.fromContact(Contact contact){
     return PhoneNumbarModel(
         name: contact.givenName.toString()??"",
         phone: contact.phones!.isEmpty?"No Data":contact.phones![0].value.toString(),
         displayName: contact.displayName??"",
         image:contact.avatar??null


     );
  }



}
