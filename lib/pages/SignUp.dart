import 'package:flutter/material.dart';
import '../Constants/stylingConstants.dart' as styles;

class SignUpPage extends StatefulWidget {
  @override
  _SignUp_PageState createState() => _SignUp_PageState();
}

class _SignUp_PageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String _selectedGender = 'Male';

  void _login() {
    final username = _usernameController.text;
    final password = _passwordController.text;

    // Perform login action here, e.g., send to backend or validate locally
    print('Username: $username');
    print('Password: $password');
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
        backgroundColor:  styles.superColor,
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
                    backgroundColor:  styles.superColor,
                    padding: const EdgeInsets.all(16.0),
                  ),
                  onPressed: _login,
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
    );
  }
}
