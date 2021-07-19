import 'package:app/common/colleagues_info.dart';
import 'package:app/common/colors.dart';
import 'package:app/common/constants.dart';
import 'package:app/common/get_it.dart';
import 'package:app/common/navigator_service.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class GroupDetail extends StatefulWidget {
  const GroupDetail({Key? key}) : super(key: key);

  @override
  _GroupDetailState createState() => _GroupDetailState();
}

class _GroupDetailState extends State<GroupDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            locator<NavigationService>().backPress();
          },
          child: Padding(
            padding: EdgeInsets.all(AppSize().width(context) * 0.05),
            child: SvgPicture.asset(
              'assets/images/arrow_back.svg',
              color: AppColor.black,
              matchTextDirection: true,
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: (){

            },
            child: Padding(
              padding: EdgeInsets.only(right: AppSize().width(context) * 0.03),
              child: Icon(Icons.delete_forever,color: Colors.red,)
            ),
          )
        ],
        backgroundColor: AppColor.backgroundColor,
        title: getBoldText('Group',
            textColor: AppColor.black, fontSize: 18),
        centerTitle: true,
      ),
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(
          left: AppSize().width(context) * 0.1,
          right: AppSize().width(context) * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSize().height(context) * 0.02),
            getBoldText('Group Name',
                textColor: AppColor.black, fontSize: 16),
            SizedBox(height: AppSize().height(context) * 0.02),
            getBoldText('XYZ Group',
                textColor: AppColor.black, fontSize: 16),
            SizedBox(height: AppSize().height(context) * 0.02),
            getBoldText('Colleagues',
                textColor: AppColor.black, fontSize: 16),
             ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return
                        // ids.contains(apiProvider.getAllUserResponse.data!.users![index].sId.toString())?Container():
                        InkWell(
                            onTap: (){
                              // ids.add(apiProvider.getAllUserResponse.data!.users![index].sId.toString());
                              setState(() {

                              });
                              // print(apiProvider.getAllUserResponse.data!.users![index].sId);
                              // userids.add(User(id: apiProvider.getAllUserResponse.data!.users![index].sId, name: apiProvider.getAllUserResponse.data!.users![index].name));
                              // print("length"+userids.length.toString());
                              // print(userids.toList().toString());


                            },
                            child: ColleagueInfo());
                    })
          ],
        ),
      ),
    );
  }
}
