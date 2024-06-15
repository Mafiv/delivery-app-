import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../Constants/stylingConstants.dart' as Styles;

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

    Uint8List? imageBytes;
    if (imageUrl.isNotEmpty) {
      final header = 'data:image/jpeg;base64,';
      final base64Image = imageUrl.replaceFirst(header, '');
      imageBytes = base64Decode(base64Image);
    }

    return Container(
      height: 260,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: imageBytes != null
                    ? MemoryImage(imageBytes)
                    : AssetImage('assets/placeholder.png') as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            productName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 34, 34, 34),
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  color:Styles.superColor,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                color: Color.fromARGB(255, 0, 0, 0),
                onPressed: onAddToCart ?? () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
