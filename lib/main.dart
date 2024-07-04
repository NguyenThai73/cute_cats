import 'package:cat_lover/main/block/block.cubit.dart';
import 'package:cat_lover/main/top_cat/top.cat.cubit.dart';
import 'package:cat_lover/userapp/user.app.cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';
import 'main/favorite_cat/favorite.cat.cubit.dart';
import 'main/splash_screen/splash.cubit.dart';
import 'main/splash_screen/splash.screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => UserAppCubit(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => FavoriteCatCubit(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => SplashCubit(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => TopCatCubit(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => BlockCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
