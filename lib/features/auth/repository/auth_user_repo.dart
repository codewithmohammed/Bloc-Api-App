import 'dart:convert';

import 'package:bloc_api_app/features/auth/model/auth_user_model.dart';
import 'package:http/http.dart' as http;

class AuthUser {
  static Future<String> loginUser(AuthUserModel userModel) async {
    var client = http.Client();
    var url = Uri.parse('https://fakestoreapi.com/auth/');
    var body = json.encode(userModel.toJson());
    var response = await client.post(url, body: body);
    // print(response.body);
    return response.body;
  }
}
