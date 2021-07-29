import 'package:app/network/api_provider.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:notification_permissions/notification_permissions.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' as IO;

class Selection extends StatefulWidget {
  const Selection({Key? key}) : super(key: key);

  @override
  _SelectionState createState() => _SelectionState();
}

class _SelectionState extends State<Selection> with WidgetsBindingObserver {
  final border = UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColor.white,
    ),
  );
  late Future<String> permissionStatusFuture;

  var permGranted = "granted";
  var permDenied = "denied";
  var permUnknown = "unknown";
  var permProvisional = "provisional";

  String login = '';
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  late CameraController _cameraController;
  late Future<void> cameraValue;
  ApiProvider apiprovider = ApiProvider();

  @override
  void initState() {
    super.initState();

    cameraperms();
  }

  permhand() async {}

  void cameraperms() {
    _cameraController =
        CameraController(apiprovider.cameras![0], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        permissionStatusFuture = getCheckNotificationPermStatus();
      });
    }
  }

  Future<String> getCheckNotificationPermStatus() {
    return NotificationPermissions.getNotificationPermissionStatus()
        .then((status) {
      switch (status) {
        case PermissionStatus.denied:
          return permDenied;
        case PermissionStatus.granted:
          return permGranted;
        case PermissionStatus.unknown:
          return permUnknown;
        case PermissionStatus.provisional:
          return permProvisional;
        default:
          return 'null';
      }
    });
  }

  askpermission() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: getBoldText('Push Notifications',
                  textColor: AppColor.black, fontSize: 18),
            ),
            content: getRegularText(
                'SecureText needs permission to send you push notifications',
                textColor: AppColor.black,
                fontSize: 18),
            actions: [
              SizedBox(
                width: AppSize().width(context) * 0.3,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColor.white),
                  ),
                  child: getBoldText('DENY',
                      textColor: AppColor.black, fontSize: 14),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(
                width: AppSize().width(context) * 0.3,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColor.white),
                  ),
                  child: getBoldText('ALLOW',
                      textColor: AppColor.buttonColor, fontSize: 14),
                  onPressed: () {
                    Navigator.pop(context);

                    NotificationPermissions.requestNotificationPermissions(
                            iosSettings: const NotificationSettingsIos(
                                sound: true, badge: true, alert: true))
                        .then((_) {
                      setState(() {
                        permissionStatusFuture =
                            getCheckNotificationPermStatus();
                      });
                    });
                  },
                ),
              ),
            ],
          );
        });
  }

  Widget usernameFieldWidget() {
    return TextFormField(
      validator: (value) {
        if (value?.trim().isEmpty ?? true) {
          return 'Please Enter Username';
        } else if (value!.length < 10) {
          return 'Please Enter Valid Username';
        }
        return null;
      },
      keyboardType: TextInputType.text,
      controller: usernameCtrl,
      style: TextStyle(
        color: AppColor.white,
        fontFamily: 'JosenfinSansRegular',
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      maxLength: 10,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(10)
      ],
      decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              'assets/images/user.png',
              color: AppColor.white,
            ),
          ),
          labelStyle: TextStyle(color: AppColor.white),
          enabledBorder: border,
          contentPadding:
              new EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          focusedBorder: border,
          counterText: "",
          border: border,
          hintStyle: TextStyle(
            color: AppColor.white,
            fontFamily: 'JosenfinSansRegular',
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          filled: true,
          counterStyle: TextStyle(color: AppColor.white),
          suffixStyle: TextStyle(color: AppColor.white),
          helperStyle: TextStyle(color: AppColor.white),
          errorStyle: TextStyle(color: AppColor.white),
          prefixStyle: TextStyle(color: AppColor.white),
          fillColor: AppColor.transparent,
          hintText: 'Username'),
    );
  }

  Widget passwordFieldWidget() {
    return TextFormField(
      validator: (value) {
        if (value?.trim().isEmpty ?? true) {
          return 'Please Enter Password';
        } else if (value!.length < 10) {
          return 'Please Enter Valid Password';
        }
        return null;
      },
      keyboardType: TextInputType.text,
      controller: passwordCtrl,
      maxLength: 10,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(10)
      ],
      decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              'assets/images/lock.png',
              color: AppColor.white,
            ),
          ),
          labelStyle: TextStyle(color: AppColor.white),
          enabledBorder: border,
          contentPadding:
              new EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          focusedBorder: border,
          counterText: "",
          border: border,
          hintStyle: TextStyle(
            color: AppColor.white,
            fontFamily: 'JosenfinSansRegular',
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          filled: true,
          counterStyle: TextStyle(color: AppColor.white),
          suffixStyle: TextStyle(color: AppColor.white),
          helperStyle: TextStyle(color: AppColor.white),
          errorStyle: TextStyle(color: AppColor.white),
          prefixStyle: TextStyle(color: AppColor.white),
          fillColor: AppColor.transparent,
          hintText: 'Password'),
      style: TextStyle(
        color: AppColor.white,
        fontFamily: 'JosenfinSansRegular',
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#E8F4FF'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: AppSize().width(context) * 0.1,
              right: AppSize().width(context) * 0.1),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: AppSize().height(context) * 0.1),
                Image.asset(
                  'assets/images/color_logo.png',
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: AppSize().height(context) * 0.01),
                  child: getBoldText('Welcome SecureText',
                      textColor: HexColor('#0E3746'), fontSize: 24),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: AppSize().height(context) * 0.05),
                  child: InkWell(
                      onTap: () {
                        locator<NavigationService>().navigateTo(signin);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: HexColor('#62D3BE'),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        width: AppSize().width(context),
                        height: AppSize().height(context) * 0.07,
                        child: Center(
                          child: getSemiBolText(AppString().signinemail,
                              textColor: Colors.white, fontSize: 14),
                        ),
                      )),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: AppSize().height(context) * 0.02),
                  child: InkWell(
                      onTap: () async {
                        locator<NavigationService>().navigateTo(yourphone);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: HexColor('#2291FF'),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        width: AppSize().width(context),
                        height: AppSize().height(context) * 0.07,
                        child: Center(
                          child: getSemiBolText(AppString().signinphno,
                              textColor: Colors.white, fontSize: 14),
                        ),
                      )),
                )
              ]),
        ),
      ),
    );
  }
}
