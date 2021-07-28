import 'dart:async';

import 'package:app/common/colleague_detail.dart';
import 'package:app/common/colleagues_info.dart';
import 'package:app/common/colors.dart';
import 'package:app/common/constants.dart';
import 'package:app/common/get_it.dart';
import 'package:app/common/navigator_route.dart';
import 'package:app/common/navigator_service.dart';
import 'package:app/common/size.dart';
import 'package:app/common/testing.dart';
import 'package:app/common/textstyle.dart';
import 'package:app/common/utils.dart';
import 'package:app/models/loader.dart';
import 'package:app/network/api_provider.dart';
import 'package:app/providers/signin_provider.dart';
import 'package:app/response/groupleave_response.dart';
import 'package:app/screens/create_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupDetail extends StatefulWidget {
  final String? index;

  GroupDetail({
    required this.index,
  });

  // final int index;
  //
  //
  // const GroupDetail(this.index);

  @override
  _GroupDetailState createState() => _GroupDetailState();
}

class _GroupDetailState extends State<GroupDetail> {
  ApiProvider apiProvider = ApiProvider();
  final _debouncer = Debouncer(milliseconds: 500);
  int memberCount = 1;
  final creategroupctrl = TextEditingController();
  SignInProvider signInProvider = SignInProvider();
  Loader loader = Loader();
  final border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
        color: AppColor.white,
      ));
  int a = 0;
  bool checker = false;
  List<String> ids = [];
  List<User> userids = <User>[];
  List<String> i = [];
  late String sids;
  late String gid;
  bool check = false;
  bool add = false;
  final addmemberctrl = TextEditingController();
  bool fav = false;
  bool changetitle = false;
  bool checking=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sid();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    final signInProvider = Provider.of<SignInProvider>(context);
    final loader = Provider.of<Loader>(context);

    if (this.signInProvider != signInProvider || this.loader != loader) {
      this.signInProvider = signInProvider;
      this.loader = loader;
      // Timer(Duration(seconds: 2), () {
      //   Future.microtask(() async {
      signInProvider.getallusers(loader, '');
      //   });
      // });
    }
  }

  void sid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sids = prefs.getString('sid')!;
    gid = widget.index!;
    formValidations();
    setState(() {
      check = true;
    });
  }

  formValidations() async {
    String id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = widget.index!;
    ids.add(id);
    prefs.setString('gid', id);

    var input = {"group_id": id};
    // Timer(Duration(seconds: 2), () {
    // Future.microtask(() async {
    signInProvider.groupdetail(
      loader,
      input,
    );
    // });
    // });

    Timer(Duration(seconds: 2), () {
      Future.microtask(() async {
        setState(() {
          checker = true;
        });
      });
    });
  }

  Widget groupnameFieldWidget() {
    return TextFormField(
      controller: creategroupctrl,
      inputFormatters: [
        new WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9@.+-_ ]")),
      ],
      decoration: InputDecoration(
          focusedBorder: border,
          enabledBorder: border,
          disabledBorder: border,
          isDense: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                color: AppColor.white,
              )),
          hintStyle: TextStyle(
            color: AppColor.textColor,
            fontSize: 16,
            fontFamily: 'PoppinsSemiBold',
            fontWeight: FontWeight.w600,
          ),
          // hintStyle: TextStyle(color: greyColor, fontSize: 16),
          filled: true,
          fillColor: AppColor.white,
          hintText: 'Group ABC'),
    );
  }

  Widget addWidget() {
    return InkWell(
      onTap: () {
        setState(() {
          memberCount++;
        });
      },
      child: Container(
          width: AppSize().width(context) * 0.16,
          height: AppSize().height(context) * 0.2,
          decoration: BoxDecoration(
            color: AppColor.white,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.add,
            size: 40,
            color: AppColor.blue,
          )),
    );
  }

  Widget memberWidget(List<User> u, int index) {
    return Padding(
      padding: EdgeInsets.only(right: AppSize().width(context) * 0.05),
      child: Stack(
        children: [
          Container(
            width: AppSize().width(context) * 0.16,
            height: AppSize().height(context) * 0.2,
            decoration: BoxDecoration(
              color: AppColor.white,
              shape: BoxShape.circle,
            ),
            child: Center(
                child: Text(
              u[index].name![0],
              style: TextStyle(color: Colors.red),
            )),
          ),
          Positioned(
              left: AppSize().width(context) * 0.11,
              child: InkWell(
                onTap: () {
                  setState(() {
                    ids.remove(u[index].id!);
                    i.remove(u[index].id!);
                    // ids.removeAt(index);
                    // print(ids);
                    u.removeAt(index);
                  });
                },
                child: Container(
                    width: AppSize().width(context) * 0.05,
                    height: AppSize().height(context) * 0.09,
                    decoration: BoxDecoration(
                      color: AppColor.red,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 10,
                      color: AppColor.white,
                    )),
              )),
        ],
      ),
    );
  }

  Widget addmemberFieldWidget() {
    return TextFormField(
      controller: addmemberctrl,
      onChanged: (v) {
        _debouncer.run(() {
          // signInProvider.getallusers(loader, addmemberctrl.text.trim());
          signInProvider.getallusers(loader, v.trim());
        });
      },
      inputFormatters: [
        new WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9@.+-_ ]")),
      ],
      decoration: InputDecoration(
          suffixIcon: Icon(Icons.search_sharp, color: AppColor.starGrey),
          focusedBorder: border,
          enabledBorder: border,
          disabledBorder: border,
          isDense: false,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                color: AppColor.white,
              )),
          hintStyle: TextStyle(
            color: AppColor.textColor,
            fontSize: 16,
            fontFamily: 'JosenfinSansRegular',
            fontWeight: FontWeight.w400,
          ),
          // hintStyle: TextStyle(color: greyColor, fontSize: 16),
          filled: true,
          contentPadding: new EdgeInsets.only(left: 10, top: 10),
          fillColor: AppColor.white,
          hintText: 'Search'),
    );
  }

  Widget memberlist() {
    return ListView.builder(
        itemCount: userids.length,
        itemBuilder: (BuildContext context, int index) {
          return memberWidget(userids, index);
        });
  }

  formValidationer() async {
    String id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = widget.index!;
    ids.add(id);
    var input = {"members_id": i, "group_id": "${id.toString()}"};
    print(input.toString());
    print("________-");
    // signInProvider.addusertogroup(loader, input);
  }

  delformValidationer() async {
    String id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = widget.index!;
    ids.add(id);
    var input = {"group_id": "${id.toString()}"};
    print(input.toString());
    print("________-");
    signInProvider.deletegroup(loader, input);
  }

  updategroup() async {
    String id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = widget.index!;
    ids.add(id);

    if (creategroupctrl.text.trim() == "") {
      ApiProvider().showToastMsg('Enter valid group name');
    }
    var input = {
      "group_id": "${id.toString()}",
      "title": creategroupctrl.text.trim(),
      "groupImage": "AWS link--2"
    };
    print(input.toString());
    print("________-");
    signInProvider.updategroup(loader, input);
  }

  formValidation(String userid, String groupid) async {
    String id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('sid')!;
    var input = {
      "user_id": userid,
      "group_id": groupid,
    };

    print(input.toString());
    print("________-");
    signInProvider.groupleave(loader, input, groupid);
   setState(() {
     checking=true;
   });

    Timer(Duration(seconds: 5), () {
      Future.microtask(() async {
        setState(() {
          checking=false;
        });
    // signInProvider.getallusers(loader, '');
      });
    });
  }

  formValidationss(String userid, String groupid) async {
    String id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('sid')!;
    var input = {
      "user_id": userid,
      "group_id": groupid,
    };

    print(input.toString());
    print("________-");
    signInProvider.groupleaves(loader, input, groupid);
  }

  removeformValidation(String userid, String groupid) async {
    String id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('sid')!;
    var input = {
      "user_id": userid,
      "group_id": groupid,
    };

    print(input.toString());
    print("________-");
    signInProvider.removegroupleave(loader, input);
  }

  favformValidation() async {
    String id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('sid')!;

    var input = {
      "user_id": sids,
      "group_id": gid,
    };

    print(input.toString());
    print("________-");
    signInProvider.addfav(loader, input);
  }

  remfavformValidation() async {
    String id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('sid')!;
    var input = {
      "user_id": sids,
      "group_id": gid,
    };

    print(input.toString());
    print("________-");
    signInProvider.remfav(loader, input);
  }

  @override
  Widget build(BuildContext context) {
    return checker == false
        ? Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: () {
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
                apiProvider.groupDetailResponse.data == null
                    ? Container()
                    : apiProvider.groupDetailResponse.data![0].favGroup ==
                                false ||
                            fav == false
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                fav = true;
                                apiProvider.groupDetailResponse.data![0]
                                    .favGroup = true;
                              });
                              favformValidation();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: AppSize().width(context) * 0.03),
                              child: SvgPicture.asset(
                                'assets/images/stars.svg',
                                width: AppSize().width(context) * 0.4,
                                height: AppSize().height(context) * 0.04,
                                color: AppColor.starblue,
                                matchTextDirection: true,
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              setState(() {
                                fav = false;
                                apiProvider.groupDetailResponse.data![0]
                                    .favGroup = false;
                              });
                              remfavformValidation();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: AppSize().width(context) * 0.03),
                              child: SvgPicture.asset(
                                'assets/images/stars.svg',
                                width: AppSize().width(context) * 0.4,
                                height: AppSize().height(context) * 0.04,
                                color: Colors.red,
                                matchTextDirection: true,
                              ),
                            ),
                          ),
                apiProvider.groupDetailResponse.data == null || check == false
                    ? Center(child: Container())
                    : sids != apiProvider.groupDetailResponse.data![0].admin
                        ? Container()
                        : InkWell(
                            onTap: () {
                              delformValidationer();
                            },
                            child: Padding(
                                padding: EdgeInsets.only(
                                    right: AppSize().width(context) * 0.03),
                                child: Icon(
                                  Icons.delete_forever,
                                  color: Colors.red,
                                )),
                          )
              ],
              backgroundColor: AppColor.backgroundColor,
              title:
                  getBoldText('Group', textColor: AppColor.black, fontSize: 18),
              centerTitle: true,
            ),
            backgroundColor: AppColor.backgroundColor,
            body: Stack(children: [
              apiProvider.groupDetailResponse.data == null || check == false
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: AppSize().width(context) * 0.05,
                            right: AppSize().width(context) * 0.05),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: AppSize().height(context) * 0.02),
                            getBoldText('Group Name',
                                textColor: AppColor.black, fontSize: 16),
                            SizedBox(height: AppSize().height(context) * 0.02),
                            changetitle == false
                                ? Row(
                                    children: [
                                      getBoldText(
                                          apiProvider.groupDetailResponse
                                              .data![0].title!,
                                          textColor: AppColor.black,
                                          fontSize: 16),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            // delformValidationer();
                                            creategroupctrl.text = apiProvider
                                                .groupDetailResponse
                                                .data![0]
                                                .title!;

                                            changetitle = true;
                                          });
                                        },
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                left: AppSize().width(context) *
                                                    0.03,
                                                right:
                                                    AppSize().width(context) *
                                                        0.03),
                                            child: Icon(
                                              Icons.edit,
                                              color: Colors.grey,
                                              size: 14,
                                            )),
                                      )
                                    ],
                                  )
                                : groupnameFieldWidget(),
                            SizedBox(height: AppSize().height(context) * 0.02),
                            changetitle == true
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: AppSize().height(context) *
                                                0.02),
                                        child: SizedBox(
                                          height:
                                              AppSize().height(context) * 0.04,
                                          width: AppSize().width(context) * 0.3,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                AppColor.white,
                                              ),
                                            ),
                                            child: getBoldText(
                                                AppString().cancel,
                                                textColor: AppColor.black,
                                                fontSize: 14),
                                            onPressed: () {
                                              setState(() {
                                                changetitle = false;
                                              });
                                              // locator<NavigationService>().navigateToReplace(otpscreen);
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: AppSize().height(context) *
                                                0.02),
                                        child: SizedBox(
                                          height:
                                              AppSize().height(context) * 0.04,
                                          width: AppSize().width(context) * 0.3,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                AppColor.buttonColor,
                                              ),
                                            ),
                                            //  RaisedButton(
                                            //   color: AppColor.buttonColor,
                                            child: getBoldText(
                                                AppString().confirm,
                                                textColor: AppColor.white,
                                                fontSize: 14),
                                            onPressed: () {
                                              updategroup();
                                              setState(() {
                                                changetitle = false;
                                              });
                                              Timer(Duration(seconds: 2), () {
                                                sid();
                                              });
                                              // print(ids.toList().toString());
                                              // locator<NavigationService>()
                                              //     .navigateToReplace(grouplisting);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            SizedBox(height: AppSize().height(context) * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                getBoldText('Colleagues',
                                    textColor: AppColor.black, fontSize: 16),
                                apiProvider.groupDetailResponse.data == null &&
                                        check == false
                                    ? Center(child: Container())
                                    : sids !=
                                            apiProvider.groupDetailResponse
                                                .data![0].admin
                                        ? Container()
                                        : InkWell(
                                            onTap: () {
                                              setState(() {
                                                add = true;
                                              });

                                              showModalBottomSheet(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                              top: Radius
                                                                  .circular(
                                                                      25.0))),
                                                  backgroundColor: Colors.white,
                                                  context: context,
                                                  isScrollControlled: true,
                                                  builder: (context) =>
                                                      HomeScreenn());
                                            },
                                            child: Icon(
                                              Icons.add,
                                              color: AppColor.black,
                                              size: 16,
                                            ))
                              ],
                            ),
                            SizedBox(height: AppSize().height(context) * 0.02),
                            apiProvider.groupDetailResponse.data == null &&
                                    check == false
                                ? Center(child: CircularProgressIndicator())
                                : ListView.builder(
                                    itemCount: apiProvider.groupDetailResponse
                                        .data![0].members!.length,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      ids.add(apiProvider.groupDetailResponse
                                          .data![0].members![index].sId
                                          .toString());
                                      return ColleagueInfo(
                                          apiProvider.groupDetailResponse,
                                          index,
                                          sids, () {
                                        ids.remove(apiProvider
                                            .getAllUserResponse
                                            .data!
                                            .users![index]
                                            .sId
                                            .toString());

                                        formValidation(
                                            apiProvider.groupDetailResponse
                                                .data![0].members![index].sId!,
                                            apiProvider.groupDetailResponse
                                                .data![0].sId!);
                                      }, () {
                                        ids.remove(apiProvider
                                            .getAllUserResponse
                                            .data!
                                            .users![index]
                                            .sId
                                            .toString());

                                        formValidationss(
                                            apiProvider.groupDetailResponse
                                                .data![0].members![index].sId!,
                                            apiProvider.groupDetailResponse
                                                .data![0].sId!);
                                      });
                                    }),
                            apiProvider.groupDetailResponse.data == null &&
                                    check == false
                                ? Center(child: Container())
                                : sids !=
                                        apiProvider
                                            .groupDetailResponse.data![0].admin
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            top: AppSize().height(context) *
                                                0.02),
                                        child: SizedBox(
                                          height:
                                              AppSize().height(context) * 0.06,
                                          width: AppSize().width(context),
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                AppColor.buttonColor,
                                              ),
                                            ),
                                            //  RaisedButton(
                                            //   color: AppColor.buttonColor,
                                            child: getBoldText('Exit Group',
                                                textColor: AppColor.white,
                                                fontSize: 14),
                                            onPressed: () {
                                              Timer(Duration(seconds: 2), () {
                                                removeformValidation(sids, gid);
                                              });
                                              // print(ids.toList().toString());
                                              // locator<NavigationService>()
                                              //     .navigateToReplace(grouplisting);
                                            },
                                          ),
                                        ),
                                      )
                                    : Container(),
                          ],
                        ),
                      ),
                    ),
              checking == false
                  ? Container()
                  : Center(child: CircularProgressIndicator())
            ]),
          );
  }
}
