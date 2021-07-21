import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/common/colors.dart';
import 'package:app/common/constants.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:flutter/services.dart';
import 'package:app/common/get_it.dart';
import 'package:app/common/navigator_route.dart';
import 'package:app/common/navigator_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app/network/api_provider.dart';
import 'package:app/providers/signin_provider.dart';
import 'package:app/models/loader.dart';
import 'package:app/common/utils.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_auth_invisible/flutter_local_auth_invisible.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final border = UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColor.white,
    ),
  );
  ApiProvider apis = ApiProvider();
  Loader loader = Loader();
  int a = 0;
  final LocalAuthentication auth = LocalAuthentication();
  bool value = false;
  bool _canCheckBiometrics = false;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';

  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  SignInProvider signInProvider = SignInProvider();

  Widget usernameFieldWidget() {
    return TextFormField(
      // onChanged: formValidatonColor(),
      validator: (value) {
        if (value?.trim().isEmpty ?? true) {
          return 'Please Enter Password';
        } else if (value!.length < 10) {
          return 'Please Enter Valid Password';
        }
        return null;
      },
      keyboardType: TextInputType.text,
      controller: usernameCtrl,
      style: TextStyle(
        color: AppColor.white,
        fontFamily: 'JosenfinSansRegular',
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      // maxLength: 10,
      inputFormatters: <TextInputFormatter>[
        // LengthLimitingTextInputFormatter(10)
      ],
      decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              'assets/images/lock.png',
              color: AppColor.white,
            ),
          ),
          labelStyle: TextStyle(color: AppColor.white),
          enabledBorder: border,
          contentPadding:
              new EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          focusedBorder: border,
          counterText: "",
          border: border,
          hintStyle: TextStyle(
            color: AppColor.white,
            fontFamily: 'JosenfinSansRegular',
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          filled: true,
          counterStyle: TextStyle(color: AppColor.white),
          suffixStyle: TextStyle(color: AppColor.white),
          helperStyle: TextStyle(color: AppColor.white),
          errorStyle: TextStyle(color: AppColor.white),
          prefixStyle: TextStyle(color: AppColor.white),
          fillColor: AppColor.transparent,
          hintText: 'Old Password'),
    );
  }

  Widget passwordFieldWidget() {
    return TextFormField(
      // onChanged: formValidatonColor(),
      validator: (value) {
        if (value?.trim().isEmpty ?? true) {
          return 'Please Enter Password';
        } else if (value!.length < 10) {
          return 'Please Enter Valid Password';
        }
        return null;
      },
      keyboardType: TextInputType.text,
      controller: passwordCtrl,
      maxLength: 10,
      inputFormatters: <TextInputFormatter>[
        // LengthLimitingTextInputFormatter(10)
      ],
      decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              'assets/images/lock.png',
              color: AppColor.white,
            ),
          ),
          labelStyle: TextStyle(color: AppColor.white),
          enabledBorder: border,
          contentPadding:
              new EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          focusedBorder: border,
          counterText: "",
          border: border,
          hintStyle: TextStyle(
            color: AppColor.white,
            fontFamily: 'JosenfinSansRegular',
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          filled: true,
          counterStyle: TextStyle(color: AppColor.white),
          suffixStyle: TextStyle(color: AppColor.white),
          helperStyle: TextStyle(color: AppColor.white),
          errorStyle: TextStyle(color: AppColor.white),
          prefixStyle: TextStyle(color: AppColor.white),
          fillColor: AppColor.transparent,
          hintText: 'New Password'),
      style: TextStyle(
        color: AppColor.white,
        fontFamily: 'JosenfinSansRegular',
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
    );
  }

  formValidation() {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (usernameCtrl.text.trim().isEmpty == true) {
      ApiProvider().showToastMsg("Please Enter old Password address");
    } else if (passwordCtrl.text.trim().isEmpty == true) {
      passwordCtrl.clear();
      ApiProvider().showToastMsg("Please Enter New password");
    } else {
      var input = {
        "newPassword": passwordCtrl.text.trim(),
        "oldPassword": usernameCtrl.text.trim(),
        "_id": apis.signinresponse.data!.user!.sId!.toString(),
      };
      signInProvider.changePassword(loader, input);
    }
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      ApiProvider().showToastMsg("Fingerprint scanning starts");
      authenticated = await auth.authenticateWithBiometrics(
        localizedReason: 'Scan your fingerprint to authenticate',
        useErrorDialogs: true,
        stickyAuth: false,
      );
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _authorized = authenticated ? 'Authorized' : 'Not Authorized';
    });
    if (_authorized == 'Authorized') {
      ApiProvider().showToastMsg("Scanned successfully");
      locator<NavigationService>().navigateToReplace(grouplisting);
    } else {
      ApiProvider().showToastMsg("Try again");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColor.lightBlue,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset('assets/images/secure_text.png',
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill),
            Padding(
              padding: EdgeInsets.only(
                  left: AppSize().width(context) * 0.1,
                  right: AppSize().width(context) * 0.1),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppSize().height(context) * 0.1),
                    Padding(
                      padding: EdgeInsets.only(
                          top: AppSize().height(context) * 0.01),
                      child: getRegularText('Change Password',
                          textColor: AppColor.white, fontSize: 28),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: AppSize().height(context) * 0.05,
                      ),
                      child: usernameFieldWidget(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: AppSize().height(context) * 0.01,
                      ),
                      child: passwordFieldWidget(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: AppSize().height(context) * 0.03),
                      child: SizedBox(
                        width: AppSize().width(context) * 0.8,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColor.white),
                          ),
                          child: getRegularText(AppString().signin,
                              textColor: AppColor.buttonColor, fontSize: 16),
                          onPressed: () {
                            formValidation();
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: AppSize().height(context) * 0.06,
                      ),
                      child: InkWell(
                        onTap: () {
                          _authenticate();
                        },
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: SvgPicture.asset(
                            'assets/images/fingerprint.svg',
                            color: AppColor.white,
                            matchTextDirection: true,
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
            loader.isLoading == false
                ? Container()
                : Center(child: CircularProgressIndicator())
          ],
        ),
      ),
    );
  }
}
