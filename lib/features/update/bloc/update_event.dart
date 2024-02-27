part of 'update_bloc.dart';

@immutable
sealed class UpdateEvent {}

final class UpdateTheProduct extends UpdateEvent {
  final PostModel postModel;
  final int productModelID;
  UpdateTheProduct({required this.postModel,required this.productModelID});
}

final class ShowImageInUI extends UpdateEvent {
  final String imageURL;
  ShowImageInUI({required this.imageURL});
}
