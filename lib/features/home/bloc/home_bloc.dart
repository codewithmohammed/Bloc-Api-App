import 'dart:async';
import 'package:bloc_api_app/features/data/cart_item.dart';
import 'package:bloc_api_app/features/data/shop_data.dart';
import 'package:bloc_api_app/features/data/wishlist_items.dart';
import 'package:bloc_api_app/features/repository/productparse.dart';
import 'package:bloc_api_app/features/model/products_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(_getAllProducts);
    // on<HomeSearchStartedEvent>(homeSearchStartedEvent);
    on<BacktoToHomeEvent>(_updateTheProducts);
    on<HomeDetailsPageButtonNavigateEvent>(homeDetailsPageButtonNavigateEvent);
    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);

    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
  }
  FutureOr<void> _getAllProducts(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    GetTheModels getTheModels = GetTheModels();
    emit(HomeLoadingState());
     ShopData.listOfProducts= await getTheModels.getAllProducts();
    emit(HomeLoadedSuccessState(productsModel: ShopData.listOfProducts));
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    for (var model in ShopData.listOfProducts) {
      if (model.id == event.productModelID) {
        model.isWishListed = model.isWishListed == false ? true : false;
      }
    }
    wishlistItems = ShopData.listOfProducts.where((element) {
      return element.isWishListed == true;
    }).toList();
    emit(HomeLoadedSuccessState(productsModel: ShopData.listOfProducts));
    emit(HomeProductItemWishlistedActionState());
    // var item = ShopData.listOfProducts
    //     .firstWhere((element) => element.id == event.productModelID);
    // item.isWishListed = true;

    // wishlistItems.addAll(ShopData.listOfProducts
    //     .where((element) => element.id == event.productModelID)
    //     .toList());
    // wishlistItems.toSet();
    // emit(NewWishListedProducts);
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Cart Navigate clicked');
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Wishlist Navigate clicked');
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeDetailsPageButtonNavigateEvent(
      HomeDetailsPageButtonNavigateEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToDetailsPageActionState(
        detailsModel: event.productsModel));
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print('Cart Product clicked');
    cartItems.addAll(ShopData.listOfProducts
        .where((element) => element.id == event.productModelID)
        .toList());
    cartItems.toSet();
    emit(HomeProductItemCartedActionState());
  }

  FutureOr<void> _updateTheProducts(
      BacktoToHomeEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadedSuccessState(productsModel: ShopData.listOfProducts));
  }
}
