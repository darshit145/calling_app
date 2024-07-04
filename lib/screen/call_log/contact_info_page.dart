import 'dart:convert';
import 'dart:typed_data';
import 'package:calling_app/component/widget/custom_texts.dart';
import 'package:calling_app/screen/calling_app/edit_contact_screen.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../component/widget/custom_call_button.dart';
import '../calling_app/bottom_navigation_forcalling.dart';
import '../calling_app/call_save_list.dart';
import 'call_log.dart';
import 'package:calling_app/screen/calling_app/add_contacts.dart';
class ContactInfoPage extends StatefulWidget {
  Uint8List? avtar;
  String displayName;
  String phone;
  Contact? obj2;

   ContactInfoPage({super.key ,required this.avtar,required this.obj2,required this.displayName,required this.phone});

  @override
  State<ContactInfoPage> createState() => _ContactInfoPageState(obj2: obj2 ,displayName: displayName,phone: phone,avtar: avtar);
}

class _ContactInfoPageState extends State<ContactInfoPage> {
  Uint8List? avtar;
  String displayName;
  String phone;
  late List li;
  // PhoneNumbarModel obj;
  Contact? obj2;
  bool isFaveroute=false;
  int indexToRemove=0;
   int indexForRemover=0;

  _ContactInfoPageState({required this.obj2,required this.displayName,required this.avtar,required this.phone, });

  @override
  void initState() {
    phone.contains("+91");
    if(phone.contains("+91")){
      phone=phone.substring(3);
      phone="+91 "+phone;
    }else{
      phone="+91 "+phone;
    }
    checkByNumber();
    super.initState();
  }


  checkByNumber()async{
    print("okkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
    print(mobile);
    SharedPreferences _preferances=await SharedPreferences.getInstance();
     li=_preferances.getStringList("lists")??[];
   Iterable<Contact>  _contact=li.map((_element){
       Map map=jsonDecode(_element);
       map['avatar']=null;
       return Contact.fromMap(map);
    });


    for(var r in _contact){
      indexToRemove++;
      print(indexToRemove);
      String thisNum=r.phones![0].value.toString();
      if(thisNum.startsWith("+91")){
        print(thisNum);

      }else{
        thisNum="+91 " +thisNum.substring(0,6)+thisNum.substring(5);
      }
      if(thisNum.contains(mobile)){
        setState(() {
                isFaveroute=true;
              });

        break;
      }
      // if(r.phones)
    }



  }
  removeFromFaverouteList()async{
    print("saveddddddddddddddddddddddddddddddd");

    print(indexToRemove);
      faverouteContact.removeAt(indexToRemove-1);
      indexToRemove=0;
    SharedPreferences _pref=await SharedPreferences.getInstance();
    // _pref.setStringList(, );
    _pref.setStringList("lists", faverouteContact as List<String> );
    print("saveddddddddddddddddddddddddddddddd");



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // print(obj2?.displayName);
          try{
            print("okkkkkkkkkkkkkkkkk");
            Navigator.push(context, MaterialPageRoute(builder: (context) => EditContactScreen(obj: obj2!),));

          }catch(e){
            print(e);
          }

        },
      ),
      backgroundColor: Colors.blueGrey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(onPressed: () async{
            CustomAlert.alertDialogCustom(context, "Delete", Container(
              child: Text("Are U Really Want to  Delete The Contact ?",style: TextStyle(fontSize: 16),

              ),
            ),[
              customMaterialButtonWidget2(content: Text("Noo! Never",style: TextStyle(color: Colors.white),), onTap: (){
                Navigator.pop(context);
              }),
              customMaterialButtonWidget2(content: Text("Yep",style: TextStyle(color: Colors.white),), onTap: ()async{
                await ContactsService.deleteContact(obj2!);
                // await sharedPreferances.setBool("key", true);
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigationForcalling(),));
              }),
            ]);
           // await ContactsService.deleteContact(obj2);
           // await sharedPreferances.setBool("key", true);

          }, icon: Icon(Icons.delete)),
           GestureDetector(
             onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => EditContactScreen(obj: obj2!),));

             },
             child: Icon(Icons.edit,color: Colors.black,),
           ),


          IconButton(onPressed: () async{

            var msg;
            if(isFaveroute){

              print("ccccccccccccccccccccccccccccccccc");

              CustomAlert.alertDialogCustom(context, "ConfirmBox", Container(
                child: Text("Are you Really Want to Remove From The Faveroute List?"),
              ),[
                customMaterialButtonWidget2(content: Text("No",style: TextStyle(color: Colors.white),), onTap: () {
                  Navigator.pop(context);
                },),
                customMaterialButtonWidget2(content: Text("Yep!",style: TextStyle(color: Colors.white),), onTap: () {


                    removeFromFaverouteList();


                  msg=SnackBar(content: Text("Removed From Faverouit ❤️"),duration: Duration(seconds: 1),);
                  ScaffoldMessenger.of(context).showSnackBar(msg);
                  Navigator.pop(context);

                  setState(() {
                    isFaveroute=!isFaveroute;
                    // faverouteContact.add(obj2!);
                  });


                },)
              ]
              );


            }else{
              setState(() {
                isFaveroute=!isFaveroute;
              });
               msg=SnackBar(content: Text("💕 Added TO Faverouit"),duration: Duration(seconds: 1),);
              ScaffoldMessenger.of(context).showSnackBar(msg);

              String name=jsonEncode(obj2!.toMap());
              faverouteContact.add(name);
              SharedPreferences _pref=await SharedPreferences.getInstance();
              _pref.setStringList("lists", faverouteContact as List<String> );

            }




          },icon:isFaveroute?Icon(Icons.star_rate,color: Colors.black,): Icon(Icons.star_outline,color: Colors.black,)),
          IconButton(onPressed: () {

          }, icon: Icon(Icons.menu_open_sharp,color: Colors.black,)),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 30,),
            Center(
              child:avtar==null? CircleAvatar(
                radius: 100,
                backgroundColor: Colors.black,
                child: Center(child: Text("${displayName[0]}",style: TextStyle(fontSize: 150,color: Colors.white),)),
              ):CircleAvatar(
                radius: 100,
                backgroundImage: MemoryImage(avtar!),
              ),
            ),
            SizedBox(height: 20,),
            Text(displayName,style: TextStyle(fontSize: 40),overflow: TextOverflow.ellipsis,),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                circularButton(text: "Call",icon: Icons.call),
                circularButton(text: "Text",icon: Icons.text_fields_rounded),
                circularButton(text: "Video",icon: Icons.video_call),


              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(12)
                )

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text("Contact Info",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 15),),
                  ),
                  ListTile(
                    leading:  Icon(Icons.call),
                    title: Container(width: 100,
                        // color: Colors.black,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("$phone",style: TextStyle(fontWeight: FontWeight.w600),),
                        Text("Mobile",style: TextStyle(fontWeight: FontWeight.w500))
                      ],
                    )),
                    // subtitle: Text("Mobile",style: TextStyle(fontWeight: FontWeight.w500),),
                    trailing: Container(
                       width: 70,
                      child: Row(
                        children: [

                          Icon(Icons.video_call,size: 30,),
                          SizedBox(width: 10,),
                          Icon(Icons.text_fields_rounded,size: 30,)

                        ],
                      ),
                    ),
                  )
                ],
              ),
            )


          ],
        ),
      ),
    );
  }
}
Widget circularButton({required icon,required String text}){
  return Column(
    children: [
      CircleAvatar(
        radius: 28,
        backgroundColor: Colors.blueGrey,
        child: Icon(icon,color: Colors.white,),
      ),
      SizedBox(height: 4,),
      Text(text,style: TextStyle(fontWeight: FontWeight.w600),)
    ],
  );
}
class clll extends StatefulWidget {
  const clll({super.key});

  @override
  State<clll> createState() => _clllState();
}

class _clllState extends State<clll> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
