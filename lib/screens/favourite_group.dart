import 'dart:async';

import 'package:app/common/colors.dart';
import 'package:app/common/get_it.dart';
import 'package:app/common/group.dart';
import 'package:app/common/navigator_route.dart';
import 'package:app/common/navigator_service.dart';
import 'package:app/common/size.dart';
import 'package:app/common/utils.dart';
import 'package:app/models/loader.dart';
import 'package:app/network/api_provider.dart';
import 'package:app/providers/signin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'create_group.dart';

class FavouriteGroup extends StatefulWidget {
  const FavouriteGroup({Key? key}) : super(key: key);

  @override
  _FavouriteGroupState createState() => _FavouriteGroupState();
}

class _FavouriteGroupState extends State<FavouriteGroup> {
  ApiProvider apiProvider = ApiProvider();
  final _debouncer = Debouncer(milliseconds: 500);
  int memberCount = 1;
  final creategroupctrl = TextEditingController();
  final addmemberctrl = TextEditingController();
  SignInProvider signInProvider = SignInProvider();
  Loader loader = Loader();
  final border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
        color: AppColor.white,
      ));
  int a = 0;
  ApiProvider apis = ApiProvider();
  User users = User();
  List<String> ids = [];
  List<User> userids = <User>[];
  String documentPath = "";
  String url = '';
  late String sids;
  bool check = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sid();
  }

  void sid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sids = prefs.getString('sid')!;
    // prefs.setString('gid', '');
    setState(() {
      check = true;
    });
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    final signInProvider = Provider.of<SignInProvider>(context);
    final loader = Provider.of<Loader>(context);

    if (this.signInProvider != signInProvider || this.loader != loader) {
      this.signInProvider = signInProvider;
      this.loader = loader;

      Timer(Duration(seconds: 2), () {
        var input = {"user_id": sids};
        Future.microtask(() async {
          signInProvider.viewgrouplist(loader, input);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return apiProvider.viewGroupListingResponse.data == null
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: EdgeInsets.only(
                top: AppSize().width(context) * 0.05,
                left: AppSize().width(context) * 0.05,
                right: AppSize().width(context) * 0.05),
            child: GridView.builder(
              itemCount: apiProvider.viewGroupListingResponse.data!.length + 1,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  // childAspectRatio: 2 / 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              // crossAxisCount: 2,
              // crossAxisSpacing: 8,
              // mainAxisSpacing: 8,
              // childAspectRatio: (2 / 1),
              // ),
              itemBuilder: (BuildContext ctx, index) {
                return GestureDetector(
                    onTap: () async {
                      if (index == 0) {
                        locator<NavigationService>().navigateTo(creategroup);
                      } else {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        // prefs.setString(
                        //     'gid',
                        //     apiProvider.viewGroupListingResponse
                        //         .data![index - 1].sId!);
                            locator<NavigationService>().argsnavigateToReplace(groupdetails,apiProvider.viewGroupListingResponse
                                .data![index - 1].sId!);
                        // locator<NavigationService>().argsnavigateToReplace(groupdetails, apiProvider.viewGroupListingResponse
                        //     .data![index - 1].sId!);
                      }
                    },
                    child: Group(index, apiProvider.viewGroupListingResponse));
              },
            ),
          );
  }
}
