import 'package:flutter/material.dart';
import 'package:stockdesign/Utilities/routes.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class User {
  final String name;
  final String email;
  final String password;

  const User({required this.name, required this.email, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: json['name'], email: json['email'], password: json['password']);
  }
}

Future<User> createUser(String name, String email, String password) async {
  final response = await http.post(
    Uri.parse('http://localhost:8000/signup'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, String>{'name': name, 'email': email, 'password': password}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create User.');
  }
}

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Future<User>? _futureUser;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Image.asset(
              'assets/images/signup.png',
              fit: BoxFit.cover,
              height: 300,
              width: 350,
            ),
            const SizedBox(
              height: 20,
              width: 20,
            ),
            const Text(
              'Create Account',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Courier',
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 32,
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'Enter Your Full Name',
                      labelText: 'Full Name',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: 'Enter Your Email/Username',
                      labelText: 'Email or Username',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock),
                      hintText: 'Enter Your Password',
                      labelText: 'Password',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextButton.icon(
                      onPressed: (() {
                        //sign up
                        setState(() {
                          _futureUser = createUser(_nameController.text,
                              _emailController.text, _passwordController.text);
                              if(_futureUser!=null)
                              {
                                Navigator.pushNamed(context, MyRoutes.loginScreen);
                              }
                        });
                        
                      }),
                      icon: const Icon(Icons.create),
                      label: Container(
                        alignment: Alignment.center,
                        width: 150,
                        height: 35,
                        // ignore: sort_child_properties_last
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    // ignore: sort_child_properties_last
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: (() {
                          Navigator.pushNamed(
                            context,
                            MyRoutes.loginScreen,
                          );
                        }),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  const Text(
                    'By signing up you agree to our terms, conditions and privacy Policy.',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
