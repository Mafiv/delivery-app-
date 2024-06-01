import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Components/OrderCard.dart';
import '../Constants/stylingConstants.dart' as styles;
import '../Components/footer.dart' as footer;

class OrderGrid extends StatefulWidget {
  final int customerId; // New field to store customer ID
  const OrderGrid({Key? key, required this.customerId}) : super(key: key);

  @override
  _OrderGridState createState() => _OrderGridState();
}

class _OrderGridState extends State<OrderGrid> {
  List<OrderData> _orders = [];

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    try {
      final response = await http.get(Uri.parse('YOUR_API_ENDPOINT?customerId=${widget.customerId}')); // Pass customer ID to the API endpoint

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _orders = data.map((item) => OrderData.fromJson(item)).toList();
        });
      } else {
        // Handle server error
        print('Failed to fetch orders: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network error
      print('Error fetching orders: $error');
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
      body: _orders.isEmpty
          ? const Center(child: CircularProgressIndicator()) 
          : ListView.builder(
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                final order = _orders[index];
                return OrderCard(
                  orderId: order.orderId,
                  productName: order.productName,
                  price: order.price,
                  status: order.status,
                  imageUrl: order.imageUrl,
                );
              },
            ),
      bottomNavigationBar: footer.CustomBottomNavigationBar(),
    );
  }
}

class OrderData {
  final int orderId;
  final String productName;
  final double price;
  final String status;
  final String imageUrl;

  OrderData({
    required this.orderId,
    required this.productName,
    required this.price,
    required this.status,
    required this.imageUrl,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      orderId: json['orderId'],
      productName: json['productName'],
      price: json['productPrice'],
      status: json['orderStatus'],
      imageUrl: json['productImage'],
    );
  }
}
