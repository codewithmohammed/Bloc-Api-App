import 'dart:ui';

import 'package:bloc_api_app/features/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Stack productCard(BuildContext context, String imageUrl, String price,
    int productID, bool isWishlisted) {
  return Stack(
    children: [
      Padding(
        padding:
            const EdgeInsets.only(right: 5.0, left: 5.0, top: 15, bottom: 15),
        child: Card(
          color: Colors.white,
          elevation: 10,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.65,
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.transparent,
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.contain,
                )),
            //child: Image.network(imageUrl,fit: BoxFit.cover, ),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 40,
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              width: 70,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black.withOpacity(0.8),
              ),
              child: Center(
                  child: Text(
                '\$$price',
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Ubuntu',
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500),
              )),
            ),
          ),
        ),
      ),
      Positioned(
          top: 20,
          right: 10,
          child: CircleAvatar(
            backgroundColor: Colors.grey.withOpacity(0.15),
            child: IconButton(
                onPressed: () {
                  context.read<HomeBloc>().add(
                      HomeProductWishlistButtonClickedEvent(
                          productModelID: productID));
                },
                icon: isWishlisted
                    ?  const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ) :const Icon(Icons.favorite_outline)
                    ),
          ))
    ],
  );
}
