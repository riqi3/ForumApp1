import 'package:flutter/material.dart';
import 'package:forum_app/dummy.dart';
import 'package:forum_app/models/TopicModel.dart';
import 'package:forum_app/providers/TopicProvider.dart';
import 'package:provider/provider.dart';


import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:forum_app/models/SectionModel.dart';
import 'package:forum_app/models/TopicModel.dart';
import 'package:forum_app/providers/SectionProvider.dart';
import 'package:forum_app/providers/TopicProvider.dart';

import 'package:provider/provider.dart';

 
import 'TopicWidget.dart';

class NewTopicWidget extends StatelessWidget {
  TopicModel newTopic;

  final List<TopicModel> allTopics;
  NewTopicWidget({
    Key? key,
     required this.newTopic,
    required this.allTopics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newTopicsProvider = Provider.of<TopicProvider>(context);
    return  Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(newTopic.title)),
      backgroundColor: Colors.pinkAccent,
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (newTopicsProvider.empty())
            emptyCard(context)
          else
          Expanded(
            child: ListView.builder(
              itemCount: allTopics.length,
              itemBuilder: (context, index) {
                final topic = allTopics[index];
                return ListTile(
                  title: Text(topic.title),
                  // Add any other details of the topic
                );
              },
            ),
          ),
            // Expanded(
            //   child: ListView(
            //     scrollDirection: Axis.vertical,
            //     shrinkWrap: true,
            //     children: allTopics.map((e) {
            //       return GestureDetector(
            //         onTap: () {
            //           Navigator.of(context).push(
            //             MaterialPageRoute(
            //               builder: (context) => Consumer<TopicProvider>(
            //                 builder: (context, value, child) {
            //                   context.read<TopicProvider>().add(newTopic);
            //                   return DummyScreen();
            //                   // return NewTopicWidget(
            //                   //   newTopic: e,
            //                   //   allTopics: UnmodifiableListView(e.topicList),
            //                   // );
            //                 },
            //               ),
            //             ),
            //           );
            //         },

 
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 10),
            //           child: ListTile(
            //             title: Text(
            //               e.title,
            //               style: TextStyle(fontSize: 24),
            //             ),
            //             subtitle: Text(
            //               e.description,
            //               maxLines: 2,
            //               overflow: TextOverflow.ellipsis,
            //               style: TextStyle(fontSize: 15),
            //             ),
            //             trailing: IconButton(
            //               onPressed: () {
            //                 context.read<TopicProvider>().deleteTopic(e);
            //               },
            //               icon: const Icon(
            //                 Icons.delete,
            //               ),
            //             ),
            //           ),
            //         ),
            //       );
            //     }).toList(),
            //   ),
            // ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'add topic',
        onPressed: () {
          addTopic(context);
        },
        label: Text('Add Topic'),
      ),
    );
  }
  
//   Widget topicListConsumer(BuildContext context) {
//   return Consumer<TopicProvider>(
//     builder: (context, value, child) {
//       return TopicWidget(allTopics: value.allTopics,);
//     },
//   );
// }


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
                            topicDescription: descriptionController.text, topicId: 0,
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
}