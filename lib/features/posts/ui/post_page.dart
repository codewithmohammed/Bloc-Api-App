import 'package:bloc_api_app/features/home/bloc/home_bloc.dart';
import 'package:bloc_api_app/features/posts/bloc/post_bloc.dart';
import 'package:bloc_api_app/features/model/post_data_ui_model.dart';
import 'package:bloc_api_app/features/posts/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController titleController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController categoryController = TextEditingController();
    final TextEditingController imageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Entry'),
      ),
      body: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {
          if (state is ProductPostedSuccess) {
            final scaffoldMessenger = ScaffoldMessenger.of(context);
            scaffoldMessenger.showSnackBar(
              SnackBar(
                content: Text(
                    'The product is Posted Succesfully the new product id is ${state.productID}'),
              ),
            );
          }
          if (state is PostInitial) {
            titleController.clear();
            priceController.clear();
            descriptionController.clear();
            categoryController.clear();
            imageController.clear();
          }
        },
        builder: (context, state) {
          if (state is PostLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
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
                        child: BlocBuilder<PostBloc, PostState>(
                          builder: (context, state) {
                            if (state is PostInitial) {
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

                            return Image.network(
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
                            controller: titleController,
                            decoration:
                                const InputDecoration(labelText: 'Title'),
                            validator: Validators.titleValidator),
                        TextFormField(
                            controller: priceController,
                            decoration:
                                const InputDecoration(labelText: 'Price'),
                            validator: Validators.priceValidator),
                        TextFormField(
                            controller: descriptionController,
                            decoration:
                                const InputDecoration(labelText: 'Description'),
                            validator: Validators.descriptionValidator),
                        TextFormField(
                            controller: categoryController,
                            decoration:
                                const InputDecoration(labelText: 'Category'),
                            validator: Validators.categoryValidator),
                        TextFormField(
                            controller: imageController,
                            onChanged: (value) {
                              context
                                  .read<PostBloc>()
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
                                context.read<PostBloc>().add(PostTheProduct(
                                        postModel: PostModel(
                                      title: titleController.text,
                                      price: priceController.text,
                                      description: descriptionController.text,
                                      category: categoryController.text,
                                      image: imageController.text,
                                    )));
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
          );
        },
      ),
    );
  }
}
