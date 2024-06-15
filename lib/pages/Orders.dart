import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Components/OrderCard.dart';
import '../Constants/stylingConstants.dart' as styles;
import '../Components/footer.dart' as footer;
import '../Api_Connections/Api_Connections.dart';
import '../Models/CustomerOrderModel.dart';

class OrderPage extends StatefulWidget {
  final String customerId;

  const OrderPage({Key? key, required this.customerId}) : super(key: key);
  // const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late Future<List<OrderItemData>> futureOrderItems;

  @override
  void initState() {
    super.initState();
    futureOrderItems = fetchOrderItems(widget.customerId);
  }

  Future<List<OrderItemData>> fetchOrderItems(String customerId) async {
    final response = await http.post(
      Uri.parse(API.showAllOrder),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'customerId': customerId,
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody is List) {
        return responseBody
            .map((item) => OrderItemData.fromJson(item))
            .toList();
      } else {
        throw Exception('No orders found for the specified customer ID');
      }
    } else {
      throw Exception('Failed to load orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: styles.superColor,
        title: const Text('Orders', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: styles.backIcon,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<List<OrderItemData>>(
        future: futureOrderItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No orders found'));
          } else {
            List<OrderItemData> orderItems = snapshot.data!;
            return ListView.builder(
              itemCount: orderItems.length,
              itemBuilder: (context, index) {
                OrderItemData item = orderItems[index];
                return OrderItem(
                  imageUrl: item.productImage,
                  productName: item.productName,
                  status: item.orderStatus,
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
