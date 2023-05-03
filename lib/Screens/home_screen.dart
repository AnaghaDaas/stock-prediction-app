import 'package:flutter/material.dart';
import 'package:stockdesign/Utilities/routes.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

//class for user Details

class UserDetails {
  final String name;
  final String age;
  final String nationailty;
  final String state;
  final String sourceIncome;
  final double annualIncome;
  final double investment;
  final String target;
  final String dependants;

  const UserDetails(
      {required this.name,
      required this.age,
      required this.nationailty,
      required this.state,
      required this.sourceIncome,
      required this.annualIncome,
      required this.investment,
      required this.target,
      required this.dependants});

  factory UserDetails.fromJson(
    Map<String, dynamic> json,
  ) {
    return UserDetails(
        name: json['name'],
        age: json['age'],
        nationailty: json['nationailty'],
        state: json['state'],
        sourceIncome: json['sourceIncome'],
        annualIncome: json['annualIncome'],
        investment: json['investment'],
        target: json['target'],
        dependants: json['dependants']);
  }
}

//class for user Details ends

Future<UserDetails> createUserDetail(
    String name,
    String age,
    String nationailty,
    String state,
    String sourceIncome,
    String annualIncome,
    String investment,
    String target,
    String dependants) async {
  final response = await http.post(
    Uri.parse('http://localhost:8000/addUser'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'age': age,
      'nationailty': nationailty,
      'state': state,
      'sourceIncome': sourceIncome,
      'annualIncome': annualIncome,
      'investment': investment,
      'target': target,
      'dependants': dependants
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return UserDetails.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create User.');
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _sincomeController = TextEditingController();
  final TextEditingController _aincomeController = TextEditingController();
  final TextEditingController _investmentController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();
  final TextEditingController _dependantsController = TextEditingController();
  Future<UserDetails>? _futureUserDetail;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.red,
            centerTitle: true,
            title: const Text(
              'Set up your Profile',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: 'Times',
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(children: [
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
                        hintText: 'Enter Your Name',
                        labelText: 'Username',
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    TextField(
                      controller: _ageController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.add_circle),
                        hintText: 'Enter Your Age',
                        labelText: 'age',
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    TextField(
                      controller: _nationalityController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.place),
                        hintText: 'Enter Your Nationality',
                        labelText: 'Nationailty',
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    TextField(
                      controller: _stateController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.location_city),
                        hintText: 'Enter Your State',
                        labelText: 'State',
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    TextField(
                      controller: _sincomeController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.money),
                        hintText: 'Enter Your Source of Income',
                        labelText: 'Source of Income',
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    TextField(
                      controller: _aincomeController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.money_outlined),
                        hintText: 'Enter Your Annual Income',
                        labelText: 'Annual Income',
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    TextField(
                      controller: _investmentController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.attach_money),
                        hintText: 'Enter Your Investment Amount',
                        labelText: 'Investment Amount',
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    TextField(
                      controller: _targetController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.badge),
                        hintText: 'Enter Your Target Level',
                        labelText: 'Target Level',
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    TextField(
                      controller: _dependantsController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.group),
                        hintText: 'Enter number of dependants',
                        labelText: 'No: of dependants',
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextButton.icon(
                        onPressed: (() {
                          setState(() {
                            _futureUserDetail = createUserDetail(
                                _nameController.text,
                                _ageController.text,
                                _nationalityController.text,
                                _stateController.text,
                                _sincomeController.text,
                                _aincomeController.text,
                                _investmentController.text,
                                _targetController.text,
                                _dependantsController.text);
                          });
                          if (_futureUserDetail != null) {
                            Navigator.pushNamed(
                                context, MyRoutes.predictionScreen);
                          }
                        }),
                        icon: const Icon(Icons.login),
                        label: Container(
                          alignment: Alignment.center,
                          width: 150,
                          height: 35,
                          child: const Text(
                            'Submit',
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
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
