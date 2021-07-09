import 'package:flutter/material.dart';
import 'package:app/common/constants.dart';
import 'package:app/response/signin_response.dart';
import 'package:app/network/api_provider.dart';
import 'package:app/common/navigator_route.dart';
import 'package:app/common/navigator_service.dart';
import 'package:app/models/loader.dart';
import 'package:app/common/get_it.dart';
import 'dart:core';
import 'package:app/response/forgotpasword_response.dart';
import 'package:app/response/signout_response.dart';

import 'package:app/response/signout_response.dart';
import 'package:app/response/sendotp_response.dart';
import 'package:app/response/verify_otp_response.dart';
import 'package:app/response/sendotp_response.dart';
class SignInProvider with ChangeNotifier {
  SigninResponse userResponse= SigninResponse();
  SignoutResponse signoutresponse = SignoutResponse();
  SendOtpResponse sendotpresponse = SendOtpResponse();
  ForgotPasswordResponse forgotpassresp = ForgotPasswordResponse();
VerifyOtpResponse verifyotpresponse = VerifyOtpResponse();
    loginWithEmail(Loader loader, Map<String, String> input) async {
   ApiProvider().sigInApi(loader, input).then((value) {
      if (value != null) {
        this.userResponse = value;
        locator<NavigationService>().navigateToReplace(grouplisting);
      }
    });
  }


  
    forgotpasswordApi(Loader loader, Map<String, String> input) async {
   ApiProvider().forgotpassApi(loader, input).then((value) {
      if (value != null) {
        this.forgotpassresp = value;
        locator<NavigationService>().navigateToReplace(signin);
      }
    });
  }

      signoutApi(Loader loader, Map<String, String> input) async {
   ApiProvider().signoutApi(loader, input).then((value) {
      if (value != null) {
        this.signoutresponse = value;
        locator<NavigationService>().navigateToReplace(signin);
      }
    });
  }

        sendotpApi(Loader loader, Map<String, String> input) async {
  
   ApiProvider().sendOtpApi(loader, input).then((value) {
      if (value != null) {
        this.sendotpresponse = value;
        locator<NavigationService>().navigateToReplace(otpscreen);
      }
    });
  
  }

       resendotpApi(Loader loader, Map<String, String> input) async {
  
   ApiProvider().resendOtpApi(loader, input).then((value) {
      if (value != null) {
        this.sendotpresponse = value;
        locator<NavigationService>().navigateToReplace(otpscreen);
      }
    });
  
  }


       verifyOTPApi(Loader loader, Map<String, String> input) async {
   ApiProvider().verifyOtpApi(loader, input).then((value) {
      if (value != null) {
        this.verifyotpresponse = value;
        locator<NavigationService>().navigateToReplace(grouplisting);
      }
    });
  }
}