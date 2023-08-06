import 'package:http/http.dart' as http;

import '../Model/user.dart';
import '../constants.dart';

Future<User> login(Map<String, String> body) async {
  final response = await http.post(Uri.parse(loginUrl), body: body);
  if (response.statusCode == 200) {
    return userFromJson(response.body);
  } else
    return throw Exception('Error in login');
}

Future<User> register(Map<String, String> body) async {
  final response = await http.post(Uri.parse(registerUrl), body: body);
  if (response.statusCode == 200) {
    return userFromJson(response.body);
  } else
    return throw Exception('Error in register');
}
