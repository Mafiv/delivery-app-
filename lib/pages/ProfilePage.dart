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
  String _firstName = 'Feben';
  String _lastName = 'Alebachew';
  String _email = 'feben@gmail.com';
  String _phoneNumber = '+251909090909';
  String _address = 'Ethiopia, Adama, Bole';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Profile'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey.shade300,
              child: const Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 20),
            Text(
              '$_firstName $_lastName',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              _email,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            _buildProfileItem('Phone Number', _phoneNumber),
            _buildProfileItem('Address', _address),
            const SizedBox(height: 45),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateProfilePage(
                    firstName: _firstName,
                    lastName: _lastName,
                    email: _email,
                    phoneNumber: _phoneNumber,
                    address: _address,
                  )),
                ).then((updatedProfile) {
                  if (updatedProfile != null) {
                    setState(() {
                      _firstName = updatedProfile.firstName;
                      _lastName = updatedProfile.lastName;
                      _email = updatedProfile.email;
                      _phoneNumber = updatedProfile.phoneNumber;
                      _address = updatedProfile.address;
                    });
                  }
                });
              },
              child: const Text('Edit Profile'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class UpdateProfilePage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String address;

  const UpdateProfilePage({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.firstName);
    _lastNameController = TextEditingController(text: widget.lastName);
    _emailController = TextEditingController(text: widget.email);
    _phoneNumberController = TextEditingController(text: widget.phoneNumber);
    _addressController = TextEditingController(text: widget.address);
  }

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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey.shade300,
              child: const Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // I will write functionality code here to change profile picture
              },
              child: const Text('Change Picture', style: TextStyle(color: Colors.purple)),
            ),
            const SizedBox(height: 30),
            _buildTextField(_firstNameController, 'First Name'),
            const SizedBox(height: 15),
            _buildTextField(_lastNameController, 'Last Name'),
            const SizedBox(height: 15),
            _buildTextField(_emailController, 'Email'),
            const SizedBox(height: 15),
            _buildTextField(_phoneNumberController, 'Phone Number'),
            const SizedBox(height: 15),
            _buildTextField(_addressController, 'Address'),
            const SizedBox(height: 45),
            ElevatedButton(
              onPressed: () {
                String firstName = _firstNameController.text;
                String lastName = _lastNameController.text;
                String email = _emailController.text;
                String phoneNumber = _phoneNumberController.text;
                String address = _addressController.text;

                // Create an updated profile object
                Profile updatedProfile = Profile(
                  firstName: firstName,
                  lastName: lastName,
                  email: email,
                  phoneNumber: phoneNumber,
                  address: address,
                );

                // Takes back to the profile viewing page and pass the updated profile object
                Navigator.pop(context, updatedProfile);
              },
              child: const Text('Save Changes'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}

class Profile {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String address;

  Profile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });
}
