import 'package:shared_preferences/shared_preferences.dart';

void saveUid(String userId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userId', userId);
}

Future<String> getUid() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('userId');
}
