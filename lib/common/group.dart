import 'package:app/common/colors.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:app/response/viewgrouplistingresponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class Group extends StatelessWidget {
  final ViewGroupListingResponse viewGroupListingResponse;
  final int index;

  Group(this.index, this.viewGroupListingResponse);

  @override
  Widget build(BuildContext context) {
    List<String> group_name = ['Add New'];
    List<Color> colors = [
      // AppColor.starGrey,
      AppColor.starOrange,
      AppColor.starblue,
      AppColor.starGreen,
    ];
    return index == 0
        ? Container(
            width: AppSize().width(context) * 0.4,
            height: AppSize().height(context) * 0.63,
            decoration: BoxDecoration(
              color: AppColor.starGrey,
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
                    padding:
                        EdgeInsets.only(top: AppSize().height(context) * 0.03),
                    child: getMediumText('Add New',
                        textColor: AppColor.white, fontSize: 18),
                  ),
                ],
              ),
            ))
        : Container(
            width: AppSize().width(context) * 0.4,
            height: AppSize().height(context) * 0.63,
            decoration: BoxDecoration(
              color: colors[index % 3],
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/stars.svg',
                    width: AppSize().width(context) * 0.4,
                    height: AppSize().height(context) * 0.09,
                    color: AppColor.white,
                    matchTextDirection: true,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: AppSize().height(context) * 0.03),
                    child: getMediumText(
                        viewGroupListingResponse.data![index - 1].title!,
                        textColor: AppColor.white,
                        fontSize: 18),
                  ),
                ],
              ),
            ));
  }
}
