import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Constants/stylingConstants.dart' as style;
import '../pages/ProfilePage.dart' as ProfilePage;
import 'package:provider/provider.dart';
import '../Provider/userProvider.dart';




class CustomBottomNavigationBar extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final String currentPage = userProvider.currentPage;
    
    return SizedBox(
      height: 56.0,
      child: Container(
        decoration: style.for_footer,
        child: BottomAppBar(
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  userProvider.setCurrentPage(newCurrentPage: 'Home');
                 
                  Navigator.pushNamed(context, '/gotoHome');
                  /***************** */
                },
             color: currentPage == 'Home' ? style.superColor : Color.fromARGB(255, 112, 112, 112),
                iconSize: 30.0,
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  userProvider.setCurrentPage(newCurrentPage: 'Cart');

                  Navigator.pushNamed(context, '/gotocartpage');

                  /***************** */
                },
                 color: currentPage == 'Cart' ? style.superColor : Color.fromARGB(255, 112, 112, 112),

                iconSize: 30.0,
              ),
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined),
                onPressed: () {
                  userProvider.setCurrentPage(newCurrentPage: 'Orders');

                  Navigator.pushNamed(context, '/gotoOrderpage');

                  /***************** */
                },
              color: currentPage == 'Orders' ? style.superColor : Color.fromARGB(255, 112, 112, 112),

                iconSize: 30.0,
              ),
              IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {
                  userProvider.setCurrentPage(newCurrentPage: 'Profile');
                  Navigator.pushNamed(context, '/gotoprofilepage');

                  /***************** */
                },
             color: currentPage == 'Profile' ? style.superColor :Color.fromARGB(255, 112, 112, 112),

                iconSize: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
