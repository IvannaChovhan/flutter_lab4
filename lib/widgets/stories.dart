import 'package:flutter/material.dart';
import 'package:my_instagram/models/feed.dart';
import 'package:my_instagram/models/story_model.dart';
import 'package:my_instagram/models/user_model.dart';
import 'package:my_instagram/pages/story_page.dart';
import 'package:provider/provider.dart';

class StoriesList extends StatefulWidget {
  @override
  _StoriesListState createState() => _StoriesListState();
}

class _StoriesListState extends State<StoriesList> {
  @override
  Widget build(BuildContext context) {
    final feedOfStories = Provider.of<StoriesFeed>(context);
    final List<StoryModel> stories = feedOfStories.getAllStories();
    var isWatched = false;
    return ListView(
      // physics: ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      children: [
        Stack(children: [
          StoryIcon(
            false,
            isWatched,
            id: 0,
            width: 70,
            height: 70,
            radius: 50,
          ),
          Positioned(
            left: 60,
            bottom: 15,
            child: Icon(
              Icons.add_circle,
              size: 20,
            ),
          ),
        ]),
        Container(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: stories.length,
            itemBuilder: (context, index) => Hero(
              tag: stories[index].id,
              child: GestureDetector(
                child: StoryIcon(
                  false,
                  isWatched,
                  id: index,
                  width: 70,
                  height: 70,
                  radius: 50,
                ),
                onTap: () async {
                  var isActive = await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => StoryPage(id: index)),
                  ) as bool;
                  setState(() {
                    isWatched = isActive;
                  });
                },
              ),
            ),
          ),
        )

        // StoryIcon(
        //   url:
        //       "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80",
        //   isActive: true,
        //   userName: 'oooooo1k',
        //   width: 70,
        //   height: 70,
        //   radius: 50,
        // ),

        // //   decoration: BoxDecoration(
        // //     gradient: LinearGradient(
        // //       colors: [Colors.red, Colors.orange],
        // //       begin: Alignment.topCenter,
        // //       end: Alignment.bottomCenter,
        // //     ),
        // //     borderRadius: BorderRadius.all(Radius.circular(100)),
        // //   ),
        // // ),
        // StoryIcon(
        //     url:
        //         "https://i.pinimg.com/236x/dd/64/74/dd6474beaaa197bd7e1bac3d16d39afe.jpg",
        //     isActive: true,
        //     userName: 'ivanna_chovhan',
        //     width: 70,
        //     height: 70,
        //     radius: 50),
        // StoryIcon(
        //   url:
        //       "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
        //   isActive: true,
        //   userName: 'oooooo1k',
        //   width: 70,
        //   height: 70,
        //   radius: 50,
        // ),
        // StoryIcon(
        //   url:
        //       "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
        //   isActive: true,
        //   userName: 'jdfjs_fk',
        //   width: 70,
        //   height: 70,
        //   radius: 50,
        // ),
        // StoryIcon(
        //   url:
        //       "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
        //   isActive: true,
        //   userName: 'joj_4',
        //   width: 70,
        //   height: 70,
        //   radius: 50,
        // ),
        // StoryIcon(
        //   url:
        //       "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
        //   isActive: true,
        //   userName: 'joj_4',
        //   width: 70,
        //   height: 70,
        //   radius: 50,
        // ),
        // StoryIcon(
        //   url:
        //       "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
        //   isActive: true,
        //   userName: 'joj_4',
        //   width: 70,
        //   height: 70,
        //   radius: 50,
        // ),
      ],
    );
  }
}

class StoryIcon extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final int id;
  bool isForPost = false;
  bool _isWatched;

  StoryIcon(this.isForPost, this._isWatched,
      {Key key, this.height, this.width, this.radius, this.id})
      : super(key: key);

  set isWatched(bool flag) {
    _isWatched = flag;
  }

  bool get isWatched => _isWatched;

  @override
  Widget build(BuildContext context) {
    return Consumer<User>(builder: (context, user, child) {
      return Column(
        children: [
          Container(
            margin: !isForPost
                ? EdgeInsets.only(left: 15)
                : EdgeInsets.only(left: 15),
            width: width,
            height: height,
            //TODO: To provide active and no active story and hero after correct way of use StoryIcon (maybe ok)
            decoration: _isWatched
                ? BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(user.userAvatar),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(new Radius.circular(radius)),
                    border: Border.all(width: 4.0, color: Colors.red),
                  )
                : BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(user.userAvatar),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(new Radius.circular(radius)),
                  ),
          ),
          !isForPost
              ? Padding(
                  padding: EdgeInsets.only(left: 18),
                  child: Text(user.nickname))
              : Padding(padding: EdgeInsets.only(left: 18)),
        ], // border: Border.all(width: 4.0, color: Colors.red),
      );
    });
  }
}

// class MyClass extends StoryIcon{
//   final
// }
