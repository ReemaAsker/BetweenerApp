
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Controller/follow_controller.dart';
import '../Controller/user_controller.dart';
import '../Model/user.dart';
import '../constants.dart';
import 'addingLink.dart';

class friendView extends StatefulWidget {
  static String id = '/friendView';
  final UserClass user;
  final bool isFollow;
  const friendView({super.key, required this.user, required this.isFollow});

  @override
  State<friendView> createState() => _FriendViewViewState();
}

class _FriendViewViewState extends State<friendView> {
  late UserClass friend;

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  void initState() {
    super.initState();
    friend = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            capitalizeFirstLetter(friend.name ?? ''),
            style: TextStyle(
                fontSize: 24,
                color: kPrimaryColor,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 16.0),
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
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(16)),
                child: Row(children: [
                  const Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          child: Image(
                            height: 100,
                            width: 100,
                            image: AssetImage('assets/imgs/profileimg.png'),
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
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              capitalizeFirstLetter(friend.name.toString()),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 24),
                            ),
                          ],
                        ),
                        Text(
                          '${friend.email} ',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                              backgroundColor: widget.isFollow
                                  ? MaterialStatePropertyAll(Colors.transparent)
                                  : MaterialStatePropertyAll(kSecondaryColor),
                              foregroundColor: widget.isFollow
                                  ? MaterialStatePropertyAll(kSecondaryColor)
                                  : MaterialStatePropertyAll(kPrimaryColor),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                horizontal: 16,
                              )), // Set the padding here
                            ),
                            onPressed: () {
                              widget.isFollow ? null : print('ok');
                            },
                            child:
                                Text(widget.isFollow ? 'Followed' : 'Follow'))
                      ],
                    ),
                  )
                ]),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: friend.links!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 6.0),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(
                                          0.2), // Shadow color and opacity
                                      blurRadius: 10, // Spread of the shadow
                                      offset: const Offset(
                                          0, 15), // Offset from the container
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: index % 2 == 0
                                      ? kLightPrimaryColor
                                      : kLightSecondaryColor),
                              child: ListTile(
                                  title:
                                      // crossAxisAlignment: CrossAxisAlignment.baseline,
                                      // textBaseline: TextBaseline.alphabetic, //
                                      // children: [
                                      Text(
                                    friend.links![index].title ??
                                        'ok'.toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: index % 2 == 0
                                          ? kPrimaryColor
                                          : kOnSecondaryColor,
                                      letterSpacing: 3,
                                    ),
                                  ),
                                  subtitle: Text(
                                    friend.links![index].link!,
                                    style: TextStyle(
                                        letterSpacing: 3,
                                        color: index % 2 == 0
                                            ? kPrimaryColor
                                            : kOnSecondaryColor),
                                  ),
                                  trailing: Icon(
                                      iscontain(friend.links![index].title!))),
                            ),
                          ),
                        ],
                      ),
                    );
                    // Padding(
                    //   padding: EdgeInsets.all(20),
                    //   child: Container(
                    //     child: ListTile(
                    //       title: Text(friend.links![index].title ?? 'ok'),
                    //       subtitle: Text(friend.links![index].link ?? 'ok2'),
                    //     ),
                    //   ),
                    // );
                  }),
            ),
          ]),
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
