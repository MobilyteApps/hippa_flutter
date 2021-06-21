import 'package:app/common/colors.dart';
import 'package:app/common/constants.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:app/common/get_it.dart';
import 'package:app/common/navigator_route.dart';
import 'package:app/common/navigator_service.dart';
import 'package:hexcolor/hexcolor.dart';

class YourPhoneScreen extends StatefulWidget {
  @override
  _YourPhoneScreenState createState() => _YourPhoneScreenState();
}

class _YourPhoneScreenState extends State<YourPhoneScreen> {
  final border = UnderlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xff000000),
    ),
  );

  final phoneCtrl = TextEditingController();

  Widget phoneFieldWidget() {
    return TextFormField(
      // onChanged: formValidatonColor(),
      validator: (value) {
        if (value?.trim().isEmpty ?? true) {
          return 'Please Enter Phone Number';
        } else if (value!.length < 10) {
          return 'Please Enter Valid Phone Number';
        }
        return null;
      },
      keyboardType: TextInputType.phone,
      controller: phoneCtrl,
      maxLength: 10,
      style: TextStyle(
        color: HexColor("#0E3746"),
        fontSize: 16,
        fontFamily: 'PoppinsSemiBold',
        fontWeight: FontWeight.w600,
      ),
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(10)
      ],
      decoration: InputDecoration(
          enabledBorder: border,
          contentPadding:
              new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          focusedBorder: border,
          counterText: "",
          border: border,
          hintStyle: TextStyle(
            color: HexColor("#0E3746"),
            fontSize: 16,
            fontFamily: 'PoppinsSemiBold',
            fontWeight: FontWeight.w600,
          ),
          filled: true,
          fillColor: Colors.transparent,
          hintText: '+123 456 7890'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#E8F4FF"),
      body: SingleChildScrollView(
        // child:
        // Padding(
        // padding: EdgeInsets.only(
        //     left: AppSize().width(context) * 0.1,
        //     right: AppSize().width(context) * 0.1),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/tmp_1623687415135.jpg',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth),
              Padding(
                padding: EdgeInsets.only(
                    left: AppSize().width(context) * 0.1,
                    right: AppSize().width(context) * 0.1),
                child: getBoldText(AppString().yourphone,
                    fontSize: 22, textColor: HexColor("#0E3746")),
              ),
              // SizedBox(
              //   height: AppSize().height(context)*0.05
              // ),
              Padding(
                padding: EdgeInsets.only(
                    top: AppSize().height(context) * 0.01,
                    left: AppSize().width(context) * 0.1,
                    right: AppSize().width(context) * 0.1),
                child: getRegularText(AppString().readyToUse,
                    textColor: HexColor("#0E3746"), fontSize: 14),
              ),

              Padding(
                padding: EdgeInsets.only(
                    left: AppSize().width(context) * 0.1,
                    right: AppSize().width(context) * 0.1,
                    top: AppSize().height(context) * 0.01),
                child: getRegularText(AppString().verifyPhone,
                    textColor: HexColor("#0E3746"), fontSize: 14),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: AppSize().height(context) * 0.02,
                    left: AppSize().width(context) * 0.1,
                    right: AppSize().width(context) * 0.1
                    // right: AppSize().width(context) * 0.1
                    ),
                child: phoneFieldWidget(),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: AppSize().height(context) * 0.04,
                    left: AppSize().width(context) * 0.1,
                    right: AppSize().width(context) * 0.1),
                child: SizedBox(
                  width: AppSize().width(context) * 0.8,
                  height:AppSize().height(context) * 0.06,
                  child: RaisedButton(
                    color: HexColor('#2291FF'),
                    child: getSemiBolText(
                      AppString().send.toUpperCase(),
                      textColor: Colors.white,
                      fontSize: 14,
                    ),
                    onPressed: () {
                      locator<NavigationService>().navigateToReplace(otpscreen);
                    },
                  ),
                ),
              ),
            ]),
      ),
      // ),
    );
  }
}
