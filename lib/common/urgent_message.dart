import 'package:app/common/colors.dart';
import 'package:app/common/constants.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class UrgentMessage extends StatelessWidget {
  const UrgentMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
       Container(
        
        width: AppSize().width(context),
        height:AppSize().height(context)*0.11,
        decoration: BoxDecoration(
        color:Colors.white,
          // borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border(bottom: BorderSide(width: 1,color:Colors.grey))
        ),
        child:
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: 
                  Center(
                    
                     child: Container(
                                width:  AppSize().width(context) * 0.16,
                                height: AppSize().height(context) * 0.2,
                                decoration: BoxDecoration(
                                  color:Colors.blue[100],
                                  shape: BoxShape.circle,),
                              child: Center(child: Text('A',style: TextStyle(color:Colors.red),)),
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
                               Row(
                                 crossAxisAlignment: CrossAxisAlignment.center,
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                getBoldText('Justin Oliver',
                    textColor: AppColor.black, fontSize: 16),
                  // SizedBox(width:  AppSize().width(context) * 0.28,),
                  
          
          
             
                getRegularText('Yesterday', textColor: HexColor('#608795'),fontSize:10),
             
                               ],
                               ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Padding(
                            padding:  EdgeInsets.only(top:AppSize().height(context)*0.015),
                            child: getBoldText('This Looks Great!', textColor: HexColor('#2291FF'),fontSize:14),
                          ),

                          Container(
                            width:  AppSize().width(context) * 0.05,
                            height: AppSize().height(context) * 0.03,
                            decoration: BoxDecoration(
                              color:HexColor('#FF0000'),
                              shape: BoxShape.circle,),
                              child:Center(child: Text('2',style:TextStyle(color:Colors.white))))                   
                          
                      ],
                    ),
           
                              ],
                            ),
                          ),
                        )
          ],
        ),
      
    );
  }
}