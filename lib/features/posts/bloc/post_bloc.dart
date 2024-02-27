import 'dart:async';
import 'package:bloc_api_app/features/data/shop_data.dart';
import 'package:bloc_api_app/features/model/post_data_ui_model.dart';
import 'package:bloc_api_app/features/model/products_model.dart';
import 'package:bloc_api_app/features/repository/productparse.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<ShowImageInUI>(showImageInUI);
    on<PostTheProduct>(postTheProductEvent);
  }

  FutureOr<void> showImageInUI(
      ShowImageInUI event, Emitter<PostState> emit) async {
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

  int id = 21;

  FutureOr<void> postTheProductEvent(
      PostTheProduct event, Emitter<PostState> emit) async {
    emit(PostLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    GetTheModels getTheModels = GetTheModels();
    final responseBody = await getTheModels.postTheProducts(event.postModel);
    //  = await postTheProductToAPI(event);
    final postModel = event.postModel;

    final rating = RatingModel(rate: 23, count: 12);
    if (responseBody == 21) {
      ShopData.listOfProducts.add(
        ProductsModel(
            id: id,
            title: postModel.title,
            price: postModel.price,
            description: postModel.description,
            category: postModel.category,
            image: postModel.image,
            rating: rating),
      );
      id++;
      emit(ProductPostedSuccess(productID: id.toString()));
    }
    print(responseBody);

    emit(PostInitial());
  }
}
  // Future<String> postTheProductToAPI(PostTheProduct event) async {
  //   var client = http.Client();
  //   try {
  //     var body = json.encode(event.postModel.toJson());
  //     var respone = await client.post(
  //         Uri.parse(
  //           'https://fakestoreapi.com/products',
  //         ),
  //         body: body);
  //     // print(respone.body);
  //     var decodedData = json.decode(respone.body) as Map;
  //     return decodedData.values.first.toString();
  //   } catch (e) {
  //     return e.toString();
  //   }
  // }