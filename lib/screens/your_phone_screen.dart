import 'package:app/common/colors.dart';
import 'package:app/common/constants.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/common/get_it.dart';
import 'package:app/common/navigator_route.dart';
import 'package:app/common/navigator_service.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/common/get_it.dart';
import 'package:app/common/navigator_route.dart';
import 'package:app/common/navigator_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app/network/api_provider.dart';
import 'package:app/providers/signin_provider.dart';
import 'package:app/models/loader.dart';

class YourPhoneScreen extends StatefulWidget {
  @override
  _YourPhoneScreenState createState() => _YourPhoneScreenState();
}

class _YourPhoneScreenState extends State<YourPhoneScreen> {
  final border = UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColor.dark,
    ),
  );
  Loader loader = Loader();
  SignInProvider signInProvider = SignInProvider();

  final phoneCtrl = TextEditingController();
  final counrtyCtrl = TextEditingController();
  Widget countryFieldWidget() {
    return TextFormField(
      // onChanged: formValidatonColor(),
      // validator: (value) {
      //   if (value?.trim().isEmpty ?? true) {
      //     return 'Please Enter Phone Number';
      //   } else if (value!.length < 10) {
      //     return 'Please Enter Valid Phone Number';
      //   }
      //   return null;
      // },
      keyboardType: TextInputType.phone,
      controller: counrtyCtrl,
      maxLength: 4,
      style: TextStyle(
        color: AppColor.textColor,
        fontSize: 16,
        fontFamily: 'PoppinsSemiBold',
        fontWeight: FontWeight.w600,
      ),
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(4)
      ],
      decoration: InputDecoration(
          enabledBorder: border,
          contentPadding:
              new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          focusedBorder: border,
          counterText: "",
          border: border,
          hintStyle: TextStyle(
            color: AppColor.textColor,
            fontSize: 16,
            fontFamily: 'PoppinsSemiBold',
            fontWeight: FontWeight.w600,
          ),
          filled: true,
          fillColor: AppColor.transparent,
          hintText: '+91'),
    );
  }

  Widget phoneFieldWidget() {
    return TextFormField(
      // onChanged: formValidatonColor(),
      // validator: (value) {
      //   if (value?.trim().isEmpty ?? true) {
      //     return 'Please Enter Phone Number';
      //   } else if (value!.length < 10) {
      //     return 'Please Enter Valid Phone Number';
      //   }
      //   return null;
      // },
      keyboardType: TextInputType.phone,
      controller: phoneCtrl,
      maxLength: 10,
      style: TextStyle(
        color: AppColor.textColor,
        fontSize: 16,
        fontFamily: 'PoppinsSemiBold',
        fontWeight: FontWeight.w600,
      ),
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(10)
      ],
      decoration: InputDecoration(
          enabledBorder: border,
          contentPadding:
              new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          focusedBorder: border,
          counterText: "",
          border: border,
          hintStyle: TextStyle(
            color: AppColor.textColor,
            fontSize: 16,
            fontFamily: 'PoppinsSemiBold',
            fontWeight: FontWeight.w600,
          ),
          filled: true,
          fillColor: AppColor.transparent,
          hintText: '123 456 7890'),
    );
  }

  formValidation() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (counrtyCtrl.text.trim().isEmpty == true) {
      ApiProvider().showToastMsg("Please Enter valid country code");
    } else if (counrtyCtrl.text.trim() == '0') {
      ApiProvider().showToastMsg("Please Enter valid country code");
    } else if (counrtyCtrl.text.trim() == '00') {
      ApiProvider().showToastMsg("Please Enter valid country code");
    } else if (counrtyCtrl.text.trim() == '000') {
      ApiProvider().showToastMsg("Please Enter valid country code");
    } else if (phoneCtrl.text.trim().isEmpty == true) {
      ApiProvider().showToastMsg("Please Enter valid phone number");
    } else if (phoneCtrl.text.trim() == '00000') {
      ApiProvider().showToastMsg("Please Enter valid phone number");
    } else if (phoneCtrl.text.trim() == '000000') {
      ApiProvider().showToastMsg("Please Enter valid phone number");
    } else if (phoneCtrl.text.trim() == '0000000') {
      ApiProvider().showToastMsg("Please Enter valid phone number");
    } else if (phoneCtrl.text.trim() == '00000000') {
      ApiProvider().showToastMsg("Please Enter valid phone number");
    } else if (phoneCtrl.text.trim() == '0000000000') {
      ApiProvider().showToastMsg("Please Enter valid phone number");
    } else if (phoneCtrl.text.trim() == '000000000') {
      ApiProvider().showToastMsg("Please Enter valid phone number");
    }
    // else if (passwordCtrl?.text?.trim()?.isEmpty ?? true) {
    //   passwordCtrl.clear();
    //   ApiProvider().showToastMsg("Please Enter password");
    // } else if (!validatePassword(passwordCtrl?.text?.trim())) {
    //   ApiProvider().showToastMsg("Incorrect username / password");
    // }
    else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('phonenumber', phoneCtrl.text.trim());
      prefs.setString('countryCode', counrtyCtrl.text.trim());
      var input = {
        "phonenumber": phoneCtrl.text.trim(),
        "countryCode": counrtyCtrl.text.trim()
      };
      signInProvider.sendotpApi(
        loader,
        input,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#E8F4FF'),
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/tmp_1623687415135.jpg',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppSize().width(context) * 0.1,
                      right: AppSize().width(context) * 0.1),
                  child: InkWell(
                    onTap: () {},
                    child: getBoldText(AppString().yourphone,
                        fontSize: 22, textColor: AppColor.textColor),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: AppSize().height(context) * 0.01,
                      left: AppSize().width(context) * 0.1,
                      right: AppSize().width(context) * 0.1),
                  child: getRegularText(AppString().readyToUse,
                      textColor: AppColor.textColor, fontSize: 14),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppSize().width(context) * 0.1,
                      right: AppSize().width(context) * 0.1,
                      top: AppSize().height(context) * 0.01),
                  child: getRegularText(AppString().verifyPhone,
                      textColor: AppColor.textColor, fontSize: 14),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: AppSize().height(context) * 0.02,
                        left: AppSize().width(context) * 0.1,
                        right: AppSize().width(context) * 0.1),
                    child: Row(children: [
                      Expanded(
                        flex: 2,
                        // padding: EdgeInsets.only(
                        //     top: AppSize().height(context) * 0.02,
                        //     left: AppSize().width(context) * 0.1,
                        //     right: AppSize().width(context) * 0.1),
                        child: countryFieldWidget(),
                      ),
                      Expanded(
                        flex: 6,
                        // padding: EdgeInsets.only(
                        //     top: AppSize().height(context) * 0.02,
                        //     left: AppSize().width(context) * 0.1,
                        //     right: AppSize().width(context) * 0.1),
                        child: phoneFieldWidget(),
                      ),
                    ])),
                // Padding(
                //   padding: EdgeInsets.only(
                //       top: AppSize().height(context) * 0.02,
                //       left: AppSize().width(context) * 0.1,
                //       right: AppSize().width(context) * 0.1),
                //   child: phoneFieldWidget(),
                // ),
                // Padding(
                //   padding: EdgeInsets.only(
                //       top: AppSize().height(context) * 0.04,
                //       left: AppSize().width(context) * 0.1,
                //       right: AppSize().width(context) * 0.1),
                //   child: InkWell(
                //     onTap: () {
                //       formValidation();
                //       // locator<NavigationService>().navigateToReplace(otpscreen);
                //     },
                //     child: Container(
                //       width: AppSize().width(context) * 0.8,
                //       height: AppSize().height(context) * 0.06,
                //       color: AppColor.buttonColor,
                //       child: getSemiBolText(
                //         AppString().send.toUpperCase(),
                //         textColor: AppColor.white,
                //         fontSize: 14,
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(
                      top: AppSize().height(context) * 0.04,
                      left: AppSize().width(context) * 0.1,
                      right: AppSize().width(context) * 0.1),
                  child: SizedBox(
                    width: AppSize().width(context) * 0.8,
                    height: AppSize().height(context) * 0.06,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColor.buttonColor),
                      ),
                      // color: AppColor.buttonColor,
                      child: getSemiBolText(
                        AppString().send.toUpperCase(),
                        textColor: AppColor.white,
                        fontSize: 14,
                      ),
                      onPressed: () {
                        formValidation();
                        // locator<NavigationService>().navigateToReplace(otpscreen);
                      },
                    ),
                  ),
                ),
              ]),
        ),
        loader.isLoading == false
            ? Container()
            : Center(child: CircularProgressIndicator())
      ]),
    );
  }
}
