import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:my_instagram/models/feed.dart';
import 'package:my_instagram/models/user_model.dart';
import 'package:my_instagram/pages/comment_page.dart';
import 'package:my_instagram/services/api_service.dart';
import 'package:my_instagram/widgets/message.dart';
// import 'package:my_instagram/pages/home_page.dart';
import 'package:my_instagram/widgets/post.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/post_model.dart';
import 'models/story_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences sp;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sp = await SharedPreferences.getInstance();
  // await sp.clear();
  //used singleton for this service
  ApiUserService apiService = ApiUserService.instance;
  APIFeedService apiFeedService = APIFeedService();
  FeedModel feed;
  await apiFeedService.getFeedByUserId(0).then((feedObj) {
    if (feedObj != null) {
      feed = feedObj;
    }
  });

  //check_friends_status can be only true or null if wasn't created
  runApp(FutureBuilder(
      future: apiService.getUser(0),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (!snapshot.hasData) {
          return MaterialApp(
              // theme: ThemeData.dark(),
              title: "Waiting for data",
              home: Center(child: CircularProgressIndicator()));
        } else {
          return MultiProvider(providers: [
            ChangeNotifierProvider<User>(create: (context) {
              User user = snapshot.data;
              return user;
            }),
            ChangeNotifierProvider<FeedModel>(
              create: (context) => feed ?? FeedModel(0, 0),
            ),
            ChangeNotifierProvider<StoriesFeed>(create: (context) {
              StoriesFeed storyFeed = StoriesFeed(0, 0);
              addTestStories(storyFeed);
              return storyFeed;
            })
          ], child: MyApp());
        }
      }));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        title: "My implementation",
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (context) => Home());
              break;
            case '/comment':
              var arguments = settings.arguments as Map<String, PostModel>;
              return MaterialPageRoute(
                  builder: (BuildContext context) => MultiProvider(
                          providers: [
                            ChangeNotifierProvider.value(
                                value: arguments['post'])
                          ],
                          builder: (context, child) =>
                              CommentPage(id: arguments['post'].id)));
              break;
          }
        });
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              // tooltip: 'Show Snackbar',
              onPressed: () {
                Text("Заглушка");
              },
              color: Colors.black,
              iconSize: 30,
            ),
            Text(
              "Instagram",
              style: GoogleFonts.lobster(fontSize: 25),
            ),
            Transform.rotate(
                angle: -35 * pi / 180,
                child: IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  // tooltip: 'Show Snackbar',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChatScreen()));
                  },
                  color: Colors.black,
                )),
          ],
        ),
      ),
      body: Feed(),
    );
  }
}

//Temporary for new stories then get from http
void addTestStories(StoriesFeed feed) {
  feed.addStories(
      1,
      StoryModel(
        1,
        "https://i.pinimg.com/236x/dd/64/74/dd6474beaaa197bd7e1bac3d16d39afe.jpg",
        '',
        1,
      ));
  feed.addStories(
      2,
      StoryModel(
        2,
        "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
        '',
        2,
      ));
  feed.addStories(
      3,
      StoryModel(
        3,
        "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80",
        '',
        1,
      ));
  feed.addStories(
      4,
      StoryModel(
        4,
        "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80",
        '',
        2,
      ));
}
