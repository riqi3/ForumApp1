import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:forum_app/models/SectionModel.dart';
import 'package:provider/provider.dart';
import '../providers/SectionProvider.dart';
import 'NewSectionWidget.dart';

TextEditingController titleController = TextEditingController();

class SectionWidget extends StatefulWidget {
  final UnmodifiableListView<SectionModel> allSections;
  const SectionWidget({
    Key? key,
    required this.allSections,
  }) : super(key: key);

  @override
  State<SectionWidget> createState() => _SectionWidgetState();
}

class _SectionWidgetState extends State<SectionWidget> {
  // var isLoaded = false;
  // List<SectionModel>? sections;

  // @override
  // void initState() {
  //   super.initState();
  //   getData();
  // }

  // getData() async {
  //   sections = await RemoteService().getPosts();
  //   if(sections != null){
  //     setState(() {
  //       isLoaded = true;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final sectionsProvider = Provider.of<SectionProvider>(context);
    return Scaffold(
      backgroundColor: Colors.limeAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (sectionsProvider.empty())
            emptyCard(context)
          else
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: widget.allSections.toList().map((e) {
                  return GestureDetector(
                    onTap: () {
                      final newSection = SectionModel(
                        sectionId: 0,
                        sectionTitle: titleController.text,
                      );
                      context.read<SectionProvider>().add(newSection);

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Consumer<SectionProvider>(
                            builder: (context, value, child) {
                              return NewSectionWidget(
                                newSection: e,
                                allTopics: UnmodifiableListView(e.topicList),
                              );
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
                        trailing: IconButton(
                          onPressed: () {
                            final index =
                                sectionsProvider.allSections.indexOf(e);
                            sectionsProvider.deleteSection(
                                sectionsProvider.allSections[index]);
                          },
                          icon: const Icon(
                            Icons.delete,
                          ),
                        ),

                        //                         IconButton(
                        //                           onPressed: () {

                        // final index = widget.allSections.indexOf(e);
                        // if (index >= 0) {
                        //   final updatedAllSections = sectionsProvider.deleteSection(
                        //     widget.allSections[index]
                        //   );
                        //   sectionsProvider.updatedaSections(updatedAllSections as List<SectionModel>);
                        // }

                        //                           },
                        //                           icon: const Icon(
                        //                             Icons.delete,
                        //                           ),
                        //                         ),
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
        onPressed: () async {
          // await newSection1(titleController.text);
          addSection(context);
        },
        label: Text('Add Section'),
      ),
    );
  }

  // static Future<int?> newSection1(String title) async {
  //   MySqlConnection conn = await Mysql().getConnection();
  //   final sec = SectionModel(sectionTitle: title, sectionId: 0);
  //   var result =
  //       await conn.query('INSERT INTO sections(title) VALUES (?)', [sec.title]);

  //   await conn.close();

  //   return result.affectedRows;
  // }

  Future<void> addSection(BuildContext context) async {
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
                  if (titleController.text.isNotEmpty) {
                    context.read<SectionProvider>().add(
                          SectionModel(
                            sectionId: 0,
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
