import 'dart:convert';
import 'CommentsModel.dart';
import 'TopicModel.dart';

List<SectionModel> sectionModelFromJson(String str) => List<SectionModel>.from(
    json.decode(str).map((x) => SectionModel.fromJson(x)));
// SectionModel sectionModelFromJson(String str) => SectionModel.fromJson(json.decode(str));
String sectionModelToJson(SectionModel data) => json.encode(data.toJson());

class SectionModel {
  int sectionId;
  String sectionTitle;
  List<CommentsModel> comments = [];
  List<TopicModel> topics;
  List<SectionModel> sections = [];

  SectionModel({
    required this.sectionId,
    required this.sectionTitle,
    required this.topics,
  });

  List<CommentsModel> get commentList => comments;
  List<TopicModel> get topicList => topics;
  List<SectionModel> get sectionList => sections;
  int get id => sectionId;
  String get title => sectionTitle;

  set setId(int id) {
    sectionId = id;
  }

  set setTitle(String title) {
    sectionTitle = title;
  }

  void addTopic(TopicModel topic) {
    topics.add(topic);
  }

  void removeTopic(TopicModel topic) {
    topics.remove(topic);
  }

    void setSectionList(List<SectionModel> section) {
     sections = section;
  }

  void setTopicList(List<TopicModel> topics) {
    this.topics = topics;
  }

  void setCommentList(List<CommentsModel> comments) {
    this.comments = comments;
  }

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      sectionId: json["id"],
      sectionTitle: json["title"], topics: [], 
    );
  }

  dynamic toJson() => {
        "id": sectionId,
        "title": sectionTitle,
      };


    SectionModel copyWith({
    List<TopicModel>? topicList,
    // Add other properties you want to update here...
  }) {
    return SectionModel(
      sectionId: this.sectionId,
      sectionTitle: this.title,
      // Copy other existing properties...
      topics: topicList ?? this.topicList,
      // Assign the updated topicList or use the existing one if not provided.
    );
  }
}
