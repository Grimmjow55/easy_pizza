import 'dart:collection';
import 'package:easy_pizza/data/pizzas.dart' as db;
import 'package:easy_pizza/models/pizza.dart';
import 'order_pizza.dart';
import 'package:flutter/material.dart';

class ProviderAddToCart extends ChangeNotifier {
  final List<OrderPizza> _cart = [];

  List<OrderPizza> get cart => UnmodifiableListView(_cart);

  void addToCart(String id) {

    Pizza pizza = db.pizzas.firstWhere((pizza) => pizza.id == id);

    if(cart.isEmpty){
      _cart.add(OrderPizza(pizza: pizza, quantity: 1));
      notifyListeners();
    }
    else{
      final int index = _cart.indexWhere((order) => order.pizza.id == id);

      if (index > -1) {
        final OrderPizza order = _cart[index];
        _cart[index] =
            OrderPizza(pizza: order.pizza, quantity: order.quantity + 1);
      } else {
        _cart.add(OrderPizza(pizza: pizza, quantity: 1));
      }
      notifyListeners();
    }
  }

  void removeFromCart(String id) {
    for (OrderPizza order in _cart) {
      if (order.pizza.id == id) {
        if (order.quantity > 1) {
          final int index = _cart.indexWhere((order) => order.pizza.id == id);
          _cart[index] =
              OrderPizza(pizza: order.pizza, quantity: order.quantity - 1);

          notifyListeners();
        } else {
          _cart.remove(order);
          notifyListeners();
        }
      }
    }
  }

  void removeAllQuantity(String id) {
    for (OrderPizza order in _cart) {
      if (order.pizza.id == id) {
        _cart.remove(order);
        notifyListeners();
      }
    }
  }

  int quantityCheck(String id) {

      final int index = _cart.indexWhere((order) => order.pizza.id == id);

      if (index > -1) {
        final OrderPizza order = _cart[index];
        return order.quantity;
      } else {
        return 0;
      }
  }

  int checkIsPresentReturnIndex(String id) {
    final int index = _cart.indexWhere((order) => order.pizza.id == id);
    return index;
  }



  double get totalAmount {
    return _cart.fold(
        0.0, (sum, item) => sum + item.pizza.price * item.quantity);
  }
}

