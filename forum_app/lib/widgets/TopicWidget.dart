import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:forum_app/dummy.dart';

import 'package:forum_app/models/TopicModel.dart';
import 'package:forum_app/providers/TopicProvider.dart';
import 'package:forum_app/screens/TopicScreen.dart';
import 'package:forum_app/widgets/NewTopicWidget.dart';
import 'package:forum_app/widgets/TopicWidget.dart';

import 'package:provider/provider.dart';

import '../models/SectionModel.dart';
import '../providers/SectionProvider.dart';

class TopicWidget extends StatelessWidget {
  
  final List<TopicModel> allTopics;
  TopicWidget({
    Key? key,
 
    required this.allTopics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topicsProvider = Provider.of<TopicProvider>(context);
    return  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (topicsProvider.empty())
            emptyCard(context)
          else

          
          // Expanded(
          //   child: ListView(
          //     scrollDirection: Axis.vertical,
          //     shrinkWrap: true,
          //     children: newSection.topicList.map((e) {
          //       return GestureDetector(
          //         onTap: () {
          //           Navigator.of(context).push(
          //             MaterialPageRoute(
          //               builder: (context) => Consumer<TopicProvider>(
          //                 builder: (context, value, child) {
          //                   context.read<SectionProvider>().add(newSection);
          //                   // return TopicWidget(allTopics: allTopics);
          //                   return DummyScreen();
          //                   // NewTopicWidget(
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
          
          Expanded(
            
            child: ListView.builder(
              
              itemCount: allTopics.length,
              itemBuilder: (context, index) {
                final topic = allTopics[index];
                return ListTile(
                  title: Text(topic.title),
                  subtitle: Text(topic.description),
                  // Add any other details of the topic
                );
              },
            ),
          ),


    //         Expanded(
    //           child: ListView(
    //             scrollDirection: Axis.vertical,
    //             shrinkWrap: true,
    //             children: widget.allTopics.toList().map((e) {
    //               return GestureDetector(
    //                 onTap: () {
    //                   Navigator.of(context).push(
    //                     MaterialPageRoute(
    //                       builder: (context) => Consumer<TopicProvider>(
    //                         builder: (context, value, child) {
                            
    //                           // return NewTopicWidget(
    //                           //   newTopic: e,
    //                           //   allTopics: widget.allTopics,
    //                           // );
    // //                               return Container(
    // //   width: 100,
    // //   height: 100,
    // //   color: Color.fromARGB(255, 64, 238, 251),
    // // );
    //                           return Text('${e.id}. ${e.title}, ${e.description}');
    //                         },
    //                       ),
    //                     ),
    //                   );
    //                 },
    //                 child: Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: 10),
    //                   child: ListTile(
    //                     title: Text(
    //                       e.title,
    //                       style: TextStyle(fontSize: 24),
    //                     ),
    //                     subtitle: Text(
    //                       e.description,
    //                       maxLines: 2,
    //                       overflow: TextOverflow.ellipsis,
    //                       style: TextStyle(fontSize: 15),
    //                     ),
    //                     trailing: IconButton(
    //                       onPressed: () {
    //                         context.read<TopicProvider>().deleteTopic(e);
    //                       },
    //                       icon: const Icon(
    //                         Icons.delete,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               );
    //             }).toList(),
    //           ),
    //         ),
        ],
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
                              topicDescription: descriptionController.text, topicId: 0),
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

// import 'dart:collection';

// import 'package:flutter/material.dart';
// import 'package:forum_app/dummy.dart';
// import 'package:forum_app/home.dart';
// import 'package:forum_app/models/TopicModel.dart';
// import 'package:forum_app/providers/TopicProvider.dart';
// import 'package:provider/provider.dart';
// import '../models/TopicModel.dart';
// import '../providers/TopicProvider.dart';
// import 'NewTopicWidget.dart';

// class TopicWidget extends StatelessWidget {
//   final UnmodifiableListView<TopicModel> allTopics;
//   const TopicWidget({
//     super.key,
//     required this.allTopics,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blueGrey,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           context.read<TopicProvider>().empty()
//               ? emptyCard(context)
//               : SizedBox(
//                   child: Expanded(
//                     child: ListView(
//                       scrollDirection: Axis.vertical,
//                       shrinkWrap: true,
//                       children: allTopics.map((e) {
//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.of(context).push(
//                               MaterialPageRoute(
//                                 builder: (context) => Consumer<TopicProvider>(
//                                   builder: (context, value, child) {
//                                     return NewTopicWidget(topic: e,
                                       
//                                     );
//                                   },
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 10),
//                             child: ListTile(
//                               leading: CircleAvatar(
//                                 backgroundColor: Colors.orange,
//                               ),
//                               title: Text(
//                                 e.title,
//                                 style: TextStyle(fontSize: 24),
//                               ),
//                               subtitle: Text(
//                                 e.description,
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(fontSize: 15),
//                               ),
//                               trailing: IconButton(
//                                 onPressed: () {
//                                   context
//                                       .read<TopicProvider>()
//                                       .deleteTopic(e);
//                                 },
//                                 icon: const Icon(
//                                   Icons.delete,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         heroTag: 'add topic',
//         onPressed: () {
//           addTopic(context);
//         },
//         label: Text('Add topic'),
//       ),
//     );
//   }

//   Future<void> addTopic(BuildContext context) async {
//     TextEditingController titleController = TextEditingController();
//     TextEditingController descriptionController = TextEditingController();
//     return showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       isDismissible: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
//       ),
//       builder: (BuildContext context) {
//         return Padding(
//           padding: const EdgeInsets.only(top: 50.0),
//           child: Column(
//             children: [
//               TextField(
//                 controller: titleController,
//                 decoration: const InputDecoration(
//                   hintText: 'topic title',
//                 ),
//               ),
//               TextField(
//                 minLines: 1,
//                 maxLines: 100,
//                 controller: descriptionController,
//                 decoration: const InputDecoration(
//                   hintText: 'topic description',
//                 ),
//               ),
//               TextButton(
//                 onPressed: (() {
//                   if (titleController.text.isNotEmpty &&
//                       descriptionController.text.isNotEmpty) {
//                     context.read<TopicProvider>().add(
//                           TopicModel(
//                               topicTitle: titleController.text,
//                               topicDescription: descriptionController.text),
//                         );
//                     Navigator.pop(context);
//                   }
//                 }),
//                 child: const Text(
//                   "Ok",
//                   style: TextStyle(),
//                 ),
//               ),
//               TextButton(
//                 onPressed: (() {
//                   Navigator.pop(context);
//                 }),
//                 child: const Text(
//                   "Cancel",
//                   style: TextStyle(),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget emptyCard(BuildContext context) {
//     return SingleChildScrollView(
//       child: SizedBox(
//         child: Card(
//           color: Colors.transparent,
//           elevation: 0,
//           shadowColor: Colors.transparent,
//           child: Text(
//             'There are no Topics :^(',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 30,
//               color: Colors.black.withOpacity(
//                 .5,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
