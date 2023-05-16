import 'package:flutter/material.dart';
import 'package:forum_app/models/TopicModel.dart';
import 'package:forum_app/providers/TopicProvider.dart';
import 'package:provider/provider.dart';

class NewTopicWidget extends StatelessWidget {
 
 
  TopicModel? newTopic;
  List<TopicModel> allTopics;
  NewTopicWidget(
      {super.key,
      this.newTopic,
 
      required this.allTopics});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('title'),
      ),
      body: 
      
      Column(
        children: [

              Expanded(
                  child: ListView(
                      children: allTopics.map((e) {
                    return Text('${e.id}. ${e.title}, ${e.description}');
                  }).toList()),
                ),
          ElevatedButton(
              onPressed: () {
                addTopic(context);
              },
              child: const Text('Add Student'))
        ],
      ),
    );
  }

// Text('data', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700,),),

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
                  hintText: 'Topic title',
                ),
              ),
              TextField(
                minLines: 1,
                maxLines: 100,
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: 'topic title',
                ),
              ),
              TextButton(
                onPressed: (() {
                  if (titleController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty) {
                    context.read<TopicProvider>().add(
                          TopicModel(
                              topicTitle: titleController.text,
                              topicDescription: descriptionController.text),
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
}

Widget emptyCard(BuildContext context) {
  return const SizedBox(
    height: 200,
    child: Card(
      child: Text('There are no students in this class'),
    ),
  );
}
