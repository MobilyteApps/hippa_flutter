import 'package:app/common/colors.dart';
import 'package:app/common/constants.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:app/common/get_it.dart';
import 'package:app/common/navigator_route.dart';
import 'package:app/common/navigator_service.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Privacy extends StatefulWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: InkWell(
            onTap: () {
              locator<NavigationService>().navigateTo(term);
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
            getBoldText(AppString().privacy,
                textColor: AppColor.black, fontSize: 24),
            SizedBox(height: AppSize().height(context) * 0.02),
            getRegularText('Coming soon...',
                textColor: AppColor.black, fontSize: 16),
          ],
        ),
      ),
    );
  }
}
