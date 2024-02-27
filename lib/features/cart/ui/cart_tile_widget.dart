import 'package:bloc_api_app/features/cart/bloc/cart_bloc.dart';
import 'package:bloc_api_app/features/home/bloc/home_bloc.dart';
import 'package:bloc_api_app/features/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartTileWidget extends StatelessWidget {
  final ProductsModel productsModel;
  final CartBloc cartBloc;
  const CartTileWidget(
      {super.key, required this.productsModel, required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(productsModel.image))),
          ),
          const SizedBox(height: 20),
          Text(productsModel.title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(productsModel.description),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("\$${productsModel.price}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      return IconButton(
                          onPressed: () {
                            context.read<HomeBloc>().add(
                                HomeProductWishlistButtonClickedEvent(
                                    productModelID: productsModel.id));
                          },
                          icon: const Icon(Icons.favorite_border));
                    },
                  ),
                  IconButton(
                      onPressed: () {
                        cartBloc.add(CartRemoveFromCartEvent(
                            productDataModel: productsModel));
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
