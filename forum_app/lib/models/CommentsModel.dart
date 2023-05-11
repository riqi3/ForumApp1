import 'package:forum_app/models/SectionModel.dart';

class CommentsModel {
  int commentId;
  int userId;
  String userName;
  String userComment;

  CommentsModel({
    this.commentId = 0,
    this.userId = 0,
    required this.userName,
    required this.userComment,
  });

  int get commentid => commentId;
  int get userid => userId;
  String get name => userName;
  String get comment => userComment;

  set setCommentId(int id) {
    commentId = id;
  }

  set setUserId(int id) {
    userId = id;
  }

  set setUserName(String name) {
    userName = name;
  }

  set setComment(String comment) {
    userComment = comment;
  }

  //   void addComment(SectionModel comments) {
  //   comments.add(comments);
  // }

  // void removeComment(SectionModel comments) {
  //   comments.remove(comments);
  // }

  // void setCommentList(List<SectionModel> comments) {
  //   this.userComment =comments;
  // }

  // factory CommentsModel.fromJson(Map<String, dynamic> json) {
  //   return CommentsModel(
  //     sectionId: json['id'],
  //     sectionTitle: json['title'],
  //     sectionDescription: json['description'],
  //   );
  // }

  // void addTopic(TopicModel topic) {
  //   comments.add(topic);
  // }

  // void toggleCompleted() {
  //   completed = !completed;
  // }

  // dynamic toJson() => {
  //       'id': sectionId,
  //       'title': sectionTitle,
  //       'description': sectionDescription,
  //     };
}
