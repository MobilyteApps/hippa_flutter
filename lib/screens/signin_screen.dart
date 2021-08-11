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
import 'package:hexcolor/hexcolor.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final border = UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColor.white,
    ),
  );
  Loader loader = Loader();
  int a = 0;
  final LocalAuthentication auth = LocalAuthentication();
  bool value = false;
  bool _canCheckBiometrics = false;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool showpass = true;
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  SignInProvider signInProvider = SignInProvider();

  Widget usernameFieldWidget() {
    return TextFormField(
      validator: (value) {
        if (value?.trim().isEmpty ?? true) {
          return 'Please Enter Username';
        } else if (value!.length < 10) {
          return 'Please Enter Valid Username';
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
      inputFormatters: <TextInputFormatter>[],
      decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              'assets/images/user.png',
              color: AppColor.white,
              // fit: BoxFit.fill,
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
          hintText: 'Username/Email'),
    );
  }

  Widget passwordFieldWidget() {
    return TextFormField(
      validator: (value) {
        if (value?.trim().isEmpty ?? true) {
          return 'Please Enter Password';
        } else if (value!.length < 10) {
          return 'Please Enter Valid Password';
        }
        return null;
      },
      obscureText: showpass,
      keyboardType: TextInputType.text,
      controller: passwordCtrl,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(10)
      ],
      decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              'assets/images/lock.png',
              color: AppColor.white,
            ),
          ),
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                showpass = !showpass;
              });
            },
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: showpass == true
                    ? Icon(
                        Icons.visibility_off,
                        color: AppColor.white,
                      )
                    : Icon(
                        Icons.visibility,
                        color: AppColor.white,
                      )),
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
          hintText: 'Password'),
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
      ApiProvider().showToastMsg("Please enter email address");
    } else if (!validateEmail(usernameCtrl.text.trim())) {
      ApiProvider().showToastMsg("Please enter a valid email address");
    } else if (passwordCtrl.text.trim().isEmpty == true) {
      passwordCtrl.clear();
      ApiProvider().showToastMsg("Please Enter password");
    } else if (!validatePassword(passwordCtrl.text.trim())) {
      ApiProvider().showToastMsg("Incorrect username / password");
    } else if (value == false) {
      ApiProvider().showToastMsg("Please accept Terms and Conditions");
    } else {
      var input = {
        "email": usernameCtrl.text.trim(),
        "password": passwordCtrl.text.trim()
      };
      signInProvider.loginWithEmail(loader, input);
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

      appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: InkWell(
              onTap: () {
                locator<NavigationService>().backPress();
              },
              child: Icon(Icons.arrow_back))),
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
                      child: getRegularText(AppString().welcome,
                          textColor: AppColor.white, fontSize: 28),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: AppSize().height(context) * 0.01),
                      child: Row(
                        children: [
                          getRegularText('to',
                              textColor: AppColor.white, fontSize: 28),
                          SizedBox(width: AppSize().width(context) * 0.03),
                          getBoldText(AppString().securetext + '!',
                              textColor: AppColor.white, fontSize: 28),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: AppSize().height(context) * 0.03,
                      ),
                      child: getRegularText(AppString().readyToUse,
                          textColor: AppColor.white, fontSize: 14),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: AppSize().height(context) * 0.01),
                      child: getRegularText(AppString().verifyPhone,
                          textColor: AppColor.white, fontSize: 14),
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
                        top: AppSize().height(context) * 0.03,
                      ),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            locator<NavigationService>().navigateTo(forgotpass);
                          },
                          child: getRegularText(AppString().forgotpass,
                              textColor: AppColor.white, fontSize: 16),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                            focusColor: Colors.grey,
                            activeColor: Colors.white,
                            checkColor: Colors.blue,
                            value: this.value,
                            onChanged: (bool? value) {
                              setState(() {
                                this.value = value!;
                              });
                            }),
                        Padding(
                          padding: EdgeInsets.only(
                            top: AppSize().height(context) * 0.0,
                          ),
                          child: InkWell(
                            onTap: () {
                              locator<NavigationService>().navigateTo(privacy);
                            },
                            child: getRegularText(
                                'I agree to all Terms and Conditions',
                                textColor: AppColor.white,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: AppSize().height(context) * 0.03),
                      child: SizedBox(
                        width: AppSize().width(context) * 0.8,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              AppColor.white,
                            ),
                          ),
                          child: getRegularText(AppString().signin,
                              textColor: AppColor.buttonColor, fontSize: 16),
                          onPressed: () {
                            formValidation();
                          },
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
