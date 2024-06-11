import 'package:flutter/material.dart';
import './Constants/stylingConstants.dart' as Styles;
import 'Components/footer.dart' as footer;
import 'Components/Products.dart' as Products;
import 'pages/Orders.dart' as order;
import 'pages/Cart.dart' as carts;
import 'pages/LoginPage.dart' as Login_Page;
import 'pages/SignUp.dart' as SignUp_Page;
import './pages/CustomerInformation.dart' as CustomerInfo;
import './pages/SearchedProducts.dart' as SearchedProducts;
import './pages/ProfilePage.dart' as ProfilePage;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: myHomePage(),
      routes: {
        '/loginPage': (context) => Login_Page.LoginPage(),
        '/signupPage': (context) => SignUp_Page.SignUpPage(),
        '/gotoHome': (context) => MyApp(),
        '/gotocartpage': (context) => const carts.Cart(),
        '/gotoOrderpage': (context) => const order.OrderGrid(customerId: 123),
        '/gotoProfile': (context) => ProfilePage.ProfilePage(),
      },
    );
  }
}

class myHomePage extends StatefulWidget {
  @override
  _myHomePageState createState() => _myHomePageState();
}

class _myHomePageState extends State<myHomePage> {
  TextEditingController _searchController = TextEditingController();

  void _searchProducts() {
    String searchText = _searchController.text;
    if (searchText.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchedProducts.ProductCard(searchQuery: searchText),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.superColor,
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle:Styles.toHintText,
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
                  _searchProducts();
                },
              ),
            ),
            IconButton(
              icon:Styles.SearchIconStyle,
              onPressed: () {
                _searchProducts();
              },
            ),
          ],
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              cards.ProductCard(
                imageUrl:
                    'https://t4.ftcdn.net/jpg/01/43/23/83/360_F_143238306_lh0ap42wgot36y44WybfQpvsJB5A1CHc.jpg',
                productName: 'Sample Product 1',
                price: 19.99,
              ),
              cards.ProductCard(
                imageUrl:
                    'https://t4.ftcdn.net/jpg/01/43/23/83/360_F_143238306_lh0ap42wgot36y44WybfQpvsJB5A1CHc.jpg',
                productName: 'Sample Product 2',
                price: 24.99,
              ),
            ],
          ),
        ),
        
        bottomNavigationBar: footer.CustomBottomNavigationBar());
<<<<<<< HEAD
      ),
      body: Center(
        child: Products.ProductCard(),
      ),
      bottomNavigationBar: footer.CustomBottomNavigationBar(),
    );
=======
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              cards.ProductCard(
                imageUrl:
                    'https://t4.ftcdn.net/jpg/01/43/23/83/360_F_143238306_lh0ap42wgot36y44WybfQpvsJB5A1CHc.jpg',
                productName: 'Sample Product 1',
                price: 19.99,
              ),
              cards.ProductCard(
                imageUrl:
                    'https://t4.ftcdn.net/jpg/01/43/23/83/360_F_143238306_lh0ap42wgot36y44WybfQpvsJB5A1CHc.jpg',
                productName: 'Sample Product 2',
                price: 24.99,
              ),
            ],
          ),
        ),
        
        bottomNavigationBar: footer.CustomBottomNavigationBar());
>>>>>>> 4f987d97e37d71400c78d1f05367bf95baa5c668
  }
}
