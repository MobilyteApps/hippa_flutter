import 'package:app/common/colors.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/common/get_it.dart';
import 'package:app/common/navigator_route.dart';
import 'package:app/common/navigator_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/response/signin_response.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int memberCount = 1;

  SigninResponse signinresponse = SigninResponse();
  bool isSwitched = false;
  var textValue = 'Switch is OFF';

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'Switch Button is ON';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
    }
  }

  void getotp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('islogged', '');
    });
    locator<NavigationService>().navigateToReplace(selection);

    // startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(color: AppColor.grey, height: 1.0),
            preferredSize: Size.fromHeight(4.0)),
        leading: InkWell(
          onTap: () {
            locator<NavigationService>().backPress();
          },
          child: Padding(
            padding: EdgeInsets.only(
                top: AppSize().width(context) * 0.05,
                bottom: AppSize().width(context) * 0.05,
                right: AppSize().width(context) * 0.05,
                left: AppSize().width(context) * 0.07),
            child: SvgPicture.asset(
              'assets/images/arrow_back.svg',
              color: AppColor.black,
              matchTextDirection: true,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: AppSize().width(context) * 0.1),
            child: InkWell(
              onTap: () {},
              child: SvgPicture.asset(
                'assets/images/settings.svg',
                color: AppColor.black,
                matchTextDirection: true,
              ),
            ),
          )
        ],
        backgroundColor: AppColor.white,
        title: getBoldText('Settings', textColor: AppColor.black, fontSize: 18),
        centerTitle: true,
      ),
      backgroundColor: AppColor.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              locator<NavigationService>().navigateTo(chatscreen);
            },
            child: Container(
              width: AppSize().width(context),
              height: AppSize().height(context) * 0.11,
              decoration: BoxDecoration(
                  color: AppColor.white,
                  border: Border(
                      bottom: BorderSide(width: 1, color: AppColor.grey))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: AppSize().width(context) * 0.05,
                  ),
                  SvgPicture.asset(
                    'assets/images/user_circle.svg',
                    color: AppColor.buttonColor,
                    matchTextDirection: true,
                  ),
                  SizedBox(
                    width: AppSize().width(context) * 0.05,
                  ),
                  getBoldText('Manage Profile',
                      textColor: AppColor.black, fontSize: 18),
                ],
              ),
            ),
          ),
          Container(
            width: AppSize().width(context),
            height: AppSize().height(context) * 0.15,
            decoration: BoxDecoration(
                color: AppColor.white,
                border:
                    Border(bottom: BorderSide(width: 1, color: AppColor.grey))),
            child: Column(
              children: [
                SizedBox(
                  height: AppSize().height(context) * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: AppSize().width(context) * 0.05,
                    ),
                    SvgPicture.asset(
                      'assets/images/notifications.svg',
                      color: AppColor.buttonColor,
                      matchTextDirection: true,
                    ),
                    SizedBox(
                      width: AppSize().width(context) * 0.05,
                    ),
                    getBoldText('Manage Notification',
                        textColor: AppColor.black, fontSize: 18),
                  ],
                ),
                SizedBox(
                  height: AppSize().height(context) * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: AppSize().width(context) * 0.15,
                      ),
                      child: getBoldText('Do not Distrub',
                          textColor: AppColor.black, fontSize: 18),
                    ),
                    Switch(
                      onChanged: toggleSwitch,
                      value: isSwitched,
                      activeColor: AppColor.blue,
                      activeTrackColor: Colors.yellow,
                      inactiveThumbColor: AppColor.darkGrey,
                      inactiveTrackColor: AppColor.darkGrey,
                    )
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              width: AppSize().width(context),
              height: AppSize().height(context) * 0.11,
              decoration: BoxDecoration(
                  color: AppColor.white,
                  // borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border(
                      bottom: BorderSide(width: 1, color: AppColor.grey))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: AppSize().width(context) * 0.05,
                  ),
                  SvgPicture.asset(
                    'assets/images/chat_bubble.svg',
                    color: AppColor.buttonColor,
                    matchTextDirection: true,
                  ),
                  SizedBox(
                    width: AppSize().width(context) * 0.05,
                  ),
                  getBoldText('Manage Replies',
                      textColor: AppColor.black, fontSize: 18),
                ],
              ),
            ),
          ),
          Container(
            width: AppSize().width(context),
            height: AppSize().height(context) * 0.11,
            decoration: BoxDecoration(
                color: AppColor.white,
                border:
                    Border(bottom: BorderSide(width: 1, color: AppColor.grey))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: AppSize().width(context) * 0.05,
                ),
                SvgPicture.asset(
                  'assets/images/group.svg',
                  color: AppColor.buttonColor,
                  matchTextDirection: true,
                ),
                SizedBox(
                  width: AppSize().width(context) * 0.05,
                ),
                getBoldText('Manage Groups',
                    textColor: AppColor.black, fontSize: 18),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      title: getBoldText('Sign Out',
                          textColor: AppColor.black, fontSize: 18),
                      content: getRegularText(
                          'Are you sure you want to sign out of SecureText',
                          textColor: AppColor.black,
                          fontSize: 18),
                      actions: [
                        CupertinoDialogAction(
                          child: getBoldText('CANCEL',
                              textColor: AppColor.black, fontSize: 14),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoDialogAction(
                          child: getBoldText('SIGNOUT',
                              textColor: AppColor.buttonColor, fontSize: 14),
                          onPressed: () {
                            getotp();
                          },
                        ),
                      ],
                    );
                  });
            },
            child: Container(
              width: AppSize().width(context),
              height: AppSize().height(context) * 0.11,
              decoration: BoxDecoration(
                  color: AppColor.white,
                  border: Border(
                      bottom: BorderSide(width: 1, color: AppColor.grey))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: AppSize().width(context) * 0.05,
                  ),
                  SvgPicture.asset(
                    'assets/images/off.svg',
                    color: AppColor.buttonColor,
                    matchTextDirection: true,
                  ),
                  SizedBox(
                    width: AppSize().width(context) * 0.05,
                  ),
                  getBoldText('Sign Out',
                      textColor: AppColor.black, fontSize: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
