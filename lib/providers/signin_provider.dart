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
  ViewGroupListingResponse viewGroupListingResponse =
      ViewGroupListingResponse();

  loginWithEmail(Loader loader, Map<String, String> input) async {
    ApiProvider().sigInApi(loader, input).then((value) {
      if (value != null) {
        this.userResponse = value;
      }
    });
  }

  forgotpasswordApi(Loader loader, Map<String, String> input) async {
    ApiProvider().forgotpassApi(loader, input).then((value) {
      if (value != null) {
        this.forgotpassresp = value;
      }
    });
  }

  signoutApi(Loader loader, Map<String, String> input) async {
    ApiProvider().signoutApi(loader, input).then((value) {
      if (value != null) {
        this.signoutresponse = value;
      }
    });
  }

  sendotpApi(Loader loader, Map<String, String> input) async {
    ApiProvider().sendOtpApi(loader, input).then((value) {
      if (value != null) {
        this.sendotpresponse = value;
      }
    });
  }

  resendotpApi(Loader loader, Map<String, String> input) async {
    ApiProvider().resendOtpApi(loader, input).then((value) {
      if (value != null) {
        this.sendotpresponse = value;
      }
    });
  }

  verifyOTPApi(Loader loader, Map<String, String> input) async {
    ApiProvider().verifyOtpApi(loader, input).then((value) {
      if (value != null) {
        this.userResponse = value;
      }
    });
  }

  changePassword(Loader loader, Map<String, String> input) async {
    ApiProvider().changepassword(loader, input).then((value) {
      if (value != null) {
        this.verifyotpresponse = value;
      }
    });
  }

  createGroup(Loader loader, Map<String, dynamic> input) async {
    ApiProvider().creategroup(loader, input).then((value) {
      if (value != null) {
        this.createGroupResponse = value;
      }
    });
  }

  getallusers(Loader loader, String search) async {
    ApiProvider().getallusers(loader, search).then((value) {
      if (value != null) {
        this.getAllUserResponse = value;
      }
    });
  }

  addusertogroup(Loader loader, Map<String, dynamic> input, String id) async {
    ApiProvider().adduserstogroup(loader, input, id).then((value) {
      if (value != null) {
        this.addUsertoGroupResponse = value;
      }
    });
  }

  deletegroup(Loader loader, Map<String, String> input) async {
    ApiProvider().deletegroup(loader, input).then((value) {
      if (value != null) {
        this.deleteGroupResponse = value;
      }
    });
  }

  groupdetail(Loader loader, Map<String, String> input) async {
    ApiProvider().groupdetail(loader, input).then((value) {
      if (value != null) {
        this.groupDetailResponse = value;
      }
    });
  }

  groupleave(Loader loader, Map<String, String> input, String id) async {
    ApiProvider().groupleave(loader, input, id).then((value) {
      if (value != null) {
        this.groupLeaveResponse = value;
      }
    });
  }

  groupleaves(Loader loader, Map<String, String> input, String id) async {
    ApiProvider().groupleaves(loader, input, id).then((value) {
      if (value != null) {
        this.groupLeaveResponse = value;
      }
    });
  }

  removegroupleave(Loader loader, Map<String, String> input) async {
    ApiProvider().removegroupleave(loader, input).then((value) {
      if (value != null) {
        this.groupLeaveResponse = value;
      }
    });
  }

  addfav(Loader loader, Map<String, String> input) async {
    ApiProvider().addfav(loader, input).then((value) {
      if (value != null) {
        this.groupLeaveResponse = value;
      }
    });
  }

  remfav(Loader loader, Map<String, String> input) async {
    ApiProvider().rewmfav(loader, input).then((value) {
      if (value != null) {
        this.groupLeaveResponse = value;
      }
    });
  }

  viewgrouplist(Loader loader, Map<String, String> input) async {
    ApiProvider().viewgrouplist(loader, input).then((value) {
      if (value != null) {
        this.viewGroupListingResponse = value;
      }
    });
  }

  updategroup(Loader loader, Map<String, String> input) async {
    ApiProvider().updategroup(loader, input).then((value) {
      if (value != null) {
        this.deleteGroupResponse = value;
      }
    });
  }
}
