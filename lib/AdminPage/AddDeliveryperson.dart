  import 'dart:convert';
  import 'dart:io';

  import 'package:flutter/material.dart';
  import 'package:image_picker/image_picker.dart';
  import 'package:http/http.dart' as http;
  import '../Api_Connections/Api_Connections.dart';
  import 'package:fluttertoast/fluttertoast.dart';
  import '../Constants/stylingConstants.dart' as Styles;
  import '../AdminPage/adminFooter.dart' as adminfooter;
  import 'package:provider/provider.dart';
import '../Provider/userProvider.dart';

  class AddDeliveryPersonPage extends StatefulWidget {
    @override
    _AddDeliveryPersonPageState createState() => _AddDeliveryPersonPageState();
  }
  void showMessage(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

  class _AddDeliveryPersonPageState extends State<AddDeliveryPersonPage> {
    final TextEditingController _firstNameController = TextEditingController();
    final TextEditingController _lastNameController = TextEditingController();
    final TextEditingController _userNameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _phoneNumberController = TextEditingController();
    final TextEditingController _addressController = TextEditingController();
    String _selectedGender = 'Male';
    // File? _imageFile;
    String? _selectedImageBase64;
      File imageFile = File('');

    final ImagePicker _picker = ImagePicker();

    Future<void> _pickImage() async {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _selectedImageBase64 = null;
          // _imageFile = File(pickedFile.path);
        });
        final bytes = await pickedFile.readAsBytes();
        final base64Image = base64Encode(bytes);
        setState(() {
          // print(base64Image);
          _selectedImageBase64 = base64Image;
        });
      }
    }

    Future<void> _addDeliveryPerson() async {
      try {
        final request = http.MultipartRequest('POST', Uri.parse(API.AddDeliveryPerson));

        request.fields['firstName'] = _firstNameController.text;
        request.fields['lastName'] = _lastNameController.text;
        request.fields['userName'] = _userNameController.text;
        request.fields['password'] = _passwordController.text;
        request.fields['gender'] = _selectedGender;
        request.fields['phoneNumber'] = _phoneNumberController.text;
        request.fields['address'] = _addressController.text;

        if (_selectedImageBase64 != null) {
          request.fields['image'] = _selectedImageBase64!;
          // request.files.add(await http.MultipartFile.fromPath('image', _imageFile!.path));
        }


        final response = await request.send();
        if (response.statusCode == 200) {
          final responseBody = await response.stream.bytesToString();
          final decodedResponse = jsonDecode(responseBody);

          
          if (decodedResponse['success']) {
            final userProvider = Provider.of<UserProvider>(context, listen: false);
             userProvider.setAdminPage(newAdminPage: 'Home');
            
            Navigator.of(context).pop();

             showMessage(context, "Sucssess",
            "Delivery person added successfully!");

            // Fluttertoast.showToast(msg: 'Delivery person added successfully!');
            // Navigator.of(context).pop();
          } else {
            Fluttertoast.showToast(msg: 'Failed to add delivery person: ${decodedResponse['error']}');
          }
        } else {
          Fluttertoast.showToast(msg: 'Failed to add delivery person. Server returned status code: ${response.statusCode}');
        }
      } catch (e) {
        Fluttertoast.showToast(msg: 'An error occurred: $e');
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Add Delivery Person', style: TextStyle(color: Colors.white, fontSize: 20),),
        backgroundColor: Styles.superColor,

        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(labelText: 'First Name'),
                ),
                TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(labelText: 'Last Name'),
                ),
                TextField(
                  controller: _userNameController,
                  decoration: InputDecoration(labelText: 'User Name'),
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
                TextField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                ),
                TextField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                  items: ['Male', 'Female'].map((gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Gender'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Styles.superColor)),
                  onPressed: _addDeliveryPerson,
                  child: Text('Add Delivery Person', style: TextStyle(fontSize: 20,color: Colors.white),),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade300,
                    foregroundImage: _selectedImageBase64 != null ? MemoryImage(base64Decode(_selectedImageBase64!)) : null,
                    // backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                    child: Icon(Icons.camera_alt, size: 50)
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: adminfooter.CustomBottomNavigationBar() ,
      );
    }
  }
