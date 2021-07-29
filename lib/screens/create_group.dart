import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
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
import 'dart:io' as IO;
import 'package:shared_preferences/shared_preferences.dart';

import 'imgpicker.dart';

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
  GetAllUserResponse response = GetAllUserResponse();
  ApiProvider apis = ApiProvider();
  User users = User();
  List<String> ids = [];
  List<User> userids = <User>[];
  String documentPath = "";
  String url = '';
  late String sids;
  bool check = false;
  String results = "";
  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  dynamic _pickImageError;
  bool isVideo = false;

  VideoPlayerController? _controller;
  VideoPlayerController? _toBeDisposed;
  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  Future<void> _playVideo(XFile? file) async {
    if (file != null && mounted) {
      await _disposeVideoController();
      late VideoPlayerController controller;
      if (kIsWeb) {
        controller = VideoPlayerController.network(file.path);
      } else {
        controller = VideoPlayerController.file(File(file.path));
      }
      _controller = controller;
      final double volume = kIsWeb ? 0.0 : 1.0;
      await controller.setVolume(volume);
      await controller.initialize();
      await controller.setLooping(true);
      await controller.play();
      setState(() {});
    }
  }

  void _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    if (_controller != null) {
      await _controller!.setVolume(0.0);
    }
    if (isVideo) {
      final XFile? file = await _picker.pickVideo(
          source: source, maxDuration: const Duration(seconds: 10));
      await _playVideo(file);
    } else if (isMultiImage) {
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final pickedFileList = await _picker.pickMultiImage(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality,
          );
          setState(() {
            _imageFileList = pickedFileList;
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      });
    } else {
      try {
        final pickedFile = await _picker.pickImage(
          source: source,
        );
        setState(() {
          _imageFile = pickedFile;
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    }
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller!.setVolume(0.0);
      _controller!.pause();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    _disposeVideoController();
    maxWidthController.dispose();
    maxHeightController.dispose();
    qualityController.dispose();
    super.dispose();
  }

  Future<void> _disposeVideoController() async {
    if (_toBeDisposed != null) {
      await _toBeDisposed!.dispose();
    }
    _toBeDisposed = _controller;
    _controller = null;
  }

  Widget _previewVideo() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_controller == null) {
      return const Text(
        '',
        textAlign: TextAlign.center,
      );
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AspectRatioVideo(_controller),
    );
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      return Semantics(
          child: ListView.builder(
            shrinkWrap: true,
            key: UniqueKey(),
            itemBuilder: (context, index) {
              return Semantics(
                label: 'image_picker_example_picked_image',
                child: kIsWeb
                    ? Image.network(_imageFileList![index].path)
                    : Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading:
                                            new Icon(Icons.camera_alt_outlined),
                                        title: new Text('Take Photo'),
                                        onTap: () {
                                          isVideo = false;
                                          _onImageButtonPressed(
                                              ImageSource.camera,
                                              context: context);
                                        },
                                      ),
                                      ListTile(
                                        leading: new Icon(Icons.photo),
                                        title: new Text('Choose from Gallery'),
                                        onTap: () {
                                          isVideo = false;
                                          _onImageButtonPressed(
                                              ImageSource.gallery,
                                              context: context);
                                        },
                                      ),
                                      ListTile(
                                        title: new Text('Cancel'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.file(
                              File(_imageFileList![index].path),
                              fit: BoxFit.fill,
                              height: AppSize().height(context) * 0.1,
                              width: AppSize().width(context) * 0.18,
                            ),
                          ),
                        )),
              );
            },
            itemCount: _imageFileList!.length,
          ),
          label: 'image_picker_example_picked_images');
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        '',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _handlePreview() {
    if (isVideo) {
      return _previewVideo();
    } else {
      return _previewImages();
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.video) {
        isVideo = true;
        await _playVideo(response.file);
      } else {
        isVideo = false;
        setState(() {
          _imageFile = response.file;
        });
      }
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sid();
  }

  void sid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sids = prefs.getString('sid')!;
    setState(() {
      check = true;
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

  Future<String> getDocuments() async {
    String urlss = '';
    print('doc clicked !!!!!!!!');
    File? imgfile;

    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);

      if (result != null) {
        PlatformFile file = result.files.first;
        imgfile = File(result.files.single.path!);
      } else {}
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
          });

          ///upload File
          AwsPage().upload(imgfile).then((onValue) {
            print("file uploaded >>>>> $onValue");
            urlss = onValue;
            print(urlss);
            setState(() {
              url = onValue;
            });
          });
        } else {}
      } else {}
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
    if (creategroupctrl.text.trim() == '') {
      ApiProvider().showToastMsg("Please Enter Group Name");
    } else {
      var input = {
        "admin_id": "${id.toString()}",
        "members_id": ids,
        "title": "${creategroupctrl.text.trim()}",
      };
      print(input.toString());
      print("________-");
      signInProvider.createGroup(loader, input);
    }
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add optional parameters'),
            content: Column(
              children: <Widget>[
                TextField(
                  controller: maxWidthController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration:
                      InputDecoration(hintText: "Enter maxWidth if desired"),
                ),
                TextField(
                  controller: maxHeightController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration:
                      InputDecoration(hintText: "Enter maxHeight if desired"),
                ),
                TextField(
                  controller: qualityController,
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(hintText: "Enter quality if desired"),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: const Text('PICK'),
                  onPressed: () {
                    double? width = maxWidthController.text.isNotEmpty
                        ? double.parse(maxWidthController.text)
                        : null;
                    double? height = maxHeightController.text.isNotEmpty
                        ? double.parse(maxHeightController.text)
                        : null;
                    int? quality = qualityController.text.isNotEmpty
                        ? int.parse(qualityController.text)
                        : null;
                    onPick(width, height, quality);
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CameraTest()),
    );
    print(result.toString());
    if (result != null) {
      setState(() {
        results = result.toString();
      });
    }
  }

  bool selection = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
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
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());

              locator<NavigationService>().navigateTo(settingsscreen);
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
              _imageFileList == null
                  ? Align(
                      alignment: Alignment.topLeft,
                      child: _imageFileList == null
                          ? InkWell(
                              onTap: () async {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            leading: new Icon(
                                                Icons.camera_alt_outlined),
                                            title: new Text('Take Photo'),
                                            onTap: () {
                                              isVideo = false;
                                              _onImageButtonPressed(
                                                  ImageSource.camera,
                                                  context: context);
                                            },
                                          ),
                                          ListTile(
                                            leading: new Icon(Icons.photo),
                                            title:
                                                new Text('Choose from Gallery'),
                                            onTap: () {
                                              isVideo = false;
                                              _onImageButtonPressed(
                                                  ImageSource.gallery,
                                                  context: context);
                                            },
                                          ),
                                          ListTile(
                                            title: new Text('Cancel'),
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: Container(
                                  height: AppSize().height(context) * 0.1,
                                  width: AppSize().width(context) * 0.18,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.grey)),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                    size: 46,
                                  )),
                            )
                          : Container())
                  : Container(),
              SizedBox(height: AppSize().height(context) * 0.02),
              Center(
                child:
                    !kIsWeb && defaultTargetPlatform == TargetPlatform.android
                        ? FutureBuilder<void>(
                            future: retrieveLostData(),
                            builder: (BuildContext context,
                                AsyncSnapshot<void> snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                  return const Text(
                                    '',
                                    textAlign: TextAlign.center,
                                  );
                                case ConnectionState.waiting:
                                  return const Text(
                                    '',
                                    textAlign: TextAlign.center,
                                  );
                                case ConnectionState.done:
                                  return _handlePreview();
                                default:
                                  if (snapshot.hasError) {
                                    return Text(
                                      'Pick image/video error: ${snapshot.error}}',
                                      textAlign: TextAlign.center,
                                    );
                                  } else {
                                    return const Text(
                                      '',
                                      textAlign: TextAlign.center,
                                    );
                                  }
                              }
                            },
                          )
                        : _handlePreview(),
              ),
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
              apiProvider.getAllUserResponse.data != null && check == true
                  ? apiProvider.getAllUserResponse.data!.users!.length == 0
                      ? Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Center(child: Text('No Colleague Found')),
                        )
                      : Container(
                          width: AppSize().width(context),
                          child: ListView.builder(
                              itemCount: apiProvider
                                  .getAllUserResponse.data!.users!.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return ids.contains(apiProvider
                                        .getAllUserResponse
                                        .data!
                                        .users![index]
                                        .sId
                                        .toString())
                                    ? Container()
                                    : InkWell(
                                        onTap: () {
                                          ids.add(apiProvider.getAllUserResponse
                                              .data!.users![index].sId
                                              .toString());
                                          setState(() {});
                                          print(apiProvider.getAllUserResponse
                                              .data!.users![index].sId);
                                          userids.add(User(
                                              id: apiProvider.getAllUserResponse
                                                  .data!.users![index].sId,
                                              name: apiProvider
                                                  .getAllUserResponse
                                                  .data!
                                                  .users![index]
                                                  .name));
                                          print("length" +
                                              userids.length.toString());
                                          print(userids.toList().toString());
                                        },
                                        child: apiProvider
                                                        .getAllUserResponse
                                                        .data!
                                                        .users![index]
                                                        .username !=
                                                    null &&
                                                apiProvider
                                                        .getAllUserResponse
                                                        .data!
                                                        .users![index]
                                                        .sId! !=
                                                    sids
                                            ? ColleagueDetail(
                                                apiProvider.getAllUserResponse,
                                                index)
                                            : Container());
                              }))
                  : Center(child: CircularProgressIndicator()),
              Container(
                  width: AppSize().width(context),
                  height: AppSize().height(context) * 0.14,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: userids.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return memberWidget(userids, index);
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
                      ids.clear();
                      userids.clear();
                      setState(() {});
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: AppSize().height(context) * 0.02,
                    bottom: AppSize().height(context) * 0.02),
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
                      formValidation();
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

typedef void OnPickImageCallback(
    double? maxWidth, double? maxHeight, int? quality);

class AspectRatioVideo extends StatefulWidget {
  AspectRatioVideo(this.controller);

  final VideoPlayerController? controller;

  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController? get controller => widget.controller;
  bool initialized = false;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }
    if (initialized != controller!.value.isInitialized) {
      initialized = controller!.value.isInitialized;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controller!.addListener(_onVideoControllerUpdate);
  }

  @override
  void dispose() {
    controller!.removeListener(_onVideoControllerUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(
        child: AspectRatio(
          aspectRatio: controller!.value.aspectRatio,
          child: VideoPlayer(controller!),
        ),
      );
    } else {
      return Container();
    }
  }
}
