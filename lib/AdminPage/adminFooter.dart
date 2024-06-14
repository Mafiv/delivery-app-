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
    final String AdminPage = userProvider.AdminPage;
    
 

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
                  userProvider.setAdminPage(newAdminPage: 'Home');
                    Navigator.pushNamed(context,'/home');

                },
                color: AdminPage == 'Home' ? style.superColor : Color.fromARGB(255, 112, 112, 112),
                iconSize: 30.0,
              ),
              IconButton(
                icon: const  Icon(Icons.category),
                onPressed: () {
                  userProvider.setAdminPage(newAdminPage: 'Detail');

                  Navigator.pushNamed(context,'/gotodetailPage');

                  /***************** */
                },
          color: AdminPage == 'Detail' ? style.superColor : Color.fromARGB(255, 112, 112, 112),

                iconSize: 30.0,
              ),
              IconButton(
                icon: const Icon(Icons.people),
                onPressed: () {
                 userProvider.setAdminPage(newAdminPage: 'CustomerList');

                Navigator.pushNamed(context,'/gotoocustomerlist');

                },
            color: AdminPage == 'CustomerList' ? style.superColor : Color.fromARGB(255, 112, 112, 112),

                iconSize: 30.0,
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                 userProvider.setAdminPage(newAdminPage: 'AddDeliveryperson');

                   Navigator.pushNamed(context,'/gotoadddeliveryperson');
                 

                  /***************** */
                },
                color: AdminPage == 'AddDeliveryperson' ? style.superColor : Color.fromARGB(255, 112, 112, 112),

                iconSize: 30.0,
              ),
                 IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  
                 userProvider.setAdminPage(newAdminPage: 'gotoaddproduct');

                   Navigator.pushNamed(context,'/gotoaddproduct');
                  
                 

                  /***************** */
                },
            color: AdminPage == 'gotoaddproduct' ? style.superColor : Color.fromARGB(255, 112, 112, 112),

                iconSize: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
