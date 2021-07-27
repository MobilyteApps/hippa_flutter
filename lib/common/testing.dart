import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:app/common/utils.dart';
import 'package:app/models/loader.dart';
import 'package:app/network/api_provider.dart';
import 'package:app/providers/signin_provider.dart';
import 'package:app/screens/create_group.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'colleague_detail.dart';
import 'colors.dart';
import 'constants.dart';

class HomeScreenn extends StatefulWidget {
  const HomeScreenn({Key? key}) : super(key: key);

  @override
  _HomeScreennState createState() => _HomeScreennState();
}

class _HomeScreennState extends State<HomeScreenn> {
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

  void didChangeDependencies() {
    super.didChangeDependencies();
    final signInProvider = Provider.of<SignInProvider>(context);
    final loader = Provider.of<Loader>(context);

    if (this.signInProvider != signInProvider || this.loader != loader) {
      this.signInProvider = signInProvider;
      this.loader = loader;

      Future.microtask(() async {
        signInProvider.getallusers(loader, '');
      });
    }
  }

  List<User> userids = <User>[];
  List<String> ids = [];
  List<String> i = [];
  late String sids;
  late String gid;
  bool check = false;
  bool add = false;
  final addmemberctrl = TextEditingController();

  formValidationer() async {
    String id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('gid')!;
    ids.add(id);
    var input = {"members_id": i, "group_id": "${id.toString()}"};
    print(input.toString());
    print("________-");
    signInProvider.addusertogroup(loader, input);
  }

  Widget addmemberFieldWidget() {
    return TextFormField(
      controller: addmemberctrl,
      onChanged: (v) {
        _debouncer.run(() {
          signInProvider.getallusers(loader, v.trim());
        });
      },
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
          filled: true,
          contentPadding: new EdgeInsets.only(left: 10, top: 10),
          fillColor: AppColor.white,
          hintText: 'Search'),
    );
  }

  void sid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sids = prefs.getString('sid')!;
    gid = prefs.getString('gid')!;
    formValidations();
    setState(() {
      check = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sid();
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

  formValidations() async {
    String id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('gid')!;
    ids.add(id);

    var input = {"group_id": id};
    signInProvider.groupdetail(loader, input);

    int l = 0;
    signInProvider.groupDetailResponse.data != null
        ? l = signInProvider.groupDetailResponse.data![0].members!.length
        : Container();
    for (int ik = 0; ik < l; ik++) {
      ids.add(signInProvider.groupDetailResponse.data![0].members![ik].sId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Column(
        verticalDirection: VerticalDirection.up,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            flex: 1,
            // child: Padding(
            //   padding: MediaQuery.of(context).viewInsets,
            child: SizedBox(
              height: AppSize().height(context) * 0.07,
              width: AppSize().width(context),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    AppColor.buttonColor,
                  ),
                ),
                child: getBoldText(AppString().confirm,
                    textColor: AppColor.white, fontSize: 14),
                onPressed: () {
                  formValidationer();
                },
              ),
            ),
            // ),
          ),
          SizedBox(height: 10),
          SizedBox(height: AppSize().height(context) * 0.02),
          Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: addmemberFieldWidget()),
          apiProvider.getAllUserResponse.data != null && check == true
              ? Expanded(
                  flex: 7,
                  child: Container(
                      width: AppSize().width(context),
                      child: ListView.builder(
                          itemCount: apiProvider
                              .getAllUserResponse.data!.users!.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return ids.contains(apiProvider
                                    .getAllUserResponse.data!.users![index].sId
                                    .toString())
                                ? Container()
                                : InkWell(
                                    onTap: () {
                                      i.add(apiProvider.getAllUserResponse.data!
                                          .users![index].sId
                                          .toString());
                                      ids.add(apiProvider.getAllUserResponse
                                          .data!.users![index].sId
                                          .toString());
                                      sid();
                                      setState(() {});
                                      print(apiProvider.getAllUserResponse.data!
                                          .users![index].sId);
                                      userids.add(User(
                                          id: apiProvider.getAllUserResponse
                                              .data!.users![index].sId,
                                          name: apiProvider.getAllUserResponse
                                              .data!.users![index].name));
                                      print(
                                          "length" + userids.length.toString());
                                      print(userids.toList().toString());
                                    },
                                    child: apiProvider.getAllUserResponse.data!
                                                    .users![index].username !=
                                                null &&
                                            apiProvider.getAllUserResponse.data!
                                                    .users![index].sId! !=
                                                sids
                                        ? ColleagueDetail(
                                            apiProvider.getAllUserResponse,
                                            index)
                                        : Container());
                          })),
                )
              : Center(child: CircularProgressIndicator()),
          apiProvider.getAllUserResponse.data != null && check == true
              ? Container(
                  width: AppSize().width(context),
                  height: AppSize().height(context) * 0.14,
                  child: ListView.builder(
                      itemCount: userids.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return memberWidget(userids, index);
                      }))
              : Container(),
        ],
      ),
    );
  }
}
