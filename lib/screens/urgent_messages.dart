import 'package:app/common/colleague_detail.dart';
import 'package:app/common/colleagues_search.dart';
import 'package:app/common/colors.dart';
import 'package:app/common/constants.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:app/common/urgent_message.dart';
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

class UrgentMessages extends StatefulWidget {
  const UrgentMessages({Key? key}) : super(key: key);

  @override
  _UrgentMessagesState createState() => _UrgentMessagesState();
}

class _UrgentMessagesState extends State<UrgentMessages> {
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
       appBar: AppBar(
         bottom:PreferredSize(
           child: Container(
             color: Colors.grey,height:1.0),
             preferredSize: Size.fromHeight(4.0)),
        leading: Padding(
          padding:  EdgeInsets.only(top:AppSize().width(context)*0.05,bottom: AppSize().width(context)*0.05,right: AppSize().width(context)*0.01,left: AppSize().width(context)*0.01),
          child: SvgPicture.asset(
                            'assets/images/arrow_back.svg',
                            color: AppColor.black,
                            matchTextDirection: true,
                          ),
        ),
        actions: [Padding(
          padding:  EdgeInsets.only(right:AppSize().width(context)*0.03),
          child: InkWell(
            onTap:(){
                locator<NavigationService>().navigateToReplace(searchcolleagues);
      //             
            },
                      child: Icon(Icons.search,color:HexColor('#608795'))
          ),
        )],
        backgroundColor: Colors.white,
        
        title:getBoldText('Urgent Messages',
            textColor: AppColor.black, fontSize: 18),
        centerTitle: true,
      ),
     

      backgroundColor: HexColor('#E8F4FF'),
      body: 
      //  Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
              
                // Expanded(
                    // width:  AppSize().width(context),
                    // height: AppSize().height(context) * 0.6,
                    // child:
                    ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context,int index){
                    return 
                    InkWell(
                      onTap:(){
                locator<NavigationService>().navigateToReplace(chatscreen);
      //             
            },
                      child: UrgentMessage());
                    
        })
        // ),
              
          //   ],
          // ),
      

    );
  }
}
