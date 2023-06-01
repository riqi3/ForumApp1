 
import 'package:flutter/material.dart';
import 'package:forum_app/models/UserCubitModel.dart';
import 'package:forum_app/providers/SectionProvider.dart';
import 'package:forum_app/widgets/SectionWidget.dart';
import 'package:provider/provider.dart';

import '../models/UserModel.dart';

class SectionScreen extends StatefulWidget {
  const SectionScreen({super.key});

  @override
  State<SectionScreen> createState() => _SectionScreenState();
}

class _SectionScreenState extends State<SectionScreen> {

  String title = "Welcome ";

  @override
  Widget build(BuildContext context) {
    User user = context.read<UserCubit>().state;
    
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text(
          'Welcome ${user.username}',
        ),
      ),
      body: sectionListConsumer(context),
    );
  }
}


Widget sectionListConsumer(BuildContext context) {
  return Consumer<SectionProvider>(
    builder: (context, value, child) {
      return SectionWidget(allSections: value.allSections,);
    },
  );
}
