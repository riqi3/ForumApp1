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
            createSectionCard(
              widget: widget,
              sectionsProvider: sectionsProvider,
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'add section',
        onPressed: () {
          addSection(context, sectionsProvider);
        },
        label: Text('Add Section'),
      ),
    );
  }

  Future<void> addSection(BuildContext context, SectionProvider sectionProvider) async {
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
                onPressed: () {
                  if (titleController.text.isNotEmpty) {
                    final newSection = SectionModel(
                      sectionId: 0,
                      sectionTitle: titleController.text,
                      topics: [],
                    );
                    sectionProvider.add(newSection);
                    titleController.clear();

                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  "Ok",
                  style: TextStyle(),
                ),
              ),
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

class createSectionCard extends StatelessWidget {
  const createSectionCard({
    super.key,
    required this.widget,
    required this.sectionsProvider,
  });

  final SectionWidget widget;
  final SectionProvider sectionsProvider;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: widget.allSections.toList().map((e) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Consumer<SectionProvider>(
                    builder: (context, value, child) {
                      return NewSectionWidget(
                        newSection: e,
                        allTopics: UnmodifiableListView([]),
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
                    final index = sectionsProvider.allSections.indexOf(e);
                    sectionsProvider
                        .deleteSection(sectionsProvider.allSections[index]);
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
    );
  }
}
