 
import 'package:flutter/material.dart';
import 'package:forum_app/providers/SectionProvider.dart';
import 'package:forum_app/widgets/SectionWidget.dart';
 
import 'package:provider/provider.dart';
 

class SectionScreen extends StatefulWidget {
  const SectionScreen({super.key});

  @override
  State<SectionScreen> createState() => _SectionScreenState();
}

class _SectionScreenState extends State<SectionScreen> {

  String title = "SectionScreen";

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
