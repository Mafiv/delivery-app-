import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Api_Connections/Api_Connections.dart';
import '../Constants/stylingConstants.dart' as style;


class OrderDetail {
  final String customerName;
  final String customer_last_name;
  final String customerImage;
  final String productName;
  final String productImage;
  final double productPrice;
  final String customerAddress;
  final String orderDate;
  final String deliveryPersonName;
  final String deliveryPersonImage;

  OrderDetail({
    required this.customerName,
    required this.customer_last_name,
    required this.customerImage,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.customerAddress,
    required this.orderDate,
    required this.deliveryPersonName,
    required this.deliveryPersonImage,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      customerName: json['customer_name'],
      customer_last_name: json['customer_last_name'],
      customerImage: json['customer_image'],
      productName: json['product_name'],
      productImage: json['product_image'],
      productPrice: double.parse(json['product_price'].toString()),
      customerAddress: json['customer_address'],
      orderDate: json['order_date'],
      deliveryPersonName: json['delivery_person_name'],
      deliveryPersonImage: json['delivery_person_image'],
    );
  }
}


Future<List<OrderDetail>> fetchOrderDetails() async {
  final response = await http.get(
    Uri.parse(API.Detail),
    headers: {'Accept': 'application/json'},
  );

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);
    if (parsed['success']) {
      return (parsed['data'] as List)
          .map<OrderDetail>((json) => OrderDetail.fromJson(json))
          .toList();
    } else {
      throw Exception(parsed['message']);
    }
  } else {
    throw Exception('Failed to load order details');
  }
}


class OrderDetailScreen extends StatefulWidget {
  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late Future<List<OrderDetail>> futureOrderDetails;

  @override
  void initState() {
    super.initState();
    futureOrderDetails = fetchOrderDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details', style: TextStyle(color: Colors.white, fontSize: 20),),
        backgroundColor: style.superColor,
      ),
      body: FutureBuilder<List<OrderDetail>>(
        future: futureOrderDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final orderDetail = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.all(10.0),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _buildImage(orderDetail.customerImage),
                            SizedBox(width: 10),
                            Text(
                              orderDetail.customerName + ' ' + orderDetail.customer_last_name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: style.superColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            _buildImage(orderDetail.productImage),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                orderDetail.productName,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Text(
                              '\$${orderDetail.productPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: style.superColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Address: ${orderDetail.customerAddress}',
                          style: TextStyle(fontSize: 13, color: style.superColor),
                        ),
                        Text(
                          'Order Date: ${orderDetail.orderDate}',
                          style: TextStyle(fontSize: 13, color: style.superColor),
                        ),
                        Row(
                          children: [
                            _buildImage(orderDetail.deliveryPersonImage),
                            SizedBox(width: 10),
                            Text(
                              'Delivered by: ${orderDetail.deliveryPersonName}',
                              style: TextStyle(fontSize: 13, color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildImage(String base64Image) {
    Uint8List bytes = base64Decode(base64Image);
    return Image.memory(
      bytes,
      height: 80, 
      width: 80, 
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.error); 
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: OrderDetailScreen(),
  ));
}
