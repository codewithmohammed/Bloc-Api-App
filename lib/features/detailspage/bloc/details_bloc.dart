import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_api_app/features/data/shop_data.dart';
import 'package:bloc_api_app/features/model/products_model.dart';
import 'package:bloc_api_app/features/repository/productparse.dart';
import 'package:meta/meta.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial()) {
    // on<DetailsEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<NavigateToPatchPageEvent>(navigateToPatchPageEvent);
    on<NavigateToUpdatePageEvent>(navigateToUpdatePageEvent);
    on<DeleteProductButtonClickedEvent>(deleteProductButtonClickedEvent);
  }

  FutureOr<void> deleteProductButtonClickedEvent(
      DeleteProductButtonClickedEvent event, Emitter<DetailsState> emit) async {
    GetTheModels getTheModels = GetTheModels();
    final response = await getTheModels.deleletTheProduct(event.productsModel);
    if (response.isNotEmpty) {
      ShopData.listOfProducts
          .removeWhere((element) => element.id == event.productsModel.id);
    }

    emit(GoBackToHomePage());
  }

  FutureOr<void> navigateToUpdatePageEvent(
      NavigateToUpdatePageEvent event, Emitter<DetailsState> emit) {
    emit(NavigateToUpdatePage());
  }

  FutureOr<void> navigateToPatchPageEvent(
      NavigateToPatchPageEvent event, Emitter<DetailsState> emit) {
    emit(NavigateToPatchPage());
  }
}
