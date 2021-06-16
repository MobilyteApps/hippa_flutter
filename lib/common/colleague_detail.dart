import 'package:app/common/colors.dart';
import 'package:app/common/constants.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:flutter/material.dart';

class ColleagueDetail extends StatelessWidget {
  const ColleagueDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:5,bottom: 5),
      child: Container(
        
        width: AppSize().width(context),
        height:AppSize().height(context)*0.11,
        decoration: BoxDecoration(
        color:Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child:
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    
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

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getBoldText('Justin Oliver',
                    textColor: AppColor.black, fontSize: 16),
                    getRegularText('physician', textColor: AppColor.black,fontSize:14),
                    getRegularText('12 Johnson Thoroughway', textColor: AppColor.black,fontSize:14),

                            ],
                          ),
                        )
          ],
        ),
      ),
    );
  }
}