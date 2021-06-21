import 'package:app/common/colleague_detail.dart';
import 'package:app/common/colleagues_search.dart';
import 'package:app/common/colors.dart';
import 'package:app/common/constants.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:flutter/cupertino.dart';
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

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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


        return Scaffold(
           appBar: AppBar(
             bottom:PreferredSize(
               child: Container(
                 color: Colors.grey,height:1.0),
                 preferredSize: Size.fromHeight(4.0)),
            leading: Padding(
              padding:  EdgeInsets.only(top:AppSize().width(context)*0.05,bottom: AppSize().width(context)*0.05,right: AppSize().width(context)*0.05,left: AppSize().width(context)*0.07),
              child: SvgPicture.asset(
                                'assets/images/arrow_back.svg',
                                color: AppColor.black,
                                matchTextDirection: true,
                              ),
            ),
            actions: [Padding(
              padding:  EdgeInsets.only(right:AppSize().width(context)*0.1),
              child: InkWell(
                onTap:(){
                    locator<NavigationService>().navigateToReplace(urgentmessages);
          //             
                },
                          child: SvgPicture.asset(
                                'assets/images/settings.svg',
                                color: AppColor.black,
                                matchTextDirection: true,
                              ),
              ),
            )],
            backgroundColor: Colors.white,
            
            title:getBoldText('Settinngs',
                textColor: AppColor.black, fontSize: 18),
            centerTitle: true,
          ),
         
    
          backgroundColor:Colors.white,
          body: 
                 Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [              
                  InkWell(
                    onTap: (){
                       locator<NavigationService>().navigateToReplace(profile);
       
                    },
                                  child: Container(
            
            width: AppSize().width(context),
            height:AppSize().height(context)*0.11,
            decoration: BoxDecoration(
            color:Colors.white,
              // borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border(bottom: BorderSide(width: 1,color:Colors.grey))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                                SizedBox(width: AppSize().width(context)*0.05,),
            SvgPicture.asset(
                                  'assets/images/user_circle.svg',
                                  color: HexColor('#2291FF'),
                                  matchTextDirection: true,
                                ),
                                SizedBox(width: AppSize().width(context)*0.05,),
             getBoldText('Manage Profile', textColor: AppColor.black,fontSize:18),
               
              ],
            ),),
                  ),
    
     Container(
            
            width: AppSize().width(context),
            height:AppSize().height(context)*0.15,
            decoration: BoxDecoration(
            color:Colors.white,
              // borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border(bottom: BorderSide(width: 1,color:Colors.grey))
            ),
            child: Column(
              children: [
                SizedBox(height: AppSize().height(context)*0.03,),
               
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                                  SizedBox(width: AppSize().width(context)*0.05,),
                SvgPicture.asset(
                                    'assets/images/notifications.svg',
                                    color: HexColor('#2291FF'),
                                    matchTextDirection: true,
                                  ),
                                  SizedBox(width: AppSize().width(context)*0.05,),
                 getBoldText('Manage Notification', textColor: AppColor.black,fontSize:18),
                   
                  ],
                ),
                SizedBox(height: AppSize().height(context)*0.01,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                 Padding(
                   padding:  EdgeInsets.only(left:  AppSize().width(context) * 0.15,),
                   child: getBoldText('Do not Distrub', textColor: AppColor.black,fontSize:18),
                 ),
                 Switch(  
                  onChanged: toggleSwitch,  
                  value: isSwitched,  
                  activeColor: Colors.blue,  
                  activeTrackColor: Colors.yellow,  
                  inactiveThumbColor: HexColor('#B1CDD7'),  
                  inactiveTrackColor: HexColor('#B1CDD7'),  
                )  
                  ],
                ),
              ],
            ),),
    
            InkWell(
              onTap: (){
                  locator<NavigationService>().navigateToReplace(managereply);
              },
                      child: Container(
              
              width: AppSize().width(context),
              height:AppSize().height(context)*0.11,
              decoration: BoxDecoration(
              color:Colors.white,
                // borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border(bottom: BorderSide(width: 1,color:Colors.grey))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                                SizedBox(width: AppSize().width(context)*0.05,),
              SvgPicture.asset(
                                  'assets/images/chat_bubble.svg',
                                  color: HexColor('#2291FF'),
                                  matchTextDirection: true,
                                ),
                                SizedBox(width: AppSize().width(context)*0.05,),
               getBoldText('Manage Replies', textColor: AppColor.black,fontSize:18),
                 
                ],
              ),),
            ),
    
    
            Container(
            
            width: AppSize().width(context),
            height:AppSize().height(context)*0.11,
            decoration: BoxDecoration(
            color:Colors.white,
              // borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border(bottom: BorderSide(width: 1,color:Colors.grey))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                              SizedBox(width: AppSize().width(context)*0.05,),
            SvgPicture.asset(
                                'assets/images/group.svg',
                                color: HexColor('#2291FF'),
                                matchTextDirection: true,
                              ),
                              SizedBox(width: AppSize().width(context)*0.05,),
             getBoldText('Manage Groups', textColor: AppColor.black,fontSize:18),
               
              ],
            ),),
    
    
    
            
            InkWell(
              onTap: (){
                showCupertinoDialog(
                  context:context,
                  builder: (BuildContext context){
                  return
                CupertinoAlertDialog(
    title: getBoldText('Sign Out',textColor:AppColor.black,fontSize:18),
    content:getRegularText('Are you sure you want to sign out to SecureText',textColor:AppColor.black,fontSize:18),
    actions: [
      CupertinoDialogAction(
        child:getBoldText('CANCEL',textColor:AppColor.black,fontSize:14),onPressed: (){},
            ),
      CupertinoDialogAction(
         child:getBoldText('SIGNOUT',textColor:HexColor('#2291FF'),fontSize:14),onPressed: (){},

            ),
    ],
            );});
              },
                  child: Container(
          
          width: AppSize().width(context),
          height:AppSize().height(context)*0.11,
          decoration: BoxDecoration(
          color:Colors.white,
            // borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border(bottom: BorderSide(width: 1,color:Colors.grey))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                            SizedBox(width: AppSize().width(context)*0.05,),
          SvgPicture.asset(
                              'assets/images/off.svg',
                              color: HexColor('#2291FF'),
                              matchTextDirection: true,
                            ),
                            SizedBox(width: AppSize().width(context)*0.05,),
           getBoldText('Sign Out', textColor: AppColor.black,fontSize:18),
             
            ],
          ),),
        ),
            ],
          ),
    );
  }
}
