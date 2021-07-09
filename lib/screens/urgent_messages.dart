import 'package:app/common/colleague_detail.dart';
import 'package:app/common/colleagues_search.dart';
import 'package:app/common/colors.dart';
import 'package:app/common/constants.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:app/common/urgent_message.dart';
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

class UrgentMessages extends StatefulWidget {
  const UrgentMessages({Key? key}) : super(key: key);

  @override
  _UrgentMessagesState createState() => _UrgentMessagesState();
}

class _UrgentMessagesState extends State<UrgentMessages> {
  int memberCount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
              child: Container(color: AppColor.grey, height: 1.0),
              preferredSize: Size.fromHeight(4.0)),
          leading: Padding(
            padding: EdgeInsets.only(
                top: AppSize().width(context) * 0.05,
                bottom: AppSize().width(context) * 0.05,
                right: AppSize().width(context) * 0.01,
                left: AppSize().width(context) * 0.01),
            child: SvgPicture.asset(
              'assets/images/arrow_back.svg',
              color: AppColor.black,
              matchTextDirection: true,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: AppSize().width(context) * 0.03),
              child: InkWell(
                  onTap: () {
                    locator<NavigationService>()
                        .navigateToReplace(searchcolleagues);
                    //
                  },
                  child: Icon(Icons.search, color: AppColor.starGrey)),
            )
          ],
          backgroundColor: AppColor.white,
          title: getBoldText('Urgent Messages',
              textColor: AppColor.black, fontSize: 18),
          centerTitle: true,
        ),
        backgroundColor: AppColor.backgroundColor,
        body: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                  onTap: () {
                    locator<NavigationService>().navigateToReplace(chatscreen);
                  },
                  child: UrgentMessage());
            }));
  }
}
