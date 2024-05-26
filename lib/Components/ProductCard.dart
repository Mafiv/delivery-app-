import 'package:flutter/material.dart';

class ShoppingCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final double price;
  final VoidCallback? onAddToCart;

  const ShoppingCard({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.price,
    this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160, 
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                height: 160,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 10), 
          Text(
            productName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10), 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, 
            children: [
              Text(
                '\$${price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 118, 20, 133),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                color: const Color.fromARGB(255, 78, 72, 61),
                onPressed: onAddToCart ?? (){},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
