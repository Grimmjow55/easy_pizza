
import 'dart:convert';
import 'package:easy_pizza/models/provider_like.dart';
import 'package:easy_pizza/models/discount.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_pizza/data/pizzas.dart' as db;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PizzaMaster extends StatefulWidget {
  const PizzaMaster({super.key});

  @override
  State<PizzaMaster> createState() => _PizzaMasterState();
}

class _PizzaMasterState extends State<PizzaMaster> {

  Future<void> subscribeToDiscounts() async {

    await dotenv.load(fileName: ".env");
    final Uri wsUrl = Uri.parse(dotenv.env["WEBSOCKET_API"]!);
    final channel = WebSocketChannel.connect(wsUrl);
    await channel.ready;
    
    channel.sink.add(
      jsonEncode(
        {"collection": "discounts", "type": "subscribe"},
      ),
    );

    channel.stream.listen((data) {
      final Map<String, dynamic> response = jsonDecode(data);

      if (response['type'] == "subscription") {

        //Afficher le dernier discount enregistré
        final Discount lastDiscount = Discount.fromJson(response["data"][0]);

        final snackBar = SnackBar(
          content : Text(lastDiscount.code)
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        //Afficher tout les discount


        for (var element in response["data"]) {

          final discount = Discount.fromJson(element);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${discount.code}: ${discount.rule} (from ${discount.start} to $discount.end})',
              ),
              duration: const Duration(seconds: 10),
            ),
          );
        }
      }
    }, onError: (error) {
      if (kDebugMode) {
        print(error);
      }
    });
  }

  @override
    void initState() {
      super.initState();
      subscribeToDiscounts();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pizza Master'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            padding: const EdgeInsets.only(right: 50),
            iconSize: 30,
            onPressed: () {
              context.push("/cart");
            },
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: db.pizzas.length,
          itemBuilder: (BuildContext context, index) {
            final pizza = db.pizzas[index];
            final isFavorite =
                Provider.of<ProviderLike>(context).isFavorite(pizza.id);
            final favoriteTextStyle = TextStyle(
              color: isFavorite ? Colors.black : Colors.white,
              fontWeight: isFavorite ? FontWeight.bold : FontWeight.normal,
            );
            return Container(
              
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 50, 50, 50),
                borderRadius: BorderRadius.circular(15),
                image: isFavorite
                    ? const DecorationImage(
                        image: AssetImage('media/lovely.png'),
                        fit: BoxFit.cover)
                    : null,
              ),
              margin: const EdgeInsets.all(6),
              child: ListTile(
                leading: Text("${db.pizzas[index].price.toStringAsFixed(2)}€",
                    style: favoriteTextStyle),
                title: Text(db.pizzas[index].name, style: favoriteTextStyle),
                subtitle: Text(
                    "${db.pizzas[index].ingrediants.length} ingrédiants",
                    style: favoriteTextStyle),
                trailing: Image.asset("media/pizza.png"),
                onTap: () {
                  context.push("/details/${db.pizzas[index].id}");
                },
              ),
            );
          },
        ),
      ),

    );
  }
}


