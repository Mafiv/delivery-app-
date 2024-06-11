import 'package:flutter/material.dart';
import 'ProductCard.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(8.0),
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
      childAspectRatio: 0.59,
      children: List.generate(8, (index) {
        return Container(
          padding: EdgeInsets.zero,
          child: ShoppingCard(
            imageUrl:
                'https://t4.ftcdn.net/jpg/01/43/23/83/360_F_143238306_lh0ap42wgot36y44WybfQpvsJB5A1CHc.jpg',
            productName: 'Product $index',
            price: 99.99,
            onAddToCart: () {
              print('clicked');
            },
          ),
        );
      }),
    );
  }
}
