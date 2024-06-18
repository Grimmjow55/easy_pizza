import 'package:easy_pizza/models/pizza.dart';

final List<Pizza> pizzas = [
  Pizza(name: "Ortolana", price: 6, ingrediants: ["Tomato", "Mozzarella", "Grilled vegetables", "Basil"], category: Category.veggie),
  Pizza(name: "Margherita", price: 6, ingrediants: ["Tomato", "Mozzarella", "Basil"], category: Category.rossa),
  Pizza(name: "Quattro Stagioni", price: 12, ingrediants: ["Tomato", "Mozzarella", "Mushrooms", "Ham", "Artichokes", "Olives", "Basil"], category: Category.rossa),
  Pizza(name: "Capricciosa", price: 11, ingrediants: ["Tomato", "Mozzarella", "Mushrooms", "Ham", "Artichokes", "Olives"], category: Category.rossa),
  Pizza(name: "Marinara", price: 5, ingrediants: ["Tomato", "Garlic", "Oregano", "Basil"], category: Category.rossa),
  Pizza(name: "Regina", price: 10, ingrediants: ["Tomato", "Mozzarella", "Ham", "Mushrooms"], category: Category.rossa),
  Pizza(name: "Diavola", price: 10, ingrediants: ["Tomato", "Mozzarella", "Spicy salami"], category: Category.rossa),
  Pizza(name: "Quattro Formaggi", price: 12, ingrediants: ["Tomato", "Mozzarella", "Gorgonzola", "Fontina", "Parmesan"], category: Category.bianca),
  Pizza(name: "Parma", price: 13, ingrediants: ["Tomato", "Mozzarella", "Parma ham", "Parmesan", "Rocket"], category: Category.rossa),
  Pizza(name: "Bianca", price: 10, ingrediants: ["Mozzarella", "Gorgonzola", "Fontina", "Parmesan", "Basil"], category: Category.bianca),
];