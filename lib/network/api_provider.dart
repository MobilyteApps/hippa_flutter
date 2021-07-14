import 'package:app/common/get_it.dart';
import 'package:app/common/navigator_route.dart';
import 'package:app/common/navigator_service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/common/colors.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:io';
import 'package:app/common/constants.dart';
import 'package:app/response/signin_response.dart';
import 'package:app/response/forgotpasword_response.dart';
import 'package:app/models/loader.dart';
import 'package:app/response/signout_response.dart';
import 'package:app/response/sendotp_response.dart';
import 'package:app/response/verify_otp_response.dart';

class ApiProvider {
  String baseurl = "http://3.142.72.8:3000/v1/auth/";
  static final ApiProvider _apiProvider = new ApiProvider._internal();
  factory ApiProvider() {
    return _apiProvider;
  }
  SigninResponse signinresponse = SigninResponse();
  SignoutResponse signoutresponse = SignoutResponse();
  ForgotPasswordResponse forgotpassword = ForgotPasswordResponse();
  SendOtpResponse sendotp = SendOtpResponse();
  VerifyOtpResponse verifyOtpresponse = VerifyOtpResponse();
  ApiProvider._internal();
  String otp = '';
  List<CameraDescription>? cameras;
  void showToastMsg(String msg) {
    Fluttertoast.showToast(
        msg: '$msg',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColor.grey,
        textColor: Colors.black,
        fontSize: 14);
  }

  void getotp(String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('code', code);
  }

  void loginstatus(String islogged) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('islogged', islogged);
  }

  Future<SigninResponse> sigInApi(
      Loader loader, Map<String, String> input) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> header = new Map();
    print("sign in api $input----${baseurl + AppString().signInUrl}");
    header["content-type"] = "application/x-www-form-urlencoded";
    loader.setloader(true);
    try {
      var postUri = Uri.parse('$baseurl' + 'signin');
      final response = await http.post(postUri, body: input, headers: header);
      print(
        " response -------------${response.body} api${response.statusCode}",
      );
      loader.setloader(false);

      if (response.statusCode == 302) {
        showToastMsg("Incorrect username / password");
      }
// Map<String, dynamic> ouptut = json.decode(response.body);
      else if (response.statusCode == 200) {
        showToastMsg('Logged in Successfully');
        loginstatus('true');
        locator<NavigationService>().navigateToReplace(changepass);

        signinresponse = SigninResponse.fromJson(json.decode(response.body));
        signinresponse.data!.user!.passwordModified == false
            ? locator<NavigationService>().navigateToReplace(changepass)
            : locator<NavigationService>().navigateToReplace(grouplisting);
        print('--');
        print(signinresponse.toJson().toString());
        // showToastMsg("token is " + signinresponse.data!.token.toString());
        // showToastMsg("Sid is " + signinresponse.data!.user!.sId.toString());
        print("token is " + signinresponse.data!.token.toString());
        print("sid is " + signinresponse.data!.user!.sId.toString());
        print('hell');
        print("karam" + signinresponse.data!.token.toString());
        String user = jsonEncode(signinresponse);
        print(user);
        //  prefs.getInt('token',response.body['data']['token']);
        //  print(response.body['data']['token'].toString());
        return signinresponse;
      } else {
        showToastMsg("Incorrect username / password");
      }
    } catch (e) {
      loader.setloader(false);
      //     showToastMsg("Sign In failed");
      // return null;
    }
    return signinresponse;
  }

  Future<ForgotPasswordResponse> forgotpassApi(
      Loader loader, Map<String, String> input) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> header = new Map();
    print("sign in api $input----${baseurl + AppString().signInUrl}");
    header["content-type"] = "application/x-www-form-urlencoded";
    loader.setloader(true);
    try {
      var postUri = Uri.parse('$baseurl' + 'forgotpassword');
      final response = await http.post(postUri, body: input, headers: header);
      print(
        " response -------------${response.body} api${response.statusCode}",
      );
      loader.setloader(false);

      if (response.statusCode == 302) {
        showToastMsg("Incorrect username");
      } else {}
      Map<String, dynamic> ouptut = json.decode(response.body);
      if (ouptut["status"] == 200) {
        showToastMsg(ouptut["message"]);
        locator<NavigationService>().navigateToReplace(signin);
        forgotpassword =
            ForgotPasswordResponse.fromJson(json.decode(response.body));
        String user = jsonEncode(forgotpassword);
        prefs.setString('user', user);
        return forgotpassword;
      } else {
        showToastMsg("Incorrect username");
      }
    } catch (e) {
      loader.setloader(false);
      //     showToastMsg("Sign In failed");
      // return null;
    }
    return forgotpassword;
  }

  Future<SignoutResponse> signoutApi(
      Loader loader, Map<String, String> input) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> header = new Map();
    print("sign in api $input----${baseurl + AppString().signInUrl}");
    loader.setloader(true);
    try {
      var postUri = Uri.parse('$baseurl' + 'signout');
      final response = await http.post(postUri, body: input, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        // 'Authorization': 'Bearer ${token}',
      });
      print(
        " response -------------${response.body} api${response.statusCode}",
      );
      loader.setloader(false);

      if (response.statusCode == 302) {
        showToastMsg("Incorrect username / password");
      } else {}
      Map<String, dynamic> ouptut = json.decode(response.body);
      if (ouptut["status"] == 200) {
        showToastMsg(ouptut["message"]);

        locator<NavigationService>().navigateToReplace(signin);
        signoutresponse = SignoutResponse.fromJson(json.decode(response.body));
        String user = jsonEncode(signoutresponse);
        prefs.setString('user', user);
        return signoutresponse;
      } else {
        showToastMsg("");
      }
    } catch (e) {
      loader.setloader(false);
      //     showToastMsg("Sign In failed");
      // return null;
    }
    return signoutresponse;
  }

  Future<SendOtpResponse> sendOtpApi(
    Loader loader,
    Map<String, String> input,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> header = new Map();
    print("sign in api $input----${baseurl + AppString().signInUrl}");
    header["content-type"] = "application/x-www-form-urlencoded";
    loader.setloader(true);
    try {
      var postUri = Uri.parse('$baseurl' + 'sendOTP');
      final response = await http.post(postUri, body: input, headers: header);
      print(
        " response -------------${response.body} api${response.statusCode}",
      );
      loader.setloader(false);

      if (response.statusCode == 302) {
        showToastMsg("");
      } else {}
      Map<String, dynamic> ouptut = json.decode(response.body);
      if (ouptut["status"] == 200) {
        showToastMsg(ouptut["message"]);

        locator<NavigationService>().navigateTo(otpscreen);
        sendotp = SendOtpResponse.fromJson(json.decode(response.body));
        showToastMsg("Otp is " + sendotp.data!.otp.toString());
        getotp(sendotp.data!.otp.toString());
        // ApiProvider().code(code: sendotp.data!.otp.toString());
        String user = jsonEncode(sendotp);
        prefs.setString('user', user);
        return sendotp;
      } else {
        loader.setloader(false);

        showToastMsg("Invalid phone number");
      }
    } catch (e) {
      loader.setloader(false);
      //     showToastMsg("Sign In failed");
      // return null;
    }
    return sendotp;
  }

  Future<SendOtpResponse> resendOtpApi(
      Loader loader, Map<String, String> input) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> header = new Map();
    print("sign in api $input----${baseurl + AppString().signInUrl}");
    header["content-type"] = "application/x-www-form-urlencoded";
    loader.setloader(true);
    try {
      var postUri = Uri.parse('$baseurl' + 'resendOTP');
      final response = await http.post(postUri, body: input, headers: header);
      print(
        " response -------------${response.body} api${response.statusCode}",
      );
      loader.setloader(false);

      if (response.statusCode == 302) {
        showToastMsg("");
      } else {}
      Map<String, dynamic> ouptut = json.decode(response.body);
      if (ouptut["status"] == 200) {
        showToastMsg(ouptut["message"]);

        locator<NavigationService>().navigateToReplace(otpscreen);
        sendotp = SendOtpResponse.fromJson(json.decode(response.body));

        showToastMsg("Otp is " + sendotp.data!.otp.toString());
        getotp(sendotp.data!.otp.toString());
        String user = jsonEncode(sendotp);
        prefs.setString('user', user);
        return sendotp;
      } else {
        showToastMsg("Try again");
        loader.setloader(false);
      }
    } catch (e) {
      loader.setloader(false);
      //     showToastMsg("Sign In failed");
      // return null;
    }
    return sendotp;
  }

  Future<VerifyOtpResponse> verifyOtpApi(
      Loader loader, Map<String, String> input) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> header = new Map();
    print("sign in api $input----${baseurl + AppString().signInUrl}");
    header["content-type"] = "application/x-www-form-urlencoded";
    loader.setloader(true);
    try {
      var postUri = Uri.parse('$baseurl' + 'verifyOTP');
      final response = await http.post(postUri, body: input, headers: header);
      print(
        " response -------------${response.body} api${response.statusCode}",
      );
      loader.setloader(false);

      if (response.statusCode == 302) {
        showToastMsg("Incorrect username / password");
      } else {}
      Map<String, dynamic> ouptut = json.decode(response.body);
      if (ouptut["status"] == 200) {
        showToastMsg(ouptut["message"]);

        locator<NavigationService>().navigateToReplace(grouplisting);
        verifyOtpresponse =
            VerifyOtpResponse.fromJson(json.decode(response.body));
        String user = jsonEncode(verifyOtpresponse);
        prefs.setString('user', user);
        return verifyOtpresponse;
      } else {
        showToastMsg("Try again");
      }
    } catch (e) {
      loader.setloader(false);
      //     showToastMsg("Sign In failed");
      // return null;
    }
    return verifyOtpresponse;
  }

  Future<VerifyOtpResponse> changepassword(
      Loader loader, Map<String, String> input) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> header = new Map();
    print("sign in api $input----${baseurl + AppString().signInUrl}");
    header["content-type"] = "application/x-www-form-urlencoded";
    loader.setloader(true);
    try {
      var postUri = Uri.parse('$baseurl' + 'changepassword');
      final response = await http.post(postUri, body: input, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${signinresponse.data!.token}',
      });
      // final response = await http.post(postUri, body: input, headers: header);
      print(
        " response -------------${response.body} api${response.statusCode}",
      );
      loader.setloader(false);

      if (response.statusCode == 302) {
        showToastMsg("Incorrect old password");
      } else {}
      Map<String, dynamic> ouptut = json.decode(response.body);
      if (ouptut["status"] == 200) {
        showToastMsg(ouptut["message"]);

        locator<NavigationService>().navigateToReplace(grouplisting);
        verifyOtpresponse =
            VerifyOtpResponse.fromJson(json.decode(response.body));
        String user = jsonEncode(verifyOtpresponse);
        prefs.setString('user', user);
        return verifyOtpresponse;
      } else {
        showToastMsg("InCorrect old Password");
      }
    } catch (e) {
      loader.setloader(false);
      //     showToastMsg("Sign In failed");
      // return null;
    }
    return verifyOtpresponse;
  }
}
