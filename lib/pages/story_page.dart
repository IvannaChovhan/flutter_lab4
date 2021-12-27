import 'package:flutter/material.dart';
import 'package:my_instagram/models/story_model.dart';
import 'package:provider/provider.dart';

class StoryPage extends StatelessWidget {
  final int id;

  const StoryPage({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Change to provider or something else for stories
    final data =
        Provider.of<StoriesFeed>(context, listen: false).getAllStories()[id];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        title: Text("Title"),
      ),
      body: Container(
        child: Hero(
          tag: data.id,
          child: Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(data.storyPhoto),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
