part of 'post_bloc.dart';

sealed class PostEvent {}

class PostsInitialFetchEvent extends PostEvent {}

final class PostTheProduct extends PostEvent {
  final PostModel postModel;
  PostTheProduct({required this.postModel});
}

final class ShowImageInUI extends PostEvent {
  final String imageURL;
  ShowImageInUI({required this.imageURL});
}
