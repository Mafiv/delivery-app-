import 'package:flutter/material.dart';
import './Constants/stylingConstants.dart' as Styles;
import 'Components/footer.dart' as footer;
import 'Components/Products.dart' as Products;
import 'pages/Orders.dart' as order;
import 'pages/Cart.dart' as carts;
import 'pages/LoginPage.dart' as Login_Page;
import 'pages/SignUp.dart' as SignUp_Page;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: myHomePage(), routes: {
      '/loginPage': (context) => Login_Page.LoginPage(),
      '/signupPage': (context) => SignUp_Page.SignUpPage(),
      '/gotoHome': (context) => MyApp(),
      '/gotocartpage': (context) => const carts.Cart(),
      '/gotoOrderpage': (context) => const order.OrderGrid(),
    });
  }
}

class myHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.superColor,
        title: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: Styles.toHintText,
                  filled: true,
                  fillColor: Styles.toFillSearchArea,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: Styles.toPadding,
                ),
                style: Styles.inputStyle,
                onSubmitted: (value) {
                  // Handle the search logic here
                  print('Search text: $value');
                },
              ),
            ),
            IconButton(
              icon: Styles.SearchIconStyle,
              onPressed: () {
                // Handle the search icon press logic here
                print('Search icon pressed');
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Products.ProductCard(),
      ),
      bottomNavigationBar: footer.CustomBottomNavigationBar(),
    );
  }
}
