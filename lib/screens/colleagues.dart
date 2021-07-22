import 'dart:async';

import 'package:app/common/colleague_detail.dart';
import 'package:app/common/colors.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:app/common/utils.dart';
import 'package:app/models/loader.dart';
import 'package:app/network/api_provider.dart';
import 'package:app/providers/signin_provider.dart';
import 'package:app/response/getalluser_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Colleagues extends StatefulWidget {
  const Colleagues({Key? key}) : super(key: key);

  @override
  _ColleaguesState createState() => _ColleaguesState();
}

class _ColleaguesState extends State<Colleagues> {
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
  GetAllUserResponse response=GetAllUserResponse();
  late Future<GetAllUserResponse> responses;
  formValidation() {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (creategroupctrl.text.trim().isEmpty == true) {
      ApiProvider().showToastMsg("Please Enter email address");
    }
      signInProvider.getallusers(loader, creategroupctrl.text.trim());
  }
 String sids='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sid();
  }
  void sid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   sids= prefs.getString('sid')!;
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final signInProvider = Provider.of<SignInProvider>(context);
    final loader = Provider.of<Loader>(context);

    if (this.signInProvider != signInProvider || this.loader != loader) {
      this.signInProvider = signInProvider;
      this.loader = loader;

      Timer(Duration(seconds: 2), () {
        Future.microtask(() async {
          signInProvider.getallusers(loader, '');
        });
      });
      // Future.microtask(() async {
      //   signInProvider.getallusers(loader, '');
      // });
    }
  }

  Widget groupnameFieldWidget() {
    return TextFormField(
      controller: creategroupctrl,
      onChanged: (v) {
        _debouncer.run(() {
          // signInProvider.getallusers(loader, creategroupctrl.text.trim());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: AppSize().width(context) * 0.05,
                right: AppSize().width(context) * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSize().height(context) * 0.02),
                Container(
                    height: AppSize().height(context) * 0.07,
                    child: groupnameFieldWidget()),
                apiProvider.getAllUserResponse.data==null|| sids==
    ''?Center(child: CircularProgressIndicator()):
                Expanded(
                    child: ListView.builder(
                        itemCount: apiProvider.getAllUserResponse.data!.users!.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return
                            apiProvider.getAllUserResponse.data!.users![index].username!=null &&
                          apiProvider.getAllUserResponse.data!.users![index].sId != sids
                                ?
                            ColleagueDetail(apiProvider.getAllUserResponse,index):
                            Container();

                        })),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
