part of 'update_bloc.dart';

@immutable
sealed class UpdateState {}

// final class UpdateInitial extends UpdateState {}
final class UpdateInitial extends UpdateState {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
}

final class UpdateLoadingState extends UpdateState {}

final class ProductUpdatedSuccess extends UpdateState {
  final String productID;
  ProductUpdatedSuccess({required this.productID});
}

final class ImageUrlDisplaySuccess extends UpdateState {
  final String displayImageURL;
  ImageUrlDisplaySuccess({required this.displayImageURL});
}

final class ImageUrlDisplayLoading extends UpdateState {}

final class ImageUrlDisplayError extends UpdateState {
  final String error;
  ImageUrlDisplayError({required this.error});
}

final class UpdateTheListOfProducts extends UpdateState {}

final class GoBackToHomePage extends UpdateState{}