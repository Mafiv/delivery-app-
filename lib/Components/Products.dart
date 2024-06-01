import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Components/ProductCard.dart';
import '../Api_Connections/Api_Connections.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  List<dynamic> items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    final response = await http
        .get(Uri.parse(API.ProductApi));

    if (response.statusCode == 200) {
      print('Items loaded successfully');
      setState(() {
        items = json.decode(response.body);
        isLoading = false;
      });
    } else {
      // Handle the error
      print('Failed to load items');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (items.isEmpty) {
      return Center(child: Text('No items found'));
    }

    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(8.0),
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
      childAspectRatio: 0.59,
      children: List.generate(items.length, (index) {
        final item = items[index];
        return Container(
          padding: EdgeInsets.zero,
          child: ShoppingCard(
            imageUrl: 'data:image/jpeg;base64,${item['image']}',
            productName: item['item_name'],
            price: double.tryParse(item['price'].toString()) ?? 0.0,
            onAddToCart: () {
              print(item['id']);
            },
          ),
        );
      }),
    );
  }
}
