import 'dart:convert';
import 'dart:typed_data';

import 'package:contacts_service/contacts_service.dart';
import "package:shared_preferences/shared_preferences.dart";
List<Contact> finalContact=[];
late double HEIGHT;
late double WIDTH;
List<Contact> faverouiteContacts=[];

String faverListKey="okok";
List<String> sharedPrefList=[];

class Resources{
  static setingListOfFaverouite(Contact obj) async {
    var preferances=await SharedPreferences.getInstance();
    String name=jsonEncode(obj.toMap());
    sharedPrefList.add(name);
    preferances.setStringList(faverListKey,sharedPrefList);
    print("Added");
    Resources.gettingFaverouteToList();
  }
  static gettingFaverouteToList()async{
    faverouiteContacts=[];
    var preferances=await SharedPreferences.getInstance();
    sharedPrefList=preferances.getStringList(faverListKey)??[];

    for(var e in sharedPrefList){
      Map r=jsonDecode(e);
      if(r['avatar'].length<10){
        r['avatar']=null;
      }else{
        r['avatar']=Uint8List.fromList(r["avatar"].cast<int>());
      }
      faverouiteContacts.add(Contact.fromMap(r));
      // print(faverouiteContacts[0].displayName);
    }
  }
  static afterRemovingTheList(int index) async {
    sharedPrefList.removeAt(index);
    var preferances=await SharedPreferences.getInstance();
    preferances.setStringList(faverListKey,sharedPrefList);
    print("Added");
    Resources.gettingFaverouteToList();




  }
}