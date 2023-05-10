import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:forum_app/home.dart';
import 'package:forum_app/models/SectionModel.dart';
import 'package:provider/provider.dart';
import '../providers/SectionProvider.dart';
import 'NewSectionWidget.dart';

class SectionWidget extends StatelessWidget {
  final UnmodifiableListView<SectionModel> allSections;
  const SectionWidget({
    super.key,
    required this.allSections,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.limeAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          context.read<SectionProvider>().empty()
              ? emptyCard(context)
              : SizedBox(
                  height: size.height,
                  width: size.height,
                  child: Expanded(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: allSections.map((e) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Consumer<SectionProvider>(
                                  builder: (context, value, child) {
                                    return NewSectionWidget(
                                      section: e,
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Card(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  e.title,
                                  style: TextStyle(
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'add section',
        onPressed: () {
          addSection(context);
        },
        label: Text('Add Section'),
      ),
    );
  }

  Future<void> addSection(BuildContext context) async {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Section Name',
                ),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Section title',
                ),
              ),
              TextButton(
                onPressed: (() {
                  if (titleController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty) {
                    context.read<SectionProvider>().add(
                          SectionModel(
                              sectionTitle: titleController.text,
                              sectionDescription: descriptionController.text),
                        );
                    Navigator.pop(context);
                  }
                }),
                child: const Text(
                  "Ok",
                  style: TextStyle(),
                ),
              ),
              TextButton(
                onPressed: (() {
                  Navigator.pop(context);
                }),
                child: const Text(
                  "Cancel",
                  style: TextStyle(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget emptyCard(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SizedBox(
        height: size.height,
        width: size.height,
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          child: Text(
            'There are no sections :^(',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              color: Colors.black.withOpacity(
                .5,
              ),
            ),
          ),
        ),
      ), 
    );
  }
}
