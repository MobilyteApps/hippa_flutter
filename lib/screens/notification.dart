// /*
// import 'dart:async';
// import 'package:app/network/api_provider.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:app/common/colors.dart';
// import 'package:app/common/constants.dart';
// import 'package:app/common/size.dart';
// import 'package:app/common/textstyle.dart';
// import 'package:flutter/services.dart';
// import 'package:app/common/get_it.dart';
// import 'package:app/common/navigator_route.dart';
// import 'package:app/common/navigator_service.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:app/common/colors.dart';
// import 'package:app/network/api_provider.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:notification_permissions/notification_permissions.dart';
//
// class N extends StatefulWidget {
//   @override
//   _NState createState() => _NState();
// }
//
// class _NState extends State<N> with WidgetsBindingObserver {
//   late Future<String> permissionStatusFuture;
//
//   var permGranted = "granted";
//   var permDenied = "denied";
//   var permUnknown = "unknown";
//   var permProvisional = "provisional";
//   final border = UnderlineInputBorder(
//     borderSide: BorderSide(
//       color: AppColor.white,
//     ),
//   );
//   // late Future<String> permissionStatusFuture;
//
//   // var permGranted = "granted";
//   // var permDenied = "denied";
//   // var permUnknown = "unknown";
//   // var permProvisional = "provisional";
//
//   String login = '';
//   final usernameCtrl = TextEditingController();
//   final passwordCtrl = TextEditingController();
//   late CameraController _cameraController;
//   late Future<void> cameraValue;
//   ApiProvider apiprovider = ApiProvider();
//
//   @override
//   void initState() {
//     super.initState();
//
//     permissionStatusFuture = getCheckNotificationPermStatus();
//     WidgetsBinding.instance!.addObserver(this);
//     cameraperms();
//   }
//
//   void cameraperms() {
//     _cameraController =
//         CameraController(apiprovider.cameras![0], ResolutionPreset.high);
//     cameraValue = _cameraController.initialize();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       setState(() {
//         permissionStatusFuture = getCheckNotificationPermStatus();
//       });
//     }
//   }
//
//   Future<String> getCheckNotificationPermStatus() {
//     return NotificationPermissions.getNotificationPermissionStatus()
//         .then((status) {
//       switch (status) {
//         case PermissionStatus.denied:
//           return permDenied;
//         case PermissionStatus.granted:
//           return permGranted;
//         case PermissionStatus.unknown:
//           return permUnknown;
//         case PermissionStatus.provisional:
//           return permProvisional;
//         default:
//           return 'null';
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: HexColor('#E8F4FF'),
//         body: Center(
//             child: Container(
//           margin: EdgeInsets.all(20),
//           child: FutureBuilder(
//               future: permissionStatusFuture,
//               builder: (context, snapshot) {
//                 // if we are waiting for data, show a progress indicator
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 }
//                 if (snapshot.hasData) {
//                   var textWidget = Text(
//                     "The permission status is ${snapshot.data}",
//                     style: TextStyle(fontSize: 20),
//                     softWrap: true,
//                     textAlign: TextAlign.center,
//                   );
//                   // The permission is granted, then just show the text
//
//                   return
//                       // else, we'll show a button to ask for the permissions
//                       Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                         SizedBox(height: AppSize().height(context) * 0.1),
//                         Image.asset(
//                           'assets/images/color_logo.png',
//                         ),
//                         // textWidget,
//                         // SizedBox(
//                         //   height: 20,
//                         // ),
//                         // ElevatedButton(
//                         //   // color: Colors.amber,
//                         //   child:
//                         //       Text("Ask for notification status".toUpperCase()),
//                         //   onPressed: () {
//                         //     // show the dialog/open settings screen
//                         //     NotificationPermissions
//                         //             .requestNotificationPermissions(
//                         //                 iosSettings:
//                         //                     const NotificationSettingsIos(
//                         //                         sound: true,
//                         //                         badge: true,
//                         //                         alert: true))
//                         //         .then((_) {
//                         //       // when finished, check the permission status
//                         //       setState(() {
//                         //         permissionStatusFuture =
//                         //             getCheckNotificationPermStatus();
//                         //       });
//                         //     });
//                         //   },
//                         // ),
//
//                         Padding(
//                           padding: EdgeInsets.only(
//                               top: AppSize().height(context) * 0.01),
//                           child: getBoldText('Welcome SecureText',
//                               textColor: HexColor('#0E3746'), fontSize: 24),
//                         ),
//                         // Padding(
//                         //     padding:
//                         //         EdgeInsets.only(top: AppSize().height(context) * 0.02),
//                         //     child: getRegularText(
//                         //         'Create a New Account or Login to begin',
//                         //         textColor: AppColor.buttonColor,
//                         //         fontSize: 16)),
//                         Padding(
//                           padding: EdgeInsets.only(
//                               top: AppSize().height(context) * 0.05),
//                           child: InkWell(
//                               onTap: () {
//                                 if (snapshot.data == permGranted) {
//                                   locator<NavigationService>()
//                                       .navigateTo(signin);
//                                 } else {
//                                   NotificationPermissions
//                                           .requestNotificationPermissions(
//                                               iosSettings:
//                                                   const NotificationSettingsIos(
//                                                       sound: true,
//                                                       badge: true,
//                                                       alert: true))
//                                       .then((_) {
//                                     // when finished, check the permission status
//                                     setState(() {
//                                       permissionStatusFuture =
//                                           getCheckNotificationPermStatus();
//                                     });
//                                   });
//                                 }
//                                 //   askpermission();
//                                 // // locator<NavigationService>().navigateTo(n);
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: HexColor('#62D3BE'),
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(10)),
//                                 ),
//                                 // color:HexColor('#62D3BE'),
//                                 width: AppSize().width(context),
//                                 height: AppSize().height(context) * 0.07,
//                                 // color: Colors.white,
//                                 child: Center(
//                                   child: getSemiBolText(AppString().signinemail,
//                                       textColor: Colors.white, fontSize: 14),
//                                 ),
//                               )),
//                         ),
//                         (snapshot.data.toString() == 'granted')
//                             ? Padding(
//                                 padding: EdgeInsets.only(
//                                     top: AppSize().height(context) * 0.02),
//                                 child: InkWell(
//                                     onTap: () async {
//                                       locator<NavigationService>()
//                                           .navigateTo(yourphone);
//                                     },
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         color: HexColor('#2291FF'),
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(10)),
//                                       ),
//                                       width: AppSize().width(context),
//                                       height: AppSize().height(context) * 0.07,
//                                       // color: HexColor('#2291FF'),
//                                       child: Center(
//                                         child: getSemiBolText(
//                                             AppString().signinphno,
//                                             textColor: Colors.white,
//                                             fontSize: 14),
//                                       ),
//                                     )),
//                               )
//                             : Padding(
//                                 padding: EdgeInsets.only(
//                                     top: AppSize().height(context) * 0.02),
//                                 child: InkWell(
//                                     onTap: () async {
//                                       NotificationPermissions
//                                               .requestNotificationPermissions(
//                                                   iosSettings:
//                                                       const NotificationSettingsIos(
//                                                           sound: true,
//                                                           badge: true,
//                                                           alert: true))
//                                           .then((_) {
//                                         // when finished, check the permission status
//                                         setState(() {
//                                           permissionStatusFuture =
//                                               getCheckNotificationPermStatus();
//                                         });
//                                       });
//                                     },
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         color: HexColor('#2291FF'),
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(10)),
//                                       ),
//                                       width: AppSize().width(context),
//                                       height: AppSize().height(context) * 0.07,
//                                       // color: HexColor('#2291FF'),
//                                       child: Center(
//                                         child: getSemiBolText(
//                                             AppString().signinphno,
//                                             textColor: Colors.white,
//                                             fontSize: 14),
//                                       ),
//                                     )),
//                               )
//                       ]);
//                   // return Column(
//                   //   mainAxisAlignment: MainAxisAlignment.center,
//                   //   children: <Widget>[
//                   //     textWidget,
//                   //     SizedBox(
//                   //       height: 20,
//                   //     ),
//                   //     FlatButton(
//                   //       color: Colors.amber,
//                   //       child:
//                   //           Text("Ask for notification status".toUpperCase()),
//                   //       onPressed: () {
//                   //         // show the dialog/open settings screen
//                   //         NotificationPermissions
//                   //                 .requestNotificationPermissions(
//                   //                     iosSettings:
//                   //                         const NotificationSettingsIos(
//                   //                             sound: true,
//                   //                             badge: true,
//                   //                             alert: true))
//                   //             .then((_) {
//                   //           // when finished, check the permission status
//                   //           setState(() {
//                   //             permissionStatusFuture =
//                   //                 getCheckNotificationPermStatus();
//                   //           });
//                   //         });
//                   //       },
//                   //     )
//                   //   ],
//                   // );
//                 }
//                 return Text("No permission status yet");
//               }),
//         )),
//       ),
//     );
//   }
// }
// */
