// import 'package:flutter/material.dart';
// import 'package:forum_app/providers/TopicProvider.dart';
// import 'package:forum_app/widgets/TopicWidget.dart';
// import 'package:provider/provider.dart';

// class TopicScreen extends StatelessWidget {
//   const TopicScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.orange,
//       body: topicListConsumer(context),
//     );
//   }

// // MaterialPageRoute(
// //                               builder: (context) => Consumer<TopicProvider>(
// //                                 builder: (context, value, child) {
// //                                   String id = value.getTopicId(e);
// //                                   return NewTopicWidget(
// //                                     newTopic: e,
// //                                     allTopics:
// //                                         UnmodifiableListView(e.topicList),
// //                                     id: id,
// //                                     title: value.getTitle(id),
// //                                   );
// //                                 },
// //                               ),
// //                             ),

//   Widget topicListConsumer(BuildContext context) {
//     return Consumer<TopicProvider>(
//       builder: (context, value, child) {
//         return TopicWidget(
//           allTopics: value.allTopics,
//         );
//       },
//     );
//   }
// }
