import 'package:betweenerapp/views/friendView.dart';
import 'package:flutter/material.dart';

import '../Controller/follow_controller.dart';
import '../Controller/link_controller.dart';
import '../Model/user.dart';
import '../constants.dart';
import '../styles.dart';

class FollowerView extends StatefulWidget {
  static const id = '/FollowerView';
  const FollowerView({super.key});

  @override
  State<FollowerView> createState() => _FollowerViewState();
}

class _FollowerViewState extends State<FollowerView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Followers')),
        backgroundColor: kLightPrimaryColor,
      ),
      body: Column(
        children: [
          const Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: getAllFollowers(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  List<dynamic> followingData = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: followingData.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map<String, dynamic> followingItem = followingData[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => friendView(
                                isFollow: true,
                                user: UserClass.fromJson(followingItem),
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            padding: EdgeInsets.all(8),
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
                              color: kSecondaryColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white),
                            ),
                            child: ListTile(
                              title: Text(
                                '${followingItem['name']}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text('${followingItem['email']}'),
                              trailing: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.white),
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return Center(
                    child: Text('No data'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
