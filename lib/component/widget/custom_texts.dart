import "package:flutter/material.dart";
import 'package:speech_to_text/speech_to_text.dart';
import "../../screen/calling_app/search_contact_on_text.dart";

Widget customMaterialButtonWidget2(
    {double width = 100,
    buttonColor = Colors.black,
    customFontSize = 12.0,
    double height = 40,
    double redius = 4,
    required content,
    required Function()? onTap}) {
  return MaterialButton(
    // padding: EdgeInsets.all(1),

    height: height,
    minWidth: width,
    color: buttonColor,
    onPressed: onTap,
    shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(redius),
        borderSide: BorderSide.none),
    child: content,
  );
}

Widget customTextField(
    {required controller,
    required String labelText,
    keybosrdType = TextInputType.text}) {
  return TextField(
    keyboardType: keybosrdType,
    cursorColor: Colors.black,
    cursorWidth: 2,
    cursorOpacityAnimates: true,
    controller: controller,
    decoration: InputDecoration(
      label: Text(
        labelText,
        style: TextStyle(color: Colors.black),
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(2))),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(2)),
          borderSide: BorderSide(color: Colors.black)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(2)),
          borderSide: BorderSide(color: Colors.black)),
    ),
  );
}

class CustomAlert {
  static alertDialog(BuildContext context, String content) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Some Error"),
          content: Text(
            "$content",
            style: TextStyle(fontSize: 12),
          ),
        );
      },
    );
  }

  static alertDialogCustom(BuildContext context, String data, Widget content,
      [act = null]) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("$data"),
          content: content,
          actions: act,
        );
      },
    );
  }
}

