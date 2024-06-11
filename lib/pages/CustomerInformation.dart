<<<<<<< HEAD
import 'package:flutter/material.dart';
import '../Constants/DeliveryConstants.dart' as Styles;
import '../Components/informationRow.dart' as InformationRow;
import '../Models/Customer.dart' as store;
import '../Constants/stylingConstants.dart' as styles;

class MyCustomerInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CustomerScreen(),
    );
  }
}
  void goToHomepage() {
        // Navigator.pushNamed(context,'/gotoHome');
  }

class CustomerScreen extends StatelessWidget {
  final store.Customer customer = store.Customer(
    name: 'Eyob Tariku',
    email: 'eyob@eyob.com',
    phoneNumber: '123-123-123',
    address: 'Ethiopia-Adama-Bole',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: styles.superColor,

        title: Styles.customerInformationText,

        leading: IconButton(
          icon: styles.backIcon,
          onPressed: () {
            goToHomepage(); 
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Image.asset(
                'Images/LogIn.png',
                width: 150,
                height: 150,
              ),
            ),
            Styles.spaces,
            
            InformationRow.InformationRow(
              rowKey: 'Name:',
              rowValue: customer.name,
            ),
            Styles.spaces,
            InformationRow.InformationRow(
              rowKey: 'Email:',
              rowValue: customer.email,
            ),
            Styles.spaces,
            InformationRow.InformationRow(
              rowKey: 'Phone Number:',
              rowValue: customer.phoneNumber,
            ),
            Styles.spaces,
            InformationRow.InformationRow(
              rowKey: 'Address:',
              rowValue: customer.address,
            ),
          ],
        ),
      ),
    );
  }
}
=======
import 'package:flutter/material.dart';
import '../Constants/DeliveryConstants.dart' as Styles;
import '../Components/informationRow.dart' as InformationRow;
import '../Models/Customer.dart' as store;
import '../Constants/stylingConstants.dart' as styles;

class MyCustomerInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CustomerScreen(),
    );
  }
}
  void goToHomepage() {
        // Navigator.pushNamed(context,'/gotoHome');
  }

class CustomerScreen extends StatelessWidget {
  final store.Customer customer = store.Customer(
    name: 'Eyob Tariku',
    email: 'eyob@eyob.com',
    phoneNumber: '123-123-123',
    address: 'Ethiopia-Adama-Bole',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: styles.superColor,

        title: Styles.customerInformationText,

        leading: IconButton(
          icon: styles.backIcon,
          onPressed: () {
            goToHomepage(); 
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Image.asset(
                'Images/LogIn.png',
                width: 150,
                height: 150,
              ),
            ),
            Styles.spaces,
            InformationRow.InformationRow(
              rowKey: 'Name:',
              rowValue: customer.name,
            ),
            Styles.spaces,
            InformationRow.InformationRow(
              rowKey: 'Email:',
              rowValue: customer.email,
            ),
            Styles.spaces,
            InformationRow.InformationRow(
              rowKey: 'Phone Number:',
              rowValue: customer.phoneNumber,
            ),
            Styles.spaces,
            InformationRow.InformationRow(
              rowKey: 'Address:',
              rowValue: customer.address,
            ),
          ],
        ),
      ),
    );
  }
}
>>>>>>> 4f987d97e37d71400c78d1f05367bf95baa5c668
