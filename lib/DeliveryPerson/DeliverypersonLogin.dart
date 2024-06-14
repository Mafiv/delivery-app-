import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Constants/stylingConstants.dart' as styles;
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Api_Connections/Api_Connections.dart';
import '../Provider/userProvider.dart';
import './AllOrdersToDeliver.dart' as AllOrdersToDeliver;


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void log_in() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    final url = API.DeliveryLogin;

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Accept": "application/json"},
        body: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        if (data["success"] == true) {
          print('Login successful, user ID: ${data["user_id"]}');
          final userId = data["user_id"];

          Provider.of<UserProvider>(context, listen: false)
              .setDeliveryPersonName(newDeliveryPersonId: userId.toString());

          final userProvider =
              Provider.of<UserProvider>(context, listen: false);
          if (userProvider.deliveryPersonId.isNotEmpty) {
            print("delivery person loged sussefully  " +
                userProvider.deliveryPersonId);
          } else {
            print("is not seting the value");
          }

          gotocustomerOrders();
        } else {
          print('Login failed: ${data["message"]}');
          showmessage(context, 'Login failed', data["message"]);
        }
      } else {
        print('Server error: ${response.statusCode}');
        showmessage(context, 'Server error',
            'Failed to connect to the server. Please try again later.');
      }
    } catch (e) {
      print('Network error: $e');
      showmessage(context, 'Network error',
          'Failed to connect to the server. Please check your internet connection.');
    }
  }

  void showmessage(BuildContext context, String title, String message) {
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

  void gotocustomerOrders() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AllOrdersToDeliver.MyApp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: styles.superColor,
        title: styles.loginAppBarText,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Image.asset(
              //   'Images/LogIn.png',
              //   height: 200,
              // ),
              styles.spaces,
              styles.welcomeText,
              styles.welcomeDetail,
              styles.spaces,
              TextField(
                controller: _usernameController,
                decoration: styles.usernameDecorate,
              ),
              styles.spaces,
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: styles.passwordDecorate,
              ),
              styles.spaces,
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: styles.superColor,
                    padding: const EdgeInsets.all(16.0),
                  ),
                  onPressed: log_in,
                  child: const Text('Login',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              styles.spaces,
            ],
          ),
        ),
      ),
    );
  }
}
