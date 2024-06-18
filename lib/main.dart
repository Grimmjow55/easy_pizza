import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'screens/pizza_master.dart';
import 'screens/pizza_details.dart';
import 'screens/cart_screen.dart';
import 'models/provider_like.dart';
import 'models/provider_add_to_cart.dart';


Future<void> main() async {
  await dotenv.load(fileName: ".env");
  

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderLike()),
        ChangeNotifierProvider(create: (_) => ProviderAddToCart()),
      ],
      child: const MainApp(),
    ),
  );
}

GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const PizzaMaster(),
    ),
    GoRoute(
      path: '/details/:id',
      builder: (context, state) =>  PizzaDetails(id: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartScreen(),
    ),
  ],
);



class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      title: 'Easy Pizza',
      theme: ThemeData.dark(),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
