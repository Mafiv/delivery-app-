import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Constants/stylingConstants.dart' as styles;
import 'package:http/http.dart' as http;
import '../Api_Connections/Api_Connections.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpPage extends StatefulWidget {
  @override
  signUp_PageState createState() => signUp_PageState();
}

class signUp_PageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String _selectedGender = 'Male';
  File? _selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  registerUser() async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(API.signUp));
      request.fields['firstName'] = _firstnameController.text;
      request.fields['lastName'] = _lastnameController.text;
      request.fields['userName'] = _usernameController.text;
      request.fields['password'] = _passwordController.text;
      request.fields['gender'] = _selectedGender;
      request.fields['phoneNumber'] = _phoneNumberController.text;

      if (_selectedImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath('image', _selectedImage!.path),
        );
      }

      var signupResponse = await request.send();

      if (signupResponse.statusCode == 200) {
        var signupResponseBody = await http.Response.fromStream(signupResponse);
        var responseBody = jsonDecode(signupResponseBody.body);

        if (responseBody["success"]) {
          Fluttertoast.showToast(msg: "Congratulations, Sign Up Successfully!!");
          goToLogInPage();
        } else {
          Fluttertoast.showToast(msg: "Error Occurred, please Try Again!!");
        }
      } else {
        Fluttertoast.showToast(msg: "Server Error, please Try Again!!");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error Occurred, please Try Again!!");
    }
  }

  validateUserEmail() async {
    try {
      var response = await http.post(
        Uri.parse(API.validateEmail),
        body: {
          'user_name': _usernameController.text,
        },
      );

      if (response.statusCode == 200) {
        var responseBodyofValidateEmail = jsonDecode(response.body);
        if (responseBodyofValidateEmail["EmailFound"]) {
          Fluttertoast.showToast(
              msg: "Email is in use by someone else, please try again");
        } else {
          registerUser();
        }
      } else {
        Fluttertoast.showToast(msg: "Server error: ${response.statusCode}");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "An error occurred: ${e.toString()}");
      print(e.toString());
    }
  }

  void signIn() {
    validateUserEmail();
  }

  void goToLogInPage() {
    Navigator.pushNamed(context, '/loginPage');
  }

  void goToHomePage() {
    Navigator.pushNamed(context, '/gotoHome');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: styles.superColor,
        title: styles.signupAppBarText,
        leading: IconButton(
          icon: styles.backIcon,
          onPressed: goToHomePage,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'Images/LogIn.png',
                height: 200,
              ),
              styles.spaces,
              styles.startingText,
              styles.signupDetail,
              styles.spaces,
              styles.spaces,
              TextField(
                controller: _firstnameController,
                decoration: styles.nameDecoration,
              ),
              styles.spaces,
              TextField(
                controller: _lastnameController,
                decoration: styles.LastNameDecoration,
              ),
              styles.spaces,
              TextField(
                controller: _phoneNumberController,
                decoration: styles.phoneNumberDecoration,
              ),
              styles.spaces,
              DropdownButtonFormField<String>(
                value: _selectedGender,
                icon: const Icon(Icons.arrow_drop_down),
                decoration: styles.genderDecorate,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGender = newValue!;
                  });
                },
                items: <String>['Male', 'Female']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              styles.spaces,
              TextField(
                controller: _usernameController,
                decoration: styles.usernameDecorate,
              ),
              styles.spaces,
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: styles.passwordDecorate,
              ),
              styles.spaces,
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: styles.ConfirmPassword,
              ),
              styles.spaces,
              Container(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: styles.superColor,
                    padding: const EdgeInsets.all(16.0),
                  ),
                  onPressed: signIn,
                  child: const Text(
                    'Sign up',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              styles.spaces,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  styles.option1,
                  TextButton(
                    onPressed: goToLogInPage,
                    child: styles.logInOption,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        child: Icon(Icons.camera_alt),
        backgroundColor: styles.superColor,
      ),
    );
  }
}
