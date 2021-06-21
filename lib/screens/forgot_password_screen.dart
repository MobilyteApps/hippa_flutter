import 'package:app/common/colors.dart';
import 'package:app/common/constants.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:flutter/material.dart';
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

  Widget emailFieldWidget() {
    return TextFormField(
      // onChanged: formValidatonColor(),
      // validator: (value) {
      //   if (value?.trim()?.isEmpty ?? true) {
      //     return 'Please Enter Email';
      //   } else if (value.length < 10) {
      //     return 'Please Enter Valid Email';
      //   }
      //   return null;
      // },
      keyboardType: TextInputType.emailAddress,
      style:TextStyle(color: AppColor.black,
        fontFamily: 'JosenfinSansRegular',
        fontWeight: FontWeight.w400,
        fontSize: 18,),
      controller: emailCtrl,
      maxLength: 10,
      inputFormatters: <TextInputFormatter>[
        new WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9@.+-_ ]")),
      ],
      decoration: InputDecoration(
          // prefixIcon: Icon(
          //   Icons.person,
          //   color: Colors.white,
          // ),

          enabledBorder: border,
          contentPadding:
          new EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          focusedBorder: border,
          counterText: "",
          border: border,
          hintStyle: TextStyle(color: AppColor.black,
            fontFamily: 'JosenfinSansRegular',
            fontWeight: FontWeight.w400,
            fontSize: 18,),
          filled: true,
          fillColor: Colors.transparent,
          hintText: 'Enter Email'),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#E8F4FF'),
      appBar: AppBar(
        backgroundColor: HexColor('#E8F4FF'),
        leading: Padding(
          padding:  EdgeInsets.all(AppSize().width(context)*0.05),
          child: SvgPicture.asset(
                            'assets/images/arrow_back.svg',
                            color: AppColor.black,
                            matchTextDirection: true,
                          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: AppSize().width(context) * 0.1,
            right: AppSize().width(context) * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: AppSize().height(context) * 0.1),
            getBoldText(AppString().forgotpass, textColor: AppColor.black,fontSize: 24),
            SizedBox(height: AppSize().height(context) * 0.02),
            getRegularText(AppString().forgotpassdesc, textColor: AppColor.black,fontSize:18),

            Padding(
              padding: EdgeInsets.only(
                top: AppSize().height(context) * 0.01,
                // right: AppSize().width(context) * 0.1
              ),
              child: emailFieldWidget(),
            ),
            Padding(
              padding:
              EdgeInsets.only(top: AppSize().height(context) * 0.01),
              child: SizedBox(
                width: AppSize().width(context) * 0.8,
                child: RaisedButton(
                  color:HexColor('#2291FF'),
                  child: Text(AppString().send,
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    locator<NavigationService>().navigateToReplace(privacy);

                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
