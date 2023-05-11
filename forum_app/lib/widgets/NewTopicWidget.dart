// import 'package:flutter/material.dart';
// import 'package:forum_app/dummy.dart';
// import 'package:forum_app/models/SectionModel.dart';
// import 'package:forum_app/models/TopicModel.dart';
// import 'package:forum_app/providers/SectionProvider.dart';

// import 'package:provider/provider.dart';

// class NewTopicWidget extends StatelessWidget {
//   TopicModel topic;
//   NewTopicWidget({super.key, required this.topic});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(centerTitle: true, title: Text(topic.topicTitle)),
//       body: SizedBox(
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView(
//                 children: topic.comments.map((e) {
//                   return Text('${e.userName}, ${e.userComment}');
//                 }).toList(),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const dummypage(),
//                   ),
//                 );
//               },
//               child: const Text('Add Topic'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
