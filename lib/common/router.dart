import 'package:app/common/navigator_route.dart';
import 'package:app/screens/forgot_password_screen.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/screens/login_screen.dart';
import 'package:app/screens/otp_screen.dart';
import 'package:app/screens/privacy.dart';
import 'package:app/screens/signin_screen.dart';
import 'package:app/screens/terms_use.dart';
import 'package:app/screens/your_phone_screen.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case yourphone:
        return MaterialPageRoute(builder: (_) => YourPhoneScreen());
      case otpscreen:
        return MaterialPageRoute(builder: (_) => OtpScreen());
      case signin:
        return MaterialPageRoute(builder: (_) => Signin());
      case forgotpass:
        return MaterialPageRoute(builder: (_) => ForgotPassword());
      case privacy:
        return MaterialPageRoute(builder: (_) => Privacy());
      case term:
        return MaterialPageRoute(builder: (_) => TermOfUse());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
