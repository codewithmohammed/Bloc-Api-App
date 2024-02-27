import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:bloc_api_app/features/data/shop_data.dart';
// import 'package:bloc_api_app/features/model/post_data_ui_model.dart';
// import 'package:bloc_api_app/features/model/products_model.dart';
// import 'package:bloc_api_app/features/repository/productparse.dart';
import 'package:bloc_api_app/features/data/shop_data.dart';
import 'package:bloc_api_app/features/model/post_data_ui_model.dart';
import 'package:bloc_api_app/features/model/products_model.dart';
import 'package:bloc_api_app/features/repository/productparse.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
part 'patch_event.dart';
part 'patch_state.dart';
class PatchBloc extends Bloc< PatchEvent,  PatchState> {
  PatchBloc() : super( PatchInitial()) {
    on<ShowImageInUI>(showImageInUI);
    on< PatchTheProduct>( patchTheProductEvent);
  }

  FutureOr<void> showImageInUI(
      ShowImageInUI event, Emitter< PatchState> emit) async {
    emit(ImageUrlDisplayLoading());
    await Future.delayed(const Duration(seconds: 2));
    try {
      final response = await http.head(Uri.parse(event.imageURL));
      if (response.statusCode == 200 &&
          response.headers['content-type']?.contains('image') == true) {
        emit(ImageUrlDisplaySuccess(displayImageURL: event.imageURL));
      } else {
        throw 'image not found in this link';
      }
    } on ArgumentError {
      emit(ImageUrlDisplayError(error: 'The URL Given is Not Valid'));
    } catch (e) {
      emit(ImageUrlDisplayError(error: e.toString()));
    }
  }

  // int id = 21;

  FutureOr<void>  patchTheProductEvent(
       PatchTheProduct event, Emitter< PatchState> emit) async {
    emit( PatchLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    GetTheModels getTheModels = GetTheModels();
    final responseBody = await getTheModels.patchTheProducts(
        event.postModel, event.productModelID);
    //  = await  PatchTheProductToAPI(event);
    final  patchmodel = event.postModel;

    final rating = RatingModel(rate: 23, count: 12);
    // if (responseBody == 21) {
    for (var model in ShopData.listOfProducts) {
      if (model.id == event.productModelID) {
        model = ProductsModel(
            id: event.productModelID,
            title:  patchmodel.title,
            price:  patchmodel.price,
            description:  patchmodel.description,
            category:  patchmodel.category,
            image:  patchmodel.image,
            rating: rating);
      }
    }
    // ShopData.listOfProducts.add();
    // id++;
    emit(ProductPatchedSuccess(productID: event.productModelID.toString()));
    emit(GoBackToHomePage());
    // }
    // print(responseBody);

    emit( PatchInitial());
  }
}
