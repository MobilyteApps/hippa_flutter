import 'package:app/common/colors.dart';
import 'package:app/common/container_curvers.dart';
import 'package:app/common/container_ui.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/common/get_it.dart';
import 'package:app/common/navigator_route.dart';
import 'package:app/common/navigator_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(top: AppSize().width(context) * 0.05,
                bottom: AppSize().width(context) * 0.05,
                right: AppSize().width(context) * 0.05,
                left: AppSize().width(context) * 0.07),
            child: SvgPicture.asset(
              'assets/images/arrow_back.svg',
              color: AppColor.white,
              matchTextDirection: true,
            ),
          ),
          actions: [Padding(
            padding: EdgeInsets.only(right: AppSize().width(context) * 0.1),
            child: InkWell(
              onTap: () {
                locator<NavigationService>().navigateToReplace(manageprofile);
                //
              },
              child: SvgPicture.asset(
                'assets/images/settings.svg',
                color: AppColor.white,
                matchTextDirection: true,
              ),
            ),
          )
          ],
          backgroundColor: AppColor.buttonColor,
          title: getBoldText('Profile',
              textColor: AppColor.white, fontSize: 18),
          centerTitle: true,
        ),
        backgroundColor: AppColor.skyblue,
        body:
        Column(
          children: [
            Container(
              color: AppColor.skyblue,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: ClipPath(
                      clipper: ClippingClass(),
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: AppSize().height(context) * 0.4,
                        decoration: BoxDecoration(
                            color: AppColor.blue
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: ClipPath(
                      clipper: ClippingClass(),
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: AppSize().height(context) * 0.4,
                        decoration: BoxDecoration(
                            color: AppColor.transparent
                        ),
                        child: Column(children: [
                          Container(
                            width: AppSize().width(context) * 0.25,
                            height: AppSize().height(context) * 0.2,
                            decoration: BoxDecoration(
                              color: AppColor.lightBlue,
                              shape: BoxShape.circle,),
                            child: Center(child: Text(
                              'A', style: TextStyle(color: Colors.red),)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: AppSize().height(context) * 0.01),
                            child: getBoldText(
                                'John Appleseed', textColor: AppColor.white,
                                fontSize: 20),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: AppSize().height(context) * 0.01),
                            child: getRegularText(
                                'Chief of Medicine', textColor: AppColor.white,
                                fontSize: 16),
                          ),
                          getRegularText(
                              'Department of Medicine', textColor: AppColor.white,
                              fontSize: 16),

                        ],),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: AppSize().height(context) * 0.01,
                  top: AppSize().height(context) * 0.05),
              child: getBoldText(
                  'Address'.toUpperCase(), textColor: Colors.black,
                  fontSize: 14),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: AppSize().height(context) * 0.01),
              child: getRegularText('4331 Oliver Street White Settlement',
                  textColor: Colors.black, fontSize: 16),
            ),


            Padding(
              padding: EdgeInsets.only(bottom: AppSize().height(context) * 0.01,
                  top: AppSize().height(context) * 0.01),
              child: getBoldText(
                  'Office Phone'.toUpperCase(), textColor: Colors.black,
                  fontSize: 14),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: AppSize().height(context) * 0.01),
              child: getRegularText(
                  '972-951-6563', textColor: Colors.black, fontSize: 16),
            ),
          ],
        ));
  }
}

class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 40);
    path.quadraticBezierTo(size.width / 4, size.height,
        size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


class CustomSelfClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    BezierCurveSection section1 = BezierCurveSection(
      start: Offset(0, 30),
      top: Offset(10, 45),
      end: Offset(0, 60),
    );
    BezierCurveSection section2 = BezierCurveSection(
      start: Offset(size.width, size.height - 90),
      top: Offset(size.width - 10, size.height - 105),
      end: Offset(size.width, size.height - 120),
    );
    BezierCurveDots dot1 = ProsteBezierCurve.calcCurveDots(section1);
    BezierCurveDots dot2 = ProsteBezierCurve.calcCurveDots(section2);

    path.lineTo(0, 0);
    path.lineTo(0, 30);
    path.quadraticBezierTo(dot1.x1, dot1.y1, dot1.x2, dot1.y2);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height - 90);
    path.quadraticBezierTo(dot2.x1, dot2.y1, dot2.x2, dot2.y2);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class CustomSelfClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    BezierCurveSection section1 = BezierCurveSection(
      start: Offset(0, size.height),
      top: Offset(30, size.height - 50),
      end: Offset(80, size.height - 70),
    );
    BezierCurveSection section2 = BezierCurveSection(
      start: Offset(size.width - 100, size.height - 70),
      top: Offset(size.width - 30, size.height - 95),
      end: Offset(size.width, size.height - 160),
    );
    BezierCurveDots dot1 = ProsteBezierCurve.calcCurveDots(section1);
    BezierCurveDots dot2 = ProsteBezierCurve.calcCurveDots(section2);

    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(dot1.x1, dot1.y1, dot1.x2, dot1.y2);
    path.lineTo(size.width - 100, size.height - 70);
    path.quadraticBezierTo(dot2.x1, dot2.y1, dot2.x2, dot2.y2);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}