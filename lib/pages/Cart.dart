
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Components/CartItem.dart';
import '../Constants/stylingConstants.dart' as styles;
import '../Components/footer.dart' as footer;
import '../Api_Connections/Api_Connections.dart';
import '../pages/orderDetail.dart';

class Cart extends StatefulWidget {
  String customerId;

  Cart({required this.customerId});



  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  late Future<List<CartItemData>> futureCartItems;

  @override
  void initState() {
    super.initState();
    futureCartItems = fetchCartItems(widget.customerId);
  }

/***************************** */
  Future<void> deleteFromCartNow(dynamic cartId) async {
    try {
      int Id = int.parse(cartId.toString());

      final response = await http.post(
        Uri.parse(API.DeleteCart),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'cart_id': Id.toString(),
        },
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          showMessage(context, "Deleted",
              "Item deleted Sussessfully reload to see a change!");
          print("item deleted Sussessfully");
        } else {
          print("Failed order:");
        }
      } else {
        print(
            "Failed to connect to the server. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }

/*************************** */
/******************* */
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

/***************** */
  void Order_now(String Name, double Price, int ID,int cartId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderDetailPage(
          productName: Name,
          productId: ID.toString(),
          price: Price,
          cartId: cartId,
        ),
      ),
    );
  }

/********************** */
  Future<List<CartItemData>> fetchCartItems(String customerId) async {
    final response = await http.post(
      Uri.parse(API.ShowAllCart),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'customerId': customerId.toString(),
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        List<dynamic> data = responseBody['cartItems'];
        return data.map((item) {
          var cartItem = CartItemData.fromJson(item);
          cartItem.productPrice = double.parse(item['productPrice'].toString());
          

          return cartItem;
        }).toList();
      } else {
        throw Exception(responseBody['message']);
      }
    } else {
      throw Exception('Failed to load cart items');
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder<List<CartItemData>>(
        future: futureCartItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } 
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
           else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No items in cart'));
          }
           else {
            List<CartItemData> cartItems = snapshot.data!;
            return ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                CartItemData item = cartItems[index];
                return CartItem(
                  imageUrl: item.productImage,
                  productName: item.productName,
                  price: item.productPrice,
                  productId: item.productId,
                  onOrderPressed: () {
                    Order_now(
                        item.productName, item.productPrice, item.productId,item.cartItemId);
                    /* onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderDetailPage(
                                productId: productId,
                                price: price,
                              ),
                            ),
                          );
                        }***/

                    print('Order button pressed for ${item.productName}');
                  },
                  onRemovePressed: () {
                    deleteFromCartNow('${item.cartItemId}');
                    print('Remove button pressed for ${item.productName}');
                  },
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: footer.CustomBottomNavigationBar(),
    );
  }
}

class CartItemData {
  final int cartItemId;
  final String productName;
  late double productPrice;
  final String productImage;
  final int productId;

  CartItemData({
    required this.cartItemId,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.productId,
  });

  factory CartItemData.fromJson(Map<String, dynamic> json) {
    return CartItemData(
        cartItemId: json['cartItemId'],
        productName: json['productName'],
        productPrice: double.parse(json['productPrice'].toString()),
        productImage: json['productImage'],
        productId: json['productId']);
  }
}
