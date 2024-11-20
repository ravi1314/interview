import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';
import 'package:interview/data/postdata.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<PostInitialsEvent>(postInitialsEvent);
  }

  FutureOr<void> postInitialsEvent(
      PostInitialsEvent event, Emitter<PostState> emit) async {
    final List<PostModel> post = [];
    var url = 'https://jsonplaceholder.typicode.com/posts';
    try {
      var response = await http.get(Uri.parse(url));
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var item in data) {
          post.add(PostModel.fromJson(item));
        }
      }
      emit(PostFetchingDataSuccessfullyState(post: post));
    } catch (e) {}
  }
}
