import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

getReference() async {
  final pref = await SharedPreferences.getInstance();
  if (pref.containsKey('locData')) {
    return json.decode(pref.getString('locData')!) as Map<String, dynamic>;
  }
}

void setReference(Map<String, dynamic> dataMap) async {
  final pref = await SharedPreferences.getInstance();
  final myData = json.encode(dataMap);

  pref.setString('locData', myData);
}
