import 'package:flutter/material.dart';
import './Constants/stylingConstants.dart' as Styles;
import 'Components/footer.dart' as footer;
import 'Components/CardComponents.dart' as cards;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: myHomePage(),
    );
  }
}

class myHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 118, 20, 133),
          title: Text(
            'Home',
            style: Styles.titleTextStyle,
          ),
          actions: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        style: Styles.inputStyle,
                        decoration: Styles.searchArea,
                        onChanged: (value) {
                          //*************************************** */
                        },
                      ),
                    ),
                    IconButton(
                      icon: Styles.searchIcon,
                      onPressed: () {
                        // Handle search action
                      },
                    ),
                  ],
                ),
              ),
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
  }
}



/**************** */


