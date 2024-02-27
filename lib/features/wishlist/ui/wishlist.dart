import 'package:bloc_api_app/features/data/wishlist_items.dart';
import 'package:bloc_api_app/features/home/bloc/home_bloc.dart';
import 'package:bloc_api_app/features/model/products_model.dart';
import 'package:bloc_api_app/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    context.read<WishlistBloc>().add(WishlistInitialEvent());
    return BlocListener<WishlistBloc, WishlistState>(
      listener: (context, state) {
        if (state is GoBackToHomeState) {
        
          Navigator.of(context).pop();
            context.read<HomeBloc>().add(BacktoToHomeEvent());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                context
                    .read<WishlistBloc>()
                    .add(OnWishlistGoBackButtonClicked());
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text('Wishlist'),
        ),
        body: BlocBuilder<WishlistBloc, WishlistState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case UpdatedListOfFavouritedProductsStates:
                final successState =
                    state as UpdatedListOfFavouritedProductsStates;
                return ListView.builder(
                  itemCount: successState.productsModel.length,
                  itemBuilder: (context, index) {
                    return _buildListItem(
                        context, index, successState.productsModel);
                  },
                );
              default:
                return ListView.builder(
                  itemCount: wishlistItems.length,
                  itemBuilder: (context, index) {
                    return _buildListItem(context, index, wishlistItems);
                  },
                );
            }
          },
        ),
      ),
    );
  }

  Widget _buildListItem(
      BuildContext context, int index, List<ProductsModel> wishlistItems) {
    final product = wishlistItems[index];
    return ListTile(
      onTap: () {},
      leading: Image.network(
        product.image,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      title: Text(product.title),
      subtitle: Text('\$${product.price}'),
      trailing: IconButton(
          onPressed: () {
            context
                .read<WishlistBloc>()
                .add(RemoveFromWishlistEvent(id: product.id));
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          )),
    );
  }
}
