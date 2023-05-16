
import 'CommentsModel.dart';

class TopicModel {
  String topicId;
  String topicTitle;
  String topicDescription;
  List<TopicModel> topics = [];
  List<CommentsModel> comments = [];

  TopicModel({
    this.topicId = '',
    required this.topicTitle,
    this.topicDescription = '',
    this.comments = const [],
    this.topics = const [],
  });

  List<CommentsModel> get commentList => comments;
  List<TopicModel> get topicList => topics;
  String get id => topicId;
  String get title => topicTitle;
  String get description => topicDescription;

  set setId(String id) {
    topicId = id;
  }

  set setTitle(String title) {
    topicTitle = title;
  }

  set setDesription(String description) {
    topicDescription = description;
  }

  void addComment(CommentsModel comment) {
    comments.add(comment);
  }

  void removeComment(CommentsModel comment) {
    comments.remove(comment);
  }

  void setCommentList(List<CommentsModel> comments){
    this.comments=comments;
  }

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return TopicModel(
      topicId: json['id'],
      topicTitle: json['title'],
      topicDescription: json['description'],
    );
  }

  // void addTopic(TopicModel topic) {
  //   topics.add(topic);
  // }

  // void toggleCompleted() {
  //   completed = !completed;
  // }

  dynamic toJson() => {
        'id': topicId,
        'title': topicTitle,
        'description': topicDescription,
      };
}
