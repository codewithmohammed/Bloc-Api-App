import 'package:bloc_api_app/features/model/post_data_ui_model.dart';

class ProductsModel {
   int id = 0;
   String title = '';
   String price = '';
   String description = '';
   String category = '';
   String image = '';
   RatingModel rating = RatingModel(rate: 1, count: 1);
   bool isWishListed;
   bool isCarted;

  ProductsModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    this.isCarted = false,
    this.isWishListed = false
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json['id'],
      title: json['title'],
      price: json['price'].toString(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: RatingModel.fromJson(json['rating']),
    );
  }
}

class Rating {
  final double rate;
  final int count;

  Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate'].toDouble(),
      count: json['count'],
    );
  }
}
