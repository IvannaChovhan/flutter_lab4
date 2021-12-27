import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:my_instagram/models/feed.dart';
import 'package:my_instagram/models/post_model.dart';
import 'package:my_instagram/models/story_model.dart';
import 'package:my_instagram/services/api_service.dart';
import 'package:my_instagram/widgets/post.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'comment_model.dart';

// To add oportunity adding friends
class User with ChangeNotifier {
  int _id;
  String _nickname;
  String _userAvatar;
  int _feedId;
  List<User> friends;
  ApiUserService apiUserService = ApiUserService.instance;

  User(this._id, this._nickname, this._userAvatar, this._feedId, this.friends);

  factory User.fromJson(Map<String, dynamic> map) {
    if (map['friends'] == []) {}
    return User(
        map["id"],
        map["nickname"],
        map["userAvatar"],
        map["feedId"],
        List.from(map['friends'] == []
            ? map['friends']
            : List.generate(map['friends'].length,
                (index) => User.fromJson(map['friends'][index]))));
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this._id,
      "nickname": this._nickname,
      "userAvatar": this._userAvatar,
      "feedId": this._feedId,
      "friends": this.friends
    };
  }

  get id => _id;
  get nickname => _nickname;
  get userAvatar => _userAvatar;
  get feedId => _feedId;

  set id(int id) {
    this._id = id;
  }

  set nickname(String nickname) {
    this.nickname = nickname;
  }

  set userAvatar(String userAvatar) {
    this._userAvatar = userAvatar;
  }

  set feedId(int feedId) {
    this._feedId = feedId;
  }

  UnmodifiableListView<PostModel> get posts => UnmodifiableListView(_posts);

  PostModel getPostById(int id) =>
      _posts.singleWhere((value) => value.id == id);

  Comment getCommentById(int id) =>
      _comments.singleWhere((value) => value.id == id);

  StoryModel getStoryById(int id) =>
      _stories.singleWhere((value) => value.id == id);

  void addPost(PostModel post) {
    _posts.add(post);
    // notifyListeners();
  }

  void addComment(Comment comment) {
    _comments.add(comment);
    // notifyListeners();
  }

  void addStory(StoryModel storyModel) {
    _stories.add(storyModel);
    // notifyListeners();
  }

  //feature for implementing db working only for testing
  static User changeFriendsPosts(User user, List<PostModel> posts) {
    for (var post in posts) {
      user.addPost(post);
    }
    return user;
  }

  static User changeFriendsStories(User user, List<StoryModel> stories) {
    for (var story in stories) {
      user.addStory(story);
    }
    return user;
  }

  //Убрать comments и posts

  List<Comment> _comments = [];
  List<PostModel> _posts = [
    PostModel(
      id: 0,
      mainPhotoUrl:
          "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
      description:
          "Lorem Ipsum is simply dummy but not yamy. Hey, you! Yes you. Get out of here.",
    )
  ];
  List<StoryModel> _stories = [
    StoryModel(
        0,
        "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80",
        '',
        0),
  ];

  User getFriendById(int id) => friends.singleWhere((value) => value.id == id);

  addFriend(User friend) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    // TODO: when I got implementaion of adding and creating new profiles then delete this 2 rows
    if (sp.getBool(friend.id.toString()) != null) {
      friends.add(friend);
    } else {
      await apiUserService
          .createUser(friend)
          .then((value) => friends.add(friend));
      await apiUserService
          .updateUser(this)
          .then((value) => value ? notifyListeners() : null);
      sp.setBool(friend.id.toString(), true);
    }
  }

  @override
  String toString() {
    return 'User{id: $id, nickname: $nickname, userAvatar: $userAvatar, feed: $_feedId}';
  }
}
