import 'package:app/response/addusertogroup_response.dart';
import 'package:app/response/create_group_response.dart';
import 'package:app/response/delete_group_response.dart';
import 'package:app/response/getalluser_response.dart';
import 'package:app/response/groupdetail_response.dart';
import 'package:app/response/groupleave_response.dart';
import 'package:app/response/viewgrouplistingresponse.dart';
import 'package:app/screens/change_password.dart';
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
  SigninResponse userResponse = SigninResponse();
  SignoutResponse signoutresponse = SignoutResponse();
  SendOtpResponse sendotpresponse = SendOtpResponse();
  ForgotPasswordResponse forgotpassresp = ForgotPasswordResponse();
  VerifyOtpResponse verifyotpresponse = VerifyOtpResponse();
  CreateGroupResponse createGroupResponse = CreateGroupResponse();
  GetAllUserResponse getAllUserResponse = GetAllUserResponse();
  AddUsertoGroupResponse addUsertoGroupResponse = AddUsertoGroupResponse();
  DeleteGroupResponse deleteGroupResponse = DeleteGroupResponse();
  GroupDetailResponse groupDetailResponse = GroupDetailResponse();
  GroupLeaveResponse groupLeaveResponse = GroupLeaveResponse();
  ViewGroupListingResponse viewGroupListingResponse = ViewGroupListingResponse();

  loginWithEmail(Loader loader, Map<String, String> input) async {
    ApiProvider().sigInApi(loader, input).then((value) {
      if (value != null) {
        this.userResponse = value;
        // locator<NavigationService>().navigateToReplace(grouplisting);
      }
    });
  }

  forgotpasswordApi(Loader loader, Map<String, String> input) async {
    ApiProvider().forgotpassApi(loader, input).then((value) {
      if (value != null) {
        this.forgotpassresp = value;
        // locator<NavigationService>().navigateToReplace(signin);
      }
    });
  }

  signoutApi(Loader loader, Map<String, String> input) async {
    ApiProvider().signoutApi(loader, input).then((value) {
      if (value != null) {
        this.signoutresponse = value;
        // locator<NavigationService>().navigateToReplace(signin);
      }
    });
  }

  sendotpApi(Loader loader, Map<String, String> input) async {
    ApiProvider().sendOtpApi(loader, input).then((value) {
      if (value != null) {
        this.sendotpresponse = value;
        // locator<NavigationService>().navigateToReplace(otpscreen);
      }
    });
  }

  resendotpApi(Loader loader, Map<String, String> input) async {
    ApiProvider().resendOtpApi(loader, input).then((value) {
      if (value != null) {
        this.sendotpresponse = value;
        // locator<NavigationService>().navigateToReplace(otpscreen);
      }
    });
  }

  verifyOTPApi(Loader loader, Map<String, String> input) async {
    ApiProvider().verifyOtpApi(loader, input).then((value) {
      if (value != null) {
        this.userResponse = value;
        // locator<NavigationService>().navigateToReplace(grouplisting);
      }
    });
  }

  changePassword(Loader loader, Map<String, String> input) async {
    ApiProvider().changepassword(loader, input).then((value) {
      if (value != null) {
        this.verifyotpresponse = value;
        // locator<NavigationService>().navigateToReplace(grouplisting);
      }
    });
  }

  createGroup(Loader loader, Map<String, dynamic> input) async {
    ApiProvider().creategroup(loader, input).then((value) {
      if (value != null) {
        this.createGroupResponse = value;
        // locator<NavigationService>().navigateToReplace(grouplisting);
      }
    });
  }

  getallusers(Loader loader, String search) async {
    ApiProvider().getallusers(loader, search).then((value) {
      if (value != null) {
        this.getAllUserResponse = value;
        // locator<NavigationService>().navigateToReplace(grouplisting);
      }
    });
  }

  addusertogroup(Loader loader, Map<String, dynamic> input) async {
    ApiProvider().adduserstogroup(loader, input).then((value) {
      if (value != null) {
        this.addUsertoGroupResponse = value;
        // locator<NavigationService>().navigateToReplace(grouplisting);
      }
    });
  }

  deletegroup(Loader loader, Map<String, String> input) async {
    ApiProvider().deletegroup(loader, input).then((value) {
      if (value != null) {
        this.deleteGroupResponse = value;
        // locator<NavigationService>().navigateToReplace(grouplisting);
      }
    });
  }

  groupdetail(Loader loader, Map<String, String> input) async {
    ApiProvider().groupdetail(loader, input).then((value) {
      if (value != null) {
        this.groupDetailResponse = value;
        // locator<NavigationService>().navigateToReplace(grouplisting);
      }
    });
  }

  groupleave(Loader loader, Map<String, String> input) async {
    ApiProvider().groupleave(loader, input).then((value) {
      if (value != null) {
        this.groupLeaveResponse = value;
        // locator<NavigationService>().navigateToReplace(grouplisting);
      }
    });
  }

  addfav(Loader loader, Map<String, String> input) async {
    ApiProvider().addfav(loader, input).then((value) {
      if (value != null) {
        this.groupLeaveResponse = value;
        // locator<NavigationService>().navigateToReplace(grouplisting);
      }
    });
  }

  remfav(Loader loader, Map<String, String> input) async {
    ApiProvider().rewmfav(loader, input).then((value) {
      if (value != null) {
        this.groupLeaveResponse = value;
        // locator<NavigationService>().navigateToReplace(grouplisting);
      }
    });
  }

  viewgrouplist(Loader loader, Map<String, String> input) async {
    ApiProvider().viewgrouplist(loader, input).then((value) {
      if (value != null) {
        this.viewGroupListingResponse = value;
        // locator<NavigationService>().navigateToReplace(grouplisting);
      }
    });
  }
}
