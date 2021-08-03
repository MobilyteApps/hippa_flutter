import 'package:app/common/colors.dart';
import 'package:app/common/constants.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:app/screens/colleagues.dart';
import 'package:app/screens/favourite_group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/common/get_it.dart';
import 'package:app/common/navigator_route.dart';
import 'package:app/common/navigator_service.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GroupListing extends StatefulWidget {
  const GroupListing({Key? key}) : super(key: key);

  @override
  _GroupListingState createState() => _GroupListingState();
}

class _GroupListingState extends State<GroupListing>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int a = 0;
  int _selectedIndex = 0;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
    _tabController!.addListener(() {
      setState(() {
        _selectedIndex = _tabController!.index;
      });
      print("Selected Index: " + _tabController!.index.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.only(right: AppSize().width(context) * 0.1),
              child: InkWell(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  locator<NavigationService>().navigateTo(settingsscreen);
                },
                child: SvgPicture.asset(
                  'assets/images/settings.svg',
                  color: AppColor.black,
                  matchTextDirection: true,
                ),
              ),
            )
          ],
          backgroundColor: AppColor.backgroundColor,
          title: getBoldText(
              _tabController!.index == 0
                  ? AppString().grouplisting
                  : 'Favorite Groups',
              textColor: AppColor.black,
              fontSize: 18),
          centerTitle: true,
        ),
        backgroundColor: AppColor.backgroundColor,
        body: Column(
          children: [
            DefaultTabController(
              length: 2,
              child: PreferredSize(
                preferredSize: Size.fromHeight(100),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: AppSize().width(context) * 0.05,
                      right: AppSize().width(context) * 0.05),
                  child: TabBar(
                    onTap: (index) {},
                    isScrollable: false,
                    indicator: BoxDecoration(
                      border: Border.all(width: 100),
                      color: AppColor.buttonColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    unselectedLabelColor: Colors.black,
                    indicatorColor: Colors.green,
                    labelColor: AppColor.white,
                    tabs: [
                      Tab(
                        text: 'Colleagues',
                      ),
                      Tab(
                        text: 'Groups',
                      )
                    ],
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                  ),
                ),
              ),
            ),
            Container(
              height: AppSize().height(context) * 0.8,
              child: TabBarView(
                children: [Colleagues(), FavouriteGroup()],
                controller: _tabController,
              ),
            ),
          ],
        ));
  }
}
