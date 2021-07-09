import 'package:app/common/colors.dart';
import 'package:app/common/get_it.dart';
import 'package:app/common/navigator_route.dart';
import 'package:app/common/navigator_service.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class ManageReply extends StatefulWidget {
  const ManageReply({ Key? key }) : super(key: key);

  @override
  _ManageReplyState createState() => _ManageReplyState();
}

class _ManageReplyState extends State<ManageReply> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(top: AppSize().width(context) * 0.05,
                bottom: AppSize().width(context) * 0.05,
                right: AppSize().width(context) * 0.05,
                left: AppSize().width(context) * 0.07),
            child: SvgPicture.asset(
              'assets/images/arrow_back.svg',
              color: AppColor.black,
              matchTextDirection: true,
            ),
          ),
          actions: [Padding(
            padding: EdgeInsets.only(right: AppSize().width(context) * 0.1),
            child: InkWell(
              onTap: () {
                locator<NavigationService>().navigateToReplace(urgentmessages);
                //
              },
              child: SvgPicture.asset(
                'assets/images/settings.svg',
                color: AppColor.black,
                matchTextDirection: true,
              ),
            ),
          )
          ],
          backgroundColor: AppColor.white,
          title: getBoldText('Manage Replies',
              textColor: AppColor.black, fontSize: 18),
          centerTitle: true,
        ),
        backgroundColor: AppColor.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Padding(
                padding: EdgeInsets.only(left: AppSize().width(context) * 0.02),
                child: SvgPicture.asset(
                  'assets/images/menu.svg',
                  color: AppColor.starGrey,
                  matchTextDirection: true,
                ),
              ),
              title: getRegularText("I'm in a rounding. Call you soon.",
                  textColor: AppColor.black, fontSize: 16),
              trailing:
              Padding(
                padding: EdgeInsets.only(
                    right: AppSize().width(context) * 0.06),
                child:
                SvgPicture.asset(
                  'assets/images/edit.svg',
                  color: AppColor.lightGrey,
                  matchTextDirection: true,
                ),
              ),
            ),

            ListTile(
              leading: Padding(
                padding: EdgeInsets.only(left: AppSize().width(context) * 0.02),
                child: SvgPicture.asset(
                  'assets/images/menu.svg',
                  color: AppColor.starGrey,
                  matchTextDirection: true,
                ),
              ),
              title: getRegularText(
                  "I'm out of the hospital. Call you when I get back.",
                  textColor: AppColor.black, fontSize: 16),
              trailing:
              Padding(
                padding: EdgeInsets.only(
                    right: AppSize().width(context) * 0.06),
                child:
                SvgPicture.asset(
                  'assets/images/edit.svg',
                  color: AppColor.lightGrey,
                  matchTextDirection: true,
                ),
              ),
            ),

            ListTile(
              leading: Padding(
                padding: EdgeInsets.only(left: AppSize().width(context) * 0.02),
                child: SvgPicture.asset(
                  'assets/images/menu.svg',
                  color: AppColor.starGrey,
                  matchTextDirection: true,
                ),
              ),
              title: getRegularText(
                  "May I help you?", textColor: AppColor.black, fontSize: 16),
              trailing:
              Padding(
                padding: EdgeInsets.only(
                    right: AppSize().width(context) * 0.06),
                child:
                SvgPicture.asset(
                  'assets/images/edit.svg',
                  color: AppColor.lightGrey,
                  matchTextDirection: true,
                ),
              ),
            ),

            ListTile(
              leading: Padding(
                padding: EdgeInsets.only(left: AppSize().width(context) * 0.02),
                child: SvgPicture.asset(
                  'assets/images/menu.svg',
                  color: AppColor.starGrey,
                  matchTextDirection: true,
                ),
              ),
              title: getRegularText(
                  "I'm in meeting. Call you soon", textColor: AppColor.black,
                  fontSize: 16),
              trailing:
              Padding(
                padding: EdgeInsets.only(
                    right: AppSize().width(context) * 0.06),
                child:
                SvgPicture.asset(
                  'assets/images/edit.svg',
                  color: AppColor.lightGrey,
                  matchTextDirection: true,
                ),
              ),
            ),

            ListTile(
              leading: Padding(
                padding: EdgeInsets.only(left: AppSize().width(context) * 0.02),
                child: SvgPicture.asset(
                  'assets/images/menu.svg',
                  color: AppColor.starGrey,
                  matchTextDirection: true,
                ),
              ),
              title: getRegularText(
                  "I'm Busy", textColor: AppColor.black, fontSize: 16),
              trailing:
              Padding(
                padding: EdgeInsets.only(
                    right: AppSize().width(context) * 0.06),
                child:
                SvgPicture.asset(
                  'assets/images/edit.svg',
                  color: AppColor.lightGrey,
                  matchTextDirection: true,
                ),
              ),
            ),


          ],
        )
    );
  }
}