import 'package:bloc_api_app/features/auth/bloc/auth_bloc.dart';
import 'package:bloc_api_app/features/detailspage/bloc/details_bloc.dart';
import 'package:bloc_api_app/features/home/bloc/home_bloc.dart';
import 'package:bloc_api_app/features/main/ui/main_page.dart';
import 'package:bloc_api_app/features/patch/bloc/patch_bloc.dart';
import 'package:bloc_api_app/features/posts/bloc/post_bloc.dart';
import 'package:bloc_api_app/features/update/bloc/update_bloc.dart';
import 'package:bloc_api_app/features/wishlist/bloc/wishlist_bloc.dart';
// import 'package:bloc_api_app/patch/bloc/patch_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
        BlocProvider<PostBloc>(
          create: (context) => PostBloc(),
        ),
        BlocProvider<WishlistBloc>(
          create: (context) => WishlistBloc(),
        ),
        BlocProvider<DetailsBloc>(
          create: (context) => DetailsBloc(),
        ),
        BlocProvider<UpdateBloc>(
          create: (context) => UpdateBloc(),
        ),
        BlocProvider<PatchBloc>(
          create: (context) => PatchBloc(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
    );
  }
}
