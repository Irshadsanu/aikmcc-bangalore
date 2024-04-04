import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


var appBarHeight = AppBar().preferredSize.height;

callNext(var className, var context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => className),
  );
}
callNextReplacement(var className, var context){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => className),
  );
}
callNextRemoveUntil(var className, var context){
  Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) => className), (route) => false);

  // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => className);
}

back(var context) {
  Navigator.pop(context);
}
void finish(context) {
  Navigator.pop(context);
}
void hideKeyboard(context) {
  FocusScope.of(context).requestFocus(FocusNode());
}
Color hexStringToHexInt(String hex) {
  hex = hex.replaceFirst('#', '');
  hex = hex.length == 6 ? 'ff' + hex : hex;
  int val = int.parse(hex, radix: 16);
  return Color(val);
}
Color colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}