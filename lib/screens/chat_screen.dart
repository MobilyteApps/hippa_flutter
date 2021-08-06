import 'package:app/common/colors.dart';
import 'package:app/common/sender_message.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:app/screens/signature.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/common/get_it.dart';
import 'package:app/common/navigator_route.dart';
import 'package:app/common/navigator_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int memberCount = 1;
  final creategroupctrl = TextEditingController();
  final border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
        color: AppColor.white,
      ));

  Widget groupnameFieldWidget() {
    return TextFormField(
      controller: creategroupctrl,
      inputFormatters: [
        new WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9@.+-_ ]")),
      ],
      decoration: InputDecoration(
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
          filled: true,
          contentPadding: new EdgeInsets.only(left: 10, top: 10),
          fillColor: AppColor.white,
          hintText: 'Type Message'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(color: AppColor.grey, height: 1.0),
            preferredSize: Size.fromHeight(4.0)),
        leading: InkWell(
          onTap: (){
            locator<NavigationService>()
                .backPress();
          },
          child: Padding(
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
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: AppSize().width(context) * 0.03),
            child: InkWell(
                onTap: () {
                  // locator<NavigationService>()
                  //     .navigateToReplace(settingsscreen);
                  //
                },
                child: Icon(Icons.search, color: AppColor.starGrey)),
          )
        ],
        backgroundColor: AppColor.white,
        title: Container(
          width: AppSize().width(context) * 0.5,
          height: AppSize().height(context) * 0.11,
          decoration: BoxDecoration(
              color: AppColor.white,
              border:
                  Border(bottom: BorderSide(width: 1, color: AppColor.grey))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    width: AppSize().width(context) * 0.1,
                    height: AppSize().height(context) * 0.2,
                    decoration: BoxDecoration(
                      color: AppColor.lightBlue,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                        child: Text(
                      'A',
                      style: TextStyle(color: Colors.red),
                    )),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getBoldText('Justin Oliver',
                          textColor: AppColor.black, fontSize: 16),
                      Padding(
                        padding: EdgeInsets.only(
                            top: AppSize().height(context) * 0.015),
                        child: getBoldText('Online',
                            textColor: AppColor.buttonColor, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColor.white,
      body: Stack(children: [
        ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return index % 2 == 0 ? myreceiverMessageView() : myMessageView();
            }),
        Align(alignment: Alignment.bottomCenter, child: bottomSheet()),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      color: AppColor.white,
      height: AppSize().height(context) * 0.05,
      width: AppSize().width(context),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: AppSize().width(context) * 0.03,
                right: AppSize().width(context) * 0.03),
            child: InkWell(
              onTap: () {
                // locator<NavigationService>().navigateToReplace(urgentmessages);
              },
              child: SvgPicture.asset(
                'assets/images/attachment.svg',
                color: AppColor.buttonColor,
                matchTextDirection: true,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: AppSize().width(context) * 0.03),
            child: InkWell(
              onTap: () {
                // locator<NavigationService>().navigateToReplace(urgentmessages);
              },
              child: Image.asset(
                'assets/images/image.png',
                color: AppColor.buttonColor,
                matchTextDirection: true,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: AppSize().width(context) * 0.03),
            child: InkWell(
              onTap: () {
                locator<NavigationService>()
                    .navigateTo(signature);
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => SignaturePage(),
                // ));
              },
              child: Image.asset(
                'assets/images/icons_edit.png',
                color: AppColor.buttonColor,
                matchTextDirection: true,
              ),
            ),
          ),
          Container(
              width: AppSize().width(context) * 0.6,
              height: AppSize().height(context) * 0.7,
              child: groupnameFieldWidget()),
          Padding(
            padding: EdgeInsets.only(left: AppSize().width(context) * 0.03),
            child: InkWell(
                onTap: () {
                  // locator<NavigationService>()
                  //     .navigateToReplace(urgentmessages);
                },
                child: Icon(
                  Icons.send,
                  color: AppColor.buttonColor,
                )),
          ),
        ],
      ),
    );
  }
}
