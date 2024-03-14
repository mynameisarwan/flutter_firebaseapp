import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

final Future<SharedPreferences> pref = SharedPreferences.getInstance();

Future<Map<String, dynamic>> getReference() async {
  final SharedPreferences prefs = await pref;
  Map<String, dynamic> localdata = {};
  if (prefs.containsKey('locData')) {
    localdata =
        json.decode(prefs.getString('locData')!) as Map<String, dynamic>;
  }
  // print('getreference username adalah ${localdata['userName']}');
  return localdata;
}

void setReference(Map<String, dynamic> dataMap) async {
  final SharedPreferences prefs = await pref;
  final myData = json.encode(dataMap);

  prefs.setString('locData', myData);
}
