import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_instagram/models/comment_model.dart';
import 'package:my_instagram/models/feed.dart';
import 'package:my_instagram/models/post_model.dart';
import 'package:my_instagram/models/story_model.dart';
import 'package:my_instagram/models/user_model.dart';
import 'package:my_instagram/pages/comment_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'stories.dart';

import 'package:provider/provider.dart';

class Post extends StatefulWidget {
  final int id;

  Post({Key key, this.id}) : super(key: key);

  @override
  _PostState createState() => _PostState();

  static Widget buildDescription(context, String nickname, String description) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(children: <TextSpan>[
            TextSpan(
                text: nickname,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  wordSpacing: 5,
                )),
            TextSpan(text: "   "),
            TextSpan(
              text: description,
            )
          ]))
        ],
      ),
    );
  }
}

class _PostState extends State<Post> {
  String lastCommet;

  @override
  Widget build(BuildContext context) {
    // final post = context.read<FeedModelProvider>().getElementById(id);
    TextEditingController commentController = TextEditingController();
    final post = Provider.of<PostModel>(context);
    final user = Provider.of<User>(context);
    User userByIdData;
    if (user.friends.length != 2)
      return Center(child: CircularProgressIndicator());
    else
      userByIdData = user.getFriendById(post.userId);

    // final postId = post.getElementById(id);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Row(children: [
                StoryIcon(
                  true,
                  false,
                  id: widget.id,
                  height: 50,
                  width: 50,
                  radius: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(userByIdData.nickname,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              ]),
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.more_horiz,
                ),
              ),
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            width: double.infinity,
            child: InkWell(
              onDoubleTap: () {
                post.changeLikeStatus();
                sp.setBool(post.id.toString(), post.like);
              },
              child: Image(
                image: NetworkImage(post.mainPhotoUrl),
                fit: BoxFit.fitWidth,
              ),
            )),
        Container(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer<PostModel>(builder: (context, post, child) {
                  return IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: (post.like ||
                              (sp.getBool(post.id.toString()) ?? false))
                          ? Colors.red
                          : Colors.white,
                      size: 25,
                    ),
                    onPressed: () {
                      post.changeLikeStatus();
                      sp.setBool(post.id.toString(), post.like);
                    },
                    // tooltip: 'Show Snackbar',
                    color: Colors.black,
                  );
                }),
                IconButton(
                    icon: Icon(
                      CupertinoIcons.chat_bubble,
                      size: 35,
                    ),
                    onPressed: () {
                      // addCommetPage(context, post);
                    }),
                Transform.rotate(
                  angle: -24 * pi / 180,
                  child: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 30,
                    ),
                    // tooltip: 'Show Snackbar',
                    onPressed: () {
                      Text("Заглушка");
                      // scaffoldKey.currentState.showSnackBar(snackBar);
                    },
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: IconButton(
                icon: Icon(
                  Icons.archive_outlined,
                  color: post.archive ? Colors.grey : Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  post.changeArchiveStatus();
                },
              ),
            )
          ]),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.only(bottom: 6, left: 15),
            child: Text(
              ("${((sp.getInt(post.id.toString() + 'count') ?? 0))} likes"),
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 6, left: 15),
            child: Post.buildDescription(
                context, userByIdData.nickname, post.description),
          ),
          Padding(
            child: GestureDetector(
              child: Text(
                "View all ${post.comments.length} comments",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              onTap: () async {
                var lastCommetString = await Navigator.pushNamed(
                    context, '/comment',
                    arguments: {'post': post}) as String;
                setState(() {
                  lastCommet = lastCommetString;
                });
                // addCommetPage(context, post);
              },
            ),
            padding: EdgeInsets.only(bottom: 0, left: 15),
          ),
          lastCommet != null
              ? Container(
                  child: Row(children: [
                    Text(
                      user.nickname,
                      style: TextStyle(fontSize: 15),
                    ),
                    Container(width: 10),
                    Text(lastCommet, style: TextStyle(fontSize: 16)),
                  ]),
                  padding: EdgeInsets.only(left: 18, top: 10, bottom: 10),
                )
              : Container(),
          Row(children: [
            StoryIcon(
              true,
              false,
              id: widget.id,
              height: 30,
              width: 30,
              radius: 40,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: commentController,
                decoration: InputDecoration(
                  hintText: 'Add comment',
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                ),
                onSubmitted: (value) {
                  String message = commentController.text;
                  if (message != '')
                    post.addComment(Comment(
                        userByIdData.id, message, post.id, userByIdData.id));
                },
              ),
            )
          ]),
          Padding(
              padding: EdgeInsets.only(bottom: 6, left: 15),
              child: Text(
                "31 minutes ago",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              )),
        ]),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FeedModel feed = Provider.of<FeedModel>(context);
    List<PostModel> posts = feed.getAllPosts();
    if ((sp.getBool('check_friends_status') == null)) {
      final User user = Provider.of<User>(context, listen: false);
      sp.setBool('check_friends_status', true);
      user.addFriend(User(
          1,
          'valera_ok',
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80",
          1, []));
      user.addFriend(User(
          2,
          'PashOk',
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80",
          2, []));
    }

    return Column(children: [
      SizedBox(height: 90, child: StoriesList()),
      Divider(
        color: Colors.white,
      ),
      Expanded(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: feed.getCountOfPosts(),
              itemBuilder: (context, index) {
                return MultiProvider(providers: [
                  ChangeNotifierProvider.value(
                    value: posts[index],
                  )
                ], child: Post(id: index));
              })),
    ]);
  }
}
