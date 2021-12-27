import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoryModel with ChangeNotifier {
  int id;
  int userId;
  String storyPhoto;
  String storyVideo;
  String description;
  bool active = true;

  StoryModel(int id, String storyPhoto, String description, int userId,
      [bool active]) {
    this.id = id;
    this.storyPhoto = storyPhoto;
    this.description = description;
    this.active = active;
    this.userId = userId;
  }

  void changeState() {
    this.active = !(this.active);
  }

  void setActive(bool state) {
    active = state;
  }
}

class StoriesFeed with ChangeNotifier {
  final int id;
  final int userId;

  final Map<int, List<StoryModel>> _stories = {};

  StoriesFeed(this.id, this.userId);

  int getCountOfStories() {
    int count = 0;
    for (var listOfPost in this._stories.values.toList()) {
      count += listOfPost.length;
    }
    return count;
  }

  List getAllStories() {
    List<StoryModel> stories = [];
    for (var listOfPost in this._stories.values.toList()) {
      for (StoryModel post in listOfPost) {
        stories.add(post);
      }
    }
    return stories;
  }

  void addStories(int id, StoryModel post) {
    print(id);
    if (_stories.containsKey(id))
      _stories[id].add(post);
    else
      _stories.putIfAbsent(
          id, () => List<StoryModel>.generate(1, (index) => post));
  }
}
