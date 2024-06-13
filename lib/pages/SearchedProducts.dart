import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import '../Components/ProductCard.dart';
import '../Api_Connections/Api_Connections.dart';
import '../Provider/userProvider.dart';
import '../pages/LoginPage.dart';
import '../Components/footer.dart' as footer;
import '../Constants/stylingConstants.dart' as styles;

class ProductSearchPage extends StatefulWidget {
  final String searchQuery;

  const ProductSearchPage({Key? key, required this.searchQuery})
      : super(key: key);

  @override
  _ProductSearchPageState createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  List<dynamic> items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchItems(widget.searchQuery);
  }

  Future<void> fetchItems(String searchQuery) async {
    setState(() {
      isLoading = true;
    });

    final url = API.ShowBySearch;

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'searchKeyword': searchQuery,
      },
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      setState(() {
        items = responseBody['items'] ?? [];
        isLoading = false;
      });
    } else {
      print('Failed to load items');
      setState(() {
        isLoading = false;
      });
    }
  }

  void addToCart(BuildContext context, dynamic productId) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (userProvider.userId.isNotEmpty) {
      addToCartNow(userProvider.userId, productId);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  Future<void> addToCartNow(dynamic customerId, dynamic productId) async {
    try {
      int parsedCustomerId = int.parse(customerId.toString());
      int parsedProductId = int.parse(productId.toString());

      final response = await http.post(
        Uri.parse(API.AddToCartApi),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'customerId': parsedCustomerId.toString(),
          'productId': parsedProductId.toString(),
        },
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          print("Successful order: ${responseBody['message']}");
        } else {
          print("Failed order: ${responseBody['message']}");
        }
      } else {
        print(
            "Failed to connect to the server. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Products' , style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: styles.superColor,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : items.isEmpty
              ? Center(
                  child:
                      Text('No Prouct Found with name ${widget.searchQuery}'))
              : GridView.count(
                  crossAxisCount: 2,
                  padding: const EdgeInsets.all(8.0),
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.59,
                  children: List.generate(items.length, (index) {
                    final item = items[index];
                    return Container(
                      padding: EdgeInsets.zero,
                      child: ShoppingCard(
                        // imageUrl: 'data:image/jpeg;base64,${item['image']}',
                        imageUrl: item['image'].toString(),


                        productName: item['item_name'],
                        price: double.tryParse(item['price'].toString()) ?? 0.0,
                        onAddToCart: () {
                          addToCart(context, item['id']);
                        },
                      ),
                    );
                  }),
                ),
      bottomNavigationBar: footer.CustomBottomNavigationBar(),
    );
  }
}