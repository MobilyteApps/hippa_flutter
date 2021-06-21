import 'package:app/common/navigator_route.dart';
import 'package:app/screens/chat_screen.dart';
import 'package:app/screens/create_group.dart';
import 'package:app/screens/forgot_password_screen.dart';
import 'package:app/screens/group_listing.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/screens/login_screen.dart';
import 'package:app/screens/manage_profile.dart';
import 'package:app/screens/manage_repllies.dart';
import 'package:app/screens/otp_screen.dart';
import 'package:app/screens/privacy.dart';
import 'package:app/screens/profile_screen.dart';
import 'package:app/screens/search_colleagues.dart';
import 'package:app/screens/settings.dart';
import 'package:app/screens/signin_screen.dart';
import 'package:app/screens/terms_use.dart';
import 'package:app/screens/urgent_messages.dart';
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
      case creategroup:
        return MaterialPageRoute(builder: (_) => CreateGroup());
      case grouplisting:
        return MaterialPageRoute(builder: (_) => GroupListing());
        case searchcolleagues:
        return MaterialPageRoute(builder: (_) =>SearchColleagues());
        case urgentmessages:
        return MaterialPageRoute(builder: (_) =>UrgentMessages());
        case chatscreen:
        return MaterialPageRoute(builder: (_) =>ChatScreen());
        case settingsscreen:
        return MaterialPageRoute(builder: (_) =>Settings());
        case profile:
        return MaterialPageRoute(builder: (_) =>Profile());
        case managereply:
        return MaterialPageRoute(builder: (_) =>ManageReply());
        case manageprofile:
        return MaterialPageRoute(builder: (_) =>ManageProfile());
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
