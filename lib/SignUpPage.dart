import 'package:flutter/material.dart';

void main() {
  runApp(const SignUpPage());
}

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Center(
        child: Text('Sign Up Page elements will be written here'),
      ),
    );
  }
}
