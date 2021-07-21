import 'dart:convert';

import 'package:app/aws/aws_page.dart';
import 'package:app/common/colleague_detail.dart';
import 'package:app/common/colors.dart';
import 'package:app/common/constants.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:app/common/utils.dart';
import 'package:app/models/loader.dart';
import 'package:app/network/api_provider.dart';
import 'package:app/providers/signin_provider.dart';
import 'package:app/response/getalluser_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/common/get_it.dart';
import 'package:app/common/navigator_route.dart';
import 'package:app/common/navigator_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
class CreateGroup extends StatefulWidget {

  const CreateGroup({Key? key}) : super(key: key);

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
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
  GetAllUserResponse response=GetAllUserResponse();
  ApiProvider apis = ApiProvider();
  User users = User();
  List<String>ids=[];
  List<User> userids = <User>[];
  String documentPath = "";
  String url='';
  late String sids;
  bool check=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sid();
  }
  void sid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sids= prefs.getString('sid')!;
    setState(() {
      check=true;
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

  Widget memberWidget(List<User>u, int index) {
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
                    ids.removeAt(index);
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
  Widget memberlist() {
    return ListView.builder(
        itemCount: userids.length,
        itemBuilder: (BuildContext context, int index) {
          return memberWidget(userids, index);
        });
  }
  Widget addmemberFieldWidget() {
    return TextFormField(
      controller: addmemberctrl,
      onChanged: (v) {
        _debouncer.run(() {
          // setState(() {

            signInProvider.getallusers(loader, v.trim());
          // });
          // signInProvider.getallusers(loader, addmemberctrl.text.trim());
          // signInProvider.getallusers(loader, v.trim());
        });
      },
      // inputFormatters: [
      //   // new WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9@.+-_ ]")),
      // ],
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

  Future<String> getDocuments() async {
    String urlss='';
    print('doc clicked !!!!!!!!');
    File? imgfile;

    try {
      // var file = await FilePicker.platform.getFile(type: FileType.image);
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

      if(result != null) {
        PlatformFile file = result.files.first;
        imgfile = File(result.files.single.path!);
      } else {
        // User canceled the picker
      }
      if (imgfile != null) {
        documentPath = imgfile.path;
        print('hello' + documentPath);
        var list = [];
        list = documentPath.split('.');
        String _fileExtension = list[list.length - 1].toString();
        if (_fileExtension.toLowerCase() == 'jpg' ||
            _fileExtension.toLowerCase() == 'jpeg' ||
            _fileExtension.toLowerCase() == 'png') {
          /// ContentType
          setState(() {
            documentPath = imgfile!.path;
            // _signUpController.imageUrl=file.path;
          });


          ///upload File
          AwsPage().upload(imgfile).then((onValue) {
            print("file uploaded >>>>> $onValue");
            // imgs=onValue;
            urlss = onValue;
            print(urlss);

            // _fileData.fileUrl=onValue;
            setState(() {
              url = onValue;
            });
          });



        } else {

        }
      } else {

      }

    } catch (e) {
      print("Error while picking the file: " + e.toString());

    }
    return urlss;
  }

  formValidation() async {
    String id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('sid')!;
    ids.add(id);
    // FocusScope.of(context).requestFocus(new FocusNode());
    // if (url.isEmpty == true) {
    //   ApiProvider().showToastMsg("Please Select member");
    // }
    // else
    if (creategroupctrl.text.trim() == '') {
      ApiProvider().showToastMsg("Please Enter Group Name");
    }
    // else if (url == '') {
    //   ApiProvider().showToastMsg("Please Select Group image");
    // }
    else {
      var input = {
        "admin_id": "${id.toString()}",
        "members_id": ids,
        "title": "${creategroupctrl.text.trim()}",
        // "groupImage": ''
        // "https://www.google.com/imgres?imgurl=https%3A%2F%2Fimages.pexels.com%2Fphotos%2F2486168%2Fpexels-photo-2486168.jpeg%3Fauto%3Dcompress%26cs%3Dtinysrgb%26dpr%3D1%26w%3D500&imgrefurl=https%3A%2F%2Fwww.pexels.com%2Fsearch%2Fiphone%2520wallpaper%2F&tbnid=RJHvAPiXhbzXuM&vet=12ahUKEwjm0L-g3-_xAhVogUsFHecHAS0QMygAegUIARDEAQ..i&docid=M2xUUjytt6PtMM&w=500&h=750&q=wallpaper&ved=2ahUKEwjm0L-g3-_xAhVogUsFHecHAS0QMygAegUIARDEAQ"
      };
      // var input = {
      //     "admin_id":  "${id.toString()}",
      //     "members_id": json.encode(ids),
      //     "title": "${creategroupctrl.text.trim()}",
      //     "groupImage":
      //     "https://www.google.com/imgres?imgurl=https%3A%2F%2Fimages.pexels.com%2Fphotos%2F2486168%2Fpexels-photo-2486168.jpeg%3Fauto%3Dcompress%26cs%3Dtinysrgb%26dpr%3D1%26w%3D500&imgrefurl=https%3A%2F%2Fwww.pexels.com%2Fsearch%2Fiphone%2520wallpaper%2F&tbnid=RJHvAPiXhbzXuM&vet=12ahUKEwjm0L-g3-_xAhVogUsFHecHAS0QMygAegUIARDEAQ..i&docid=M2xUUjytt6PtMM&w=500&h=750&q=wallpaper&ved=2ahUKEwjm0L-g3-_xAhVogUsFHecHAS0QMygAegUIARDEAQ"
      // };
      print(input.toString());
      print("________-");
      // print(ids.toList().toString());
      // print(input..toString());
      signInProvider.createGroup(loader, input);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            locator<NavigationService>().backPress();
          },
          child: Padding(
            padding: EdgeInsets.all(AppSize().width(context) * 0.04),
            child: SvgPicture.asset(
              'assets/images/arrow_back.svg',
              color: AppColor.black,
              matchTextDirection: true,
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: (){
              locator<NavigationService>().navigateTo(groupdetails);
            },
            child: Padding(
              padding: EdgeInsets.only(right: AppSize().width(context) * 0.03),
              child: SvgPicture.asset(
                'assets/images/settings.svg',
                color: AppColor.black,
                matchTextDirection: true,
              ),
            ),
          )
        ],
        backgroundColor: AppColor.backgroundColor,
        title: getBoldText(AppString().creategroup,
            textColor: AppColor.black, fontSize: 18),
        centerTitle: true,
      ),
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: AppSize().width(context) * 0.05,
              right: AppSize().width(context) * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                  onTap: () async {
                    // locator<NavigationService>().navigateTo(createmessage);
                    print('filepicker');
                    FocusScope.of(context).unfocus();

                    url = await getDocuments();
                  },
                  child: Align(
                      alignment: Alignment.topLeft,
                      child:
                          documentPath == ""
                          ? Container(
                          height:AppSize().height(context) * 0.1,
                          width: AppSize().width(context)* 0.18,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.grey)),
                          child: Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 46,
                          ))
                          :
                    ClipRRect(
                        borderRadius:
                        BorderRadius.circular(20.0),
                        child: Image.file(
                          File(documentPath),
                          fit: BoxFit.fitWidth,
                          height: AppSize().height(context) * 0.1,
                          width: AppSize().width(context) * 0.18,
                        ),
                      ))),
              SizedBox(height: AppSize().height(context) * 0.02),
              getBoldText(AppString().groupname,
                  textColor: AppColor.black, fontSize: 16),
              SizedBox(height: AppSize().height(context) * 0.02),
              groupnameFieldWidget(),
              SizedBox(height: AppSize().height(context) * 0.02),
              getBoldText(AppString().addteammember,
                  textColor: AppColor.black, fontSize: 16),
              SizedBox(height: AppSize().height(context) * 0.02),
              Container(
                  height: AppSize().height(context) * 0.07,
                  child: addmemberFieldWidget()),
              SizedBox(height: AppSize().height(context) * 0.02),
              apiProvider.getAllUserResponse.data!=null && check==true ?
              Container(
                // fit: FlexFit.tight,
                width: AppSize().width(context),
                // height: AppSize().height(context) * 0.34,
                    child: ListView.builder(
                        itemCount: apiProvider.getAllUserResponse.data!.users!.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return
                            ids.contains(apiProvider.getAllUserResponse.data!.users![index].sId.toString())?Container():
                            InkWell(
                              onTap: (){
                                ids.add(apiProvider.getAllUserResponse.data!.users![index].sId.toString());
                                setState(() {

                                });
                                print(apiProvider.getAllUserResponse.data!.users![index].sId);
                                userids.add(User(id: apiProvider.getAllUserResponse.data!.users![index].sId, name: apiProvider.getAllUserResponse.data!.users![index].name));
print("length"+userids.length.toString());
print(userids.toList().toString());


                              },
                              child:


                              // apiProvider.getAllUserResponse.data!.users![index].username==null ?Container():
                              apiProvider.getAllUserResponse.data!.users![index].username!=null &&
                                  apiProvider.getAllUserResponse.data!.users![index].sId! != sids
                                  ?
                              ColleagueDetail(apiProvider.getAllUserResponse,index):Container()

                            );
                        })):Center(child: CircularProgressIndicator()),

              Container(
                  width: AppSize().width(context),
                  height: AppSize().height(context) * 0.14,
                  child: ListView.builder(
                    shrinkWrap: true,
                      itemCount: userids.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return
                          // index != userids.length
                          //   ?
                        memberWidget(userids, index);
                            // : addWidget();
                      })),
              Padding(
                padding: EdgeInsets.only(top: AppSize().height(context) * 0.02),
                child: SizedBox(
                  height: AppSize().height(context) * 0.07,
                  width: AppSize().width(context),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        AppColor.white,
                      ),
                    ),
                    child: getBoldText(AppString().cancel,
                        textColor: AppColor.black, fontSize: 14),
                    onPressed: () {

                      // locator<NavigationService>().navigateToReplace(otpscreen);
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: AppSize().height(context) * 0.02),
                child: SizedBox(
                  height: AppSize().height(context) * 0.07,
                  width: AppSize().width(context) ,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        AppColor.buttonColor,
                      ),
                    ),
                    //  RaisedButton(
                    //   color: AppColor.buttonColor,
                    child: getBoldText(AppString().confirm,
                        textColor: AppColor.white, fontSize: 14),
                    onPressed: () {
                      formValidation();
                      // print(ids.toList().toString());
                      // locator<NavigationService>()
                      //     .navigateToReplace(grouplisting);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}


class User {
  String? id;
  String? name;

  User({this.id, this.name});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

