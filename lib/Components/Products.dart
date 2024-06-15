import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Components/ProductCard.dart';
import '../Api_Connections/Api_Connections.dart';
import 'package:provider/provider.dart';
import '../Provider/userProvider.dart';
import '../pages/LoginPage.dart' as Login;


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
 
  void addToCart(BuildContext context, dynamic prodctId) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (userProvider.userId.isNotEmpty) {
      addToCartNow(userProvider.userId, prodctId);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login.LoginPage()),
      );
    }
  }

  Future<void> addToCartNow(dynamic customerId, dynamic productId) async {
    try {
      int parsedCustomerId = int.parse(customerId.toString());
      int parsedProductId = int.parse(productId.toString());

      final response = await http.post(
        Uri.parse(API.AddToCartApi),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'customerId': parsedCustomerId.toString(),
          'productId': parsedProductId.toString(),
        },
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
            Fluttertoast.showToast(msg: "One item added to cart");


          print("Successful order: ${responseBody['message']}");
        } else {
          print("Failed order: ${responseBody['message']}");
        }
      } else {
        print(
            "Failed to connect to the server. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  Future<void> fetchItems() async {
    final response = await http.get(Uri.parse(API.ProductApi));

    if (response.statusCode == 200) {
      print('Items loaded successfully');
      setState(() {
        items = json.decode(response.body);
        isLoading = false;
      });
    } else {
    
      print('Failed to load items');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const  Center( child: CircularProgressIndicator());
    }

    if (items.isEmpty) {
      return const  Center(child: Text('No items found'));
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
            imageUrl: item['image'].toString(),
            productName: item['item_name'],
            price: double.tryParse(item['price'].toString()) ?? 0.0,
            onAddToCart: () {
              addToCart(context,item['id']);
              print(item['id']);
            },
          ),
        );
      }),
    );
  }
}

