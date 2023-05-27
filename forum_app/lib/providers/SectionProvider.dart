import 'package:flutter/material.dart';
import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/SectionModel.dart';
import '../models/TopicModel.dart';

class SectionProvider with ChangeNotifier {
  SectionProvider() {
    this.fetchSection();
  }

  List<SectionModel> _sections = [];

  UnmodifiableListView<SectionModel> get allSections =>
      UnmodifiableListView(_sections);

  // void toggleSection(SectionModel section) {
  //   final sectionIndex = sections.indexOf(section);
  //   sections[sectionIndex].toggleCompleted();
  //   notifyListeners();
  // }

  bool empty() {
    return _sections.isEmpty;
  }

    bool notEmpty() {
    return _sections.isNotEmpty;
  }

  int getIndex(int id) {
    int index = _sections.indexWhere((e) => e.id == id);

    return index;
  }

  void deleteSection(SectionModel section) async {
    final url = 'http://10.0.2.2:8000/sections/${section.id}/';
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode == 204) {
      _sections.remove(section);
      notifyListeners();
    }
    // return _sections;
  }

    void add(SectionModel section) async {
    const url = 'http://10.0.2.2:8000/sections/';
    final response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(section));
    if (response.statusCode == 201) {
      section.sectionId = json.decode(response.body)['id'];
      _sections.add(section);
      notifyListeners();
    }
  }

  void updatedaSections(List<SectionModel> updatedSections) {
    _sections = updatedSections;
    notifyListeners();
  }


  fetchSection() async {
    // final url = 'http://127.0.0.1:8000/apis/v1/?format=json';
    const url = 'http://10.0.2.2:8000/sections/';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _sections = data
          .map<SectionModel>((json) => SectionModel.fromJson(json))
          .toList();
      notifyListeners();
    } else {
      print('a network error occured');
    }
  }

    void updateSection(SectionModel updatedSection) {
    final index = _sections.indexWhere((section) => section.sectionId == updatedSection.sectionId);
    if (index >= 0) {
      _sections[index] = updatedSection;
      notifyListeners();
    }
  }
}
