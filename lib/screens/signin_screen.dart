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
import 'package:hexcolor/hexcolor.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final border = UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
    ),
  );

  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  Widget usernameFieldWidget() {
    return TextFormField(
      // onChanged: formValidatonColor(),
      validator: (value) {
        if (value
            ?.trim()
            .isEmpty ?? true) {
          return 'Please Enter Username';
        } else if (value!.length < 10) {
          return 'Please Enter Valid Username';
        }
        return null;
      },
      keyboardType: TextInputType.text,
      controller: usernameCtrl,
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'JosenfinSansRegular',
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      maxLength: 10,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(10)
      ],
      decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              'assets/images/user.png',
              color: Colors.white,
              // fit: BoxFit.fill,
            ),
          ),
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: border,
          contentPadding:
          new EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          focusedBorder: border,
          counterText: "",
          border: border,
          hintStyle: TextStyle(
            color: Colors.white,
            fontFamily: 'JosenfinSansRegular',
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          filled: true,
          counterStyle: TextStyle(color: Colors.white),
          suffixStyle: TextStyle(color: Colors.white),
          helperStyle: TextStyle(color: Colors.white),
          errorStyle: TextStyle(color: Colors.white),
          prefixStyle: TextStyle(color: Colors.white),
          fillColor: Colors.transparent,
          hintText: 'Username'),
    );
  }

  Widget passwordFieldWidget() {
    return TextFormField(
      // onChanged: formValidatonColor(),
      validator: (value) {
        if (value
            ?.trim()
            .isEmpty ?? true) {
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
        LengthLimitingTextInputFormatter(10)
      ],
      decoration: InputDecoration(
          prefixIcon:
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                'assets/images/lock.png',
                color: Colors.white,

          ),
            ),
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: border,
          contentPadding:
          new EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          focusedBorder: border,
          counterText: "",
          border: border,
          hintStyle: TextStyle(
            color: Colors.white,
            fontFamily: 'JosenfinSansRegular',
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          filled: true,
          counterStyle: TextStyle(color: Colors.white),
          suffixStyle: TextStyle(color: Colors.white),
          helperStyle: TextStyle(color: Colors.white),
          errorStyle: TextStyle(color: Colors.white),
          prefixStyle: TextStyle(color: Colors.white),
          fillColor: Colors.transparent,
          hintText: 'Password'),
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'JosenfinSansRegular',
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColor.lightBlue,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset('assets/images/secure_text.png',
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
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
                          textColor: Colors.white, fontSize: 28),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: AppSize().height(context) * 0.01),
                      child: Row(
                        children: [
                          getRegularText('to',
                              textColor: Colors.white, fontSize: 28),
                          SizedBox(width: AppSize().width(context) * 0.03),
                          getBoldText(AppString().securetext + '!',
                              textColor: Colors.white, fontSize: 28),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: AppSize().height(context) * 0.03,
                        // left: AppSize().width(context) * 0.1,
                        // right: AppSize().width(context) * 0.1
                      ),
                      child: getRegularText(AppString().readyToUse,
                          textColor: Colors.white, fontSize: 14),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        // left: AppSize().width(context) * 0.1,
                        // right: AppSize().width(context) * 0.1,
                          top: AppSize().height(context) * 0.01),
                      child: getRegularText(AppString().verifyPhone,
                          textColor: Colors.white, fontSize: 14),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: AppSize().height(context) * 0.05,
                        // right: AppSize().width(context) * 0.1
                      ),
                      child: usernameFieldWidget(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: AppSize().height(context) * 0.01,
                        // right: AppSize().width(context) * 0.1
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
                            locator<NavigationService>()
                                .navigateToReplace(forgotpass);
                          },
                          child: getRegularText(AppString().forgotpass,
                              textColor: Colors.white,fontSize:16),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: AppSize().height(context) * 0.03),
                      child: SizedBox(
                        width: AppSize().width(context) * 0.8,
                        child: RaisedButton(
                          color: Colors.white,
                          child: getRegularText(AppString().signin,
                              textColor: HexColor('#2291FF'),fontSize:16),
                          // child: Text(AppString().signin,
                          //     style: TextStyle(color: AppColor.lightBlue)),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: AppSize().height(context) * 0.05,
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: getRegularText(AppString().donthaveaccount,
                            textColor: Colors.white,fontSize:16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: AppSize().height(context) * 0.06,
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: SvgPicture.asset(
                          'assets/images/fingerprint.svg',
                          color: Colors.white,
                          matchTextDirection: true,
                        ),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
