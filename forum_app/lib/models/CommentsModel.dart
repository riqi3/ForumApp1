class CommentsModel {
  int commentId;


  CommentsModel({
    this.commentId = 0,

  });

  int get id => commentId;


  set setId(int id) {
    commentId = id;
  }


  // factory CommentsModel.fromJson(Map<String, dynamic> json) {
  //   return CommentsModel(
  //     sectionId: json['id'],
  //     sectionTitle: json['title'],
  //     sectionDescription: json['description'],
  //   );
  // }

  // void addTopic(TopicModel topic) {
  //   topics.add(topic);
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
