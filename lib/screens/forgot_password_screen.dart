import 'package:app/common/colors.dart';
import 'package:app/common/constants.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/common/get_it.dart';
import 'package:app/common/navigator_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app/network/api_provider.dart';
import 'package:app/providers/signin_provider.dart';
import 'package:app/models/loader.dart';
import 'package:app/common/utils.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final border = UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColor.black,
    ),
  );

  final emailCtrl = TextEditingController();
  Loader loader = Loader();
  SignInProvider signInProvider = SignInProvider();

  Widget emailFieldWidget() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: AppColor.black,
        fontFamily: 'JosenfinSansRegular',
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
      controller: emailCtrl,
      inputFormatters: <TextInputFormatter>[
        new FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9@.+-_ ]")),
      ],
      decoration: InputDecoration(
          enabledBorder: border,
          contentPadding:
              new EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          focusedBorder: border,
          counterText: "",
          border: border,
          hintStyle: TextStyle(
            color: AppColor.black,
            fontFamily: 'JosenfinSansRegular',
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
          filled: true,
          fillColor: AppColor.transparent,
          hintText: 'Enter Email'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        leading: InkWell(
          onTap: () {
            locator<NavigationService>().backPress();
          },
          child: Padding(
            padding: EdgeInsets.all(AppSize().width(context) * 0.05),
            child: SvgPicture.asset(
              'assets/images/arrow_back.svg',
              color: AppColor.black,
              matchTextDirection: true,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: AppSize().width(context) * 0.1,
            right: AppSize().width(context) * 0.1),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getBoldText(AppString().forgotpass,
                    textColor: AppColor.black, fontSize: 24),
                SizedBox(height: AppSize().height(context) * 0.02),
                getRegularText(AppString().forgotpassdesc,
                    textColor: AppColor.black, fontSize: 18),
                Padding(
                  padding: EdgeInsets.only(
                    top: AppSize().height(context) * 0.01,
                  ),
                  child: emailFieldWidget(),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: AppSize().height(context) * 0.01),
                  child: SizedBox(
                    width: AppSize().width(context) * 0.8,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          AppColor.buttonColor,
                        ),
                      ),
                      child: Text(AppString().send,
                          style: TextStyle(color: AppColor.white)),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        if (emailCtrl.text.trim().isEmpty == true) {
                          ApiProvider()
                              .showToastMsg("Please Enter email address");
                        } else if (!validateEmail(emailCtrl.text.trim())) {
                          ApiProvider().showToastMsg(
                              "Please Enter a valid email address");
                        } else {
                          var input = {"email": "${emailCtrl.text.trim()}"};
                          signInProvider.forgotpasswordApi(loader, input);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
