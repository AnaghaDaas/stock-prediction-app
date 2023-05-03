import 'package:flutter/material.dart';
import 'package:stockdesign/Utilities/routes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserForgot {
  final String email;
  final String name;

  const UserForgot({required this.email, required this.name});

  factory UserForgot.fromJson(Map<String, dynamic> json) {
    return UserForgot(email: json['email'], name: json['name']);
  }
}

Future<UserForgot> ChangePassword(String email, String name) async {
  final response = await http.post(
    Uri.parse('http://localhost:8000/forgot'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'email': email, 'name': name}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return UserForgot.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create User.');
  }
}

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  Future<UserForgot>? _futureUserForgot;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/forgot.png',
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 32,
                ),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        "Forgot your password?\nNo problem type your email and username",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.redAccent),
                      ),
                    ),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: 'Enter Your Email',
                        labelText: 'Email',
                      ),
                    ),
                    TextField(
                      controller: _nameController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.lock),
                        hintText: 'Enter Your name',
                        labelText: 'name',
                      ),
                    ),
                    TextField(
                      controller: _nameController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.lock),
                        hintText: 'new password',
                        labelText: 'new password',
                      ),
                    ),
                    TextField(
                      controller: _nameController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.lock),
                        hintText: 'confirm password',
                        labelText: 'confirm password',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextButton.icon(
                        onPressed: (() {
                          _futureUserForgot = ChangePassword(
                              _emailController.text, _nameController.text);
                          if (_futureUserForgot != null) {
                            Navigator.pushNamed(context, MyRoutes.loginScreen);
                          }
                        }),
                        icon: const Icon(Icons.password_rounded),
                        label: Container(
                          alignment: Alignment.center,
                          width: 150,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Text(
                            'Change password',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account?'),
                          TextButton(
                            onPressed: (() {
                              Navigator.pushNamed(
                                context,
                                MyRoutes.signUp,
                              );
                            }),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
