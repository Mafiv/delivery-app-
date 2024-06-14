import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Constants/stylingConstants.dart' as style;
import '../pages/ProfilePage.dart' as ProfilePage;

class CustomBottomNavigationBar extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
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
                  Navigator.pushNamed(context, '/gotoHome');
                  /***************** */
                },
                color: style.superColor,
                iconSize: 30.0,
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.pushNamed(context, '/gotocartpage');

                  /***************** */
                },
                color: Colors.grey,
                iconSize: 30.0,
              ),
              IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () {
                  Navigator.pushNamed(context, '/gotoOrderpage');

                  /***************** */
                },
                color: Colors.grey,
                iconSize: 30.0,
              ),
              IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {
                  Navigator.pushNamed(context, '/gotoprofilepage');

                  /***************** */
                },
                color: Colors.grey,
                iconSize: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
