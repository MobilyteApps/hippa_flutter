import 'package:app/common/colors.dart';
import 'package:app/common/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget myMessageView() {
  return Padding(
    padding: const EdgeInsets.only(top: 4, bottom: 4, right: 4, left: 130),
    child: Align(
      alignment: Alignment.centerRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              padding: EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  color: HexColor('#2291FF')),
              child: Text(
                'Mauris neque nisi, faucibus sque urna. Praesent mi sem, tincidunt eget facilisis in, pharetra et sapien. Proin sagittis erat magna, id eleifend ante posuere nec. Suspendisse potenti. Suspendisse tincidunt sed tortor at porta. Donec a molestie lectus, ac laoreet tellus. Nullam non rutrum velit, in lacinia diam. Nam vulputate elit sit amet orci mattis faucibus. Nam auctor eu eros in vehicula. Donec non risus id lacus aliquet dignissim.',
                style:
                    TextStyle(color: AppColor.white, fontFamily: 'Montserrat'),
              )),
          Container(
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: HexColor('#FFDEDE')),
            // borderRadius: BorderRadius.all(Radius.circular(15)),color: HexColor('#FFDEDE'),                 color: HexColor('#FF000021')),
            child: getBoldText('T-60 MIN',
                textColor: HexColor('#FF0000'), fontSize: 9),
          ),
        ],
      ),
    ),
  );
}

///my message view
Widget myreceiverMessageView() {
  return Padding(
    padding: const EdgeInsets.only(top: 4, bottom: 4, right: 130, left: 4),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  color: HexColor('#EBF3FB')),
              child: Text(
                'Mauris neque nisi, faucibus sque urna. Praesent mi sem, tincidunt eget facilisis in, pharetra et sapien. Proin sagittis erat magna, id eleifend ante posuere nec. Suspendisse potenti. Suspendisse tincidunt sed tortor at porta. Donec a molestie lectus, ac laoreet tellus. Nullam non rutrum velit, in lacinia diam. Nam vulputate elit sit amet orci mattis faucibus. Nam auctor eu eros in vehicula. Donec non risus id lacus aliquet dignissim.',
                style: TextStyle(color: Colors.black, fontFamily: 'Montserrat'),
              )),
          Container(
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: HexColor('#FFDEDE')),
            // borderRadius: BorderRadius.all(Radius.circular(15)),color: HexColor('#FFDEDE'),                 color: HexColor('#FF000021')),
            child: getBoldText('T-60 MIN',
                textColor: HexColor('#FF0000'), fontSize: 9),
          ),
        ],
      ),
    ),
  );
}
