import 'package:flutter/material.dart';

const superColor = Color.fromARGB(255, 86, 1, 119);
const toPadding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0);
const TextStyle toHintText =
    TextStyle(color: Color.fromARGB(179, 240, 238, 238));
const toFillSearchArea = Color.fromARGB(59, 241, 241, 241);
const inputStyle =
    TextStyle(color: Colors.white, decoration: TextDecoration.none);
const SearchIconStyle = Icon(Icons.search, color: Colors.white);

/***for footer part */
const BoxDecoration for_footer = BoxDecoration(
  border: Border(
    top: BorderSide(
      color: superColor,
      width: 5.0,
    ),
  ),
);

/* styles to the login page */
const Text welcomeText = Text(
  'Welcome Back!',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: superColor,
  ),
);

const Text welcomeDetail = Text(
  'Welcome back, we missed you!',
  style: TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 0, 0, 0),
  ),
);

const SizedBox spaces = SizedBox(height: 16);

const InputDecoration passwordDecorate = InputDecoration(
  labelText: 'Password',
  border: OutlineInputBorder(),
  prefixIcon: Icon(Icons.vpn_key, color: superColor),
);

const InputDecoration usernameDecorate = InputDecoration(
  labelText: 'Username',
  border: OutlineInputBorder(),
  prefixIcon: Icon(Icons.email, color: superColor),
);

const InputDecoration phoneNumberDecoration = InputDecoration(
  labelText: 'Phone Number',
  border: OutlineInputBorder(),
  prefixIcon: Icon(Icons.phone, color: superColor),
);

const Text Option = Text('Don’t have an account?');
const Text signUp_option = Text(
  'Sign up',
  style: TextStyle(
    color: superColor,
  ),
);

/*styles to sign up page */
const Text startingText = Text(
  'Get started for free!',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: superColor,
  ),
);

const Text signupDetail = Text(
  'Create Account for free',
  style: TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 0, 0, 0),
  ),
);

const InputDecoration ConfirmPassword = InputDecoration(
  labelText: 'Confirm Password',
  border: OutlineInputBorder(),
  prefixIcon: Icon(Icons.vpn_key, color: superColor),
);

const InputDecoration nameDecoration = InputDecoration(
  labelText: 'First Name',
  border: OutlineInputBorder(),
  prefixIcon: Icon(Icons.account_box, color: superColor),
);

const InputDecoration LastNameDecoration = InputDecoration(
  labelText: 'Last Name',
  border: OutlineInputBorder(),
  prefixIcon: Icon(
    Icons.account_box,
    color: superColor,
  ),
);

const Text option1 = Text('Already  have an Account ?');
const Text logInOption = Text(
  'Log in',
  style: TextStyle(
    color: superColor,
  ),
);

const InputDecoration genderDecorate = InputDecoration(
  labelText: 'Gender',
  border: OutlineInputBorder(),
  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
);

/*for login and sign up app bar */
const Icon backIcon = Icon(Icons.arrow_back, color: Colors.white);
const Text loginAppBarText =
    Text('Login', style: TextStyle(color: Colors.white));
const Text signupAppBarText =
    Text('Sign up', style: TextStyle(color: Colors.white));

/*for customer Information Page */
