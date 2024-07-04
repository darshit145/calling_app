import 'package:calling_app/screen/call_log/call_log.dart';
import 'package:calling_app/screen/calling_app/add_contacts.dart';
import 'package:flutter/material.dart';
import 'call_save_list.dart';
class BottomNavigationForcalling extends StatefulWidget {
  const BottomNavigationForcalling({super.key});

  @override
  State<BottomNavigationForcalling> createState() => _BottomNavigationForcallingState();
}

class _BottomNavigationForcallingState extends State<BottomNavigationForcalling> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  int index=0;
  List listForButtomNavigationBar=[
    // CallInFlutter(),
    CallLogScreen(),
    CallSaveList(),
    AddContacts(),
    // CallInFlutter(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,

        onTap: (value) {

          setState(() {

            index=value;
          });
        },

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.history),label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.watch_later),label: "Recents"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_outlined),label: "Contacts"),
        ],
      ),
      body: listForButtomNavigationBar[index],

    );
  }

}
