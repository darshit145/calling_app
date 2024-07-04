
import 'package:calling_app/screen/calling_app/bottom_navigation_forcalling.dart';
import 'package:calling_app/utility/resources.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
import 'dart:async';

bool callindg=false;
void main() {
  callindg=true;
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
   Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PerMitionsFromUser(),
    );
  }

}
class PerMitionsFromUser extends StatefulWidget {
  const PerMitionsFromUser({super.key});

  @override
  State<PerMitionsFromUser> createState() => _PerMitionsFromUserState();
}

class _PerMitionsFromUserState extends State<PerMitionsFromUser> {
  static const platform = MethodChannel('com.example.calling_app');

  @override
  void initState() {

    super.initState();
    gettingPerMition();
  }
  Future<void>  gettingPerMition()async {

    if(await Permission.contacts.isGranted && await Permission.camera.isGranted && await Permission.phone.isGranted && await Permission.microphone.isGranted){
      finalContact=await ContactsService.getContacts();
      Resources.gettingFaverouteToList();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavigationForcalling(),));

    }else{
      await Permission.contacts.request();
      await Permission.camera.request();
      await Permission.phone.request();
      await Permission.microphone.request();
      await Permission.notification.request();
      await Permission.systemAlertWindow.request();
      await Permission.backgroundRefresh.request();
      finalContact=await ContactsService.getContacts();
      Resources.gettingFaverouteToList();
      // await Permission.readPhoneState.request();


      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavigationForcalling(),));
    }


    // Permission.call

  }
  @override
  Widget build(BuildContext context) {
    HEIGHT=MediaQuery.of(context).size.height;
    WIDTH=MediaQuery.of(context).size.width;
    return const Scaffold();
  }


}

// ... (other imports)

