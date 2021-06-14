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

class TermOfUse extends StatefulWidget {
  const TermOfUse({Key key}) : super(key: key);

  @override
  _TermOfUseState createState() => _TermOfUseState();
}

class _TermOfUseState extends State<TermOfUse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightBlue,
      body: Padding(
        padding: EdgeInsets.only(
            left: AppSize().width(context) * 0.1,
            right: AppSize().width(context) * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSize().height(context) * 0.1),
            getBoldText(AppString().privacy, textColor: Colors.white),
            SizedBox(height: AppSize().height(context) * 0.02),
            getLightText(
                AppString().forgotpassdesc + " " + AppString().forgotpassdesc,
                textColor: Colors.white),
            SizedBox(height: AppSize().height(context) * 0.02),
            getLightText(AppString().forgotpassdesc, textColor: Colors.white),
            SizedBox(height: AppSize().height(context) * 0.02),
            getLightText(AppString().forgotpassdesc, textColor: Colors.white),
            SizedBox(height: AppSize().height(context) * 0.02),
            getLightText(
                AppString().forgotpassdesc + " " + AppString().forgotpassdesc,
                textColor: Colors.white),
            Padding(
              padding:
              EdgeInsets.only(top: AppSize().height(context) * 0.01),
              child: SizedBox(
                width: AppSize().width(context) * 0.8,
                child: RaisedButton(
                  color: Colors.white,
                  child: Text(AppString().cancel,style:TextStyle(color:AppColor.blue,)),
                  onPressed: () {
                    locator<NavigationService>().navigateToReplace(otpscreen);
                  },
                ),
              ),
            ),
            Padding(
              padding:
              EdgeInsets.only(top: AppSize().height(context) * 0.01),
              child: SizedBox(
                width: AppSize().width(context) * 0.8,
                child: RaisedButton(
                  color: AppColor.blue,
                  child: Text(AppString().accept,style:TextStyle(color:Colors.white)),
                  onPressed: () {
                    locator<NavigationService>().navigateToReplace(otpscreen);
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
