import 'package:app/common/colors.dart';
import 'package:app/common/constants.dart';
import 'package:app/common/utils.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/common/get_it.dart';
import 'package:app/common/navigator_route.dart';
import 'package:app/common/navigator_service.dart';

import 'package:app/network/api_provider.dart';

import 'package:app/common/get_it.dart';
import 'package:app/common/navigator_route.dart';
import 'package:app/common/navigator_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app/network/api_provider.dart';
import 'package:app/providers/signin_provider.dart';
import 'package:app/models/loader.dart';

class YourEmailScreen extends StatefulWidget {
  @override
  _YourEmailScreenState createState() => _YourEmailScreenState();
}

class _YourEmailScreenState extends State<YourEmailScreen> {

  final border = UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColor.dark,
    ),
  );
Loader loader = Loader();
SignInProvider signInProvider=SignInProvider();

  final TextEditingController emailCtrl = TextEditingController();

  Widget emailFieldWidget() {
    return TextFormField(
      // onChanged: formValidatonColor(),
      // validator: (value) {
      //   if (value?.trim().isEmpty ?? true) {
      //     print('Please Enter Phone Number');
      //   } else if (value!.length < 10) {
      //      print('Please Enter Valid Phone Number');
      //   }
      //   print('hee');
      // },
      keyboardType: TextInputType.emailAddress,
      controller: emailCtrl,
      // maxLength: 10,
      style: TextStyle(
        color: AppColor.textColor,
        fontSize: 16,
        fontFamily: 'PoppinsSemiBold',
        fontWeight: FontWeight.w600,
      ),
      inputFormatters: [
        new WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9@.+-_ ]")),
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
          hintText: 'abc@yopmail.com'),
    );
  }

 formValidation() {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (emailCtrl.text.trim().isEmpty == true) {
      ApiProvider().showToastMsg("Please Enter email address");
    } else if (!validateEmail(emailCtrl.text.trim())) {
      ApiProvider().showToastMsg("Please Enter a valid email address");
    } else {
      var input = {
        "email": emailCtrl.text.trim(),
      };
      // signInProvider.loginWithEmail(loader, input);
              locator<NavigationService>().navigateToReplace(signin);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image.asset('assets/images/tmp_1623687415135.jpg',
              //     width: MediaQuery.of(context).size.width,
              //     fit: BoxFit.fitWidth),
                SizedBox(height: AppSize().height(context) * 0.1),
                    
            Align(
              alignment:Alignment.topCenter,
              child:  Image.asset(
            'assets/images/color_logo.png',
          )),
              Padding(
                padding: EdgeInsets.only(
                    left: AppSize().width(context) * 0.1,
                    right: AppSize().width(context) * 0.1),
                child: InkWell(
                  onTap: () {},
                  child: getBoldText(AppString().youremail,
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
                child: getRegularText(AppString().verifyEmail,
                    textColor: AppColor.textColor, fontSize: 14),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: AppSize().height(context) * 0.02,
                    left: AppSize().width(context) * 0.1,
                    right: AppSize().width(context) * 0.1),
                child: emailFieldWidget(),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: AppSize().height(context) * 0.04,
                    left: AppSize().width(context) * 0.1,
                    right: AppSize().width(context) * 0.1),
                child: SizedBox(
                  width: AppSize().width(context) * 0.8,
                  height: AppSize().height(context) * 0.06,
                  child: RaisedButton(
                    color: AppColor.buttonColor,
                    child: getSemiBolText(
                      AppString().send.toUpperCase(),
                      textColor: AppColor.white,
                      fontSize: 14,
                    ),
                    onPressed: () {
                      
                       formValidation();
                      // locator<NavigationService>().navigateToReplace(signin);
                    },
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
