import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:interview/data/postdata.dart';

class PostRepo {
  static Future fetchData() async {
    List<PostModel> post = [];

    try {
      var url = 'https://jsonplaceholder.typicode.com/posts';
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        for (var item in data) {
          post.add(PostModel.fromJson(item));
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
