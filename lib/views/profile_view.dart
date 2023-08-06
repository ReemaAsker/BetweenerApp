import 'package:betweenerapp/Model/link.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../Controller/follow_controller.dart';
import '../Controller/link_controller.dart';
import '../Controller/user_controller.dart';
import '../Model/user.dart';
import '../constants.dart';
import 'Follower.dart';
import 'Follwing.dart';
import 'addingLink.dart';

class ProfileView extends StatefulWidget {
  static String id = '/profileView';

  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool isfollowerclick = false;
  bool isfollowingclick = false;
  late User currentUser;
  int followers = 0;
  int follwing = 0;
  bool isload = false;
  late Future<List<Link>> links;
  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }

  Future<void> getFolowersAndFollwesNum() async {
    final data = await getFolowersAndFollwes(context);
    setState(() {
      followers = data['followers']!;
      follwing = data['following']!;
    });

    print(followers);
    print(follwing);
  }

  Future<void> currentUserInfo() async {
    final user = await getLocalUser();
    setState(() {
      currentUser = user;
    });
  }

  void deletemyLink(int linkid) {
    deleteLink(context, linkid).then((isdeleted) {
      if (isdeleted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('deleted successfully!'),
          backgroundColor: Colors.green,
        ));
      }
      updateLinksList();
    });
  }

  void editmyLink(Link link) async {
    final updatedLink = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditLink(link: link),
      ),
    );

    setState(() {
      updateLinksList();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Link added successfully!'),
        backgroundColor: Colors.green,
      ));
    });
  }

  @override
  void initState() {
    super.initState();

    currentUserInfo().then((value) {
      getFolowersAndFollwesNum().then(
        (value) {
          setState(() {
            isload = true;
            updateLinksList();
          });
        },
      );
    });
  }

  void updateLinksList() {
    setState(() {
      links = getlinks(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return !isload
        ? const Center(
            child: CircularProgressIndicator(
            color: kPrimaryColor,
          ))
        : Scaffold(
            floatingActionButton: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AddEditLink.id, arguments: null)
                    .then((value) {
                  setState(() {
                    updateLinksList();
                  });
                });
              },
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(100)),
                padding: EdgeInsets.only(bottom: 100.0, right: 20.0),
                child: CircleAvatar(
                  backgroundColor: kPrimaryColor,
                  child: Icon(Icons.add, size: 30, color: Colors.white),
                  radius: 30,
                ),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Column(children: [
                  Center(
                    child: Text(
                      'Profile',
                      style: TextStyle(
                          fontSize: 24,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 14.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16.0),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(0.2), // Shadow color and opacity
                              blurRadius: 10, // Spread of the shadow
                              offset:
                                  Offset(0, 15), // Offset from the container
                            ),
                          ],
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(16)),
                      child: Row(children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                child: Image(
                                  height: 100,
                                  width: 100,
                                  image:
                                      AssetImage('assets/imgs/profileimg.png'),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic, //
                            children: [
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    capitalizeFirstLetter(
                                        currentUser.user!.name.toString()),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24),
                                  ),
                                ],
                              ),
                              Text(
                                '${currentUser.user!.email} ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isfollowerclick = !isfollowerclick;
                                        isfollowingclick = false;
                                      });
                                      Navigator.pushNamed(
                                          context, FollowerView.id);
                                    },
                                    focusColor: kPrimaryColor,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 8.0),
                                      decoration: BoxDecoration(
                                          color: isfollowerclick
                                              ? kSecondaryColor
                                              : kLightSecondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: Row(
                                        children: [
                                          Text(
                                            'follwers ',
                                            style: TextStyle(
                                                color: kPrimaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: kLightPrimaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            // radius: 16,
                                            child: Text(
                                              '$followers',
                                              style: TextStyle(
                                                  color: kPrimaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isfollowingclick = !isfollowingclick;
                                        isfollowerclick = false;
                                      });
                                      Navigator.pushNamed(
                                          context, FollowingView.id);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 8.0),
                                      decoration: BoxDecoration(
                                        color: isfollowingclick
                                            ? kSecondaryColor
                                            : kLightSecondaryColor,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Row(
                                        children: [
                                          const Text(
                                            'following',
                                            style: TextStyle(
                                                color: kPrimaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: kLightPrimaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            // radius: 16,
                                            child: Text(
                                              '$follwing',
                                              style: TextStyle(
                                                  color: kPrimaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ]),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: links,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return allLinks(
                              index % 2 == 0,
                              snapshot.data![index],
                              // .title.toString(),
                              // snapshot.data![index].link.toString(),

                              // snapshot.data![index].id!
                            );
                          },
                        );
                      },
                    ),
                  ),
                ]),
              ),
            ),
          );
  }

  Widget allLinks(bool isEven, Link link) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
      child: Slidable(
        key: ValueKey(0),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SizedBox(
              width: 20.0,
            ),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: isEven ? kLightPrimaryColor : kLightSecondaryColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: InkWell(
                onTap: () {
                  editmyLink(link);
                },
                child: Icon(
                  Icons.edit,
                  color: Colors.white, // Set the color of the Icon here
                ),
              ),
            ),
            SizedBox(
              width: 30.0,
            ),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: kDangerColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: InkWell(
                onTap: () {
                  deletemyLink(link.id!);
                },
                child: Icon(
                  color: Colors.white,
                  Icons.delete,
                ),
              ),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.2), // Shadow color and opacity
                        blurRadius: 10, // Spread of the shadow
                        offset:
                            const Offset(0, 15), // Offset from the container
                      ),
                    ],
                    borderRadius: BorderRadius.circular(12.0),
                    color: isEven ? kLightPrimaryColor : kLightSecondaryColor),
                child: ListTile(
                    title: Text(
                      link.title!.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isEven ? kPrimaryColor : kOnSecondaryColor,
                        letterSpacing: 3,
                      ),
                    ),
                    subtitle: Text(
                      link.link!,
                      style: TextStyle(
                          letterSpacing: 3,
                          color: isEven ? kPrimaryColor : kOnSecondaryColor),
                    ),
                    trailing: Icon(iscontain(link.title!))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData? iscontain(String linktitle) {
    if (socialMediaIcons.containsKey(linktitle.toLowerCase())) {
      return socialMediaIcons[linktitle.toLowerCase()];
    }
    return FontAwesomeIcons.link;
  }
}
