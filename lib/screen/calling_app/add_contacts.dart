import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:calling_app/component/widget/custom_texts.dart';
import 'package:calling_app/screen/calling_app/call_save_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import '../../utility/resources.dart';
import '../call_log/call_log.dart';
import 'dart:typed_data';

class AddContacts extends StatefulWidget {
   AddContacts({super.key});

  @override
  State<AddContacts> createState() => _AddContactsState();
}
Uint8List? phoneAvtat;
class _AddContactsState extends State<AddContacts> {
  DateTime? dataStore=null;


  List<String?> dataForShow=["Home","Home",null,"Birthday"];
  File? imagePath;
  TextEditingController _controllerForName = TextEditingController();
  TextEditingController _controllerForLastName = TextEditingController();
  TextEditingController _controllerForPhone = TextEditingController();
  TextEditingController _controllerForCompany = TextEditingController();
  TextEditingController _controllerForMail = TextEditingController();
  late Uint8List imageFormated;

  @override
  void initState() {
    super.initState();
     // imagePath?.readAsArrayBuffer();
    // _controllerForName.text=widget.obj!.displayName.toString();
    // _controllerForPhone.text=widget.obj!.phones![0].value.toString();

  }
  //
  // getContacts() async {
  //   sharedPreferances.setBool("key", true);
  // }


  saveContacts(String? givenName, String? phone) async {

    Contact _contact = Contact(avatar: phoneAvtat,
        birthday: dataStore,emails: [Item(value: _controllerForMail.text.toString(),label:dataForShow[1]??"Home")]);
    _contact.givenName = givenName;

    _contact.company=_controllerForCompany.text.toString();

    // _contact=_contact.emails?.add(Item(value: _controllerForMail.text.toString(),label:dataForShow[1]??"Home"));
    _contact.displayName = givenName;
    _contact.phones = [Item(label: dataForShow[0], value: phone)];
    ContactsService.addContact(_contact);

    _controllerForName.clear();
    _controllerForPhone.clear();
    finalContact=await ContactsService.getContacts();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        leading: IconButton(
          onPressed: () {
            // Navigator.pop(context);
          },
          icon: Icon(Icons.exit_to_app_sharp),
        ),
        title: Text("Add Contact"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  CustomAlert.alertDialogCustom(
                      context,
                      "Set Image",
                      Container(
                        height: 130,
                        child: Column(
                          children: [
                            ListTile(
                              onTap: () async {
                                imagePath = await pickImage(ImageSource.camera);
                                Navigator.pop(context);
                                setState(() {});
                              },
                              leading: Icon(Icons.camera),
                              title: Text("Capture Image"),
                            ),
                            ListTile(
                              onTap: () async {
                                Navigator.pop(context);
                                imagePath =
                                    await pickImage(ImageSource.gallery);
                                setState(() {});
                              },
                              leading: Icon(Icons.photo),
                              title: Text("Set From Gallary"),
                            ),
                          ],
                        ),
                      ));
                },
                child: imagePath == null
                    ? CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.blue.shade50,
                        child: Icon(
                          Icons.photo,
                          color: Colors.black,
                          size: 70,
                        ),
                      )
                    : CircleAvatar(
                        radius: 70,
                        backgroundImage: FileImage(imagePath!),
                      ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.person_outline_outlined,
                    size: 30,
                  ),
                  SizedBox(
                      width: width * 80 / 100,
                      child: customTextField(
                          controller: _controllerForName,
                          labelText: "First Name")),
                ],
              ),
              SizedBox(
                height: 13,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 10 / 100,
                  ),
                  SizedBox(
                      width: width * 80 / 100,
                      child: customTextField(
                          controller: _controllerForLastName,
                          keybosrdType: TextInputType.number,
                          labelText: "Last Name")),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 10 / 100,
                    child: Icon(
                      Icons.house_sharp,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    width: width * 80 / 100,
                    child: customTextField(
                        controller: _controllerForCompany,
                        labelText: "Company"),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 10 / 100,
                    child: Icon(
                      Icons.phone,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    width: width * 80 / 100,
                    child: customTextField(
                        controller: _controllerForPhone,keybosrdType: TextInputType.number, labelText: "Phone"),
                  )
                ],
              ),
              SizedBox(
                height: 13,
              ),
              customRow(dataForMenu: {"No Label":"No Label","Mobile":'Mobile','Work':'Work',"Home":"Home","Main":"Main",'Work Fax':"Work Fax","Home Fax":"Home Fax",'Pager':'Pager','Other':'Other','Custom':'Custom'},
                  index:0,
                  valueForList: dataForShow[0],
                  context: context,

                  labels: "Label"),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 10 / 100,
                    child: Icon(
                      Icons.mail_outline_outlined,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    width: width * 80 / 100,
                    child: customTextField(
                        controller: _controllerForMail, labelText: "Email"),
                  )
                ],
              ),
              SizedBox(
                height: 13,
              ),
              customRow(dataForMenu: {"No Label":"No Label",'Home':'Home','Work':'Work','Other':'Other','Custom':'Custom'},
                  index: 1,
                  valueForList:  dataForShow[1],

                  context: context,

                  labels: "Label"),
              SizedBox(
                height: 20,
              ),
              customRow(dataForMenu: {},
                  valueForList:  dataForShow[2],
                  index: 2,

                  context: context,

                  preFixicon: Icon(Icons.calendar_today),
                  widths: width * 80 / 100,
                  labels: "Significant Date"),
              SizedBox(
                height: 13,
              ),
              customRow(dataForMenu: {"No Label":"No Label",'Birthday':'Birthday','Anniversary':'Anniversary','Other':'Other','Custom':'Custom'},
                context: context,
                  index: 3,
                  valueForList:  dataForShow[3],
                  labels: "Label"),
              customMaterialButtonWidget2(
                  content: Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    if (_controllerForPhone.text.toString() == '' ||_controllerForName.text.toString() == '') {
                      print("object");
                      print(_controllerForName.text.toString());
                      print(_controllerForPhone.text.toString());
                      CustomAlert.alertDialogCustom(context,"Invalids!🫤",
                          Text("Please Enter Name And Number\nThose Filds Are Required"),
                          [customMaterialButtonWidget2(
                              content: Text("Ok!",style: TextStyle(color: Colors.white),),
                              onTap: () {Navigator.pop(context);})]);
                    } else {
                      // await getContacts();
                      saveContacts(_controllerForName.text.toString(),
                          _controllerForPhone.text.toString());
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }










  Widget customRow(
      {double? widths,
          String? valueForList,
        Icon? preFixicon,
        required int index,
        required  Map<String,String> dataForMenu,
        required BuildContext context,
        required String labels}) {
    return Row(
      children: [
        SizedBox(
          width: width * 10 / 100,
          child: preFixicon != null ? preFixicon : null,
        ),
        SizedBox(
          width: preFixicon!=null?width*80/100:width*50/100,
          height: 60,
          child:  Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(1,),
                ),
                border: Border.all(width: 1),
                color: Colors.transparent
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child:index==2?GestureDetector(
                onTap: ()async {
                  DateTime? dataPicked=await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),


                      firstDate: DateTime(2004),
                      lastDate: DateTime(2030)
                  );
                  if(dataPicked!=null){
                    setState(() {
                      dataStore=dataPicked!;
                    });
                  }


                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(dataStore==null?"Significant Date":" ${dataStore?.year}:${dataStore?.month}:${dataStore?.day}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                      Icon(Icons.arrow_drop_down_sharp)
                    ],
                  ),
                ),
              ) :DropdownButton<String>(
                dropdownColor: Colors.blueGrey.shade50,
                elevation: 10,
                underline: Container(height: 2,color: Colors.transparent,),
                alignment: Alignment.center,

                isExpanded: true,
                enableFeedback: true,
                value: dataForShow[index],
                // hint: Text("ok    "),
                borderRadius: BorderRadius.circular(23),
                onChanged: (value) {
                  setState(() {
                    // valueForList=value;
                    dataForShow[index]=value;
                    print(valueForList);
                  });
                },

                items: dataForMenu.map((key, value) {
                  return MapEntry(
                      key,
                      DropdownMenuItem<String>(
                        value: key,
                        child: Text(value),
                      ));
                })
                    .values
                    .toList(),
              ),
            ),
          ),
        )
      ],
    );
  }

}

pickImage(
  ImageSource src,
) async {
  print("okkkkkkkkkkkkkkkkkkkkkkkkkk");

  final picker = await ImagePicker().pickImage(source: src);
  if (picker == null) return;
  final data = File(picker.path);
  testCompressFile(data.readAsBytesSync());
  return data!;
}

 testCompressFile(Uint8List file) async {
  var result = await FlutterImageCompress.compressWithList(file,quality: 60,minHeight: 600,minWidth: 600,);
  phoneAvtat=result;
}
