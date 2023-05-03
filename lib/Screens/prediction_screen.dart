import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../Utilities/routes.dart';

class Company {
  String? companyName;
  String? companyDescription;

  Company({
    this.companyName,
    this.companyDescription,
  });

  Company.fromJson(Map<String, dynamic> json) {
    companyName = json['companyName'];
    companyDescription = json['companyDescription'];
  }

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['companyName'] = companyName;
    data['companyDescription'] = companyDescription;
    return data;
  }
}

Future<List<Company>> getCompanyDetails() async {
  //replace your restFull API here.
  String url = "http://localhost:8000/reccomendations";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final List responseData = json.decode(response.body);
    return responseData.map((e) => Company.fromJson(e)).toList();
  } else {
    throw Exception("fail to load data");
  }
}

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({Key? key}) : super(key: key);

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  Future<List<Company>>? _futureCompanies;

  @override
  void initState() {
    super.initState();
    _futureCompanies = getCompanyDetails();
    // Or call your function here
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(),
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              const Positioned(
                left: 24.0,
                top: 24.0,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Center(
                    child: Text(
                      "Reccommended Companies",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(children: [
                  Center(
                    child: FutureBuilder<List<Company>>(
                      future: getCompanyDetails(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.all(28),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  snapshot.data![index].companyName.toString(),
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: AutofillHints.jobTitle,
                                      fontWeight: FontWeight.bold),
                                ),
                                contentPadding: const EdgeInsets.all(4),
                                tileColor:
                                    const Color.fromARGB(153, 247, 247, 247),
                                // hoverColor: Colors.green,
                                textColor:
                                    const Color.fromARGB(255, 50, 49, 49),
                                shape: const Border(
                                  bottom: BorderSide(
                                    color: Color.fromARGB(255, 106, 167, 117),
                                    width: 0.8,
                                  ),
                                ),
                                visualDensity: VisualDensity.lerp(
                                    VisualDensity.adaptivePlatformDensity,
                                    VisualDensity.standard,
                                    0.3),
                                subtitle: Text(
                                  snapshot.data![index].companyDescription
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic),
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                  ),
                ]),
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                const UserAccountsDrawerHeader(
                  accountName: Text("STOCK RECOMMENDATION"),
                  accountEmail: Text("Let us guide you!"),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.orange,
                    child: Text(
                      "S",
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text("Home"),
                  onTap: () {
                    Navigator.pushNamed(context, MyRoutes.predictionScreen);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.contacts),
                  title: const Text("Update details"),
                  onTap: () {
                    Navigator.pushNamed(context, MyRoutes.updateUser);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.feedback),
                  title: const Text("feedback"),
                  onTap: () {
                    Navigator.pushNamed(context, MyRoutes.feedbackScreen);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text("logout"),
                  onTap: () {
                    Navigator.pushNamed(context, MyRoutes.loginScreen);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
