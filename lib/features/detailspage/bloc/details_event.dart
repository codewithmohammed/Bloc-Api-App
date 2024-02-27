part of 'details_bloc.dart';

@immutable
sealed class DetailsEvent {}

class DeleteProductButtonClickedEvent extends DetailsEvent {
  final ProductsModel productsModel;
  DeleteProductButtonClickedEvent({required this.productsModel});
}

class NavigateToUpdatePageEvent extends DetailsEvent {
  final ProductsModel productsModel;
  NavigateToUpdatePageEvent({required this.productsModel});
}

class NavigateToPatchPageEvent extends DetailsEvent {
  final ProductsModel productsModel;
  NavigateToPatchPageEvent({required this.productsModel});
}
