import 'package:app/common/colors.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:app/response/getalluser_response.dart';
import 'package:app/response/groupdetail_response.dart';
import 'package:flutter/material.dart';

class ColleagueInfo extends StatefulWidget {
  final GroupDetailResponse groupDetailResponse;
  final int index;
  final String sid;
  var callback;
  var callbacks;

  ColleagueInfo(this.groupDetailResponse, this.index, this.sid, this.callback,
      this.callbacks,
      {Key? key})
      : super(key: key);

  @override
  _ColleagueInfoState createState() => _ColleagueInfoState();
}

class _ColleagueInfoState extends State<ColleagueInfo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 0),
      child: Container(
        width: AppSize().width(context),
        height: AppSize().height(context) * 0.07,
        decoration: BoxDecoration(
          color: AppColor.backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      width: AppSize().width(context) * 0.1,
                      height: AppSize().height(context) * 0.13,
                      decoration: BoxDecoration(
                        color: AppColor.lightBlue,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                          child: Text(
                        widget.groupDetailResponse.data![0]
                            .members![widget.index].username![0],
                        style: TextStyle(color: Colors.red),
                      )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getBoldText(
                          widget.groupDetailResponse.data![0]
                              .members![widget.index].username!,
                          textColor: AppColor.black,
                          fontSize: 16),
                    ],
                  ),
                ),
              ],
            ),
            widget.sid != widget.groupDetailResponse.data![0].admin
                ? Container()
                : widget.sid !=
                        widget.groupDetailResponse.data![0]
                            .members![widget.index].sId
                    ? InkWell(
                        onTap: () {
                          widget.callback();

                          widget.groupDetailResponse.data![0].members!
                              .removeAt(widget.index);
                        },
                        child: Padding(
                            padding: EdgeInsets.only(
                                right: AppSize().width(context) * 0.03),
                            child: Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            )))
                    : InkWell(
                        onTap: () {
                          setState(() {});
                          widget.callbacks();

                          widget.groupDetailResponse.data![0].members!
                              .removeAt(widget.index);
                        },
                        child: Padding(
                            padding: EdgeInsets.only(
                                right: AppSize().width(context) * 0.03),
                            child: Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            )))
          ],
        ),
      ),
    );
  }
}
