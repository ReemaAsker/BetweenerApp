import 'package:betweenerapp/views/Search.dart';
import 'package:betweenerapp/views/addingLink.dart';
import 'package:flutter/material.dart';

import '../Controller/link_controller.dart';
import '../Controller/user_controller.dart';
import '../Model/link.dart';
import '../Model/user.dart';
import '../constants.dart';

class HomeView extends StatefulWidget {
  static String id = '/homeView';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<User> user;
  late Future<List<Link>> links;

  @override
  void initState() {
    user = getLocalUser();
    links = getlinks(context);
    super.initState();
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }

  void naviatgeAndAllLinks() {
    Navigator.pushNamed(context, AddEditLink.id).then((value) => {
          setState(() {
            links = getlinks(context);
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              kLightSecondaryColor,
              kLightDangerColor,
              kLightPrimaryColor
            ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.person_search_rounded,
                      size: 30,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, SearchView.id);
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.qr_code_scanner,
                    size: 30,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: FutureBuilder(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return RichText(
                      text: TextSpan(
                        text: 'Hello, ',
                        style: DefaultTextStyle.of(context).style.copyWith(
                              fontSize: 24,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                        children: <TextSpan>[
                          TextSpan(
                              text: capitalizeFirstLetter(
                                  snapshot.data!.user!.name.toString()),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: kPrimaryColor)),
                          TextSpan(text: ' 👋'),
                        ],
                      ),
                    );

                    // Text('Welcome ');
                  }
                  return Text('loading');
                },
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 48, left: 48, right: 48.0, top: 38),
                child: Container(
                    child: const Image(
                  image: AssetImage('assets/imgs/qr_code_withcorners.png'),
                  color: kPrimaryColor,
                )),
              ),
            ),
            Divider(
              color: kPrimaryColor,
              indent: 100,
              endIndent: 100,
              thickness: 2,
            ),
            SizedBox(
              height: 16,
            ),
            FutureBuilder(
              future: links,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: kPrimaryColor),
                  );
                }
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return GestureDetector(
                      onTap: () {
                        naviatgeAndAllLinks();
                      },
                      child: Container(
                          margin: EdgeInsets.all(8),
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                              color: kLinksColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [
                              Icon(
                                Icons.add,
                                color: kSecondaryColor,
                              ),
                              Text(
                                'add link',
                                style: TextStyle(color: kSecondaryColor),
                              )
                            ],
                          )),
                    );
                  }
                  return SizedBox(
                    height: 100,
                    child: ListView.separated(
                        padding: EdgeInsets.all(12),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, int index) {
                          final title = index == 0
                              ? snapshot.data![index].title
                              : snapshot.data?[index - 1].title;

                          final username = index == 0
                              ? snapshot.data![index].username
                              : snapshot.data?[index - 1].username;
                          return index == 0
                              ? GestureDetector(
                                  onTap: () {
                                    naviatgeAndAllLinks();
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                          color: kLinksColor,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.add,
                                            color: kSecondaryColor,
                                          ),
                                          Text(
                                            'add link',
                                            style: TextStyle(
                                                color: kSecondaryColor),
                                          )
                                        ],
                                      )),
                                )
                              : Container(
                                  padding: EdgeInsets.all(12.0),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(
                                              0.2), // Shadow color and opacity
                                          blurRadius:
                                              10, // Spread of the shadow
                                          offset: const Offset(0,
                                              10), // Offset from the container
                                        ),
                                      ],
                                      color:
                                          kLightSecondaryColor, //kLightSecondaryColor
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '  ${title.toString().toUpperCase()}   ',
                                            style: TextStyle(
                                                color: kOnSecondaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            username ?? '',
                                            style: TextStyle(
                                              color: kOnSecondaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 8,
                          );
                        },
                        itemCount: (snapshot.data!.length) + 1),
                  );
                }
                if (snapshot.connectionState != ConnectionState.active) {
                  return const Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons
                              .signal_wifi_statusbar_connected_no_internet_4_outlined,
                          color: kSecondaryColor,
                          size: 40,
                        ),
                        Text(
                          'Wrong in wifi connection...',
                          style: TextStyle(
                            color: kPrimaryColor,
                          ),
                        )
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Something wrong');
                }

                return Padding(
                  padding: const EdgeInsets.only(top: 12.0, left: 12.0),
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
