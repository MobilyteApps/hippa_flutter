import 'package:app/common/colors.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class UrgentMessage extends StatelessWidget {
  const UrgentMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize().width(context),
      height: AppSize().height(context) * 0.11,
      decoration: BoxDecoration(
          color: AppColor.white,
          border: Border(bottom: BorderSide(width: 1, color: AppColor.grey))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                width: AppSize().width(context) * 0.16,
                height: AppSize().height(context) * 0.2,
                decoration: BoxDecoration(
                  color: AppColor.lightBlue,
                  shape: BoxShape.circle,
                ),
                child: Center(
                    child: Text(
                  'A',
                  style: TextStyle(color: Colors.red),
                )),
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
                      getRegularText('Yesterday',
                          textColor: AppColor.starGrey, fontSize: 10),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: AppSize().height(context) * 0.015),
                        child: getBoldText('This Looks Great!',
                            textColor: AppColor.buttonColor, fontSize: 14),
                      ),
                      Container(
                          width: AppSize().width(context) * 0.05,
                          height: AppSize().height(context) * 0.03,
                          decoration: BoxDecoration(
                            color: AppColor.red,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                              child: Text('2',
                                  style: TextStyle(color: AppColor.white))))
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
