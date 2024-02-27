


  import 'package:flutter/material.dart';

Padding card(BuildContext context, String imageUrl) {
    return Padding(
      padding:
          const EdgeInsets.only(right: 5.0, left: 5.0, top: 15, bottom: 15),
      child: Card(
        elevation: 10,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.40,
          height: MediaQuery.of(context).size.height * 0.35,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }