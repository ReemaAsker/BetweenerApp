import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../Model/user.dart';
import '../constants.dart';
import '../views/login_view.dart';

Future<List<UserClass>> SearchByname(context, String userName) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user')!);
  final response = await http.post(Uri.parse(searchkUrl),
      body: {'name': userName},
      headers: {'Authorization': 'Bearer ${user.token}'});

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['user'] as List<dynamic>;

    return data.map((e) {
      return UserClass.fromJson(e);
    }).toList();
  } else if (response.statusCode == 401) {
    Navigator.pushReplacementNamed(context, LoginView.id);
  }

  return Future.error('Something error');
}
