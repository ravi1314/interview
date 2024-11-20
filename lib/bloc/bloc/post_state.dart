part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostActionState extends PostState {}

class PostFetchingDataLoadingState extends PostState {
  final List<PostModel> post;

  PostFetchingDataLoadingState({required this.post});
}

class PostFetchingDataSuccessfullyState extends PostState {
  final List<PostModel> post;

  PostFetchingDataSuccessfullyState({required this.post});
}

class PostFetchingDataErrorState extends PostState {
  final String errorMessage;

  PostFetchingDataErrorState({required this.errorMessage});
}
