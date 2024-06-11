<<<<<<< HEAD
  import 'package:flutter/material.dart';
  import '../Components/footer.dart' as footer;
import '../Constants/stylingConstants.dart' as styles;

void main() => runApp(MyApp());
=======
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

>>>>>>> 4f987d97e37d71400c78d1f05367bf95baa5c668
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile',
      home: ProfilePage(),
    );
  }
}
<<<<<<< HEAD
=======

>>>>>>> 4f987d97e37d71400c78d1f
05367bf95baa5c668
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
<<<<<<< HEAD
   String _firstName = 'Feben';
  String _lastName = 'Alebachew';
  String _email = 'feben@gmail.com';
  String _gender = 'Female';
  String _phoneNumber = '+251909090909';

  // String _address = 'Ethiopia, Adama, Bole';

  @override
   Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),  title: const Text('Profile'),
        backgroundColor: styles.superColor,
=======
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
>>>>>>> 4f987d97e37d71400c78d1f05367bf95baa5c668
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
<<<<<<< HEAD
            // _buildProfileItem('Address', _address),
=======
            _buildProfileItem('Address', _address),
>>>>>>> 4f987d97e37d71400c78d1f05367bf95baa5c668
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
<<<<<<< HEAD
                    gender: _gender,

                    // address: _address,
=======
                    address: _address,
>>>>>>> 4f987d97e37d71400c78d1f05367bf95baa5c668
                  )),
                ).then((updatedProfile) {
                  if (updatedProfile != null) {
                    setState(() {
                      _firstName = updatedProfile.firstName;
                      _lastName = updatedProfile.lastName;
                      _email = updatedProfile.email;
                      _phoneNumber = updatedProfile.phoneNumber;
<<<<<<< HEAD
                      // _address = updatedProfile.address;
=======
                      _address = updatedProfile.address;
>>>>>>> 4f987d97e37d71400c78d1f05367bf95baa5c668
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
<<<<<<< HEAD
      bottomNavigationBar: footer.CustomBottomNavigationBar(),

    );
  }




=======
    );
  }

>>>>>>> 4f987d97e37d71400c78d1f05367bf95baa5c668
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
<<<<<<< HEAD
  final String gender;
=======
  final String address;
>>>>>>> 4f987d97e37d71400c78d1f05367bf95baa5c668

  const UpdateProfilePage({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
<<<<<<< HEAD
    required this.gender,
=======
    required this.address,
>>>>>>> 4f987d97e37d71400c78d1f05367bf95baa5c668
  });

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
<<<<<<< HEAD
  // late TextEditingController _addressController;
=======
  late TextEditingController _addressController;
>>>>>>> 4f987d97e37d71400c78d1f05367bf95baa5c668

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.firstName);
    _lastNameController = TextEditingController(text: widget.lastName);
    _emailController = TextEditingController(text: widget.email);
    _phoneNumberController = TextEditingController(text: widget.phoneNumber);
<<<<<<< HEAD
    // _genderController = TextEditingController(text: widget.phoneNumber);

    // _addressController = TextEditingController(text: widget.address);
  }
=======
    _addressController = TextEditingController(text: widget.address);
  }

>>>>>>> 4f987d97e37d71400c78d1f05367bf95baa5c668
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
<<<<<<< HEAD
            // _buildTextField(_addressController, 'Address'),
=======
            _buildTextField(_addressController, 'Address'),
>>>>>>> 4f987d97e37d71400c78d1f05367bf95baa5c668
            const SizedBox(height: 45),
            ElevatedButton(
              onPressed: () {
                String firstName = _firstNameController.text;
                String lastName = _lastNameController.text;
                String email = _emailController.text;
                String phoneNumber = _phoneNumberController.text;
<<<<<<< HEAD
                // String address = _addressController.text;
=======
                String address = _addressController.text;
>>>>>>> 4f987d97e37d71400c78d1f05367bf95baa5c668

                // Create an updated profile object
                Profile updatedProfile = Profile(
                  firstName: firstName,
                  lastName: lastName,
                  email: email,
                  phoneNumber: phoneNumber,
<<<<<<< HEAD
                  // address: address,
=======
                  address: address,
>>>>>>> 4f987d97e37d71400c78d1f05367bf95baa5c668
                );

                // Takes back to the profile viewing page and pass the updated profile object
                Navigator.pop(context, updatedProfile);
              },
              child: const Text('Save Changes'),
<<<<<<< HEAD
              style: ElevatedButton.styleFrom(backgroundColor: styles.superColor),
=======
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
>>>>>>> 4f987d97e37d71400c78d1f05367bf95baa5c668
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
<<<<<<< HEAD
          border: OutlineInputBorder(),
      ),
       );
=======
        border: OutlineInputBorder(),
      ),
    );
>>>>>>> 4f987d97e37d71400c78d1f05367bf95baa5c668
  }
}

class Profile {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
<<<<<<< HEAD
  // final String address;
=======
  final String address;
>>>>>>> 4f987d97e37d71400c78d1f05367bf95baa5c668

  Profile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
<<<<<<< HEAD
    // required this.address,
=======
    required this.address,
>>>>>>> 4f987d97e37d71400c78d1f05367bf95baa5c668
  });
}
