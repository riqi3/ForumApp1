import 'package:flutter/material.dart';
import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../models/SectionModel.dart';
import '../models/TopicModel.dart';

class SectionProvider with ChangeNotifier {


  // SectionProvider() {
  //   this.fetchSection();
  // }

  final List<SectionModel> _sections = [];

  UnmodifiableListView<SectionModel> get allSections => UnmodifiableListView(_sections);

  // void toggleSection(SectionModel section) {
  //   final sectionIndex = sections.indexOf(section);
  //   sections[sectionIndex].toggleCompleted();
  //   notifyListeners();
  // }

  bool empty(){
    return _sections.isEmpty;
  }

  int getIndex(int id){
    int index = _sections.indexWhere((e) => e.id == id);

    return index;
  }

  void deleteSection(SectionModel section) async {
    // final url = '${envurl}/apis/v1/${section.id}/';
    // final response = await http.delete(Uri.parse(url));

    // if (response.statusCode == 204) {
    //   // sections.remove(section);
    //   // notifyListeners();
    // }
    _sections.remove(section);
    notifyListeners();
  }

  void add(SectionModel section) {
    _sections.add(section);
    notifyListeners();
  }

  void addSection(int id, List<TopicModel> topics) async {
    // final url = '${envurl}apis/v1/?format=json';
    // final response = await http.post(Uri.parse(url),
    //     headers: {'Content-Type': 'application/json'},
    //     body: json.encode(section));
    // if (response.statusCode == 201) {
    //   section.id = json.decode(response.body)['id'];
    //   // sections.add(section);
    //   // notifyListeners();
    // }
    _sections[getIndex(id)].setTopicList(topics);
    notifyListeners();
  }

  fetchSection() async {
    // final url = 'http://127.0.0.1:8000/apis/v1/?format=json';
    //   final url = '${envurl}/apis/v1/?format=json';
    //   final response = await http.get(Uri.parse(url));
    //   if (response.statusCode == 200) {
    //     var data = json.decode(response.body) as List;
    //     sections = data
    //         .map<SectionModel>((json) => SectionModel.fromJson(json))
    //         .toList();
    //     // notifyListeners();
    //   } else {
    //     print('a network error occured');
    //   }
    // }
    notifyListeners();
  }
}
