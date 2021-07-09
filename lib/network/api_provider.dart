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
  String signiurl = "http://3.142.72.8:3000/v1/auth/signin";
  static final ApiProvider _apiProvider = new ApiProvider._internal();
  factory ApiProvider() {
    return _apiProvider;
  }
SigninResponse signinresponse= SigninResponse();
SignoutResponse signoutresponse = SignoutResponse();
ForgotPasswordResponse forgotpassword = ForgotPasswordResponse();
SendOtpResponse sendOtpresponse = SendOtpResponse();
VerifyOtpResponse verifyOtpresponse = VerifyOtpResponse();
  ApiProvider._internal();

  void showToastMsg(String msg) {
    Fluttertoast.showToast(
        msg: '$msg',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColor.grey,
        textColor: Colors.black,
        fontSize: 14);
  }

   Future<SigninResponse> sigInApi(
      Loader loader, Map<String, String> input) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> header = new Map();
    print("sign in api $input----${baseurl + AppString().signInUrl}");
    header["content-type"] = "application/x-www-form-urlencoded";
    loader.setloader(true);
    try {
      var postUri = Uri.parse(
          '$baseurl' + 'signin' );
      final response =
          await http.post(postUri, body: input, headers: header);
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
        signinresponse =
            SigninResponse.fromJson(json.decode(response.body));
            print('hell');
        print("karam"+signinresponse.data!.token.toString());
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
      var postUri = Uri.parse(
          '$baseurl' + 'forgotpassword' );
      final response =
          await http.post(postUri, body: input, headers: header);
      print(
        " response -------------${response.body} api${response.statusCode}",
      );
      loader.setloader(false);
      

      if (response.statusCode == 302) {
        showToastMsg("Incorrect username / password");
      } else {
       
      }
Map<String, dynamic> ouptut = json.decode(response.body);
      if (ouptut["status"] == 200) {
        showToastMsg(ouptut["message"]);
        ForgotPasswordResponse userRes =
            ForgotPasswordResponse.fromJson(json.decode(response.body));
        String user = jsonEncode(userRes);
        prefs.setString('user', user);
        return userRes;
      } else {
        showToastMsg("Incorrect username / password");
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
      var postUri = Uri.parse(
          '$baseurl' + 'signout' );
      final response =
          await http.post(postUri, body: input,  headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Accept': 'application/json',
            // 'Authorization': 'Bearer ${token}',
          });;
      print(
        " response -------------${response.body} api${response.statusCode}",
      );
      loader.setloader(false);
      

      if (response.statusCode == 302) {
        showToastMsg("Incorrect username / password");
      } else {
       
      }
Map<String, dynamic> ouptut = json.decode(response.body);
      if (ouptut["status"] == 200) {
        showToastMsg(ouptut["message"]);
        SignoutResponse userRes =
            SignoutResponse.fromJson(json.decode(response.body));
        String user = jsonEncode(userRes);
        prefs.setString('user', user);
        return userRes;
      } else {
        showToastMsg("Incorrect username / password");
      }
    } catch (e) {
      loader.setloader(false);
      //     showToastMsg("Sign In failed");
      // return null;
    }
    return signoutresponse;
  }


  Future<SendOtpResponse> sendOtpApi(
      Loader loader, Map<String, String> input,) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> header = new Map();
    print("sign in api $input----${baseurl + AppString().signInUrl}");
    header["content-type"] = "application/x-www-form-urlencoded";
    loader.setloader(true);
    try {
      var postUri = Uri.parse(
          '$baseurl' + 'sendOTP' );
      final response =
          await http.post(postUri, body: input, headers: header);
      print(
        " response -------------${response.body} api${response.statusCode}",
      );
      loader.setloader(false);
      

      if (response.statusCode == 302) {
        showToastMsg("Incorrect username / password");
      } else {
       
      }
Map<String, dynamic> ouptut = json.decode(response.body);
      if (ouptut["status"] == 200) {
        showToastMsg(ouptut["message"]);
        SendOtpResponse sendotp =
            SendOtpResponse.fromJson(json.decode(response.body));
        String user = jsonEncode(sendotp);
        prefs.setString('user', user);
        return sendotp;
      } else {
        showToastMsg("Incorrect username / password");
      }
    } catch (e) {
      loader.setloader(false);
      //     showToastMsg("Sign In failed");
      // return null;
    }
    return sendOtpresponse;
  }

  Future<SendOtpResponse> resendOtpApi(
      Loader loader, Map<String, String> input) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> header = new Map();
    print("sign in api $input----${baseurl + AppString().signInUrl}");
    header["content-type"] = "application/x-www-form-urlencoded";
    loader.setloader(true);
    try {
      var postUri = Uri.parse(
          '$baseurl' + 'resendOTP' );
      final response =
          await http.post(postUri, body: input, headers: header);
      print(
        " response -------------${response.body} api${response.statusCode}",
      );
      loader.setloader(false);
      

      if (response.statusCode == 302) {
        showToastMsg("Incorrect username / password");
      } else {
       
      }
Map<String, dynamic> ouptut = json.decode(response.body);
      if (ouptut["status"] == 200) {
        showToastMsg(ouptut["message"]);
        SendOtpResponse sendotp =
            SendOtpResponse.fromJson(json.decode(response.body));
        String user = jsonEncode(sendotp);
        prefs.setString('user', user);
        return sendotp;
      } else {
        showToastMsg("Incorrect username / password");
      }
    } catch (e) {
      loader.setloader(false);
      //     showToastMsg("Sign In failed");
      // return null;
    }
    return sendOtpresponse;
  }
 
 Future<VerifyOtpResponse> verifyOtpApi(
      Loader loader, Map<String, String> input) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> header = new Map();
    print("sign in api $input----${baseurl + AppString().signInUrl}");
    header["content-type"] = "application/x-www-form-urlencoded";
    loader.setloader(true);
    try {
      var postUri = Uri.parse(
          '$baseurl' + 'verifyOTP' );
      final response =
          await http.post(postUri, body: input, headers: header);
      print(
        " response -------------${response.body} api${response.statusCode}",
      );
      loader.setloader(false);
      

      if (response.statusCode == 302) {
        showToastMsg("Incorrect username / password");
      } else {
       
      }
Map<String, dynamic> ouptut = json.decode(response.body);
      if (ouptut["status"] == 200) {
        showToastMsg(ouptut["message"]);
        VerifyOtpResponse verifyotp =
            VerifyOtpResponse.fromJson(json.decode(response.body));
        String user = jsonEncode(verifyotp);
        prefs.setString('user', user);
        return verifyotp;
      } else {
        showToastMsg("Incorrect username / password");
      }
    } catch (e) {
      loader.setloader(false);
      //     showToastMsg("Sign In failed");
      // return null;
    }
    return verifyOtpresponse;
  }
 

}