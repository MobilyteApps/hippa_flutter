import 'package:app/common/colleague_detail.dart';
import 'package:app/common/colleagues_search.dart';
import 'package:app/common/colors.dart';
import 'package:app/common/constants.dart';
import 'package:app/common/container_curvers.dart';
import 'package:app/common/container_ui.dart';
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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int memberCount=1;
  final creategroupctrl=TextEditingController();
  final border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: Colors.white,)
      );
  Widget groupnameFieldWidget() {
    return TextFormField(
      controller: creategroupctrl,
      inputFormatters: [
        new WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9@.+-_ ]")),
      ],
      decoration: InputDecoration(
          suffixIcon: Icon(Icons.search_sharp,color:HexColor('#608795')),
          focusedBorder: border,
          enabledBorder: border,
          disabledBorder: border,
          isDense: false,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.white,)
          ),
          hintStyle: TextStyle(
            color: HexColor("#0E3746"),
            fontSize: 16,
            fontFamily: 'JosenfinSansRegular',
            fontWeight: FontWeight.w400,
          ),
          // hintStyle: TextStyle(color: greyColor, fontSize: 16),
          filled: true,
          contentPadding:
          new EdgeInsets.only(left:10,top:10),
          fillColor: Colors.white,
          hintText: 'Search'),
    );
  }

  Widget addWidget(){
    return InkWell(
      onTap: (){
        setState(() {
          memberCount++;
        });
      },
         
       child:  Container(
                          width:  AppSize().width(context) * 0.16,
                          height: AppSize().height(context) * 0.2,
                          decoration: BoxDecoration(
                            color:Colors.white,
                            shape: BoxShape.circle,),
                            child:Icon(Icons.add,size: 40,color: Colors.blue,)),
    );
  }

  Widget memberWidget(){
    return Padding(
      padding:  EdgeInsets.only(right:AppSize().width(context)*0.05),
      child: Stack(
                    children: [
                      Container(
                        width:  AppSize().width(context) * 0.16,
                        height: AppSize().height(context) * 0.2,
                        decoration: BoxDecoration(
                          color:Colors.white,
                          shape: BoxShape.circle,),
                      child: Center(child: Text('A',style: TextStyle(color:Colors.red),)),
                      ),
                      Positioned(
                        left: AppSize().width(context) * 0.11,
                          // alignment: Alignment.topRight,
                      child:InkWell(
                        onTap: (){
                          setState(() {
                            memberCount--;
                          });
                        },
                        child: Container(
                          width:  AppSize().width(context) * 0.05,
                          height: AppSize().height(context) * 0.09,
                          decoration: BoxDecoration(
                            color:HexColor('#FF0000'),
                            shape: BoxShape.circle,),
                            child:Icon(Icons.close,size: 10,color: Colors.white,)),
                      )),
                     
                  // Align(
                  //   alignment: Alignment.topRight,
                  //   child: CircleAvatar(
                  //     radius:8,child: Icon(Icons.close,size: 10,),backgroundColor:HexColor('#FF0000'),),
                  // )
                    ],
      ),
    );
  }

  Widget memberlist(){
    return ListView.builder(
      itemCount: memberCount,
      itemBuilder: (BuildContext context,int index){
        return memberWidget();
      });
  }



bool isSwitched = false;  
  var textValue = 'Switch is OFF';  
  
  void toggleSwitch(bool value) {  
  
    if(isSwitched == false)  
    {  
      setState(() {  
        isSwitched = true;  
        textValue = 'Switch Button is ON';  
      });  
      print('Switch Button is ON');  
    }  
    else  
    {  
      setState(() {  
        isSwitched = false;  
        textValue = 'Switch Button is OFF';  
      });  
      print('Switch Button is OFF');  
    }  
  }  


  @override
  Widget build(BuildContext context) {

   double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
       appBar: AppBar(
         leading: Padding(
          padding:  EdgeInsets.only(top:AppSize().width(context)*0.05,bottom: AppSize().width(context)*0.05,right: AppSize().width(context)*0.05,left: AppSize().width(context)*0.07),
          child: SvgPicture.asset(
                            'assets/images/arrow_back.svg',
                            color: Colors.white,
                            matchTextDirection: true,
                          ),
        ),
        actions: [Padding(
          padding:  EdgeInsets.only(right:AppSize().width(context)*0.1),
          child: InkWell(
            onTap:(){
                locator<NavigationService>().navigateToReplace(manageprofile);
      //             
            },
                      child: SvgPicture.asset(
                            'assets/images/settings.svg',
                            color: Colors.white,
                            matchTextDirection: true,
                          ),
          ),
        )],
        backgroundColor: HexColor('#2291FF'),
        title:getBoldText('Profile',
        textColor: Colors.white, fontSize: 18),
        centerTitle: true,
      ),
      backgroundColor:Colors.white,
    body:
    //  Column(
    //   mainAxisAlignment: MainAxisAlignment.start,
    //     children: [
    //       Container(
    //         color:HexColor('#2291FF'),
    //         height: AppSize().height(context)*0.15,
    //       ),
    //       ClipPath(
    //         clipper: ProsteBezierCurve(
    //           position: ClipPosition.bottom,
    //           list: [
    //             BezierCurveSection(
    //               start: Offset(0, 100),
    //               top: Offset(screenWidth / 2, 140),
    //               end: Offset(screenWidth, 100),
    //             ),
    //           ],
    //         ),
    //         child: Container(
    //           height:500,width: AppSize().width(context),
    //           color: HexColor('#2291FF'),
    //         ),
    //       ),
          
    //     ],
    //   ),
  Column(
    children: [
      Container(
          color: Colors.white,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                  child:ClipPath(
                    clipper: ClippingClass(),
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: AppSize().height(context)*0.4,
                    decoration: BoxDecoration(
                      color: Colors.blue
                       ),
                  ),
                ),
              ),

Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                  child:ClipPath(
                    clipper: ClippingClass(),
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: AppSize().height(context)*0.4,
                    decoration: BoxDecoration(
                      color: Colors.transparent
                       ),
                       child: Column(children: [
                         Container(
                                    width:  AppSize().width(context) * 0.25,
                                    height: AppSize().height(context) * 0.2,
                                    decoration: BoxDecoration(
                                      color:Colors.blue[100],
                                      shape: BoxShape.circle,),
                                  child: Center(child: Text('A',style: TextStyle(color:Colors.red),)),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(bottom:AppSize().height(context) * 0.01),
                                    child: getBoldText('John Appleseed',textColor:Colors.white,fontSize:20),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(bottom:AppSize().height(context) * 0.01),
                                    child: getRegularText('Chief of Medicine',textColor:Colors.white,fontSize:16),
                                  ),
                                  getRegularText('Department of Medicine',textColor:Colors.white,fontSize:16),
                                  
                       ],),
                  ),
                ),
              ),
            ],
          ),
        ),
         Padding(
                                    padding:  EdgeInsets.only(bottom:AppSize().height(context) * 0.01,top:AppSize().height(context) * 0.05),
                                    child: getBoldText('Address'.toUpperCase(),textColor:Colors.black,fontSize:14),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(bottom:AppSize().height(context) * 0.01),
                                    child: getRegularText('4331 Oliver Street White Settlement',textColor:Colors.black,fontSize:16),
                                  ),


                                   Padding(
                                    padding:  EdgeInsets.only(bottom:AppSize().height(context) * 0.01,top:AppSize().height(context) * 0.01),
                                    child: getBoldText('Office Phone'.toUpperCase(),textColor:Colors.black,fontSize:14),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(bottom:AppSize().height(context) * 0.01),
                                    child: getRegularText('972-951-6563',textColor:Colors.black,fontSize:16),
                                  ),
    ],
  ));
  }
}

class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height-40);
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
    // ),
//     }
// }




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