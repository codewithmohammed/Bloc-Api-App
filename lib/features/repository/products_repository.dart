import 'dart:convert';

import 'package:bloc_api_app/features/model/post_data_ui_model.dart';
import 'package:bloc_api_app/features/model/products_model.dart';
import 'package:http/http.dart' as http;

class ProductsRepository {
  static final ProductsRepository _instance = ProductsRepository._internal();

  factory ProductsRepository() {
    return _instance;
  }

  ProductsRepository._internal();

  Future<String> getProductsFromApi() async {
    var client = http.Client();
    try {
      var url = Uri.parse('https://fakestoreapi.com/products');
      var response = await client.get(url);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return 'someErroOccured';
      }
    } catch (e) {
      return e.toString();
    } finally {
      client.close();
    }
  }

  Future<String> postTheProductToAPI(PostModel postModel) async {
    var client = http.Client();
    try {
      var body = json.encode(postModel.toJson());
      var respone = await client.post(
          Uri.parse(
            'https://fakestoreapi.com/products',
          ),
          body: body);
      // print(respone.body);
      return respone.body;
    } catch (e) {
      return e.toString();
    } finally {
      client.close();
    }
  }

  Future<String> deleteTheProductFromAPI(ProductsModel productsModel) async {
    var client = http.Client();
    try {
      var response = await client.delete(
          Uri.parse('https://fakestoreapi.com/products/${productsModel.id}'));
      print(response.body);
      return response.body;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> updateTheProductFromAPI(PostModel postModel,int id) async {
    var client = http.Client();
    try {
            var body = json.encode(postModel.toJson());
      var response = await client.put(
          Uri.parse('https://fakestoreapi.com/products/${id}'),body: body);
      return response.body;
    } catch (e) {
      return e.toString();
    } finally {
      client.close();
    }
  }

    Future<String> patchTheProductFromAPI(PostModel postModel,int id) async {
    var client = http.Client();
    try {
            var body = json.encode(postModel.toJson());
      var response = await client.patch(
          Uri.parse('https://fakestoreapi.com/products/${id}'),body: body);
      return response.body;
    } catch (e) {
      return e.toString();
    } finally {
      client.close();
    }
  }
}
