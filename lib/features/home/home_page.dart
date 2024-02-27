import 'package:bloc_api_app/features/cart/ui/cart.dart';
import 'package:bloc_api_app/features/detailspage/ui/detail_page.dart';
import 'package:bloc_api_app/features/home/bloc/home_bloc.dart';
import 'package:bloc_api_app/features/home/widgets/custom_app_bar.dart';
import 'package:bloc_api_app/features/home/widgets/image_slider_demo.dart';
import 'package:bloc_api_app/features/home/widgets/product_card_stack.dart';
import 'package:bloc_api_app/features/home/widgets/products_carousel.dart';
import 'package:bloc_api_app/features/utils/constants.dart';
import 'package:bloc_api_app/features/wishlist/ui/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // HomeBloc homeBloc = HomeBloc();
  @override
  void initState() {
    context.read<HomeBloc>().add(HomeInitialEvent());
    super.initState();
  }
  // @override
  // void didChangeDependencies() {
  //   context.read<HomeBloc>().add(WishListToHomeEvent());
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<HomeBloc, HomeState>(
      // bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          // print('hekdlf');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Cart()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Wishlist()));
        } else if (state is HomeProductItemCartedActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Item Carted')));
        } else if (state is HomeProductItemWishlistedActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Item Wishlisted')));
        }
        if (state is HomeNavigateToDetailsPageActionState) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return  DetailsPage(productsModel: state.detailsModel,);
            },
          ));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );

          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            List<String> imageList1 = successState.productsModel.map((e) {
              return e.image;
            }).toList();
            final productsModels = state.productsModel;
            List<String> imageList2 = state.productsModel
                .map((e) {
                  return e.image;
                })
                .toList()
                .reversed
                .toList();
            return Scaffold(
              appBar: const CustomAppBar(),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.teal,
                      ),
                      child: Text('Drawer Header'),
                    ),
                    ListTile(
                      title: const Text('Item 1'),
                      onTap: () {
                        // Update the state of the app.
                        // ...
                      },
                    ),
                    ListTile(
                      title: const Text('Item 2'),
                      onTap: () {
                        // Update the state of the app.
                        // ...
                      },
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: defaultPadding, horizontal: defaultPadding),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: defaultPadding * 0.5,
                    ),
                    SizedBox(
                      width: size.width * 0.9,
                      child: const Text('Welcome',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'Ubuntu',
                              fontSize: 25,
                              fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    const SizedBox(
                      height: defaultPadding * 2,
                    ),
                    Column(
                      children: [
                        ImageSliderDemo(
                          imgList: imageList1,
                        ),
                        const SizedBox(
                          height: defaultPadding * 2,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Most Popular',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontFamily: 'Ubuntu',
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'See all',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                  fontFamily: 'Ubuntu',
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        // SizedBox(height: 20,),
                        // ProductsCarousel(),
                        const SizedBox(
                          height: 10,
                        ),
                        //ProductsCarousel(),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.95,
                            height: MediaQuery.of(context).size.height * 0.35,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: productsModels.length,
                              itemBuilder: (context, index) {
                                final currentProductsModel =
                                    productsModels[index];
                                return InkWell(
                                  onTap: () {
                                    context.read<HomeBloc>().add(
                                        HomeDetailsPageButtonNavigateEvent(
                                            productsModel:
                                                currentProductsModel));
                                  },
                                  child: productCard(
                                      context,
                                      currentProductsModel.image,
                                      currentProductsModel.price,
                                      currentProductsModel.id,currentProductsModel.isWishListed),
                                );
                              },
                            )),
                        const SizedBox(
                          height: 100,
                        ),
                        ProductsCarousel(
                          imgList: imageList2,
                        )
                      ],
                    )
                  ],
                ),
              ),
            );

          // case HomeLoadedSuccessState!:
          //   return Container(
          //     child: Center(),
          //   );

          case HomeErrorState:
            return const Scaffold(body: Center(child: Text('Error')));
          // default:
          //   return const SizedBox();
          default:
            return Container(
              child: const Center(),
            );
        }
        // return const Center();
      },
    );
  }
}
