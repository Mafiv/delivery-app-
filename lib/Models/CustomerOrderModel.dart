class OrderItemData {
  final int orderId;
  final String productName;
  final double productPrice;
  final String productImage;
  final String orderStatus;

  OrderItemData({
    required this.orderId,
    required this.productName,
    required this.productPrice, 
    required this.productImage,
    required this.orderStatus,
  });

  factory OrderItemData.fromJson(Map<String, dynamic> json) {
    return OrderItemData(
      orderId: json['orderId'],
      productName: json['productName'],
      productPrice: double.parse(json['productPrice'].toString()),
      productImage: json['productImage'],
      orderStatus: json['orderStatus'],
    );
  }
}
