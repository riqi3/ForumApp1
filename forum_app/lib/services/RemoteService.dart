// import 'package:forum_app/models/SectionModel.dart';
// import 'package:http/http.dart' as http;

// class RemoteService {
//   Future<List<SectionModel>?> getPosts() async {
//     var client = http.Client();
//     var uri = Uri.parse('http://127.0.0.1:8000/sections/');
//     var response = await client.get(uri);
//     if (response.statusCode == 200) {
//       var json = response.body;
//       return sectionModelFromJson(json);
//     }
//   }
// }
