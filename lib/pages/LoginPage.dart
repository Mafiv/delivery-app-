import 'package:flutter/material.dart';
import '../Constants/stylingConstants.dart' as styles;


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void log_in() {
    final username = _usernameController.text;
    final password = _passwordController.text;

    // Perform login action here, e.g., send to backend or validate locally
    print('Username: $username');
    print('Password: $password');
  }

  void goTosignUpPage() {
    Navigator.pushNamed(context,'/signupPage');
  }
   void goToHomepage() {
        Navigator.pushNamed(context,'/gotoHome');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: styles.superColor,
        title: styles.loginAppBarText,
        leading: IconButton(
          icon: styles.backIcon,
          onPressed: () {
            goToHomepage(); 
          },
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
              styles.welcomeText,
              styles.welcomeDetail,
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
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor:  styles.superColor,
                    padding: const EdgeInsets.all(16.0),
                  ),
                  onPressed: log_in,
                  child: const Text('Login',style: TextStyle(color: Colors.white)),
                ),
              ),
              styles.spaces,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  styles.Option,
                  TextButton(
                    onPressed: goTosignUpPage,
                    child: styles.signUp_option,
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
