import 'package:flutter/material.dart';

import '../Controller/follow_controller.dart';
import '../Controller/link_controller.dart';
import '../Controller/search_controller.dart';
import '../Model/user.dart';
import '../constants.dart';
import '../styles.dart';
import 'friendView.dart';

class SearchView extends StatefulWidget {
  static const id = '/SearchView';
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late Future<List<UserClass>> result;
  final TextEditingController? searchController = TextEditingController();
  bool checkFollow = false;
  late List<dynamic> followingdata;
  @override
  void initState() {
    result = SearchByname(context, '');
    checkFollwing();
    super.initState();
  }

  bool isUserFollow(int userIdToSearch) {
    bool checkFollow =
        followingdata.any((user) => user['id'] == userIdToSearch);

    return checkFollow;
  }

  void checkFollwing() {
    getAllFowolling(context).then(
      (following) {
        setState(() {
          followingdata = following;
        });
      },
    );
  }

  void addFolloweeAndUpdateList(int userIdToSearch) {
    AddFollowee(context, {
      'followee_id': '$userIdToSearch',
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Added successfully!'),
        backgroundColor: Colors.green,
      ));

      // After successfully adding the followee, update the followingdata list.
      checkFollwing();
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(err.toString()),
        backgroundColor: Colors.red,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        backgroundColor: kLightPrimaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Search',
                  style: Styles.textStyle14,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    hintText: 'Put user name ',
                    border: Styles.primaryRoundedOutlineInputBorder,
                    focusedBorder: Styles.primaryRoundedOutlineInputBorder,
                    errorBorder: Styles.primaryRoundedOutlineInputBorder,
                    enabledBorder: Styles.primaryRoundedOutlineInputBorder,
                    disabledBorder: Styles.primaryRoundedOutlineInputBorder,
                  ),
                  controller: searchController,
                  onFieldSubmitted: (value) {
                    result = SearchByname(context, searchController!.text);
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: result,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => friendView(
                                isFollow:
                                    isUserFollow(snapshot.data![index].id!),
                                user: snapshot.data![index],
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: kSecondaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.white)),
                              child: ListTile(
                                title: Text(
                                  '${snapshot.data![index].name}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle:
                                    Text('${snapshot.data![index].email}'),
                                trailing: GestureDetector(
                                  onTap: () {
                                    addFolloweeAndUpdateList(
                                        snapshot.data![index].id!);
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: kPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: isUserFollow(
                                              snapshot.data![index].id!)
                                          ? const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            )
                                          : const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  'Follow',
                                                  style: TextStyle(
                                                      color: kSecondaryColor),
                                                ),
                                                // isFollwed
                                                Icon(
                                                    Icons
                                                        .add_circle_outline_rounded,
                                                    color: kSecondaryColor,
                                                    size: 20),
                                              ],
                                            )),
                                ),
                              )),
                        ),
                      );
                    },
                  );
                }
                if (snapshot.hasError) {
                  return Text('no data');
                }
                return Text('loading');
              },
            ),
          ),
        ],
      ),
    );
  }
}
