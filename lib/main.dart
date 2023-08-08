import 'package:betweenerapp/views/Follower.dart';
import 'package:betweenerapp/views/Follwing.dart';
import 'package:betweenerapp/views/Search.dart';
import 'package:betweenerapp/views/addingLink.dart';
import 'package:betweenerapp/views/home_view.dart';
import 'package:betweenerapp/views/loading.dart';
import 'package:betweenerapp/views/login_view.dart';
import 'package:betweenerapp/views/main_app_view.dart';
import 'package:betweenerapp/views/profile_view.dart';
import 'package:betweenerapp/views/receive_view.dart';
import 'package:betweenerapp/views/register_view.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Betweener',
        theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: kPrimaryColor,
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor),
            ),
            scaffoldBackgroundColor: kScaffoldColor),
        home: const LoadingView(),
        routes: {
          LoadingView.id: (context) => LoadingView(),
          LoginView.id: (context) => LoginView(),
          RegisterView.id: (context) => RegisterView(),
          HomeView.id: (context) => const HomeView(),
          MainAppView.id: (context) => const MainAppView(),
          ProfileView.id: (context) => const ProfileView(),
          ReceiveView.id: (context) => const ReceiveView(),
          AddEditLink.id: (context) => const AddEditLink(),
          SearchView.id: (context) => const SearchView(),
          FollowingView.id: (context) => const FollowingView(),
          FollowerView.id: (context) => const FollowerView(),
          // FriendView.id: (context) => const FriendView(),
        });
  }
}
