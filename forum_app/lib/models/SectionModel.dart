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
  List<TopicModel> topics = [];
  List<SectionModel> sections = [];

  SectionModel({
    required this.sectionId,
    required this.sectionTitle,
    this.topics = const [],
  });

  List<CommentsModel> get commentList => comments;
  List<TopicModel> get topicList => topics;
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

  void setTopicList(List<TopicModel> topics) {
    this.topics = topics;
  }

  void setCommentList(List<CommentsModel> comments) {
    this.comments = comments;
  }

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      sectionId: json["id"],
      sectionTitle: json["title"],
    );
  }

  dynamic toJson() => {
        "id": sectionId.toString(),
        "title": sectionTitle,
      };
}
