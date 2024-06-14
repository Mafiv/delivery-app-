// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../Api_Connections/Api_Connections.dart';
// import '../Constants/stylingConstants.dart' as style;
// import '../Models/AllcustomerModel.dart';
// import '../AdminPage/adminFooter.dart' as adminfooter;

// class CustomersList extends StatefulWidget {
//   @override
//   _CustomersListState createState() => _CustomersListState();
// }

// class _CustomersListState extends State<CustomersList> {
//   late Future<List<Customer>> futureCustomers;

//   @override
//   void initState() {
//     super.initState();
//     futureCustomers = fetchCustomers();
//   }

//   Future<List<Customer>> fetchCustomers() async {
//     final response = await http.get(Uri.parse(API.ShowAllCustomer));
//     if (response.statusCode == 200) {
//       List<Customer> customers = [];
//       final List<dynamic> data = json.decode(response.body);
//       data.forEach((customer) {
//         customers.add(Customer.fromJson(customer));
//       });
//       return customers;
//     } else {
//       throw Exception('Failed to load customers');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           'Customers List',
//           style: TextStyle(color: Colors.white, fontSize: 20),
//         ),
//         backgroundColor: style.superColor,
//       ),
//       body: FutureBuilder<List<Customer>>(
//         future: futureCustomers,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 return _buildCustomerCard(snapshot.data![index]);
//               },
//             );
//           }
//         },
//       ),
//       bottomNavigationBar: adminfooter.CustomBottomNavigationBar() ,
//     );
//   }

//   Widget _buildCustomerCard(Customer customer) {
//     return Card(
//       margin: EdgeInsets.all(30),
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//             child: Image.memory(
//               base64Decode(customer.image),
//               width: double.infinity,
//               height: 300,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   '${customer.firstName} - ${customer.lastName}',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: style.superColor,
//                     fontSize: 20,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Username: ${customer.userName}',
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   'Gender: ${customer.gender}',
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   'Phone Number: ${customer.phoneNumber}',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: CustomersList(),
//   ));
// }
