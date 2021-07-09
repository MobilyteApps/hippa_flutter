import 'package:app/common/colleague_detail.dart';
import 'package:app/common/colors.dart';
import 'package:app/common/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class Colleagues extends StatefulWidget {
  const Colleagues({Key? key}) : super(key: key);

  @override
  _ColleaguesState createState() => _ColleaguesState();
}

class _ColleaguesState extends State<Colleagues> {
  int memberCount = 1;
  final creategroupctrl = TextEditingController();
  final border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: AppColor.white,)
  );

  Widget groupnameFieldWidget() {
    return TextFormField(
      controller: creategroupctrl,
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
              borderSide: BorderSide(color: AppColor.white,)
          ),
          hintStyle: TextStyle(
            color: AppColor.textColor,
            fontSize: 16,
            fontFamily: 'JosenfinSansRegular',
            fontWeight: FontWeight.w400,
          ),
          // hintStyle: TextStyle(color: greyColor, fontSize: 16),
          filled: true,
          contentPadding:
          new EdgeInsets.only(left: 10, top: 10),
          fillColor: AppColor.white,
          hintText: 'Search'),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColor.backgroundColor,
      body:
      Padding(
        padding: EdgeInsets.only(
            left: AppSize().width(context) * 0.1,
            right: AppSize().width(context) * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: AppSize().height(context) * 0.02),
            Container(
                height: AppSize().height(context) * 0.07,
                child: groupnameFieldWidget()),
            Expanded(
                child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return
                        ColleagueDetail();
                    })),

          ],
        ),
      ),

    );
  }
}
