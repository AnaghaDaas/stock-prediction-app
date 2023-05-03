import 'package:flutter/material.dart';
import 'package:stockdesign/Utilities/routes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserLogin {
  final String email;
  final String password;

  const UserLogin({required this.email, required this.password});

  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(email: json['email'], password: json['password']);
  }
}

Future<UserLogin> loginUser(String email, String password) async {
  final response = await http.post(
    Uri.parse('http://localhost:8000/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'email': email, 'password': password}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return UserLogin.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,     /
    // then throw an exception.
    throw Exception('Failed to create User.');
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
Future <UserLogin>? _futureUserLogin;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 32,
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: 'Enter Your Username/Email',
                        labelText: 'Email or Username',
                      ),
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
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextButton.icon(
                        onPressed: (() {
                          _futureUserLogin = loginUser(
                              _emailController.text, _passwordController.text);
                          if (_futureUserLogin != null) {
                            Navigator.pushNamed(context, MyRoutes.homeScreen);
                          }
                        }),
                        icon: const Icon(Icons.verified_user),
                        label: Container(
                          alignment: Alignment.center,
                          width: 150,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(25),
                          ),     
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 18,
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
                    TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        onPressed: (() {
                          Navigator.pushNamed(
                            context,
                            MyRoutes.forgotPassword,
                          );
                        }),
                        child: const Text(
                          "Forgot password",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.orangeAccent),
                        ))
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
