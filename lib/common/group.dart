import 'package:app/common/colors.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class Group extends StatelessWidget {
  final int index;
  Group(this.index);
  @override
  Widget build(BuildContext context) {
    List<String> group_name=['My Team','Our Nurses','Clinic','Add New'];
    List<HexColor>colors=[HexColor('#F98055'),HexColor('#6A8AFC'),HexColor('#23BCA2'),HexColor('#608795')];
    return  Container(
        
        width: AppSize().width(context)*0.4,
        height:AppSize().height(context)*0.63,
        decoration: BoxDecoration(
        color:colors[index],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child:
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                              
                  
                    

          SvgPicture.asset(
                            'assets/images/stars.svg',
        width: AppSize().width(context)*0.4,
        height:AppSize().height(context)*0.09,
                            color: Colors.white,
                            matchTextDirection: true,
                          ),
      
                 
                    Padding(
                      padding:  EdgeInsets.only(top:8.0),
                      child: getRegularText(group_name[index], textColor: AppColor.black,fontSize:18),
                    ),

                            ],
                          ),
                        )
      );
  }
}