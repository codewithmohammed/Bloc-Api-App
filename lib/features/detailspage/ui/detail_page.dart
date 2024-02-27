import 'package:bloc_api_app/features/detailspage/bloc/details_bloc.dart';
import 'package:bloc_api_app/features/home/bloc/home_bloc.dart';
import 'package:bloc_api_app/features/model/products_model.dart';
import 'package:bloc_api_app/features/patch/ui/patch.dart';
// import 'package:bloc_api_app/features/patch/ui/patch.dart';
import 'package:bloc_api_app/features/update/ui/update.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.productsModel});

  final ProductsModel productsModel;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailsBloc, DetailsState>(
      listener: (context, state) {
        if (state is GoBackToHomePage) {
          Navigator.of(context).pop();
          context.read<HomeBloc>().add(BacktoToHomeEvent());
        }
        if (state is NavigateToUpdatePage) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) {
              return Update(
                productsModel: productsModel,
              );
            },
          ));
        }
         if (state is NavigateToPatchPage) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) {
              return Patch(
                productsModel: productsModel,
              );
            },
          ));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Product Details'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextButton.icon(
                      onPressed: () {
                        context.read<DetailsBloc>().add(
                            DeleteProductButtonClickedEvent(
                                productsModel: productsModel));
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      label: const Text(
                        'delete Product',
                        style: TextStyle(color: Colors.red),
                      )),
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: const Icon(
                  //       Icons.delete,
                  //       color: Colors.red,
                  //     ))
                ],
              ),
              Image.network(
                productsModel.image,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productsModel.title,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '\$${productsModel.price}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Category: ${productsModel.category}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Description:${productsModel.description}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // const Text(
                    //   '${productsModel.}',
                    //   style: TextStyle(
                    //     fontSize: 16.0,
                    //   ),
                    // ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Rating: ${productsModel.rating.rate}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<HomeBloc>().add(
                                    HomeProductCartButtonClickedEvent(
                                        productModelID: productsModel.id));
                              },
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.yellow),
                                  foregroundColor:
                                      MaterialStatePropertyAll((Colors.red))),
                              child: const Text('Add to Cart'),
                            ),
                          ),
                          Container(
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<DetailsBloc>().add(
                                    NavigateToUpdatePageEvent(
                                        productsModel: productsModel));
                                // context.read<HomeBloc>().add(
                                //     HomeProductCartButtonClickedEvent(
                                //         productModelID: productsModel.id));
                              },
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color.fromARGB(255, 0, 255, 85)),
                                  foregroundColor: MaterialStatePropertyAll(
                                      (Color.fromARGB(255, 255, 255, 255)))),
                              child: const Text('Edit Product'),
                            ),
                          ),
                          Container(
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<DetailsBloc>().add(
                                    NavigateToUpdatePageEvent(
                                        productsModel: productsModel));
                                // context.read<HomeBloc>().add(
                                //     HomeProductCartButtonClickedEvent(
                                //         productModelID: productsModel.id));
                              },
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color.fromARGB(255, 13, 0, 255)),
                                  foregroundColor: MaterialStatePropertyAll(
                                      (Color.fromARGB(255, 255, 255, 255)))),
                              child: const Text('Patch Product'),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
