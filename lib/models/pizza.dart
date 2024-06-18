
import 'package:uuid/v4.dart';

class Pizza {
  String id;
  final String name;
  final double price;
  List<String> ingrediants;
  Category category;
  

  Pizza({
  required this.name,
  required this.price,
  required this.ingrediants,
  required this.category,
  }) : id = const UuidV4().generate();

  @override
  String toString() {
    return "Pizza(id:$id, name:$name, price:$price, ingrediants:$ingrediants, category:$category)";
      }
}

enum Category {
  rossa,
  bianca,
  veggie,
}

