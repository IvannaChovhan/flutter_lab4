import 'package:my_instagram/models/feed.dart';
import 'package:my_instagram/widgets/post.dart';
import 'package:my_instagram/widgets/post.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:my_instagram/widgets/stories.dart';

// class Feed extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // final productData = Provider.of<ProductDataProvider>(context);
//     // *Для версии > 4.1.0
//     final postsData = context.watch<FeedModelProvider>();
//     print(postsData.posts);
//     return Container(
//         child: ListView(scrollDirection: Axis.vertical,
//             // mainAxisSize: MainAxisSize.min,
//             children: [
//           SizedBox(
//             height: 100,
//             child: StoriesList(),
//           ),
//           Divider(
//             color: Colors.white,
//           ),
//           ...postsData.posts.map((e) {
//             return Post(id: e.id);
//           }).toList()
//         ]
//             // Post(
//             //   mainPhotoUrl:
//             //       "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
//             //   nickname: "lorem_ipsum",
//             //   userAvatar:
//             //       "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
//             //   comment: "Lorem Ipsum is simply dummy",
//             //   userPhoto:
//             //       "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80",
//             // ),
//             // Post(
//             //   mainPhotoUrl:
//             //       "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80",
//             //   nickname: "lorem_ipsum",
//             //   userAvatar:
//             //       "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
//             //   comment: "Lorem Ipsum is simply dummy",
//             //   userPhoto:
//             //       "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
//             // ),
//             // Post(
//             //   mainPhotoUrl:
//             //       "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
//             //   nickname: "lorem_ipsum",
//             //   userAvatar:
//             //       "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
//             //   comment: "Lorem Ipsum is simply dummy",
//             //   userPhoto:
//             //       "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80",
//             // ),
//             ));
//   }
// }
