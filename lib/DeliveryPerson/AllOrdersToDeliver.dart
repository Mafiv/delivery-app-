import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import './CustomerInformation.dart' as CustomerInfo;
import '../Api_Connections/Api_Connections.dart';
import '../Constants/stylingConstants.dart' as styles;
import '../DeliveryPerson/DeliverypersonLogin.dart' as DeliveryPersonLogin;
import '../Provider/userProvider.dart';
import '../Models/OrderModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orders List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OrdersScreen(),
    );
  }
}

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late Future<List<Order>> _orders;

  @override
  void initState() {
    super.initState();
    _orders = fetchOrders();
  }

  Future<List<Order>> fetchOrders() async {
    try {
      final response = await http.get(Uri.parse(API.AllOrdersForDelivary));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body)['response'];
        return jsonResponse.map((order) => Order.fromJson(order)).toList();
      } else {
        throw Exception('Failed to load orders: ${response.reasonPhrase}');
      }
    } catch (error) {
      throw Exception('Failed to connect to the server: $error');
    }
  }

  void showErrorDialog(BuildContext context, String title, String message) {
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

  void logout() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    // userProvider.setDeliveryPersonName(newDeliveryPersonId: '');
    // userProvider.setDeliveryPersonId(newDeliveryPersonId: '');
  }

  void gotodetailPage(int ID) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.deliveryPersonId.isEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DeliveryPersonLogin.LoginPage()),
      );
      // Navigator.pushNamed(context, '/gotologin');
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CustomerInfo.CustomerScreen(orderId: ID)),
      );
    }
  }
  // Navigator.push(
  //   context,
  //   MaterialPageRoute(
  //       builder: (context) => CustomerInfo.CustomerScreen(
  //           orderId: order.orderId)),
  // );

  Future<void> changeOrderStatus(int orderId) async {
    try {
      // Provider.of<UserProvider>(context, listen: false)
      //     .setDeliveryPersonName(newDeliveryPersonId: userId.toString());

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      if (userProvider.deliveryPersonId.isEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DeliveryPersonLogin.LoginPage()),
        );
        // Navigator.pushNamed(context, '/deliveryLogin');
      } else {
        // }
        final response = await http.post(
          Uri.parse(API.updateStatusApi),
          body: {
            'orderId': orderId.toString(),
            'deliveryPersonId': userProvider.deliveryPersonId.toString(),
            // 'deliveryPersonId': '7',

            'date': DateTime.now().toString()
          },
        );

        if (response.statusCode == 200) {
          Map<String, dynamic> jsonResponse = json.decode(response.body);
          bool success = jsonResponse['success'];
          if (success) {
            showErrorDialog(
                context, 'Successful', 'item delivered successfully');
            // Navigator.popAndPushNamed(context, "/showAllcustomerOrders");
            Navigator.pushNamed(context, '/showAllcustomerOrders');

            print('Order status updated successfully');
          } else {
            showErrorDialog(context, 'Failed', jsonResponse['message']);
            throw Exception(jsonResponse['message']);
          }
        } else {
          throw Exception(
              'Failed to update order status: ${response.reasonPhrase}');
        }
      }
    } catch (error) {
      throw Exception('Failed to connect to the server: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: styles.superColor,
        title: const Text('All Orders', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: styles.backIcon,
          onPressed: () {
            logout();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DeliveryPersonLogin.LoginPage()),
            );
          },
        ),
      ),
      body: FutureBuilder<List<Order>>(
        future: _orders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoading();
          } else if (snapshot.hasError) {
            return _buildError(snapshot.error.toString());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return _buildNoData();
          } else {
            return _buildOrderList(snapshot.data!);
          }
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text('Orders List'),
    );
  }

  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildError(String error) {
    return Center(child: Text('Error occurred: $error'));
  }

  Widget _buildNoData() {
    return Center(child: Text('No orders found'));
  }

  Widget _buildOrderList(List<Order> orders) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        Order order = orders[index];
        return _buildOrderItem(order);
      },
    );
  }

  Widget _buildOrderItem(Order order) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              child: order.productImage.isNotEmpty
                  ? ClipOval(
                      child: Image.memory(
                        order.productImage,
                        gaplessPlayback: true,
                        fit: BoxFit.cover,
                      ),
                    )
                  : CircleAvatar(child: Icon(Icons.image)),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(order.productName),
                  SizedBox(height: 8),
                  Text(order.productPrice.toStringAsFixed(2)),
                ],
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    gotodetailPage(order.orderId);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => CustomerInfo.CustomerScreen(
                    //           orderId: order.orderId)),
                    // );
                  },
                  child: Text('Customer Detail',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    backgroundColor: Color.fromARGB(255, 3, 228, 67),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () => changeOrderStatus(order.orderId),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: order.buttonColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      order.orderStatus,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
