import 'package:app/common/get_it.dart';
import 'package:app/common/group.dart';
import 'package:app/common/navigator_route.dart';
import 'package:app/common/navigator_service.dart';
import 'package:app/common/size.dart';
import 'package:flutter/material.dart';

class FavouriteGroup extends StatefulWidget {
  const FavouriteGroup({Key? key}) : super(key: key);

  @override
  _FavouriteGroupState createState() => _FavouriteGroupState();
}

class _FavouriteGroupState extends State<FavouriteGroup> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: AppSize().width(context) * 0.05,
          left: AppSize().width(context) * 0.05,
        right: AppSize().width(context) * 0.05),
      child: GridView.builder(
        itemCount: 1,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          // childAspectRatio: (2 / 1),
        ),
        itemBuilder: (
          context,
          index,
        ) {
          return GestureDetector(onTap: () {
            // if(index==4){
              locator<NavigationService>().navigateTo(creategroup);
            // }
          }, child: Group(index));
        },
      ),
    );
  }
}
