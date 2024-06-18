import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/userProvider.dart';
import './Constants/stylingConstants.dart' as Styles;
import 'Components/footer.dart' as footer;
import 'Components/Products.dart' as Products;
import 'pages/Orders.dart' as order;
import 'pages/Cart.dart' as carts;
import 'pages/LoginPage.dart' as Login_Page;
import 'pages/SignUp.dart' as SignUp_Page;
import './pages/SearchedProducts.dart' as SearchedProducts;
import './pages/ProfilePage.dart' as ProfilePage;
/**************for admin  */

import '../AdminPage/ShowAllProducts.dart' as ShowAllProductsForAdmin;
import 'AdminPage/AddDeliveryperson.dart' as AddDeliveryPerson;
import 'AdminPage/ShowAllCustomers.dart' as ShowAllCustomers;
import 'AdminPage/AddProduct.dart' as AddProduct;
import 'AdminPage/detail.dart' as detail;
import 'AdminPage/adminFooter.dart' as adminfooter;

/*******for the delivery person */

import '../DeliveryPerson/AllOrdersToDeliver.dart' as AllOrdersToDeliver;
import '../DeliveryPerson/DeliverypersonLogin.dart' as DeliveryPersonLogin;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        home: myHomePage(),
        routes: {
          /***for all */
          '/home': (context) => myHomePage(),

          /**admin panel */
          '/gotoadddeliveryperson': (context) =>
              AddDeliveryPerson.AddDeliveryPersonPage(),
          '/gotoaddproduct': (context) => AddProduct.ProductUploader(),
          '/gotoocustomerlist': (context) => ShowAllCustomers.CustomersList(),
          '/gotoHome': (context) => myHomePage(),
          '/AllcustomersDetail': (context) {
            final userProvider =
                Provider.of<UserProvider>(context, listen: false);
            if (userProvider.userId.isNotEmpty) {
              return ShowAllCustomers.CustomersList();
            } else {
              return Login_Page.LoginPage();
            }
          },

          /****for the delivery */
          '/gotologin': (context) => DeliveryPersonLogin.LoginPage(),
          '/gotodetailPage': (context) => detail.OrderDetailScreen(),
          '/showAllcustomerOrders': (context) => AllOrdersToDeliver.MyApp(),

          /******to customer */
          '/gotocartpage': (context) {
            final userProvider =
                Provider.of<UserProvider>(context, listen: false);
            if (userProvider.userId.isNotEmpty) {
              return carts.Cart(customerId: userProvider.userId);
            } else {
              return Login_Page.LoginPage();
            }
          },
          '/loginPage': (context) => Login_Page.LoginPage(),
          '/signupPage': (context) => SignUp_Page.SignUpPage(),
          '/gotoOrderpage': (context) {
            final userProvider =
                Provider.of<UserProvider>(context, listen: false);
            if (userProvider.userId.isNotEmpty) {
              return order.OrderPage(customerId: userProvider.userId);
            } else {
              return Login_Page.LoginPage();
            }
          },
          '/gotoprofilepage': (context) {
            final userProvider =
                Provider.of<UserProvider>(context, listen: false);
            if (userProvider.userId.isNotEmpty) {
              return ProfilePage.ProfilePage(userId: userProvider.userId);
            } else {
              return Login_Page.LoginPage();
            }
          },
        },
      ),
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
          builder: (context) =>
              SearchedProducts.ProductSearchPage(searchQuery: searchText),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Styles.superColor,
      //   title: Row(
      //     children: [
      //       Expanded(
      //         child: TextField(
      //           controller: _searchController,
      //           decoration: InputDecoration(
      //             hintText: 'Search...',
      //             hintStyle: Styles.toHintText,
      //             filled: true,
      //             fillColor: Styles.toFillSearchArea,
      //             border: OutlineInputBorder(
      //               borderSide: BorderSide.none,
      //               borderRadius: BorderRadius.circular(8.0),
      //             ),
      //             enabledBorder: OutlineInputBorder(
      //               borderSide: BorderSide.none,
      //               borderRadius: BorderRadius.circular(8.0),
      //             ),
      //             focusedBorder: OutlineInputBorder(
      //               borderSide: BorderSide.none,
      //               borderRadius: BorderRadius.circular(8.0),
      //             ),
      //             contentPadding: Styles.toPadding,
      //           ),
      //           style: Styles.inputStyle,
      //           onSubmitted: (value) {
      //             _searchProducts();
      //           },
      //         ),
      //       ),
      //       IconButton(
      //         icon: Styles.SearchIconStyle,
      //         onPressed: () {
      //           _searchProducts();
      //         },
      //       ),
      //     ],
      //   ),
      // ),

      
      body: Center(

        // child: Login_Page.LoginPage(),

        // child: Products.ProductCard(),
        //  child:ShowAllProductsForAdmin.ProductPage(),
        //  child:DeliveryPersonLogin.LoginPage(),
      ),
      bottomNavigationBar: adminfooter.CustomBottomNavigationBar(),

      // bottomNavigationBar: footer.CustomBottomNavigationBar(),
    );
  }
}
