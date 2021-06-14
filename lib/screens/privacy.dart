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
import 'package:hexcolor/hexcolor.dart';

class Privacy extends StatefulWidget {
  const Privacy({Key key}) : super(key: key);

  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor:  HexColor('#E8F4FF'),
        title:InkWell(
            onTap: (){
                  locator<NavigationService>().navigateToReplace(term);

            },
            child: Image.asset('assets/images/maskgroup.png')),
        centerTitle: true,
      ),
      backgroundColor: HexColor('#E8F4FF'),
      body: Padding(
        padding: EdgeInsets.only(
            left: AppSize().width(context) * 0.1,
            right: AppSize().width(context) * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: AppSize().height(context) * 0.1),
            getBoldText(AppString().privacy, textColor: HexColor('#0E3746'),fontSize:24),
            SizedBox(height: AppSize().height(context) * 0.02),
            getRegularText(
                AppString().forgot1,
                textColor:HexColor('#0E3746'),fontSize: 16),
            //             InkWell(
            //   onTap: (){
            //     locator<NavigationService>().navigateToReplace(term);
            //
            //   },
            //   child: getLightText(
            //       AppString().forgotpassdesc + " " + AppString().forgotpassdesc,
            //       textColor: Colors.white),
            // ),
          ],
        ),
      ),
    );
  }
}
