 
// import 'package:flutter/material.dart';
// import 'package:forum_app/models/SectionModel.dart';
// import 'package:forum_app/providers/SectionProvider.dart';
// import 'package:forum_app/widgets/SectionWidget.dart';
 
// import 'package:provider/provider.dart';

// import 'providers/TopicProvider.dart';
// import 'widgets/NewTopicWidget.dart';
// import 'widgets/TopicWidget.dart';
 

// class DummyScreen extends StatefulWidget {
//   const DummyScreen({super.key});

//   @override
//   State<DummyScreen> createState() => _DummyScreenState();
// }

// class _DummyScreenState extends State<DummyScreen> {

//   String title = "DummyScreen";


//   @override
//   Widget build(BuildContext context) {

//     return 
//     // Container(
//     //   color: Colors.greenAccent,
//     //   width: 100,
//     //   height: 100,
//     // );

//     Scaffold(
//       backgroundColor: Color.fromARGB(255, 0, 255, 106),
//       appBar: AppBar(
//         title: Text(
//           title,
//         ),
//       ),
//       body: topicListConsumer(context),
//     );
//   }
// }


// Widget eventListConsumer(BuildContext context) {
//   return Consumer<SectionProvider>(
//     builder: (context, value, child) {
//       return SectionWidget(allSections: value.allSections,);
//     },
//   );
// }

// Widget topicListConsumer(BuildContext context) {
//   return Consumer<TopicProvider>(
//     builder: (context, value, child) {
//        final sectionsProvider = Provider.of<SectionProvider>(context);
//       return TopicWidget(allTopics: value.allTopics );
//     },
//   );
// }
