import 'package:app/common/colors.dart';
import 'package:app/common/constants.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:app/common/get_it.dart';
import 'package:app/common/navigator_route.dart';
import 'package:app/common/navigator_service.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TermOfUse extends StatefulWidget {
  const TermOfUse({Key? key}) : super(key: key);

  @override
  _TermOfUseState createState() => _TermOfUseState();
}

class _TermOfUseState extends State<TermOfUse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        leading: Padding(
          padding: EdgeInsets.all(AppSize().width(context) * 0.05),
          child: SvgPicture.asset(
            'assets/images/arrow_back.svg',
            color: AppColor.black,
            matchTextDirection: true,
          ),
        ),
        title: InkWell(
            onTap: () {
              locator<NavigationService>().navigateToReplace(creategroup);
            },
            child: Image.asset('assets/images/maskgroup.png')),
        centerTitle: true,
      ),
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(
            left: AppSize().width(context) * 0.1,
            right: AppSize().width(context) * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: AppSize().height(context) * 0.1),
            getBoldText(AppString().termofuse,
                textColor: AppColor.black, fontSize: 24),
            SizedBox(height: AppSize().height(context) * 0.02),
            getRegularText(AppString().term,
                textColor: AppColor.black, fontSize: 16),

            Padding(
              padding: EdgeInsets.only(top: AppSize().height(context) * 0.01),
              child: SizedBox(
                width: AppSize().width(context) * 0.8,
                child: RaisedButton(
                  color: AppColor.white,
                  child: getBoldText(AppString().cancel,
                      textColor: AppColor.black, fontSize: 14),
                  // child: Text(AppString().cancel,style:TextStyle(color:AppColor.blue,)),
                  onPressed: () {
                    locator<NavigationService>().navigateToReplace(otpscreen);
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: AppSize().height(context) * 0.01),
              child: SizedBox(
                width: AppSize().width(context) * 0.8,
                child: RaisedButton(
                  color: AppColor.buttonColor,
                  child: getBoldText(AppString().accept,
                      textColor: AppColor.white, fontSize: 14),
                  // child: Text(AppString().accept,style:TextStyle(color:AppColor.white)),
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
