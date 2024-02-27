import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_api_app/features/data/shop_data.dart';
import 'package:bloc_api_app/features/data/wishlist_items.dart';
import 'package:bloc_api_app/features/model/products_model.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>((event, emit) {
      emit(WishlistInitialState(initialproductsModel: wishlistItems));
    });
    on<RemoveFromWishlistEvent>(removeFromWishlistEvent);
    on<OnWishlistGoBackButtonClicked>(onWishlistGoBackButtonClicked);
  }

  FutureOr<void> removeFromWishlistEvent(
      RemoveFromWishlistEvent event, Emitter<WishlistState> emit) {
    for (var model in ShopData.listOfProducts) {
      if (model.id == event.id) {
        model.isWishListed = false;
      }
    }
    wishlistItems = ShopData.listOfProducts.where((element) {
      return element.isWishListed == true;
    }).toList();
    emit(state);
    emit(UpdatedListOfFavouritedProductsStates(productsModel: wishlistItems));
  }

  FutureOr<void> onWishlistGoBackButtonClicked(
      OnWishlistGoBackButtonClicked event, Emitter<WishlistState> emit) {
    emit(GoBackToHomeState());
  }
}
