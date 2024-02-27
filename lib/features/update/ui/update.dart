
import 'package:bloc_api_app/features/home/bloc/home_bloc.dart';
import 'package:bloc_api_app/features/model/post_data_ui_model.dart';
import 'package:bloc_api_app/features/model/products_model.dart';
import 'package:bloc_api_app/features/posts/utils/validators.dart';
import 'package:bloc_api_app/features/update/bloc/update_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Update extends StatelessWidget {
  const Update({super.key, required this.productsModel});

  final ProductsModel productsModel;

  @override
  Widget build(BuildContext context) {
    context
        .read<UpdateBloc>()
        .add(ShowImageInUI(imageURL: productsModel.image));
    final formKey = GlobalKey<FormState>();
    final TextEditingController titleController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController categoryController = TextEditingController();
    final TextEditingController imageController = TextEditingController();

    titleController.text = productsModel.title;
    priceController.text = productsModel.price;
    descriptionController.text = productsModel.description;
    categoryController.text = productsModel.category;
    imageController.text = productsModel.image;

    return BlocListener<UpdateBloc, UpdateState>(
      listener: (context, state) {
        if (state is GoBackToHomePage) {
          Navigator.of(context).pop();
               context.read<HomeBloc>().add(BacktoToHomeEvent());
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Update Product'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: 350,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(color: Colors.black, blurRadius: 5)
                            ]),
                        child: BlocBuilder<UpdateBloc, UpdateState>(
                          builder: (context, state) {
                            if (state is UpdateInitial) {
                              return const Icon(Icons.image);
                            }
                            if (state is ImageUrlDisplayError) {
                              return Center(child: Text(state.error));
                            }
                            if (state is ImageUrlDisplayLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (state is! ImageUrlDisplaySuccess) {
                              return const Center(
                                  child: CircularProgressIndicator.adaptive());
                            }

                            return
                                // child:
                                Image.network(
                              state.displayImageURL,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                            // initialValue: productsModel.title,
                            // onChanged: (value) {
                            //   titleController.text = value;
                            // },
                            controller: titleController,
                            decoration:
                                const InputDecoration(labelText: 'Title'),
                            validator: Validators.titleValidator),
                        TextFormField(
                            // initialValue: productsModel.price,
                            // onChanged: (value) {
                            //   priceController.text = value;
                            // },
                            controller: priceController,
                            decoration:
                                const InputDecoration(labelText: 'Price'),
                            validator: Validators.priceValidator),
                        TextFormField(
                            // initialValue: productsModel.description,
                            // onChanged: (value) {
                            //   descriptionController.text = value;
                            // },
                            controller: descriptionController,
                            decoration:
                                const InputDecoration(labelText: 'Description'),
                            validator: Validators.descriptionValidator),
                        TextFormField(
                            // initialValue: productsModel.category,
                            // onChanged: (value) {
                            //   categoryController.text = value;
                            // },
                            controller: categoryController,
                            decoration:
                                const InputDecoration(labelText: 'Category'),
                            validator: Validators.categoryValidator),
                        TextFormField(
                            // initialValue: productsModel.image,
                            controller: imageController,
                            onChanged: (value) {
                              context
                                  .read<UpdateBloc>()
                                  .add(ShowImageInUI(imageURL: value));
                            },
                            decoration:
                                const InputDecoration(labelText: 'Image URL'),
                            validator: Validators.imageValidator),
                        const SizedBox(height: 16),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                context.read<UpdateBloc>().add(UpdateTheProduct(
                                    postModel: PostModel(
                                      title: titleController.text,
                                      price: priceController.text,
                                      description: descriptionController.text,
                                      category: categoryController.text,
                                      image: imageController.text,
                                    ),
                                    productModelID: productsModel.id));
                                context
                                    .read<HomeBloc>()
                                    .add(BacktoToHomeEvent());
                              }
                            },
                            child: const Text('Submit'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
