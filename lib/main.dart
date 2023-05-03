import 'package:flutter/material.dart';
import 'package:stockdesign/Screens/feedback_screen.dart';
import 'package:stockdesign/Screens/forgot_password.dart';
import 'package:stockdesign/Screens/home_screen.dart';
import 'package:stockdesign/Screens/login_screen.dart';
import 'package:stockdesign/Screens/prediction_screen.dart';
import 'package:stockdesign/Screens/signup.dart';
import 'package:stockdesign/Utilities/routes.dart';

import 'Screens/update_user.dart';

void main() => runApp(const AuthApp());

class AuthApp extends StatelessWidget {
  const AuthApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        MyRoutes.homeScreen: (context) => const HomeScreen(),
        MyRoutes.loginScreen: (context) => const LoginScreen(),
        MyRoutes.signUp: (context) => const SignUp(),
        MyRoutes.forgotPassword: (context) => const ForgotPassword(),
        MyRoutes.predictionScreen: (context) => const PredictionScreen(),
        MyRoutes.updateUser: (context) => const UpdateUser(),
        MyRoutes.feedbackScreen: (context) => const FeedbackScreen()
      },
    );
  }
}
