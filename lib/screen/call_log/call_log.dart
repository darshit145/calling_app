import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:calling_app/component/widget/custom_dial_pad.dart';
import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart' ;
import 'package:contacts_service/contacts_service.dart';

import '../../component/widget/custom_call_button.dart';
import '../../component/widget/custom_texts.dart';
import '../../utility/custom_list_tile.dart';
import '../../utility/resources.dart';
import '../calling_app/add_contacts.dart';
import '../calling_app/bottom_navigation_forcalling.dart';
late double width ;
late double height ;
List<String>  faverouteContact=[];
List<Contact>  faverouteContactObj=[];
class CallLogScreen extends StatefulWidget {
  const CallLogScreen({super.key});

  @override
  State<CallLogScreen> createState() => _CallLogScreenState();
}
late TextEditingController controller;

Future<Iterable<CallLogEntry>> calLog = CallLog.get();
bool isOpen=false;
File? imagePath;

class _CallLogScreenState extends State<CallLogScreen> {


  bool showFaveroute=false;
  bool forSearchig = false;
  List datasToSearch = [];

  @override
  void initState() {
    // faverouteContactObj=[];
    //
    // faverouteContactObj=faverouiteContacts;
    // TODO: implement initState
    super.initState();

    controller=TextEditingController()..addListener(() {
      setState(() {
        if (controller.text.toString() == "") {
          forSearchig = false;
          setState(() {});
        } else {
            getingALlEnterirs();
            setState(() {});
        }
      });
    },);
    gettingTheCallLogs();
    // setList();

  }
  // setList()async{
  //   SharedPreferences _pref=await SharedPreferences.getInstance();
  //   faverouteContact= _pref.getStringList('lists')??[];
  //   for(var e in faverouteContact){
  //     Map r=jsonDecode(e);
  //     if(r['avatar'].length<10){
  //       r['avatar']=null;
  //     }else{
  //       r['avatar']=Uint8List.fromList(r["avatar"].cast<int>());
  //     }
  //
  //     faverouteContactObj.add(Contact.fromMap(r));
  //
  //
  //   }
  //  // print(faverouteContactObj[4].photoOrThumbnail );
  //   if(imagePath==null){
  //     imagePath=await getImage();
  //   }
  // }

  //
  Future<Iterable<CallLogEntry>> gettingTheCallLogs() async {
    return await CallLog.get();
  }

  getingALlEnterirs()async{
    // datasToSearch=[];
    forSearchig = true;

    String contact = controller.text.toString();
    var result = await CallLog.get();
    print("ok102");
    print(result.runtimeType);
    print(result.first.name);
    var contactList = result.map((val) {
      return {
        "name": val.name.toString() ?? "",
        "phone": val.number.toString() ?? "",
        "call": val.callType == CallType.incoming ? "incoming" : "nice"
      };
    });

    var rx = contactList.where((el) {
      return el['phone']!.contains(contact);
    });
    int t = 0;
    for (var rw in rx) {
      t++;
      datasToSearch.add(rw);
      if (t == 10) {
        break;
      }
      if(datasToSearch.length>10){
        datasToSearch.removeAt(0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    width= MediaQuery.of(context).size.width;
    height= MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.000001,
        backgroundColor: Colors.transparent,

        actions: [
          IconButton(onPressed: () async{
            Iterable<Contact> contactstrr = await ContactsService.getContacts();
           print(contactstrr.last.birthday);

          }, icon: Icon(Icons.add)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: () {
              Resources.gettingFaverouteToList();
              setState(() {
                showFaveroute=!showFaveroute;
              });
              // print(faverouiteContacts[].displayName);

            }, icon:showFaveroute?Icon(Icons.star,color: Colors.black,): Icon(Icons.star_outline,color: Colors.black,)),
          )
        ],
      ),
      drawer: Drawer(
        width: width*75/100,
        backgroundColor: Colors.black54,
        child: Column(
          children: [
            Card(child: Container(height: 200,width: width*75/100,
              child: Icon(Icons.settings,size: width*20/100,),
            ),),
            GestureDetector(
              onTap: () {
                CustomAlert.alertDialogCustom(context, "Set Image", Container(
                  height: 130,
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () async {
                          imagePath= await pickImage(ImageSource.camera);
                          Navigator.pop(context);
                          setState(() {});
                          if(imagePath!=null){
                            saveImage(imagePath!.path);
                          }

                        },
                        leading: Icon(Icons.camera),
                        title: Text("Capture Image"),
                      ),
                      ListTile(
                        onTap: () async{

                          Navigator.pop(context);
                          imagePath= await pickImage(ImageSource.gallery);
                          if(imagePath!=null){
                             saveImage(imagePath!.path);
                          }
                          setState(() {});
                        },
                        leading: Icon(Icons.photo),
                        title: Text("Set From Gallary"),
                      ),
                    ],
                  ),
                ));


              },
              child: Card(child: Container(height: 100,width: width*75/100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if(imagePath==null)
                      CircleAvatar(radius: 30,),
                    if(imagePath!=null)
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: FileImage(imagePath!),),
                    Text("Set Image",style: TextStyle(fontWeight: FontWeight.w600),)
                  ],
                ),
              ),),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {});

          CustomDialPad.ShoeCustomDilar(
            context,true
          );

        },child: Icon(Icons.dialer_sip),
      ),
      body:showFaveroute? RefreshIndicator(
        onRefresh: () async{
          setState(() {
            faverouteContactObj=[];
            // setList();
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: faverouiteContacts.length,
            itemBuilder: (context, index) {


            return CustomListTile.customListTile(context: context,object: faverouiteContacts[index]);
          },),
        ),
      )
          :forSearchig
          ? Container(
              child: Center(
                child: ListView.builder(
                  itemCount: datasToSearch.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Text("${datasToSearch[index]['name']==""?"U":datasToSearch[index]['name'][0]}",style: TextStyle(fontSize: 20,color: Colors.white),),
                      ),
                      title: Text(datasToSearch[index]['name'] == ""
                          ? "UnKnown"
                          : datasToSearch[index]['name']),
                      subtitle: Text(datasToSearch[index]['phone']),
                      trailing: CircleAvatar(

                        radius: 25,
                        backgroundColor: Colors.green,
                        child: Icon(Icons.call,color: Colors.white,size: 29,),

                      ),
                    );
                  },
                ),
              ),
            )
          : Container(
              child: FutureBuilder(
                future: calLog,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    List<CallLogEntry> datasOfCall = snapshot.data!.toList();
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: datasOfCall.length,



                        itemBuilder: (context, index) {

                          DateTime dateTime=DateTime.fromMillisecondsSinceEpoch(datasOfCall[index].timestamp as int);
                          print(dateTime);
                          return ExpansionTile(
                            collapsedBackgroundColor: Colors.blueGrey.shade50,
                            backgroundColor: Colors.blueGrey.shade200,
                            // enabled: false,
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(21),

                            ),

                            onExpansionChanged: (value) {
                              setState(() {

                              });
                            },



                            leading: CircleAvatar(
                              radius: 23,
                              backgroundColor: Colors.black,
                              // backgroundImage: MemoryImage(
                              //   datasOfCall[index].phoneAccountId
                              // ),
                              // child:  datasOfCall[index].callType==CallType.outgoing? Icon(Icons.call_made,color: Colors.red,size: 16,):Icon(Icons.transit_enterexit_sharp,color: Colors.green,size: 16,),
                              child: Text(
                                datasOfCall[index].name.toString() == ""
                                    ? "U"
                                    : datasOfCall[index].name![0].toString(),
                                style:
                                    TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                            title: Text(
                              datasOfCall[index].name.toString() == ""
                                  ? "UnKnown"
                                  : datasOfCall[index].name.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                            subtitle:Row(
                              children: [
                                datasOfCall[index].callType==CallType.missed?
                                    Icon(Icons.phone_missed,size: 16,color: Colors.red,):
                                datasOfCall[index].callType == CallType.outgoing
                                    ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.phone_forwarded_rounded,
                                    color: Colors.black,
                                    size: 16,
                                  ),
                                )
                                    : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.phone_callback_sharp,
                                    color: Colors.green,
                                    size: 16,
                                  ),
                                ),
                                Text(datasOfCall[index].number.toString()),
                              ],
                            ),

                            trailing: GestureDetector(
                              onTap: () {
                                setState(() {
                                  directCall(datasOfCall[index].number);
                                });
                              },
                              child: CircleAvatar(
                                  radius: 23,
                                  backgroundColor: Colors.green,
                                  child: Icon(
                                    Icons.call,
                                    size: 20,
                                    color: Colors.white,
                                  )),
                            ),
                            children: [
                               Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  datasOfCall[index].callType == CallType.outgoing
                                      ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.call_made,
                                      color: Colors.red,
                                      size: 16,
                                    ),
                                  )
                                      : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.transit_enterexit_sharp,
                                      color: Colors.green,
                                      size: 16,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${datasOfCall[index].duration.toString()} sec"),
                                      Text("${dateTime.hour}:${dateTime.minute}  ${dateTime.day}:${dateTime.month}:${dateTime.year}")

                                    ],
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),

                            ],
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
    );
  }
}

directCall(num) async {
  try {
    await FlutterPhoneDirectCaller.callNumber(num);
  } catch (w) {
    print("oooooooooooooooooo");
  }
}
Future<void> saveImage(path)async{
  SharedPreferences  _pref=await SharedPreferences.getInstance();
  _pref.setString("image", path);
}
Future<File> getImage()async{
  SharedPreferences _pref=await SharedPreferences.getInstance();
  var r= _pref.getString("image");
  return File(r!);
}
