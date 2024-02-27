part of 'home_bloc.dart';

sealed class HomeState {}

abstract class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeLoadedSuccessState extends HomeState {
  final List<ProductsModel> productsModel;
  HomeLoadedSuccessState({required this.productsModel});
}



// final class HomeSearchingState extends HomeState {
//   final List<ProductsModel> searchedProductsModel;
//   HomeSearchingState({required this.searchedProductsModel});
// }

final class HomeWishListedScreen extends HomeState {
  final List<ProductsModel> wishListedModel;
  HomeWishListedScreen({required this.wishListedModel});
}

final class HomeErrorState extends HomeState {}

class HomeProductItemCartedActionState extends HomeActionState {}

class HomeNavigateToWishlistPageActionState extends HomeActionState {}

class HomeNavigateToCartPageActionState extends HomeActionState {}

class HomeNavigateToDetailsPageActionState extends HomeActionState {
  final ProductsModel detailsModel;
  HomeNavigateToDetailsPageActionState({required this.detailsModel});
}

class HomeProductItemWishlistedActionState extends HomeActionState {}
