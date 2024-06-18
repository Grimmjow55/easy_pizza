// cart_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_pizza/models/provider_add_to_cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<ProviderAddToCart>(context);
    final cart = cartProvider.cart;

    return Scaffold(
      appBar: AppBar(
        title:  const Text('Panier')
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final order = cart[index];
                return ListTile(
                  leading: Image.asset('media/pizza.png'),
                  title: Text(order.pizza.name),
                  subtitle: Text('Quantity: ${order.quantity}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          cartProvider.addToCart(order.pizza.id);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          cartProvider.removeFromCart(order.pizza.id);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: (){
                          cartProvider.removeAllQuantity(order.pizza.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Text('Total: ${cartProvider.totalAmount.toStringAsFixed(2)}€'),
          Container(height: 50,)
        ],
      ),
    );
  }
}


