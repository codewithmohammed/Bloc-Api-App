part of 'patch_bloc.dart';

@immutable
sealed class PatchEvent {}

final class PatchTheProduct extends PatchEvent {
  final PostModel postModel;
  final int productModelID;
  PatchTheProduct({required this.postModel,required this.productModelID});
}

final class ShowImageInUI extends PatchEvent {
  final String imageURL;
  ShowImageInUI({required this.imageURL});
}
