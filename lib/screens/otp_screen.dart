import 'package:app/response/sendotp_response.dart';
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

import 'package:app/common/get_it.dart';
import 'package:app/common/navigator_route.dart';
import 'package:app/common/navigator_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app/network/api_provider.dart';
import 'package:app/providers/signin_provider.dart';
import 'package:app/models/loader.dart';
import 'package:app/common/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  ApiProvider a = ApiProvider();
  final border = UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColor.dark,
    ),
  );
  int ab = 0;

  Loader loader = Loader();
  SignInProvider signInProvider = SignInProvider();
  final codeCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    codeCtrl.text = '';
    Future.delayed(Duration(seconds: 5), () {
      getotp();
    });
  }

  void getotp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  Widget codeFieldWidget() {
    return TextFormField(
      validator: (value) {
        if (value?.trim().isEmpty ?? true) {
          return 'Please Enter Code';
        } else if (value!.length < 6) {
          return 'Please Enter Valid Code';
        }
        return null;
      },
      keyboardType: TextInputType.phone,
      controller: codeCtrl,
      // enabled: false,
      style: TextStyle(
        color: AppColor.textColor,
        fontSize: 16,
        fontFamily: 'PoppinsSemiBold',
        fontWeight: FontWeight.w600,
      ),
      maxLength: 6,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(6),
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
          hintText: 'Code'),
    );
  }

  formValidation() async {
    FocusScope.of(context).requestFocus(new FocusNode());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('phonenumber'));
    print(prefs.getString('countryCode'));
    var input = {
      "phonenumber": "${prefs.getString('phonenumber')}",
      "countryCode": "${prefs.getString('countryCode')}"
    };
    signInProvider.resendotpApi(
      loader,
      input,
    );
  }

  verifyValidation() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (codeCtrl.text.trim().isEmpty == true) {
      ApiProvider().showToastMsg("Please Enter 6 digit Otp");
    } else if (codeCtrl.text.trim().length < 6) {
      ApiProvider().showToastMsg("Please Enter 6 digit Otp");
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(prefs.getString('phonenumber'));
      print(prefs.getString('countryCode'));
      var input = {
        "phonenumber": "${prefs.getString('phonenumber')}",
        "countryCode": "${prefs.getString('countryCode')}",
        "otp": codeCtrl.text
      };
      signInProvider.verifyOTPApi(
        loader,
        input,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor:AppColor.backgroundColor ,
        leading: InkWell(
            onTap: (){
              locator<NavigationService>().backPress();
            },
            child: Icon(Icons.arrow_back,color: Colors.black,)),
      ),
      backgroundColor: AppColor.backgroundColor,
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/tmp_1623687411385.jpg',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppSize().width(context) * 0.1,
                      right: AppSize().width(context) * 0.1),
                  child: getBoldText(AppString().entercode,
                      fontSize: 22, textColor: AppColor.textColor),
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
                  child: codeFieldWidget(),
                ),
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
                          AppColor.buttonColor,
                        ),
                      ),
                      child: getSemiBolText(
                        AppString().verify.toUpperCase(),
                        textColor: AppColor.white,
                        fontSize: 14,
                      ),
                      onPressed: () {
                        verifyValidation();
                      },
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: AppSize().height(context) * 0.03,
                        left: AppSize().width(context) * 0.1,
                        right: AppSize().width(context) * 0.1),
                    child: Center(
                        child: InkWell(
                      onTap: () {
                        formValidation();
                      },
                      child: getSemiBolText('Resend',
                          fontSize: 14, textColor: AppColor.textColor),
                    ))),
              ]),
        ),
        loader.isLoading == false
            ? Container()
            : Center(child: CircularProgressIndicator())
      ]),
      // ),
    );
  }
}
