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
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _firstnameController = TextEditingController();
    final TextEditingController _lastnameController = TextEditingController();
    final TextEditingController _confirmPasswordController =TextEditingController();
    final TextEditingController _phoneNumberController = TextEditingController();
    String _selectedGender = 'Male';
    String? _selectedImageBase64;
    File imageFile = File('');

    final ImagePicker _picker = ImagePicker();

    Future<void> _pickImage() async {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _selectedImageBase64 = null;
        });
        final bytes = await pickedFile.readAsBytes();
        final base64Image = base64Encode(bytes);
        setState(() {
          // print(base64Image);
          _selectedImageBase64 = base64Image;
        });
      }
    }

    Future<void> registerUser() async {
      if (_passwordController.text != _confirmPasswordController.text) {
        Fluttertoast.showToast(msg: "Passwords do not match!");
        return;
      }

      try {
        final request = http.MultipartRequest('POST', Uri.parse(API.signUp));
        request.fields['firstName'] = _firstnameController.text;
        request.fields['lastName'] = _lastnameController.text;
        request.fields['userName'] = _usernameController.text;
        request.fields['password'] = _passwordController.text;
        request.fields['gender'] = _selectedGender;
        request.fields['phoneNumber'] = _phoneNumberController.text;

        if (_selectedImageBase64 != null) {
          request.fields['image'] = _selectedImageBase64!;
        }

        final signupResponse = await request.send();
        if (signupResponse.statusCode == 200) {
          final responseBody = await signupResponse.stream.bytesToString();
          final decodedResponse = jsonDecode(responseBody);

          if (decodedResponse["success"]) {
            Fluttertoast.showToast(msg: "Congratulations, Sign Up Successful!!");
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

    Future<void> validateUserEmail() async {
      try {
        final response = await http.post(
          Uri.parse(API.validateEmail),
          body: {
            'user_name': _usernameController.text,
          },
        );

        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);
          if (responseBody["EmailFound"]) {
            Fluttertoast.showToast(
                msg: "Email is already in use, please try another one");
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
