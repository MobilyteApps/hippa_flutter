import 'package:app/common/colors.dart';
import 'package:app/common/constants.dart';
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

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
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
          focusedBorder: border,
          enabledBorder: border,
          disabledBorder: border,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.white,)
          ),
          hintStyle: TextStyle(
            color: HexColor("#0E3746"),
            fontSize: 16,
            fontFamily: 'PoppinsSemiBold',
            fontWeight: FontWeight.w600,
          ),
          // hintStyle: TextStyle(color: greyColor, fontSize: 16),
          filled: true,
          fillColor: Colors.white,
          hintText: 'Group ABC'),
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding:  EdgeInsets.all(AppSize().width(context)*0.05),
          child: SvgPicture.asset(
                            'assets/images/arrow_back.svg',
                            color: AppColor.black,
                            matchTextDirection: true,
                          ),
        ),
        actions: [Padding(
          padding:  EdgeInsets.only(right:AppSize().width(context)*0.03),
          child: SvgPicture.asset(
                          'assets/images/settings.svg',
                          color: AppColor.black,
                          matchTextDirection: true,
                        ),
        )],
        backgroundColor: HexColor('#E8F4FF'),
        title:getBoldText(AppString().creategroup,
            textColor: AppColor.black, fontSize: 18),
        centerTitle: true,
      ),
      backgroundColor: HexColor('#E8F4FF'),
      body: SingleChildScrollView(
              child: Padding(
          padding: EdgeInsets.only(
              left: AppSize().width(context) * 0.1,
              right: AppSize().width(context) * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: AppSize().height(context) * 0.1),
              getBoldText(AppString().groupname,
                  textColor: AppColor.black, fontSize: 16),
              SizedBox(height: AppSize().height(context) * 0.02),
              // getRegularText(AppString().groupname,
              //     textColor: AppColor().black, fontSize: 16),
              groupnameFieldWidget(),
              SizedBox(height: AppSize().height(context) * 0.02),
              getBoldText(AppString().addteammember,
                  textColor: AppColor.black, fontSize: 16),
                  // Container(
                  //   width:  AppSize().width(context),
                  //   height: AppSize().height(context) * 0.2,
                  //   child: memberlist()),
                  // memberWidget(),
                  Container(
                    width:  AppSize().width(context),
                    height: AppSize().height(context) * 0.14,
                    child:ListView.builder(
                    itemCount: memberCount+1,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context,int index){
                    return 
                    index!=memberCount?memberWidget():addWidget();
                    
        })),
              Padding(
                padding: EdgeInsets.only(top: AppSize().height(context) * 0.02),
                child: SizedBox(
                  height: AppSize().height(context) * 0.07,
                  width: AppSize().width(context) * 0.8,
                  child: RaisedButton(
                    color: Colors.white,
                    child: getBoldText(AppString().cancel,
                        textColor: AppColor.black, fontSize: 14),
                    // child: Text(AppString().cancel,style:TextStyle(color:AppColor.blue,)),
                    onPressed: () {
                      locator<NavigationService>().navigateToReplace(otpscreen);
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: AppSize().height(context) * 0.02),
                child: SizedBox(
                  height: AppSize().height(context) * 0.07,
                  width: AppSize().width(context) * 0.8,
                  child: RaisedButton(
                    color: HexColor('#2291FF'),
                    child: getBoldText(AppString().confirm,
                        textColor: Colors.white, fontSize: 14),
                    // child: Text(AppString().accept,style:TextStyle(color:Colors.white)),
                    onPressed: () {
                      locator<NavigationService>().navigateToReplace(grouplisting);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
