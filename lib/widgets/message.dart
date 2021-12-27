import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';

final List<Tab> tabs = <Tab>[
  Tab(
    text: 'Primary',
    // child: PrimaryMessages,
  ),
  Tab(
    text: 'General',
    // child: PrimaryMessages,
  ),
];

class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      // The Builder widget is used to have a different BuildContext to access
      // closest DefaultTabController.
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context);
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            // Your code goes here.
            // To get index of current tab use tabController.index
          }
        });
        return Scaffold(
          appBar: AppBar(
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_left),
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            // ),
            title: Center(
              child: Text(
                "Ivanna_chovhan",
              ),
            ),
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(Icons.video_call)),
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(Icons.note_sharp),
              )
            ],
            bottom: TabBar(
              tabs: tabs,
            ),
          ),
          body: TabBarView(
            children: tabs.map((Tab tab) {
              if (tab.text == "Primary")
                return PrimaryMessages();
              else
                return Center(
                  child: Text("Заглушка"),
                );
            }).toList(),
          ),
        );
      }),
    );
  }
}

class Message extends StatelessWidget {
  const Message({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Go back!'),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  ChatScreenState createState() {
    return ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyStatelessWidget(),
    );
  }
}

class MessageModel {
  final String name;
  final String message;
  final String time;
  final String avatarUrl;

  MessageModel({this.name, this.message, this.time, this.avatarUrl});
}

List<MessageModel> dummyData = [
  MessageModel(
      name: "oopppp",
      message: "Lorem Ipsum is simply dummy",
      time: "15:00",
      avatarUrl:
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80"),
  MessageModel(
      name: "aaaappp",
      message: "Lorem Ipsum is simply dummy",
      time: "17:00",
      avatarUrl:
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80"),
  MessageModel(
      name: "fjsdlkfjdslk",
      message: "Lorem Ipsum is simply dummy",
      time: "4:00",
      avatarUrl:
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80"),
  MessageModel(
      name: "some_dkfjd",
      message: "Lorem Ipsum is simply dummy",
      time: "10:12",
      avatarUrl:
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80"),
  MessageModel(
      name: "nope_yep",
      message: "Lorem Ipsum is simply dummy",
      time: "12:43",
      avatarUrl:
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80"),
  MessageModel(
      name: "top_bottom",
      message: "Lorem Ipsum is simply dummy",
      time: "00:23",
      avatarUrl:
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80"),
];

class PrimaryMessages extends StatelessWidget {
  const PrimaryMessages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dummyData.length,
      itemBuilder: (context, i) => Column(
        children: <Widget>[
          Divider(
            height: 10.0,
          ),
          ListTile(
            leading: CircleAvatar(
              foregroundColor: Theme.of(context).primaryColor,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(dummyData[i].avatarUrl),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  dummyData[i].name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  dummyData[i].time,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0),
                ),
              ],
            ),
            subtitle: Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                dummyData[i].message,
                style: TextStyle(color: Colors.grey, fontSize: 15.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
