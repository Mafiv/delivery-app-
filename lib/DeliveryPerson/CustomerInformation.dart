import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Constants/DeliveryConstants.dart' as Styles;
import 'informationRow.dart' as InformationRow;
import '../Models/Customer.dart' as store;
import '../Constants/stylingConstants.dart' as styles;
import '../Api_Connections/Api_Connections.dart';

class MyCustomerInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CustomerScreen(orderId: 1),
    );
  }
}

class CustomerScreen extends StatefulWidget {
  final int orderId;

  CustomerScreen({required this.orderId});

  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  late Future<Map<String, dynamic>> _customerInfo;

  @override
  void initState() {
    super.initState();
    _customerInfo = fetchCustomerInfo();
  }

  Future<Map<String, dynamic>> fetchCustomerInfo() async {
    final response = await http.post(
      Uri.parse(API.showCustomerInfo),
      body: {'orderId': widget.orderId.toString()},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load customer information');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: styles.superColor,
        title: Styles.customerInformationText,
        leading: IconButton(
          icon: styles.backIcon,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _customerInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final customer = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ClipOval(
                          child: Image.memory(
                            base64Decode(customer['image']),
                            width: 150,
                            height: 150,
                            // fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Styles.spaces,
                    InformationRow.InformationRow(
                      rowKey: 'Name:',
                      rowValue: '${customer['FirstName']} ${customer['LastName']}',
                    ),
                    Styles.spaces,
                    InformationRow.InformationRow(
                      rowKey: 'Email:',
                      rowValue: customer['email'],
                    ),
                    Styles.spaces,
                    InformationRow.InformationRow(
                      rowKey: 'Phone Number:',
                      rowValue: customer['PhoneNumber'],
                    ),
                    Styles.spaces,
                    InformationRow.InformationRow(
                      rowKey: 'Address:',
                      rowValue: customer['address'],
                    ),
                    Styles.spaces,
                    InformationRow.InformationRow(
                      rowKey: 'Gender:',
                      rowValue: customer['Gender'],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
