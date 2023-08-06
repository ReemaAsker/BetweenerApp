import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Model/user.dart';
import '../constants.dart';
import '../views/login_view.dart';

Future<Map<String, int>> getFolowersAndFollwes(context) async {
  int followers = 0;
  int following = 0;
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user')!);
  final response = await http.get(Uri.parse(followUrl),
      headers: {'Authorization': 'Bearer ${user.token}'});
  final data = jsonDecode(response.body);
  print(data);
  if (response.statusCode == 200) {
    following = data['following_count'];
    followers = data['followers_count'];
    return {'followers': followers, 'following': following};
  } else if (response.statusCode == 401) {
    Navigator.pushReplacementNamed(context, LoginView.id);
  }

  return Future.error('Something error');
}

Future<List<dynamic>> getAllFowolling(context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user')!);

  final response = await http.get(Uri.parse(followUrl),
      headers: {'Authorization': 'Bearer ${user.token}'});

  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    List<dynamic> following = data['following'];
    return following;
  } else if (response.statusCode == 401) {
    Navigator.pushReplacementNamed(context, LoginView.id);
  }
  throw Exception('error in followee link');
}

Future<List<dynamic>> getAllFollowers(context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user')!);

  final response = await http.get(Uri.parse(followUrl),
      headers: {'Authorization': 'Bearer ${user.token}'});

  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    List<dynamic> follower = data['followers'];
    return follower;
  } else if (response.statusCode == 401) {
    Navigator.pushReplacementNamed(context, LoginView.id);
  }
  throw Exception('error in followee link');
}

Future<void> AddFollowee(context, Map<String, String> body) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user')!);
  final response = await http.post(Uri.parse(followUrl),
      body: body, headers: {'Authorization': 'Bearer ${user.token}'});
  if (response.statusCode == 200) {
    print('body of followee link  ${response.body}');
  } else if (response.statusCode == 401) {
    Navigator.pushReplacementNamed(context, LoginView.id);
  } else {
    throw Exception('error in followee link');
  }
}
