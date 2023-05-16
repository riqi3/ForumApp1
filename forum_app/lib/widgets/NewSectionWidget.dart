import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:forum_app/models/SectionModel.dart';
import 'package:forum_app/models/TopicModel.dart';
import 'package:forum_app/providers/SectionProvider.dart';
import 'package:forum_app/providers/TopicProvider.dart';


import 'package:provider/provider.dart';
 
import 'NewTopicWidget.dart';

class NewSectionWidget extends StatelessWidget {
  SectionModel newSection;

  final UnmodifiableListView<TopicModel> allTopics;
  NewSectionWidget({
    Key? key,
    required this.newSection,
    required this.allTopics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(newSection.title)),
      backgroundColor: Colors.orangeAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          context.read<TopicProvider>().empty()
              ? emptyCard(context)
              : Expanded(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: allTopics.map((e) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Consumer<TopicProvider>(
                                builder: (context, value, child) {
 
                                  return NewTopicWidget(
                                    newTopic: e,
                                    allTopics:
                                        UnmodifiableListView(e.topicList),

                                  );
                                },
                              ),
                            ),
                            
                          );
                        },

                        // {
                        //   Navigator.of(context).push(
                        //     MaterialPageRoute(
                        //       builder: (context) => Consumer<TopicProvider>(
                        //         builder: (context, value, child) {
                        //           String id = value.getTopicId(e);
                        //           return NewTopicWidget(
                        //             newTopic: e,
                        //             id: id,
                        //             title: value.getTitle(id),
                        //             allTopics: allTopics,
                        //           );

                        //           // return NewSectionWidget(allTopics: UnmodifiableListView(e.topics),
                        //           // );
                        //         },
                        //       ),
                        //     ),
                        //   );
                        // },
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
                                context.read<TopicProvider>().deleteTopic(e);
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

      // body: Column(
      //   children: [
      //     Expanded(
      //       child: ListView(
      //         children: newSection.topics.map((e) {
      //           return Text('${e.id}. ${e.title}, ${e.description}');
      //         }).toList(),
      //       ),
      //     ),
      //     ElevatedButton(
      //         onPressed: () {
      //           Navigator.of(context).push(
      //             MaterialPageRoute(
      //               builder: (context) => addList(context, newSection),
      //             ),
      //           );
      //         },
      //         child: const Text('Add Classs'),),
      //   ],

      // ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'add topic',
        onPressed: () {
 
          addTopic(context);
        },
        label: Text('Add Topic'),
      ),
    );
  }

 


  Future<void> addTopic(BuildContext context) async {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

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
                  hintText: 'Title',
                ),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Description',
                ),
              ),
              TextButton(
                onPressed: (() {
                  if (titleController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty) {
                    context.read<TopicProvider>().add(
                          TopicModel(
                            topicTitle: titleController.text,
                            topicDescription: descriptionController.text,
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
            'There are no topics :^(',
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

  Widget addList(BuildContext context, SectionModel section) {
    var topics = context.read<TopicProvider>().allTopics;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Select topic'),
      ),
      body: ListView(
        children: topics.map((e) {
          return GestureDetector(
            onTap: () {
              var selectTopic = e.topicList;
              context
                  .read<SectionProvider>()
                  .addSection(section.sectionId, selectTopic);
              Navigator.pop(context);
            },
            child: Text(e.title),
          );
        }).toList(),
      ),
    );
  }
}
