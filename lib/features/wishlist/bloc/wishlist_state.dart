part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistState {}

class WishlistInitial extends WishlistState {

}

class WishlistInitialState extends WishlistState{
    final List<ProductsModel> initialproductsModel;
  WishlistInitialState({required this.initialproductsModel});
}
class UpdatedListOfFavouritedProductsStates extends WishlistState {
  final List<ProductsModel> productsModel;
  UpdatedListOfFavouritedProductsStates({required this.productsModel});
}

class GoBackToHomeState extends WishlistState{}