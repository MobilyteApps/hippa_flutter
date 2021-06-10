import 'package:app/common/colors.dart';
import 'package:app/common/constants.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class YourPhoneScreen extends StatefulWidget {

  @override
  _YourPhoneScreenState createState() => _YourPhoneScreenState();
}

class _YourPhoneScreenState extends State<YourPhoneScreen> {



  final border =UnderlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xff000000),
    ),
  );


final phoneCtrl = TextEditingController();
  Widget phoneFieldWidget() {
    return TextFormField(
      // onChanged: formValidatonColor(),
      validator: (value) {
        if (value?.trim()?.isEmpty ?? true) {
          return 'Please Enter Phone Number';
        } else if (value.length < 10) {
          return 'Please Enter Valid Phone Number';
        }
        return null;
      },
     keyboardType: TextInputType.phone,
      controller: phoneCtrl,
      maxLength: 10,
      inputFormatters:<TextInputFormatter> [LengthLimitingTextInputFormatter(10)],
      decoration: InputDecoration(
          enabledBorder: border,
          contentPadding:
              new EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          focusedBorder: border,
          counterText: "",
          border: border,
          hintStyle: TextStyle(color: Colors.black54),
          filled: true,
          fillColor: Colors.transparent,
          hintText: 'Phone Number'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightBlue,
      body:SingleChildScrollView(
              child: Padding(
          padding: EdgeInsets.only(left: AppSize().width(context)*0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              SizedBox(
                height: AppSize().height(context)*0.5
              ),
              getBoldText(AppString().yourphone),
              // SizedBox(
              //   height: AppSize().height(context)*0.05
              // ),
              Padding(
                padding: EdgeInsets.only(top: AppSize().height(context)*0.01),
                child: getLightText(AppString().readyToUse),
              ),Padding(
                padding: EdgeInsets.only(top: AppSize().height(context)*0.01),
                child: getLightText(AppString().verifyPhone),
              ),
              Padding(
                padding: EdgeInsets.only(top: AppSize().height(context)*0.01,right:AppSize().width(context)*0.1),
                child: phoneFieldWidget(),
              ),
              SizedBox(
                  width: AppSize().width(context)*0.8,
                  child: RaisedButton(color: AppColor.blue,
                  child:Text(AppString().send),onPressed: (){},
                ),
              ),
          
            ]
          ),
        ),
      ),
    );
  }
}