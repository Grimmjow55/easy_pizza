import 'package:easy_pizza/models/pizza.dart';


class OrderPizza {
  Pizza pizza;
   final int quantity;

  OrderPizza({
    required this.pizza,
    required this.quantity,
  });
}