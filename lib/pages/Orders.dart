import 'package:flutter/material.dart';
import '../Components/OrderCard.dart';
import '../Constants/stylingConstants.dart' as styles;
import '../Components/footer.dart' as footer;

class OrderGrid extends StatelessWidget {
  const OrderGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  styles.superColor,
        title: const Text('Orders', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: styles.backIcon,
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
      ),
      body: ListView(
        children: List.generate(
          5,
          (index) => OrderCard(
            productName: 'Product $index',
            price: 99.99,
            status: 'Delivered',
            imageUrl:
                'https://t4.ftcdn.net/jpg/01/43/23/83/360_F_143238306_lh0ap42wgot36y44WybfQpvsJB5A1CHc.jpg',
          ),
        ),
      ),
    bottomNavigationBar: footer.CustomBottomNavigationBar()

    );
  }
}
