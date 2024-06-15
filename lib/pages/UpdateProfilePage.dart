import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:typed_data';
import '../Constants/stylingConstants.dart' as styles;
import '../Api_Connections/Api_Connections.dart';
import './ProfilePage.dart' as ProfilePage;
import '../Models/profileModel.dart';

class UpdateProfilePage extends StatefulWidget {
  final String userId;
  final Profile profile;

  UpdateProfilePage({required this.userId, required this.profile});

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _userNameController;
  late TextEditingController _genderController;
  late TextEditingController _phoneNumberController;

  Uint8List? _profileImage;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.profile.firstName);
    _lastNameController = TextEditingController(text: widget.profile.lastName);
    _userNameController = TextEditingController(text: widget.profile.username);
    _genderController = TextEditingController(text: widget.profile.gender);

    _phoneNumberController =
        TextEditingController(text: widget.profile.phoneNumber);
    if (widget.profile.image != null) {
      _profileImage = base64Decode(widget.profile.image!);
    }
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _profileImage = bytes;
      });
    }
  }

  Future<void> updateProfile() async {
    String? base64Image;
    if (_profileImage != null) {
      base64Image = base64Encode(_profileImage!);
    }

    final updatedProfile = Profile(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      username: _userNameController.text,
      gender: _genderController.text,
      phoneNumber: _phoneNumberController.text,
      image: base64Image,
    );

    final response = await http.post(
      Uri.parse(API.upDateProfile),
      body: {
        'user_id': widget.userId,
        'firstName': updatedProfile.firstName,
        'lastName': updatedProfile.lastName,
        'userName': updatedProfile.username,
        'password': "123",
        'gender': updatedProfile.gender,
        'phoneNumber': updatedProfile.phoneNumber,
        'image': base64Image ?? '',
      },
    );

    if (response.statusCode == 200) {
      print("Profile updated successfully");
      print(json.decode(response.body));

      final responseBody = json.decode(response.body);
      print(responseBody['error']);
      if (responseBody['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully')));

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(responseBody['message'])));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to update profile')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: styles.superColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: _profileImage != null
                      ? MemoryImage(_profileImage!)
                      : null,
                  child: _profileImage == null
                      ? const Icon(Icons.camera_alt, size: 50)
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _userNameController,
                decoration: InputDecoration(
                  labelText: 'User Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _genderController,
                decoration: InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateProfile,
                child: const Text('Update Profile',style: TextStyle(color: Colors.white, fontSize: 16),),
                style: ElevatedButton.styleFrom(
                    backgroundColor: styles.superColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
