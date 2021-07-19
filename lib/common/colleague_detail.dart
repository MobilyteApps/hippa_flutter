import 'package:app/common/colors.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:app/response/getalluser_response.dart';
import 'package:flutter/material.dart';

class ColleagueDetail extends StatelessWidget {
  final GetAllUserResponse getAllUserResponse;
  final int index;
  const ColleagueDetail(this.getAllUserResponse, this.index,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Container(
        width: AppSize().width(context),
        height: AppSize().height(context) * 0.11,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  width: AppSize().width(context) * 0.13,
                  height: AppSize().height(context) * 0.1,
                  // width: 48,
                  // height: 48,
                  decoration: BoxDecoration(
                    color: AppColor.lightBlue,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                      child: Text(
                        getAllUserResponse.data!.users![index].name![0],
                    style: TextStyle(color: Colors.red),
                  )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getBoldText(getAllUserResponse.data!.users![index].username??'',
                      textColor: AppColor.black, fontSize: 16),
                  SizedBox(height: AppSize().height(context)*0.01,),
                  getRegularText(getAllUserResponse.data!.users![index].role!,
                      textColor: AppColor.black, fontSize: 14),
                  SizedBox(height: AppSize().height(context)*0.01,),
                  getRegularText(getAllUserResponse.data!.users![index].name!,
                      textColor: AppColor.black, fontSize: 14),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
