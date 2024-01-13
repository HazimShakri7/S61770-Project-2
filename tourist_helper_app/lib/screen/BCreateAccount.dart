// ignore_for_file: prefer_const_constructors

/*Author: Hazim Shakri
 Date: 24/12/2023: 3:26 PM
*/

import 'package:flutter/material.dart';
import 'package:tourist_helper_app/screen/ASign-in.dart';
import 'package:tourist_helper_app/widget/AppBarWidget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BCreateAccount extends StatefulWidget {
  @override
  __BCreateAccountState createState() => __BCreateAccountState();
}

class __BCreateAccountState extends State<BCreateAccount> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    try {
      if (_passwordController.text.isEmpty ||
          _usernameController.text.isEmpty) {
        // Show a snackbar or display an error message for empty fields
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fields cannot be empty!')),
        );
        return; // Exit the method if any field is empty
      }

      if (_passwordController.text != _confirmPasswordController.text) {
        // Show a snackbar or display an error message for empty fields
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password does not match.')),
        );
        return; // Exit the method if any field is empty
      }

      final url = Uri.https(
        'touristhelperapplication-default-rtdb.asia-southeast1.firebasedatabase.app',
        'CreateAccount.json',
      );

      final response = await http.post(
        url,
        body: json.encode(
          {
            'username': _usernameController.text,
            'password': _passwordController.text,
          },
        ),
      );

      if (response.statusCode == 200) {
        print('User registered successfully');
        print(response.body);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return ASignIn();
          },
        ));
      } else {
        print('Failed to register user');
        // Handle registration failure
        // Show a snackbar or display an error message
      }
    } catch (error) {
      print('Error during registration: $error');
      // Handle other errors
    }
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
            Container(
              padding: const EdgeInsets.all(5.0),
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
                        Icons.account_balance_wallet_outlined,
                        size: 60.0,
                        color: Color.fromARGB(255, 0, 96, 175),
                      ),
                    ),
                    const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Stay updated with your tourist world!',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20.0),
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
                    const SizedBox(height: 20.0),
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
                    const SizedBox(height: 20.0),
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
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: TextField(
                              controller: _confirmPasswordController,
                              obscureText: !_isConfirmPasswordVisible,
                              decoration: const InputDecoration(
                                labelText: 'Confirm Password:',
                                labelStyle: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordVisible =
                                    !_isConfirmPasswordVisible;
                              });
                            },
                            icon: Icon(
                              _isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _signUp();
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
                            'Create', //When user click done button, new account is created
                            style: TextStyle(
                              fontSize: 23.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
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
