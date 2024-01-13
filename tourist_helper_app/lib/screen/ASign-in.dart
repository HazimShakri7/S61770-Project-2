// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tourist_helper_app/screen/A2ViewLocation.dart';
import 'package:tourist_helper_app/screen/BCreateAccount.dart';
import 'package:tourist_helper_app/widget/AppBarWidget.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ASignIn extends StatefulWidget {
  @override
  __ASignInState createState() => __ASignInState();
}

class __ASignInState extends State<ASignIn> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  void _login() async {
    final url = Uri.https(
        'touristhelperapplication-default-rtdb.asia-southeast1.firebasedatabase.app',
        'CreateAccount.json');

    final response = await http.get(url);
    final Map<String, dynamic> users = json.decode(response.body);
    String tempUser = "";
    // Check if the entered username and password match any user in the database
    final user = users.values.firstWhere(
      (user) {
        if (user['username'] == _usernameController.text &&
            user['password'] == _passwordController.text) {
          tempUser = _usernameController.text;
        }
        return (user['username'] == _usernameController.text &&
            user['password'] == _passwordController.text);
      },
      orElse: () => null,
    );

    if (user != null) {
      print('Sucesfully Login');
      print(tempUser);
      // Successful login, navigate to home screen or desired screen
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return A2ViewLocation(username: tempUser);
        },
      ));
    } else if (_passwordController.text.isEmpty ||
        _usernameController.text.isEmpty) {
      // Show a snackbar or display an error message for empty fields
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
      return; // Exit the method if any field is empty
    } else {
      // Handle login failure
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Account does not exist. Please create a new account.')),
      );
      print('Error Sign-in');
    }
  }

  void _navigateToCreateAccount() {
    // Navigate to create account screen here when user click 'Dont have account'
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return BCreateAccount();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      backgroundColor: const Color.fromARGB(255, 123, 210, 241),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Creating a main sign-in container
            Container(
              padding: const EdgeInsets.all(5.0), //thickness of the border
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 83, 174, 249),
                    Color.fromARGB(255, 3, 67, 196),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  children: <Widget>[
                    const CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.login,
                        size: 60.0,
                        color: Color.fromARGB(255, 0, 96, 175),
                      ),
                    ),
                    const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Stay updated with your tourist world!',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    // Rectangle box for username
                    Container(
                      width: 350.0,
                      margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            labelText: 'Username:',
                            labelStyle: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    // Rectangle box for password
                    Container(
                      width: 350.0,
                      margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                      //Stack is used to overlay(tindih) an IconButton on top of the TextField for the password.
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: !_isPasswordVisible,
                              decoration: const InputDecoration(
                                labelText: 'Password:',
                                labelStyle: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                          //Creating an oneye/offeye button at password elevatedbutton
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _login();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        onPrimary: Colors.white,
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        fixedSize: const Size(150, 40),
                      ),
                      child: Container(
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 83, 174, 249),
                              Color.fromARGB(255, 3, 67, 196),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.topRight,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: const Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 23.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      "New to Tourist Helper Application?",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: () {
                        _navigateToCreateAccount();
                      },
                      child: Text(
                        "Click Here!",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
