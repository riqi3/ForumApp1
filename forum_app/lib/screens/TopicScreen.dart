import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/TopicProvider.dart';
import '../widgets/TopicWidget.dart';
class TopicScreen extends StatefulWidget {
  const TopicScreen({super.key});

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  String title = "Topic Screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      body: topicListConsumer(context),
    );
  }
}

Widget topicListConsumer(BuildContext context) {
  return Consumer<TopicProvider>(
    builder: (context, value, child) {
      return TopicWidget(allTopics: value.allTopics);
    },
  );
}
