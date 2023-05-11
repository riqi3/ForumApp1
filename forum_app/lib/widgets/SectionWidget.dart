import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:forum_app/dummy.dart';
import 'package:forum_app/home.dart';
import 'package:forum_app/models/SectionModel.dart';
import 'package:forum_app/screens/TopicScreen.dart';
import 'package:forum_app/widgets/TopicWidget.dart';
import 'package:provider/provider.dart';
import '../providers/SectionProvider.dart';
import 'NewSectionWidget.dart';

class SectionWidget extends StatelessWidget {
  final UnmodifiableListView<SectionModel> allSections;
  const SectionWidget({
    Key? key,
    required this.allSections,
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.limeAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          context.read<SectionProvider>().empty()
              ? emptyCard(context)
              : Expanded(
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
                                return TopicScreen();
                                
                                // return NewSectionWidget(allTopics: UnmodifiableListView(e.topics),
                                // );
                              },
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListTile(
 
                          title: Text(
                            e.title,
                            style: TextStyle(fontSize: 24),
                          ),
                          subtitle: Text(
                            e.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 15),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              context
                                  .read<SectionProvider>()
                                  .deleteSection(e);
                            },
                            icon: const Icon(
                              Icons.delete,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
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
 
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Section Name',
                ),
              ),
 
              TextButton(
                onPressed: (() {
                  if (titleController.text.isNotEmpty  ) {
                    context.read<SectionProvider>().add(
                          SectionModel(
                              sectionTitle: titleController.text,
                          ),
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
    return SingleChildScrollView(
      child: SizedBox(
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
