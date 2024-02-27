import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_api_app/features/data/shop_data.dart';
import 'package:bloc_api_app/features/model/post_data_ui_model.dart';
import 'package:bloc_api_app/features/model/products_model.dart';
import 'package:bloc_api_app/features/repository/productparse.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'update_event.dart';
part 'update_state.dart';

// class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
//   UpdateBloc() : super(UpdateInitial()) {
//     on<UpdateEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }
class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  UpdateBloc() : super(UpdateInitial()) {
    on<ShowImageInUI>(showImageInUI);
    on<UpdateTheProduct>(updateTheProductEvent);
  }

  FutureOr<void> showImageInUI(
      ShowImageInUI event, Emitter<UpdateState> emit) async {
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

  FutureOr<void> updateTheProductEvent(
      UpdateTheProduct event, Emitter<UpdateState> emit) async {
    emit(UpdateLoadingState());
    print(event.productModelID);
    await Future.delayed(const Duration(seconds: 2));
    GetTheModels getTheModels = GetTheModels();
    final responseBody = await getTheModels.updateTheProducts(
        event.postModel, event.productModelID);
    //  = await UpdateTheProductToAPI(event);
    final updatemodel = event.postModel;

    final rating = RatingModel(rate: 23, count: 12);
    // if (responseBody == 21) {
    for (var model in ShopData.listOfProducts) {
      if (model.id == event.productModelID) {
        print(model.id);

        model.id = event.productModelID;
        model.title = updatemodel.title;
        model.price = updatemodel.price;
        model.description = updatemodel.description;
        model.category = updatemodel.category;
        model.image = updatemodel.image;
        model.rating = rating;
      }
    }
    print(ShopData.listOfProducts[event.productModelID].category);
    // ShopData.listOfProducts.add();
    // id++;
    emit(ProductUpdatedSuccess(productID: event.productModelID.toString()));
    emit(GoBackToHomePage());
    // }
    // print(responseBody);

    emit(UpdateInitial());
  }
}
