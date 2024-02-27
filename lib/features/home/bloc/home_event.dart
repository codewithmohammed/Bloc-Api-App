part of 'home_bloc.dart';

sealed class HomeEvent {}

// final class HomeGetAllProducts extends HomeEvent {}
class HomeInitialEvent extends HomeEvent {}

final class HomeAddNewProducts extends HomeEvent {
  final ProductsModel productsModel;
  HomeAddNewProducts({required this.productsModel});
}

class HomeProductCartButtonClickedEvent extends HomeEvent {
  final int productModelID;
  HomeProductCartButtonClickedEvent({
    required this.productModelID,
  });
}

final class HomeProductWishlistButtonClickedEvent extends HomeEvent {
  final int productModelID;
  HomeProductWishlistButtonClickedEvent({required this.productModelID});
}

class HomeDetailsPageButtonNavigateEvent extends HomeEvent {
  final ProductsModel productsModel;
  HomeDetailsPageButtonNavigateEvent({required this.productsModel});
}

class HomeWishlistButtonNavigateEvent extends HomeEvent {}

class HomeCartButtonNavigateEvent extends HomeEvent {}

class BacktoToHomeEvent extends HomeEvent{}