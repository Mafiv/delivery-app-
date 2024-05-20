import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 50),

                // Logo
                Icon(
                  Icons.delivery_dining,
                  size: 100,
                ),

                // Welcome back
                Text(
                  'Welcome back, you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 50),

                // Email text field
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(18.0),
                  margin: EdgeInsets.symmetric(vertical: 18.0, horizontal: 25.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.email,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Your email address',
                            hintStyle: TextStyle(
                              fontSize: 20.0,
                              color: Colors.blueAccent.shade100,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),

                // Password text field
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(18.0),
                  margin: EdgeInsets.symmetric(vertical: 18.0, horizontal: 25.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.lock,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Your password',
                            hintStyle: TextStyle(
                              fontSize: 20.0,
                              color: Colors.blueAccent.shade100,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10.0),

                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                // Login button
                ElevatedButton(
                  onPressed: () {
                    Checking(),
                  },
                  child: Text('Log In'),
                ),
                SizedBox(height: 10.0),

                // "Or continue with" text
                Text(
                  'Or continue with',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10.0),

                // Login with Google button
                SignInButton(
                  Buttons.Google,
                  onPressed: () {
                    GoogleAccount(),
                  },
                ),

                // Sign-up link
                TextButton(
                  onPressed: () {
                    // Navigate to the sign-up page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: Text("Don't have an account? Sign up"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
