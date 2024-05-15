import 'package:flutter/material.dart';
import '../Constants/stylingConstants.dart' as style;

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
                  /***************** */
                },
                color: const Color.fromARGB(255, 130, 0, 153),
                iconSize: 30.0,
              ),
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  /***************** */
                },
                color: Colors.grey,
                iconSize: 30.0,
              ),
              IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {
                  /***************** */
                },
                color: Colors.grey,
                iconSize: 30.0,
              ),
              IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {
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
