part of 'post_bloc.dart';

sealed class PostState {}

final class PostInitial extends PostState {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
}

final class PostLoadingState extends PostState {}

final class ProductPostedSuccess extends PostState {
  final String productID;
  ProductPostedSuccess({required this.productID});
}

final class ImageUrlDisplaySuccess extends PostState {
  final String displayImageURL;
  ImageUrlDisplaySuccess({required this.displayImageURL});
}

final class ImageUrlDisplayLoading extends PostState {}

final class ImageUrlDisplayError extends PostState {
  final String error;
  ImageUrlDisplayError({required this.error});
}

final class UpdateTheListOfProducts extends PostState {}
