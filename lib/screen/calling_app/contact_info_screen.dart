import 'package:calling_app/screen/call_log/call_log.dart';
import 'package:calling_app/utility/resources.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

import '../../component/widget/custom_texts.dart';
import 'bottom_navigation_forcalling.dart';
import 'edit_contact_screen.dart';
class ContactInfoScreen extends StatefulWidget {
  Contact contacts;
  ContactInfoScreen({super.key, required this.contacts});

  @override
  State<ContactInfoScreen> createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends State<ContactInfoScreen> {
  bool isAlreadyFavourite=false;
  int removind=0;
  bool emptyNumber=false;

  @override
  void initState() {
    emptyNumber=widget.contacts.phones!.isEmpty?true:false;
    super.initState();
    for(var r in faverouiteContacts){
      removind++;
      if(r.phones!.isEmpty){

      }else if(widget.contacts.phones!.isEmpty){

      } else{
        // print(r.phones!.first.value==widget.contacts.phones![0].value);
        if(r.phones!.first.value==widget.contacts.phones![0].value){
          isAlreadyFavourite=true;
          break;
        }
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // print(obj2?.displayName);
          try {
            print("okkkkkkkkkkkkkkkkk");
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditContactScreen(obj: widget.contacts),
                ));
          } catch (e) {
            print(e);
          }
        },
      ),
      backgroundColor: Colors.blueGrey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(onPressed: (){
           callFunctionForAddingRemoving();
          }, icon: Icon(isAlreadyFavourite?Icons.star:Icons.star_outline,color: Colors.black,)),
          IconButton(
              onPressed: () async {
                CustomAlert.alertDialogCustom(
                    context,
                    "Delete",
                    Container(
                      child: const Text(
                        "Are U Really Want to  Delete The Contact ?",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    [
                      customMaterialButtonWidget2(
                          content: const Text(
                            "Noo! Never",
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          }),
                      customMaterialButtonWidget2(
                          content: const Text(
                            "Yep",
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () async {
                            await ContactsService.deleteContact(widget.contacts);
                            finalContact=await ContactsService.getContacts();


                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BottomNavigationForcalling(),
                                ));
                          }),
                    ]);
                // await ContactsService.deleteContact(obj2);
                // await sharedPreferances.setBool("key", true);
              },
              icon: Icon(Icons.delete,color: Colors.black,)),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EditContactScreen(obj: widget.contacts),
                  ));
            },
            child: const Icon(
              Icons.edit,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(
                child:widget.contacts.avatar!=null? widget.contacts.avatar!.isEmpty
                    ?   CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.black,
                        child: Center(
                            child: Text(
                          "${widget.contacts.displayName![0]}",
                          style: TextStyle(fontSize: 150, color: Colors.white),
                        )),
                      )
                    : CircleAvatar(
                        radius: 100,
                        backgroundImage: MemoryImage(widget.contacts.avatar!),
                      ): CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.black,
                  child: Center(
                      child: Text(
                        "${widget.contacts.displayName![0]}",
                        style: TextStyle(fontSize: 150, color: Colors.white),
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "${widget.contacts.displayName}",
                style: const TextStyle(fontSize: 40),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  circularButton(text: "Call", icon: Icons.call),
                  circularButton(text: "Text", icon: Icons.text_fields_rounded),
                  circularButton(text: "Video", icon: Icons.video_call),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: WIDTH*90/100,
                // height: HEIGHT*widget.contacts.phones!.length*14/100,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "Contact Info",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      ),
                    ),
                    if(emptyNumber==false)
                      Container(
                        height: 66,
                        child: ListView.builder(
                          itemCount: widget.contacts.phones!.length,
                          itemBuilder: (context, index) {
                          return ListTile(

                            leading: Icon(Icons.call),
                            title: Text(widget.contacts.phones![index].label.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                            subtitle: Text(widget.contacts.phones![index].value.toString()),
                            trailing: Icon(Icons.edit),
                          );
                        },),
                      ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget circularButton({required icon, required String text}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.blueGrey,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w600),
        )
      ],
    );
  }

  void callFunctionForAddingRemoving() {
    var msg;
    if(isAlreadyFavourite){
      CustomAlert.alertDialogCustom(context, "ConfirmBox", Container(
        child: const Text("Are you Really Want to Remove From The Faveroute List?"),
      ),[
        customMaterialButtonWidget2(content: Text("No",style: TextStyle(color: Colors.white),), onTap: () {
          Navigator.pop(context);
        },),
        customMaterialButtonWidget2(content: Text("Yep!",style: TextStyle(color: Colors.white),), onTap: () {
          int ij=removind-1;
          faverouiteContacts.removeAt(ij);
          Resources.afterRemovingTheList(ij);
          setState(() {
            isAlreadyFavourite=!isAlreadyFavourite;
          });


          msg=const SnackBar(content: Text("Removed From Faverouit! ❤️"),duration: Duration(seconds: 1),);
          ScaffoldMessenger.of(context).showSnackBar(msg);


          Navigator.pop(context);




        },)
      ]
      );



    }else if(emptyNumber==false){
      msg=SnackBar(content: Text("Added TO Faverouit! ❤️"),duration: Duration(seconds: 1),);
      Resources.setingListOfFaverouite(widget.contacts);
      // setingListOfFaverouite
      setState(() {
        isAlreadyFavourite=!isAlreadyFavourite;
      });
      ScaffoldMessenger.of(context).showSnackBar(msg);



    }
  }
}
