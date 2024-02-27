import 'dart:convert';
import 'package:bloc_api_app/features/model/post_data_ui_model.dart';
import 'package:bloc_api_app/features/repository/products_repository.dart';
import 'package:bloc_api_app/features/model/products_model.dart';

class GetTheModels {
  List<ProductsModel> listOfProducts = [];
  static final GetTheModels _instance = GetTheModels._internal();

  factory GetTheModels() {
    return _instance;
  }

  GetTheModels._internal();

  ProductsRepository productsRepository = ProductsRepository();

  Future<List<ProductsModel>> getAllProducts() async {
    String response = await productsRepository.getProductsFromApi();
    var decodedData = await json.decode(response) as List;
    listOfProducts =
        decodedData.map((product) => ProductsModel.fromJson(product)).toList();
    return listOfProducts;
  }

  Future<int> postTheProducts(PostModel postModel) async {
    String response = await productsRepository.postTheProductToAPI(postModel);
    var decodedData = json.decode(response) as Map;
    return decodedData.values.first;
  }

  Future<String> deleletTheProduct(ProductsModel productsModel) async {
    String response =
        await productsRepository.deleteTheProductFromAPI(productsModel);
    return response;
  }

  Future<int> updateTheProducts(PostModel postModel, int id) async {
    String response =
        await productsRepository.updateTheProductFromAPI(postModel, id);
    // print(response);
    var decodedData = await json.decode(response) as Map;
    // print(decodedData.values.first);
    return decodedData.values.first;
  }
    Future<int> patchTheProducts(PostModel postModel, int id) async {
    String response =
        await productsRepository.patchTheProductFromAPI(postModel, id);
    // print(response);
    var decodedData = await json.decode(response) as Map;
    print(decodedData.values.first);
    return decodedData.values.first;
  }
}
