

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Order {
  int orderId;
  String productName;
  double productPrice;
  Uint8List productImage;
  String orderStatus;
  Color buttonColor;

  Order({
    required this.orderId,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.orderStatus,
    required this.buttonColor,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: int.parse(json['orderId'].toString()),
      productName: json['productName'],
      productPrice: double.parse(json['productPrice'].toString()),
      productImage: Base64Decoder().convert(json['productImage']),
      orderStatus: json['orderStatus'],
      buttonColor: json['orderStatus'] == 'pending'
          ? Color.fromARGB(255, 1, 151, 46)
          : Color.fromARGB(255, 41, 0, 34),
    );
  }
}
