import 'package:flutter/material.dart';
import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../main.dart';

import '../models/TopicModel.dart';

class TopicProvider with ChangeNotifier {
  // TopicProvider() {
  //   this.fetchSection();
  // }

  final List<TopicModel> _topics = [];

  UnmodifiableListView<TopicModel> get allTopics =>
      UnmodifiableListView(_topics);

  // void toggleSection(TopicModel section) {
  //   final sectionIndex = sections.indexOf(section);
  //   sections[sectionIndex].toggleCompleted();
  //   notifyListeners();
  // }

  bool empty() {
    return _topics.isEmpty;
  }

  bool checkEmpty(String id) {
    return _topics[getIndex(id)].commentList.isEmpty;
  }

  bool notEmpty() {
    return _topics.isNotEmpty;
  }

  int getIndex(String id) {
    int index = _topics.indexWhere((e) => e.id == id);

    return index;
  }

  void deleteTopic(TopicModel topic) async {
    // final url = '${envurl}/apis/v1/${section.id}/';
    // final response = await http.delete(Uri.parse(url));

    // if (response.statusCode == 204) {
    //   // sections.remove(section);
    //   // notifyListeners();
    // }
    _topics.remove(topic);
    notifyListeners();
  }

  void addTopic(int id, List<TopicModel> topics) async {
    // final url = '${envurl}apis/v1/?format=json';
    // final response = await http.post(Uri.parse(url),
    //     headers: {'Content-Type': 'application/json'},
    //     body: json.encode(section));
    // if (response.statusCode == 201) {
    //   section.id = json.decode(response.body)['id'];
    //   // sections.add(section);
    //   // notifyListeners();
    // }
    // _topics[getIndex(id)].setTopicList(topics);
    notifyListeners();
  }

  void add(TopicModel topic) {
    _topics.add(topic);
    notifyListeners();
  }

  String getTopicId(TopicModel list) {
    int index = _topics.indexWhere((e) => e == list);
    return _topics[index].id;
  }

  String getTitle(String id) {
    return _topics[getIndex(id)].title;
  }

  List<TopicModel> getTopics(String id) {
    return _topics[getIndex(id)].topicList;
  }

  fetchSection() async {
    // final url = 'http://127.0.0.1:8000/apis/v1/?format=json';
    //   final url = '${envurl}/apis/v1/?format=json';
    //   final response = await http.get(Uri.parse(url));
    //   if (response.statusCode == 200) {
    //     var data = json.decode(response.body) as List;
    //     sections = data
    //         .map<TopicModel>((json) => TopicModel.fromJson(json))
    //         .toList();
    //     // notifyListeners();
    //   } else {
    //     print('a network error occured');
    //   }
    // }
    notifyListeners();
  }
}
