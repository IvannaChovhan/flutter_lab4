import 'package:my_instagram/models/comment_model.dart';
import 'package:my_instagram/widgets/post.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostModel with ChangeNotifier {
  final int id;
  final int userId;
  final String mainPhotoUrl;
  String video;
  final String description;
  bool like = false;
  List<Comment> comments = [];
  int likesCount = 0;
  bool archive = false;

  PostModel({
    this.id,
    this.mainPhotoUrl,
    this.description,
    this.userId,
  });

  factory PostModel.fromJson(Map<String, dynamic> map) {
    return PostModel(
      id: map["id"],
      mainPhotoUrl: map["mainPhotoUrl"],
      description: map["description"],
      userId: map["userId"],
    );
  }

  void changeLikeStatus() {
    this.like = !(this.like);
    if (this.like)
      incrementLikes();
    else
      decrementLikes();
    notifyListeners();
  }

  void changeArchiveStatus() {
    this.archive = !(this.archive);
    notifyListeners();
  }

  void incrementLikes() async {
    likesCount++;
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setInt(this.id.toString() + 'count', likesCount);
  }

  void decrementLikes() async {
    likesCount--;
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setInt(this.id.toString() + 'count', likesCount);
  }

  void addComment(Comment comment) {
    comments.add(comment);
    notifyListeners();
  }
}
