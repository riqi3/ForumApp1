import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:forum_app/models/SectionModel.dart';
import 'package:forum_app/models/TopicModel.dart';
import 'package:forum_app/providers/TopicProvider.dart';
import 'package:forum_app/screens/TopicScreen.dart';
import 'package:forum_app/widgets/NewTopicWidget.dart';
import 'package:forum_app/widgets/SectionWidget.dart';
import 'package:provider/provider.dart';
import '../providers/SectionProvider.dart';
import 'TopicWidget.dart';

class NewSectionWidget extends StatefulWidget {
  final SectionModel newSection;
  final UnmodifiableListView<TopicModel> allTopics;

  const NewSectionWidget({
    Key? key,
    required this.newSection,
    required this.allTopics,
  }) : super(key: key);

  @override
  State<NewSectionWidget> createState() => _NewSectionWidgetState();
}

class _NewSectionWidgetState extends State<NewSectionWidget> {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    final topicProvider = Provider.of<TopicProvider>(context);
    final sectionProvider = Provider.of<SectionProvider>(context);
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(widget.newSection.title)),
      backgroundColor: Colors.orangeAccent,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (topicProvider.empty())
                  emptyCard(context)
                else
                  // createTopicCard(
                  //   topicProvider: topicProvider,
                  //   allTopics: widget.allTopics,
                  //   widget: widget,
                  // ),

                  Consumer<SectionProvider>(
                    builder: (context, value, child) {
                      return Container(
                        width: 200,
                        height: 300,
                        color: Colors.indigoAccent,
                        child: topicListConsumer(context),
                      );
                    },
                  ),
                // Expanded(child: topicListConsumer(context))
              ],
            ),
          ),
        ],
      ),

      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: <Widget>[
      //     if (topicProvider.empty())
      //       emptyCard(context)
      //     else

      //        createTopicCard(
      //         newSection: newSection,
      //         topicProvider: topicProvider,
      //         allTopics: allTopics,
      //       ),
      //       Expanded(child: topicListConsumer(context))

      //   ],
      // ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'add topic',
        onPressed: () {
          addTopic(context, titleController, descriptionController,
              topicProvider, sectionProvider);
        },
        label: Text('Add Topic'),
      ),
    );
  }

  Future<void> addTopic(
    BuildContext context,
    TextEditingController titleController,
    TextEditingController descriptionController,
    TopicProvider topicProvider,
    SectionProvider sectionProvider,
  ) async {
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
                onPressed: () {
                  if (titleController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty) {
                    topicProvider.add(
                      TopicModel(
                        topicTitle: titleController.text,
                        topicDescription: descriptionController.text,
                        topicId: 0,
                      ),
                    );

                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  "Ok",
                  style: TextStyle(),
                ),
              ),

              // () {
              //   if (titleController.text.isNotEmpty &&
              //       descriptionController.text.isNotEmpty) {
              //     final newTopic = TopicModel(
              //       topicId: 0,
              //       topicTitle: titleController.text,
              //       topics: [],
              //     );
              //     topicProvider.add(newTopic);

              //     final updatedSection = newSection.copyWith(
              //       topicList: [
              //         ...newSection.topicList,
              //         TopicModel(
              //           topicTitle: titleController.text,
              //           topicDescription: descriptionController.text,
              //           topicId: 0,
              //         ),
              //       ],
              //     );
              //     sectionProvider.updateSection(updatedSection);
              //     titleController.clear();
              //     Navigator.pop(context);
              //   }
              // },

              TextButton(
                onPressed: () {
                  titleController.clear();
                  Navigator.pop(context);
                },
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

class createTopicCard extends StatelessWidget {
  final UnmodifiableListView<TopicModel> allTopics;
  final TopicProvider topicProvider;
  final NewSectionWidget widget;

  const createTopicCard({
    super.key,
    required this.widget,
    required this.topicProvider,
    required this.allTopics,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.allTopics
          .map(
            (e) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Consumer<SectionProvider>(
                      builder: (context, value, child) {
                        // temporarily
                        return TopicScreen();
                        // NewSectionWidget(
                        //   newSection: e,
                        //   allTopics: UnmodifiableListView([]),
                        // );
                      },
                    ),
                  ),
                );
              },
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
                    final index = topicProvider.allTopics.indexOf(e);
                    topicProvider.deleteTopic(topicProvider.allTopics[index]);
                  },
                  icon: const Icon(
                    Icons.delete,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );

    // Expanded(
    //   child: ListView.builder(
    //     itemCount: widget.allTopics.length,
    //     itemBuilder: (context, index) {
    //       final topic = widget.allTopics[index];
    //       return GestureDetector(
    //         onTap: () {
    //           Navigator.of(context).push(
    //             MaterialPageRoute(
    //               builder: (context) => Consumer<TopicProvider>(
    //                 builder: (context, value, child) {
    //                   //temporarily
    //                   return TopicScreen();
    //                 },
    //               ),
    //             ),
    //           );
    //         },
    //         child: Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 10),
    //           child: ListTile(
    //             title: Text(
    //               topic.topicTitle,
    //               style: TextStyle(fontSize: 24),
    //             ),
    //             subtitle: Text(
    //               topic.topicDescription,
    //               maxLines: 2,
    //               overflow: TextOverflow.ellipsis,
    //               style: TextStyle(fontSize: 15),
    //             ),
    //             trailing: IconButton(
    //               onPressed: () {
    //                 widget.topicProvider.deleteTopic(topic);
    //               },
    //               icon: const Icon(
    //                 Icons.delete,
    //               ),
    //             ),
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );

    // Expanded(
    //   child: ListView(
    //     scrollDirection: Axis.vertical,
    //     shrinkWrap: true,
    //     children: widget.allTopics.toList().map((e) {
    //       return GestureDetector(
    //         onTap: () {
    //           Navigator.of(context).push(
    //             MaterialPageRoute(
    //               builder: (context) => Consumer<TopicProvider>(
    //                 builder: (context, value, child) {
    //                   //temporarily
    //                   return TopicScreen();
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
    //                 final index = widget.topicProvider.allTopics.indexOf(e);
    //                 widget.topicProvider
    //                     .deleteTopic(widget.topicProvider.allTopics[index]);
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
    // );
  }
}

// import 'dart:collection';

// import 'package:flutter/material.dart';
// import 'package:forum_app/dummy.dart';
// import 'package:forum_app/models/SectionModel.dart';
// import 'package:forum_app/models/TopicModel.dart';
// import 'package:forum_app/providers/SectionProvider.dart';
// import 'package:forum_app/providers/TopicProvider.dart';
// import 'package:forum_app/screens/TopicScreen.dart';

// import 'package:provider/provider.dart';

// import 'NewTopicWidget.dart';
// import 'TopicWidget.dart';

// class NewSectionWidget extends StatelessWidget {
//   SectionModel newSection;
//   final List<TopicModel> allTopics;

//   NewSectionWidget({
//     Key? key,
//     required this.newSection,
//     required this.allTopics,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final topicProvider = Provider.of<TopicProvider>(context);
//     final sectionProvider = Provider.of<SectionProvider>(context);
//     return Scaffold(
//       appBar: AppBar(centerTitle: true, title: Text(newSection.title)),
//       backgroundColor: Colors.orangeAccent,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           if (topicProvider.empty())
//             emptyCard(context)
//           // else if (topicProvider.notEmpty())

//           //   )
//           else
//           // Expanded(child: DummyScreen())
//             // ListTile(

//             //     title: Text(newSection.title),
//             //     subtitle: Text('Topic count: ${newSection.topicList.length}'),
//             //     trailing: IconButton(
//             //       icon: Icon(Icons.delete),
//             //       onPressed: () {
//             //         sectionProvider.deleteSection(newSection);
//             //       },
//             //     ),
//             //   ),
// // ListView(
// //   scrollDirection: Axis.vertical,
// //   shrinkWrap: true,
// //   children: newSection.topicList.map((e) {
// //     return ListTile(
// //       title: Text(e.title),
// //       subtitle: Text(e.description),
// //       // Add any other details of the topic
// //     );
// //   }).toList(),
// // ),

//             // ListView.builder(
//             //   shrinkWrap: true,
//             //     physics: ClampingScrollPhysics(),
//             //   itemCount: newSection.topicList.length,
//             //   itemBuilder: (context, topicIndex){
//             //     final topic = newSection.topicList[topicIndex];
//             //     return ListTile(
//             //       title: Text(topic.title),
//             //     );
//             //   },
//             // )

//             // Expanded(
//             //   child: ListView.builder(
//             //     itemCount: newSection.topicList.length,
//             //     itemBuilder: (context, index) {
//             //       final topic = newSection.topicList[index];
//             //       return ListTile(
//             //         title: Text(
//             //           topic.title,
//             //           style: TextStyle(fontSize: 24),
//             //         ),
//             //         subtitle: Text(
//             //           topic.topicDescription,
//             //           maxLines: 2,
//             //           overflow: TextOverflow.ellipsis,
//             //           style: TextStyle(fontSize: 15),
//             //         ),
//             //         trailing: IconButton(
//             //               onPressed: () {
//             //                 final index =
//             //                     topicProvider.allTopics.indexOf(topic);
//             //                 topicProvider.deleteTopic(
//             //                     topicProvider.allTopics[index]);
//             //               },
//             //               icon: const Icon(
//             //                 Icons.delete,
//             //               ),
//             //             ),
//             //       );
//             //     },
//             //   ),
//             // ),

//           Expanded(
//             child: ListView(
//               scrollDirection: Axis.vertical,
//               shrinkWrap: true,
//               children: newSection.topicList.map((e) {
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => Consumer<TopicProvider>(
//                           builder: (context, value, child) {
//                             context.read<SectionProvider>().add(newSection);
//                             return TopicWidget(allTopics: allTopics);

//                             // TopicScreen();
//                             // NewTopicWidget(
//                             //   newTopic: e,
//                             //   allTopics: UnmodifiableListView(e.topicList),
//                             // );
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: ListTile(
//                       title: Text(
//                         e.title,
//                         style: TextStyle(fontSize: 24),
//                       ),
//                       subtitle: Text(
//                         e.description,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(fontSize: 15),
//                       ),
//                       trailing: IconButton(
//                         onPressed: () {
//                           context.read<TopicProvider>().deleteTopic(e);
//                         },
//                         icon: const Icon(
//                           Icons.delete,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         heroTag: 'add topic',
//         onPressed: () {
//           addTopic(context, sectionProvider);
//         },
//         label: Text('Add Topic'),
//       ),
//     );
//   }

//   // Widget topicListConsumer(BuildContext context) {
//   //   final topicProvider = Provider.of<TopicProvider>(context);
//   //   return Consumer<TopicProvider>(
//   //     builder: (context, value, child) {
//   //       return TopicWidget(
//   //         allTopics: topicProvider.allTopics,
//   //       );
//   //     },
//   //   );
//   // }

//   Future<void> addTopic(
//       BuildContext context, SectionProvider sectionProvider) async {
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
//                   hintText: 'Title',
//                 ),
//               ),
//               TextField(
//                 controller: descriptionController,
//                 decoration: const InputDecoration(
//                   hintText: 'Description',
//                 ),
//               ),
//               TextButton(
//                 onPressed: (() {
//                   if (titleController.text.isNotEmpty &&
//                       descriptionController.text.isNotEmpty) {
//                     context.read<TopicProvider>().add(
//                           TopicModel(
//                             topicTitle: titleController.text,
//                             topicDescription: descriptionController.text,
//                             topicId: 0,
//                           ),
//                         );
//                     final updatedSection = newSection.copyWith(
//                       topicList: [
//                         ...newSection.topicList,
//                         TopicModel(
//                           topicTitle: titleController.text,
//                           topicDescription: descriptionController.text,
//                           topicId: 0,
//                         ),
//                       ],
//                     );
//                     sectionProvider.updateSection(updatedSection);
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
//             'There are no topics :^(',
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
