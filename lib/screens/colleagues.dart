import 'package:app/common/colleague_detail.dart';
import 'package:app/common/colors.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class Colleagues extends StatefulWidget {
  const Colleagues({Key? key}) : super(key: key);

  @override
  _ColleaguesState createState() => _ColleaguesState();
}

class _ColleaguesState extends State<Colleagues> {
  int memberCount = 1;
  final creategroupctrl = TextEditingController();
  final border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
        color: AppColor.white,
      ));
  int a = 0;

  @override
  void initState() {
    super.initState();
  }

  Widget groupnameFieldWidget() {
    return TextFormField(
      controller: creategroupctrl,
      inputFormatters: [
        new WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9@.+-_ ]")),
      ],
      decoration: InputDecoration(
          suffixIcon: Icon(Icons.search_sharp, color: AppColor.starGrey),
          focusedBorder: border,
          enabledBorder: border,
          disabledBorder: border,
          isDense: false,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                color: AppColor.white,
              )),
          hintStyle: TextStyle(
            color: AppColor.textColor,
            fontSize: 16,
            fontFamily: 'JosenfinSansRegular',
            fontWeight: FontWeight.w400,
          ),
          // hintStyle: TextStyle(color: greyColor, fontSize: 16),
          filled: true,
          contentPadding: new EdgeInsets.only(left: 10, top: 10),
          fillColor: AppColor.white,
          hintText: 'Search'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: AppSize().width(context) * 0.1,
                right: AppSize().width(context) * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSize().height(context) * 0.02),
                Container(
                    height: AppSize().height(context) * 0.07,
                    child: groupnameFieldWidget()),
                Expanded(
                    child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return ColleagueDetail();
                        })),
              ],
            ),
          ),
          //        a == 0?
          //   showCupertinoDialog(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return CupertinoAlertDialog(
          //           title: getBoldText('Camera Access',
          //               textColor: AppColor.black, fontSize: 18),
          //           content: getRegularText(
          //               'SecureText needs permission to access your camera',
          //               textColor: AppColor.black,
          //               fontSize: 18),
          //           actions: [
          //             CupertinoDialogAction(
          //               child: getBoldText('DENY',
          //                   textColor: AppColor.black, fontSize: 14),
          //               onPressed: () {
          //                 Navigator.pop(context);
          //                 setState(() {
          //                   a = 1;
          //                 });
          //               },
          //             ),
          //             CupertinoDialogAction(
          //               child: getBoldText('ALLOW',
          //                   textColor: AppColor.buttonColor, fontSize: 14),
          //               onPressed: () {
          //                 Navigator.pop(context);
          //                 setState(() {
          //                   a = 1;
          //                 });
          //               },
          //             ),
          //           ],
          //         );
          //       }):
          // a == 1?
          //   showCupertinoDialog(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return CupertinoAlertDialog(
          //           title: getBoldText('Microphone Access',
          //               textColor: AppColor.black, fontSize: 18),
          //           content: getRegularText(
          //               'SecureText needs permission to access your microphone',
          //               textColor: AppColor.black,
          //               fontSize: 18),
          //           actions: [
          //             CupertinoDialogAction(
          //               child: getBoldText('DENY',
          //                   textColor: AppColor.black, fontSize: 14),
          //               onPressed: () {
          //                 Navigator.pop(context);
          //                 setState(() {
          //                   a = 2;
          //                 });
          //               },
          //             ),
          //             CupertinoDialogAction(
          //               child: getBoldText('ALLOW',
          //                   textColor: AppColor.buttonColor, fontSize: 14),
          //               onPressed: () {
          //                 Navigator.pop(context);
          //                 setState(() {
          //                   a = 2;
          //                 });
          //               },
          //             ),
          //           ],
          //         );
          //       }):
          // a == 2?
          //   showCupertinoDialog(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return CupertinoAlertDialog(
          //           title: getBoldText('Push Notifications',
          //               textColor: AppColor.black, fontSize: 18),
          //           content: getRegularText(
          //               'SecureText needs permission to send you push notifications',
          //               textColor: AppColor.black,
          //               fontSize: 18),
          //           actions: [
          //             CupertinoDialogAction(
          //               child: getBoldText('DENY',
          //                   textColor: AppColor.black, fontSize: 14),
          //               onPressed: () {
          //                 setState(() {
          //                   a = 3;
          //                 });
          //                 Navigator.pop(context);
          //               },
          //             ),
          //             CupertinoDialogAction(
          //               child: getBoldText('ALLOW',
          //                   textColor: AppColor.buttonColor, fontSize: 14),
          //               onPressed: () {
          //                 Navigator.pop(context);
          //                 setState(() {
          //                   a = 3;
          //                 });
          //               },
          //             ),
          //           ],
          //         );
          //       }):
        ],
      ),
    );
  }
}
