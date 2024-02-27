part of 'patch_bloc.dart';

@immutable
sealed class  PatchState {}

// final class  PatchInitial extends  PatchState {}
final class  PatchInitial extends  PatchState {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
}

final class  PatchLoadingState extends  PatchState {}

final class ProductPatchedSuccess extends  PatchState {
  final String productID;
  ProductPatchedSuccess({required this.productID});
}

final class ImageUrlDisplaySuccess extends  PatchState {
  final String displayImageURL;
  ImageUrlDisplaySuccess({required this.displayImageURL});
}

final class ImageUrlDisplayLoading extends  PatchState {}

final class ImageUrlDisplayError extends  PatchState {
  final String error;
  ImageUrlDisplayError({required this.error});
}

final class  PatchTheListOfProducts extends  PatchState {}

final class GoBackToHomePage extends  PatchState{}