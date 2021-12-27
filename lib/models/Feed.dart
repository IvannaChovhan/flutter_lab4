import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:my_instagram/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:my_instagram/models/user_model.dart';
import 'package:my_instagram/widgets/post.dart';
import 'package:provider/provider.dart';

class FeedModel with ChangeNotifier {
  final int id;
  final userId;

  FeedModel(this.id, this.userId, [this.feed]);

  factory FeedModel.fromJson(Map<String, dynamic> map) {
    if (map['feed'] != {}) {
      map['feed'].forEach((key, value) {
        map['feed'][key] = List.generate(
            value.length, (index) => PostModel.fromJson(value[index]));
      });
    }
    return FeedModel(map["id"], map["userId"], Map.from(map['feed']));
  }

  final Map<String, dynamic> feed;

  int getCountOfPosts() {
    int count = 0;
    for (var listOfPost in this.feed.values.toList()) {
      count += listOfPost.length;
    }
    return count;
  }

  List getAllPosts() {
    List<PostModel> posts = [];
    for (var listOfPost in this.feed.values.toList()) {
      for (PostModel post in listOfPost) {
        posts.add(post);
      }
    }
    return posts;
  }

  void addItem(String id, PostModel post) {
    feed.putIfAbsent(id, () => List<PostModel>.generate(1, (index) => post));
  }
}
