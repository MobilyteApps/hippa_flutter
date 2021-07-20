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
    List<String> group_name = [ 'Add New'];
    List<Color> colors = [
      AppColor.starGrey,
      AppColor.starOrange,
      AppColor.starblue,
      AppColor.starGreen,
      AppColor.starGrey
    ];
    return Container(
        width: AppSize().width(context) * 0.4,
        height: AppSize().height(context) * 0.63,
        decoration: BoxDecoration(
          color: colors[index],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/add-circle.svg',
                width: AppSize().width(context) * 0.4,
                height: AppSize().height(context) * 0.09,
                color: AppColor.white,
                matchTextDirection: true,
              ),
              Padding(
                padding: EdgeInsets.only(top:AppSize().height(context)*0.03 ),
                child: getMediumText(group_name[index],
                    textColor: AppColor.white, fontSize: 18),
              ),
            ],
          ),
        ));
  }
}
