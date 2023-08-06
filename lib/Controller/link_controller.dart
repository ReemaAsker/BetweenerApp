// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:http/http.dart' as http;
// import 'package:tt9_betweener_challenge/Model/link.dart';
// import 'package:tt9_betweener_challenge/Model/user.dart';
// import 'package:tt9_betweener_challenge/views/login_view.dart';

// import '../constants.dart';

// Future<List<Link>> getlinks(context) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   User user = userFromJson(prefs.getString('user')!);
//   final response = await http.get(Uri.parse(linksUrl),
//       headers: {'Authorization': 'Bearer ${user.token}'});
//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body)['links'] as List<dynamic>;
//     return data.map((e) => Link.fromJson(e)).toList();
//   } else if (response.statusCode == 401) {
//     Navigator.pushReplacementNamed(context, LoginView.id);
//   }

//   return Future.error('Something error');
// }

// Future<void> addLink(context, Map<String, String> body) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   User user = userFromJson(prefs.getString('user')!);
//   final response = await http.post(Uri.parse(linksUrl),
//       body: body, headers: {'Authorization': 'Bearer ${user.token}'});
//   if (response.statusCode == 200) {
//     // print('body of add link  ${response.body}');
//   } else if (response.statusCode == 401) {
//     Navigator.pushReplacementNamed(context, LoginView.id);
//   } else {
//     Future.error('error in adding link');
//   }
// }

// Future<bool> deleteLink(context, int linkid) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   User user = userFromJson(prefs.getString('user')!);

//   final response = await http.delete(Uri.parse('$linksUrl/$linkid'),
//       headers: {'Authorization': 'Bearer ${user.token}'});

//   if (response.statusCode == 200) {
//     return true;
//   } else if (response.statusCode == 401) {
//     Navigator.pushReplacementNamed(context, LoginView.id);
//   }
//   return false;
// }

// Future<bool> editLink(context, int linkid, Map<String, String> body) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   User user = userFromJson(prefs.getString('user')!);
//   final response = await http.put(Uri.parse('$linksUrl/$linkid'),
//       body: body, headers: {'Authorization': 'Bearer ${user.token}'});
//   if (response.statusCode == 200) {
//     return true;
//   } else if (response.statusCode == 401) {
//     Navigator.pushReplacementNamed(context, LoginView.id);
//   }
//   return false;
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/link.dart';
import '../Model/user.dart';
import '../constants.dart';
import '../views/login_view.dart';

Future<http.Response?> makeAuthorizedRequest(Uri uri, String method,
    Map<String, String> body, BuildContext context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user')!);

  http.Response? response; // Initialize with a nullable value
  switch (method) {
    case 'GET':
      response = await http
          .get(uri, headers: {'Authorization': 'Bearer ${user.token}'});
      break;
    case 'POST':
      response = await http.post(uri,
          body: body, headers: {'Authorization': 'Bearer ${user.token}'});
      break;
    case 'PUT':
      response = await http.put(uri,
          body: body, headers: {'Authorization': 'Bearer ${user.token}'});
      break;
    case 'DELETE':
      response = await http
          .delete(uri, headers: {'Authorization': 'Bearer ${user.token}'});
      break;
  }

  if (response != null && response.statusCode == 401) {
    Navigator.pushReplacementNamed(context, LoginView.id);
  }

  return response;
}

Future<List<Link>> getlinks(context) async {
  final response =
      await makeAuthorizedRequest(Uri.parse(linksUrl), 'GET', {}, context);
  if (response != null && response.statusCode == 200) {
    final data = jsonDecode(response.body)['links'] as List<dynamic>;
    return data.map((e) => Link.fromJson(e)).toList();
  }

  return Future.error('Something error');
}

Future<void> addLink(context, Map<String, String> body) async {
  final response =
      await makeAuthorizedRequest(Uri.parse(linksUrl), 'POST', body, context);
  if (response != null && response.statusCode == 200) {
    // print('body of add link  ${response.body}');
  } else {
    Future.error('Error in adding link');
  }
}

Future<bool> deleteLink(context, int linkid) async {
  final response = await makeAuthorizedRequest(
      Uri.parse('$linksUrl/$linkid'), 'DELETE', {}, context);
  return response != null && response.statusCode == 200;
}

Future<bool> editLink(context, int linkid, Map<String, String> body) async {
  final response = await makeAuthorizedRequest(
      Uri.parse('$linksUrl/$linkid'), 'PUT', body, context);
  return response != null && response.statusCode == 200;
}
