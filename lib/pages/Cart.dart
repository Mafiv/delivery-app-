import 'package:flutter/material.dart';
import '../Components/CartItem.dart';
import '../Constants/stylingConstants.dart' as styles;
import '../Components/footer.dart' as footer;

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

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
      body: ListView(
        children: [
          CartItem(
            imageUrl:
                'https://t4.ftcdn.net/jpg/01/43/23/83/360_F_143238306_lh0ap42wgot36y44WybfQpvsJB5A1CHc.jpg',
            productName: 'Product 1',
            price: 19.99,
            onOrderPressed: () {
              // Handle order button pressed
              print('Order button pressed for Product 1');
            },
            onRemovePressed: () {
              // Handle remove button pressed
              print('Remove button pressed for Product 1');
            },
          ),
          CartItem(
            imageUrl:
                'https://t4.ftcdn.net/jpg/01/43/23/83/360_F_143238306_lh0ap42wgot36y44WybfQpvsJB5A1CHc.jpg',
            productName: 'Product 2',
            price: 29.99,
            onOrderPressed: () {
              // Handle order button pressed
              print('Order button pressed for Product 2');
            },
            onRemovePressed: () {
              // Handle remove button pressed
              print('Remove button pressed for Product 2');
            },
          ),
          // Add more CartItem widgets as needed
        ],
      ),
    bottomNavigationBar: footer.CustomBottomNavigationBar());
    
  }
}
