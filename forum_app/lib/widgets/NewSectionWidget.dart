import 'package:flutter/material.dart';
import 'package:forum_app/dummy.dart';
import 'package:forum_app/models/SectionModel.dart';
import 'package:forum_app/providers/SectionProvider.dart';
 
import 'package:provider/provider.dart';

 

class NewSectionWidget extends StatelessWidget {
  SectionModel section;
  NewSectionWidget({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(section.sectionTitle)),
      body: SizedBox(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: section.topics.map((e) {
                  return Text('${e.id}. ${e.title}, ${e.description}');
                }).toList(),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const dummypage()));
                },
                child: const Text('Add Class')),
          ],
        ),
      ),
    );
  }

 
}
