import 'package:flutter/material.dart';
import 'package:stockdesign/Utilities/routes.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

//class for user Details

class Feedback {
  final String feedback;

  const Feedback({
    required this.feedback,
  });

  factory Feedback.fromJson(
    Map<String, dynamic> json,
  ) {
    return Feedback(feedback: json['feedback']);
  }
}

//class for user Details ends

Future<Feedback> createFeedback(String feedback) async {
  final response = await http.post(
    Uri.parse('http://localhost:8000/addFeedback'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'feedback': feedback,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Feedback.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to add feedback.');
  }
}

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackController = TextEditingController();
  Future<Feedback>? _futureFeedback;
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
              'Feedback Forum',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: 'Times',
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.all(15),
                child: Center(
                  child: Text(
                    "We are happy to hear from you!\nPlease feel free to write,we appreciate all kind of feedbacks or queries.",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 32,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 10,
                      textAlign: TextAlign.start,
                      controller: _feedbackController,
                      decoration: const InputDecoration(
                          //icon: Icon(Icons.feedback_sharp),
                          iconColor: Colors.orangeAccent,
                          hintText: 'Enter Your feed back here',
                          labelText: 'feedback',
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          floatingLabelStyle:
                              TextStyle(color: Colors.orangeAccent)),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(22),
                      child: TextButton.icon(
                        onPressed: (() {
                          setState(() {
                            _futureFeedback =
                                createFeedback(_feedbackController.text);
                          });
                          if (_futureFeedback != null) {
                            Navigator.pushNamed(context, MyRoutes.homeScreen);
                          }
                        }),
                        icon: const Icon(Icons.question_answer),
                        label: Container(
                          alignment: Alignment.center,
                          width: 150,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Text(
                            'Upload',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
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
                    Navigator.pushNamed(context, MyRoutes.feedbackScreen);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.feedback),
                  title: const Text("feedback"),
                  onTap: () {
                    Navigator.pop(context);
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
