 
import 'package:flutter/material.dart';
import 'package:forum_app/providers/SectionProvider.dart';
import 'package:forum_app/widgets/SectionWidget.dart';
 
import 'package:provider/provider.dart';

import 'providers/TopicProvider.dart';
import 'widgets/TopicWidget.dart';
 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String title = "HomeScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: eventListConsumer(context),
    );
  }
}


Widget eventListConsumer(BuildContext context) {
  return Consumer<SectionProvider>(
    builder: (context, value, child) {
      return SectionWidget(allSections: value.allSections,);
    },
  );
}

Widget topicListConsumer(BuildContext context) {
  return Consumer<TopicProvider>(
    builder: (context, value, child) {
      return TopicWidget(allTopics: value.allTopics,);
    },
  );
}
