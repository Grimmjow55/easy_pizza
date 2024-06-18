import 'package:easy_pizza/models/pizza.dart';
import 'package:easy_pizza/models/provider_add_to_cart.dart';
import 'package:easy_pizza/models/provider_like.dart'; 
import 'package:flutter/material.dart';
import 'package:easy_pizza/data/pizzas.dart' as db;
import 'package:provider/provider.dart';

class PizzaDetails extends StatelessWidget {
  final String id;

  const PizzaDetails({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final Pizza pizza = db.pizzas.firstWhere((pizza) => pizza.id == id);
    final providerLikeModel = Provider.of<ProviderLike>(context);
    final bool isFavorite = providerLikeModel.isFavorite(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(pizza.name),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        color: const Color.fromARGB(255, 50, 50, 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(pizza.name, style: const TextStyle(fontSize: 24)),
            Container(height: 10),
            Text('Tarif : ${pizza.price.toStringAsFixed(2)}€'),
            Container(height: 10),
            Text('ingrédients : ${pizza.ingrediants.join(", ")}'),
            Container(height: 10),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.white,
              ),
              onPressed: () {
                providerLikeModel.add(id);
              },
            ),
            Container(height: 10),
            Consumer<ProviderAddToCart>(
              builder: (context, providerCartModel, child) {
                return Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        providerCartModel.addToCart(id);
                      },
                    ),
                    Container(height: 10),
                    const Text("QUantité"),

                    Text(providerCartModel.quantityCheck(id).toString()),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
