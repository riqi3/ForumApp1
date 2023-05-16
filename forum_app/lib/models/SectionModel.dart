import 'package:flutter/src/widgets/framework.dart';

import 'CommentsModel.dart';
import 'TopicModel.dart';

class SectionModel {
  int sectionId;
  String sectionTitle;
  String sectionDescription;
  List<CommentsModel> comments = [];
  List<TopicModel> topics = [];

  SectionModel({
    this.sectionId = 0,
    required this.sectionTitle,
    this.sectionDescription = '',
    this.topics = const [],
  });

    List<CommentsModel> get commentList => comments;
  List<TopicModel> get topicList => topics;
  int get id => sectionId;
  String get title => sectionTitle;
  String get description => sectionDescription;

  set setId(int id) {
    sectionId = id;
  }

  set setTitle(String title) {
    sectionTitle = title;
  }

  set setDesription(String description) {
    sectionDescription = description;
  }

  void addTopic(TopicModel topic) {
    topics.add(topic);
  }

  void removeTopic(TopicModel topic) {
    topics.remove(topic);
  }

  void setTopicList(List<TopicModel> topics) {
    this.topics = topics;
  }

  void setCommentList(List<CommentsModel> comments) {
    this.comments = comments;
  }

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      sectionId: json['id'],
      sectionTitle: json['title'],
      sectionDescription: json['description'],
    );
  }

  // void addTopic(TopicModel topic) {
  //   topics.add(topic);
  // }

  // void toggleCompleted() {
  //   completed = !completed;
  // }

  dynamic toJson() => {
        'id': sectionId,
        'title': sectionTitle,
        'description': sectionDescription,
      };
}
