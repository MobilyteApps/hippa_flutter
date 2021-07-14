import 'dart:typed_data';
import 'package:app/common/colors.dart';
import 'package:app/common/get_it.dart';
import 'package:app/common/navigator_route.dart';
import 'package:app/common/navigator_service.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:app/screens/signature_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:signature/signature.dart';

class SignaturePage extends StatefulWidget {
  @override
  _SignaturePageState createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  late SignatureController controller;
  TextEditingController? creategroupctrl;

  @override
  void initState() {
    super.initState();

    controller = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.black,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
        color: AppColor.light,
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
              borderSide: BorderSide(color: AppColor.light)),
          hintStyle: TextStyle(
            color: AppColor.starGrey,
            fontSize: 16,
            fontFamily: 'JosenfinSansRegular',
            fontWeight: FontWeight.w400,
          ),
          // hintStyle: TextStyle(color: greyColor, fontSize: 16),
          filled: true,
          contentPadding: new EdgeInsets.only(left: 10, top: 10),
          fillColor: AppColor.light,
          hintText: 'Type Message'),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: AppSize().width(context) * 0.1),
              child: InkWell(
                onTap: () {
                  locator<NavigationService>()
                      .navigateToReplace(urgentmessages);
                  //
                },
                child: SvgPicture.asset(
                  'assets/images/close.svg',
                  color: Colors.red,
                  matchTextDirection: true,
                ),
              ),
            )
          ],
          backgroundColor: AppColor.white,
          title: getBoldText('Create Doodle',
              textColor: AppColor.black, fontSize: 16),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Signature(
              controller: controller,
              backgroundColor: AppColor.white,
            ),
            buildButtons(context),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: bottomSheet(),
            )
          ],
        ),
      );

  Widget bottomSheet() {
    return Container(
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
                locator<NavigationService>().navigateToReplace(urgentmessages);
                //
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
                locator<NavigationService>().navigateToReplace(urgentmessages);
                //
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
                locator<NavigationService>().navigateToReplace(urgentmessages);
                //
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
                  locator<NavigationService>()
                      .navigateToReplace(urgentmessages);
                  //
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

  Widget buildSwapOrientation() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        final newOrientation =
            isPortrait ? Orientation.landscape : Orientation.portrait;

        controller.clear();
        setOrientation(newOrientation);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isPortrait
                  ? Icons.screen_lock_portrait
                  : Icons.screen_lock_landscape,
              size: 40,
            ),
            const SizedBox(width: 12),
            Text(
              'Tap to change signature orientation',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButtons(BuildContext context) => Container(
        color: AppColor.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildClear(),
            buildCheck(context),
          ],
        ),
      );

  Widget buildCheck(BuildContext context) => InkWell(
      onTap: () async {
        if (controller.isNotEmpty) {
          final signature = await exportSignature();

          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SignaturePreviewPage(signature: signature),
          ));

          controller.clear();
        }
      },
      child: Container(
          color: AppColor.buttonColor,
          height: AppSize().height(context) * 0.05,
          width: AppSize().width(context) * 0.35,
          child: Center(
              child: getBoldText('SEND',
                  textColor: AppColor.white, fontSize: 14))));

  Widget buildClear() => InkWell(
      onTap: () => controller.clear(),
      child: Container(
          color: AppColor.light,
          height: AppSize().height(context) * 0.05,
          width: AppSize().width(context) * 0.35,
          child: Center(
              child: getBoldText('CLEAR',
                  textColor: Colors.black, fontSize: 14))));

  Future<Uint8List?> exportSignature() async {
    final exportController = SignatureController(
      penStrokeWidth: 2,
      penColor: AppColor.white,
      exportBackgroundColor: Colors.black,
      points: controller.points,
    );

    final signature = await exportController.toPngBytes();
    exportController.dispose();

    return signature;
  }

  void setOrientation(Orientation orientation) {
    if (orientation == Orientation.landscape) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }
}
