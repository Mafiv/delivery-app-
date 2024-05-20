import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile',
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _firstNameController = TextEditingController(text: 'feben');
  final TextEditingController _middleNameController = TextEditingController(text: 'alebachew');
  final TextEditingController _lastNameController = TextEditingController(text: 'mitku');
  final TextEditingController _emailController = TextEditingController(text: 'feben@gmail.com');
  final TextEditingController _phoneNumberController = TextEditingController(text: '+251909090909');
  final TextEditingController _passwordController = TextEditingController(text: '123456789');
  final TextEditingController _addressController = TextEditingController(text: 'Ethiopia,Adama,bole');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Edit Profile'),
        backgroundColor: Colors.purple,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: <Widget>[
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey.shade300,
            child: const Icon(Icons.person, size: 50),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              // I will write functionality code here to change profile picture-hasn't done yet
            },
            child: const Text('Change Picture', style: TextStyle(color: Colors.purple)),
          ),
          const SizedBox(height: 10),
          _buildTextField(_firstNameController, 'First Name'),const SizedBox(height: 25),
          _buildTextField(_middleNameController, 'Middle Name'),const SizedBox(height: 25),
          _buildTextField(_lastNameController, 'Last Name'),const SizedBox(height: 25),
          _buildTextField(_emailController, 'Email'),const SizedBox(height: 25),
          _buildTextField(_phoneNumberController, 'Phone Number'),const SizedBox(height: 25),
          _buildTextField(_passwordController, 'Password', isPassword: true),const SizedBox(height: 25),
          _buildTextField(_addressController, 'Address'),
          const SizedBox(height: 45),
          ElevatedButton(
            onPressed: () {
              // I will write the functionality code here to update profile when the button is clicked-hasn't done yet
            },
            child: Text('Update'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      obscureText: isPassword,
    );
  }
}
