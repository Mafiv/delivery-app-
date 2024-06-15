import 'package:flutter/material.dart';
import '../Constants/stylingConstants.dart' as styles;
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Api_Connections/Api_Connections.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../Provider/userProvider.dart';

void showMessage(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

Future<void> deleteFromCartNow(BuildContext context, dynamic cartId) async {
  try {
    int id = int.parse(cartId.toString());

    final response = await http.post(
      Uri.parse(API.DeleteCart),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'cart_id': id.toString(),
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        showMessage(context, "Congratulations",
            "Your order has been successfully placed and will be delivered soon!!");
        print("Item deleted successfully");
      } else {
        print("Failed to delete item:");
      }
    } else {
      print(
          "Failed to connect to the server. Status code: ${response.statusCode}");
    }
  } catch (e) {
    print("An error occurred: $e");
  }
}

Future<void> placeAnOrder(
    BuildContext context, String location, String productId, dynamic cartId) async {
  try {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    String customerId = userProvider.userId;

    final response = await http.post(
      Uri.parse(API.saveOrder),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'customerId': customerId,
        'location': location,
        'productId': productId,
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        // showMessage(context, "Congratulations", "Your order has been successfully placed and will be delivered soon!!");
        // deleteFromCartNow(context,)

        Navigator.pushNamed(context, '/gotocartpage');
        deleteFromCartNow(context, cartId);
      } else {
        Fluttertoast.showToast(msg: "Your order is not saved");
        print("Failed to place order:");
      }
    } else {
      print(
          "Failed to connect to the server. Status code: ${response.statusCode}");
    }
  } catch (e) {
    print("An error occurred: $e");
  }
}

class OrderDetailPage extends StatelessWidget {
  final String productId;
  final String productName;
  final double price;
  final int cartId;

  OrderDetailPage({
    Key? key,
    required this.productId,
    required this.productName,
    required this.price,
    required this.cartId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController paymentIdController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: styles.superColor,
        title: const Text('Cart', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: styles.backIcon,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Product Name: $productName',
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '\$${price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20  ,
                  color: styles.superColor,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: paymentIdController,
                decoration: InputDecoration(
                  labelText: 'Payment ID',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your payment ID';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 134, 5, 5),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: styles.superColor,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        placeAnOrder(
                            context, addressController.text, productId, cartId);
                      }
                    },
                    child: Text(
                      'Place Order',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
