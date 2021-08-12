import 'dart:io';

import 'package:app/common/colors.dart';
import 'package:app/common/imagepickerhandler.dart';
import 'package:app/common/sender_message.dart';
import 'package:app/common/size.dart';
import 'package:app/common/textstyle.dart';
import 'package:app/models/loader.dart';
import 'package:app/providers/signin_provider.dart';
import 'package:app/response/chat_details_response.dart';
import 'package:app/screens/signature.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/common/get_it.dart';
import 'package:app/common/navigator_route.dart';
import 'package:app/common/navigator_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
// import 'package:socket_io_client/socket_io_client.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with TickerProviderStateMixin, ImagePickerListener {
  final messageTextController = TextEditingController();
  Color blackColor = Colors.black;

  bool shouldWait = false;

  //messageList..
  // List<MessageBubble> messages = List();

  // select image
  var bytes;
  late File image;
  late File _cameraVideo;

  // late Socket socket;
  late double height;
  late double width;

  int msgItemLength = 0;

  //CheckForSurvey_Response checkSurveyData;
  late ImagePickerHandler imagePicker;
  late AnimationController _controller;

  // ItemScrollController itemScrollController = ItemScrollController();
  // ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  SignInProvider? signInProvider;
  Loader? loader;
  String storageAccountConnectionString =
      "DefaultEndpointsProtocol=https;AccountName=sunny75;AccountKey=7CJjx9TVC9WC2kRVhJT4S5LDlXmiExLwNVE6oTsEd2873Vf5/21MH7OCyZo9VW3LHJRZMjD9NL824xYg61i2rA==;EndpointSuffix=core.windows.net";
  String containerAzure = "chat";
  String baseUrlAzure = 'https://sunny75.blob.core.windows.net/chat/';
  String mediaUrl = "";
  bool showSendButton = false;
  int memberCount = 1;
  final creategroupctrl = TextEditingController();
  final border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
        color: AppColor.white,
      ));

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
          hintText: 'Type Message'),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final signInProvider = Provider.of<SignInProvider>(this.context);
    final loader = Provider.of<Loader>(this.context);

    if (this.signInProvider != signInProvider || this.loader != loader) {
      this.signInProvider = signInProvider;
      this.loader = loader;
      // Future.microtask(() async {
      //   await signInProvider.checkForSurvey(loader, widget.tripId);
      //   await signInProvider.getTripMembersList(
      //       loader, widget.tripId, signInProvider.userResponse);
      //   getPreviousMessages();
      //   _connectSocket01();
      // });
    }
  }

  @override
  void dispose() {
    //WidgetsBinding.instance.removeObserver(true);
    // socket.destroy(); //disconnect socket and dispose not needed controllers
    messageTextController.dispose();
    print('response----------------------------- disconnect');
    // signInProvider.messagesResponse = null;
    // signInProvider.checkForSurveyRes = null;
    // signInProvider.tripMembersRes = null;
    super.dispose();
  }

  //disconnect socket
  // disconnectSocket() async {
  //   if (socket != null) {
  //     socket.destroy();
  //   }
  // }

  getPreviousMessages() async {
    // var res = await signInProvider.getChatMessagesList(
    //     loader, signInProvider.userResponse, widget.tripId, 1, 100);
    //
    // if (signInProvider.messagesResponse != null &&
    //     signInProvider.messagesResponse.data.length > 0) {
    //   for (int i = 0; i < signInProvider.messagesResponse.data.length; i++) {
    //     addMessagesToList(signInProvider.messagesResponse.data[i]);
    //   }
    // }
  }

  addMessagesToList(DataM data) {
    // bool checkUser = data.senderId.sId.toString() ==
    //     signInProvider.userResponse.data.id.toString();
    //
    // myreceiverMessageView msgBubble = myreceiverMessageView(
    //   sender: data.senderId.sId,
    //   content: data.message,
    //   avatar: data.senderId.image,
    //   timestamp: data.createdAt,
    //   isMe: checkUser,
    //   messageType: data.messageType,
    //   messageCategory: data.messageCategory,
    //   senderName: data.senderId.fullName,
    //   tripName: '${signInProvider.tripMembersRes.data?.tripName}',
    // );
    // setState(() {
    //
    //   // messages.add(msgBubble);
    // });
  }

  // _connectSocket01() {
  //   //update your domain before using
  //   // Dart client
  //   IO.Socket socket = IO.io(
  //       'http://203.190.154.100:8087/',
  //       OptionBuilder()
  //           .setTransports(['websocket']) // for Flutter or Dart VM
  //           .disableAutoConnect() // disable auto-connection
  //           .setExtraHeaders({'foo': 'bar'}) // optional
  //           .build());
  //   socket.connect();
  //
  //   socket.onConnect((_) {
  //     print('response----------------------------- connect');
  //     // socket.emit('joinChannel', widget.tripId);
  //   });
  //
  //   socket.on('getMessage', (data) {
  //     //messageTextController.clear();
  //
  //     Data messageData = Data.fromJson(data);
  //     print('msg----------------------------- ' + messageData.toString());
  //     addMessagesToList(messageData);
  //
  //     // if (messages != null && messages.length > 2) {
  //     //   itemScrollController.scrollTo(
  //     //       index: messages.length - 1,
  //     //       duration: Duration(milliseconds: 200),
  //     //       curve: Curves.decelerate);
  //     // }
  //   });
  //
  //   socket.onDisconnect((_) => print('disconnect'));
  //   socket.on('fromServer', (_) => print(_));
  // }

  String profileImage =
      "https://cultivatedculture.com/wp-content/uploads/2019/12/LinkedIn-Profile-Picture-Example-Madeline-Mann.jpeg";

// stack avatar showing avatar of person who text on particular list
  Widget positionedAvatar(/*InvitedData invitiesData*/) {
    return Align(
      heightFactor: 0.75,
      widthFactor: 0.75,
      alignment: Alignment.centerLeft,
      child: CircleAvatar(
        radius: 12,
        backgroundColor: Colors.white,
        // child: CircleAvatar(
        //   radius: 11,
        //   backgroundImage:
        //       invitiesData.image != null && invitiesData.image != ""
        //           ? NetworkImage(invitiesData.image)
        //           : AssetImage(
        //               "assets/images/profile.png",
        //             ),
        // ),
      ),
    );
  }

// total message on particular conversation
  Widget totalMessageCircle(int count) {
    return Align(
      heightFactor: 0.75,
      widthFactor: 0.9,
      alignment: Alignment.centerLeft,
      child: CircleAvatar(
        radius: 12,
        // backgroundColor: appColor,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 11,
          child: Text(
            '+${count - 3}',
            style: TextStyle(/*color: appColor,*/ fontSize: 12),
          ),
        ),
      ),
    );
  }

  _connectSocket01() {
    //update your domain before using
    // Dart client
    IO.Socket socket = IO.io(
        'http://3.142.72.8:3000/',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());
    socket.connect();
    socket.onConnect((_) {
      print('response----------------------------- connect');
      socket.emit('joinChannel', 't45ts54pv045');
      var messageData = {
        "senderId": '60ef5bf342bfc70add091d4d',
        "receiverId": '60f9b25cbc7fd8c764938d04',
        "roomId": 't45ts54ui945',
        "msg": 'hello sir',
        "msgType": "text",
        "seen": false,
        "msgCategory": "collegue",
      };
      // socket.emit("sendMessage", messageData);
      socket.emitWithAck("sendMessage", messageData, ack: (data) {
        print('ack $data') ;
        if (data != null) {
          print('from server $data');
        } else {
          print("Null") ;
        }
      });
    // });
    });
    socket.on('getMessage', (data) {
      final dataList = data as List;
      final ack = dataList.last as Function;
      print(dataList.toList().toString());
      ack(null);
    });
    socket.on('getMessage', (data) {
      //messageTextController.clear();
      // print(data.toString());
      DataM res = DataM.fromJson(data);
      // print(res.toJson().toString());
      print('msg----------------------------- ${res.toString()}');
      addMessagesToList(res);

      // if (messages != null && messages.length > 2) {
      //   itemScrollController.scrollTo(
      //       index: messages.length - 1,
      //       duration: Duration(milliseconds: 200),
      //       curve: Curves.decelerate);
      // }
    });
    // socket.on('getMessage', (data) {
    //   //messageTextController.clear();
    //
    //   Data messageData = Data.fromJson(data);
    //   print('msg----------------------------- ' + messageData.toString());
    //   addMessagesToList(messageData);
    //
    //   // if(messages!=null && messages.length>2){
    //   //   itemScrollController.scrollTo(
    //   //       index: messages.length-1,
    //   //       duration: Duration(milliseconds: 200),
    //   //       curve: Curves.decelerate);
    //   // }
    // });

    // socket.onDisconnect((_) => print('disconnect'));
    // socket.on('getMessage', (_) => print(_));
    // print(socket.json.toString());
    socket.on('event', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
  }

  void connectToServer() {
    try {
      // Configure socket transports must be sepecified
      IO.Socket socket = IO.io('http://3.142.72.8:3000/',
          // socket = io('http://127.0.0.1:3000',
          <String, dynamic>{
            'transports': ['websocket'],

            'autoConnect': false,
          });

      // Connect to websocket
      socket.connect();

      // Handle socket events
      socket.on('connect', (_) => print('connect: ${socket.id}'));
      // socket.on('location', handleLocationListen);
      // socket.on('typing', handleTyping);
      socket.on('getMessage', (_) => print('message'));
      socket.on('disconnect', (_) => print('disconnect'));
      socket.on('fromServer', (_) => print(_));
    } catch (e) {
      print(e.toString());
    }
  }

// Send Location to Server
// sendLocation(Map<String, dynamic> data) {
//   socket.emit("location", data);
// }

// Listen to Location updates of connected usersfrom server
// handleLocationListen(Map<String, dynamic> data) async {
//   print(data);
// }

// Send update of user's typing status
// sendTyping(bool typing) {
//   socket.emit("typing",
//       {
//         "id": socket.id,
//         "typing": typing,
//       });
// }

// Listen to update of typing status from connected users
// void handleTyping(Map<String, dynamic> data) {
//   print(data);
// }

// Send a Message to the server
// sendMessage(String message) {
//   socket.emit("message",
//     {
//       "id": socket.id,
//       "message": message, // Message to be sent
//       "timestamp": DateTime.now().millisecondsSinceEpoch,
//     },
//   );
// }

// Listen to all message events from connected users
  void handleMessage(Map<String, dynamic> data) {
    print(data);
  }

  _connectSocket02() {
    //update your domain before using
    // Dart client
    // IO.Socket socket = IO.io('http://3.142.72.8:3000/');

    IO.Socket socket = IO.io(
        'http://3.142.72.8:3000/',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect()
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());

    // socket = io(
    //   //'http://api.sunny-75.com:8087/',
    //   //'http://10.10.30.20:8087/',
    //   //   'http://sunny75.mobilytedev.com:8087/',
    //     'http://3.142.72.8:3000/',
    //     OptionBuilder()
    //         .setTransports(['websocket']) // for Flutter or Dart VM
    //         .disableAutoConnect() // disable auto-connection
    //         .setExtraHeaders({'foo': 'bar'}) // optional
    //         .build());
    socket.connect();
    socket.onConnect((_) {
      print('connect');
      socket.emit('joinChannel', 't45ts54pv045');
    });

    // socket.onConnect((_) {
    //   print('response----------------------------- connect');
    //   socket.emit('joinChannel', 't45ts54pv045');
    //   var messageData = {
    //     "senderId": '60ef5bf342bfc70add091d4d',
    //     "receiverId":'6101bfdb9836893913804b53',
    //     "roomId": 't45ts54ui945',
    //     "msg": 'hello sir',
    //     "msgType": "text",
    //     "seen":false,
    //     "msgCategory" : "collegue",
    //   };
    //   socket.emit("sendMessage",
    //       messageData);
    //
    // });
    socket.on('connect', (data) => print('Connectde...'));
    socket.on('getMessage', (data) {
      //messageTextController.clear();
      // print(data.toString());
      DataM res = DataM.fromJson(data);
      // print(res.toJson().toString());
      print('msg----------------------------- ${res.toString()}');
      addMessagesToList(res);

      // if (messages != null && messages.length > 2) {
      //   itemScrollController.scrollTo(
      //       index: messages.length - 1,
      //       duration: Duration(milliseconds: 200),
      //       curve: Curves.decelerate);
      // }
    });
    // socket.on('getMessage', (data) {
    //   //messageTextController.clear();
    //
    //   Data messageData = Data.fromJson(data);
    //   print('msg----------------------------- ' + messageData.toString());
    //   addMessagesToList(messageData);
    //
    //   // if(messages!=null && messages.length>2){
    //   //   itemScrollController.scrollTo(
    //   //       index: messages.length-1,
    //   //       duration: Duration(milliseconds: 200),
    //   //       curve: Curves.decelerate);
    //   // }
    // });

    // socket.onDisconnect((_) => print('disconnect'));
    // socket.on('getMessage', (_) => print(_));
    // print(socket.json.toString());
    socket.on('event', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
  }

// header of chat screen
  Widget header() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: width * 0.02,
        ),
        InkWell(
          onTap: () {
            Navigator.pop(this.context);
          },
          child: Icon(
            Icons.arrow_back,
            size: width * 0.09,
          ),
        ),
        InkWell(
            onTap: () async {
              // TripMembersResModel response = await signInProvider.getTripMembersList(loader,widget.tripId,signInProvider.userResponse);
              // Navigator.push(
              //     this.context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //             Members(signInProvider.tripMembersRes.data)));
            },
            child: headerTitle())
      ],
    );
  }

//header title with image
  headerTitle() {
    return Container(
      padding: EdgeInsets.all(width * 0.02),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: width * 0.07,
            // backgroundImage:
            //     NetworkImage(signInProvider.tripMembersRes.data.image),
          ),
          SizedBox(
            width: width * 0.02,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width * 0.65,
                child: Text(
                  /*signInProvider.tripMembersRes.data?.tripName ??*/
                  "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: blackColor, fontSize: width * 0.05),
                ),
              ),
              // SizedBox(
              //   height: 35,
              //   width: width * 0.65,
              //   child: ListView.builder(
              //     itemCount: signInProvider
              //         .tripMembersRes.data.totalInviteeGoing.length,
              //     shrinkWrap: true,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (BuildContext context, int index) {
              //       if (index < 3) {
              //         return positionedAvatar(signInProvider
              //             .tripMembersRes.data.totalInviteeGoing[index]);
              //       } else if (index == 3) {
              //         return totalMessageCircle(signInProvider
              //             .tripMembersRes.data.totalInviteeGoing.length);
              //       } else {
              //         return Container();
              //       }
              //     },
              //   ),
              // ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    _connectSocket01();
    // super.initState();
    // connectToServer();
    // _controller = new AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 500),
    // );
    //
    // imagePicker = new ImagePickerHandler(this, _controller);
    // imagePicker.init();
  }

// @override
// userImage(File _image) {
//   if (_image != null) {
//     uploadFileToAzure(_image, "image").then((value) {
//       mediaUrl = value;
//       this.image = _image;
//       setState(() {});
//     });
//   }
// }

// Future<String> uploadFileToAzure(File image, String type) async {
//   mediaUrl = "";
//   try {
//     String fileName = basename(image.path);
//     if (type == "video") {
//       fileName = fileName.replaceAll('.jpg', '.mp4');
//     }
//
//     print("file name check chnage-----------" + fileName.toString());
//     // read file as Uint8List
//     Uint8List content = await image.readAsBytes();
//     var storage = AzureStorage.parse(storageAccountConnectionString);
//     String container = containerAzure;
//     // get the mine type of the file
//     String contentType = lookupMimeType(fileName);
//     await storage.putBlob('/$container/$fileName',
//         bodyBytes: content,
//         contentType: contentType,
//         type: BlobType.BlockBlob);
//
//     String responseUrl = baseUrlAzure + fileName;
//     print("file url video check !!!!!!!! " + responseUrl);
//     return responseUrl;
//   } on AzureStorageException catch (ex) {
//     print(ex.message);
//   } catch (err) {
//     print(err);
//   }
// }

  @override
// userVideo(File _video) {
//   if (_video != null) {
//     uploadFileToAzure(_video, "video").then((value) {
//       mediaUrl = value;
//
//       var messageData = {
//         "sender": signInProvider.userResponse.data.id,
//         "trip": widget.tripId,
//         "room": widget.tripId,
//         "message": mediaUrl,
//         "messageType": "video"
//       };
//       socket.emit("sendMessage", messageData);
//     });
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(color: AppColor.grey, height: 1.0),
            preferredSize: Size.fromHeight(4.0)),
        leading: InkWell(
          onTap: () {
            locator<NavigationService>().backPress();
          },
          child: Padding(
            padding: EdgeInsets.only(
                top: AppSize().width(context) * 0.05,
                bottom: AppSize().width(context) * 0.05,
                right: AppSize().width(context) * 0.01,
                left: AppSize().width(context) * 0.01),
            child: SvgPicture.asset(
              'assets/images/arrow_back.svg',
              color: AppColor.black,
              matchTextDirection: true,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: AppSize().width(context) * 0.03),
            child: InkWell(
                onTap: () {
                  // locator<NavigationService>()
                  //     .navigateToReplace(settingsscreen);
                  //
                },
                child: Icon(Icons.search, color: AppColor.starGrey)),
          )
        ],
        backgroundColor: AppColor.white,
        title: Container(
          width: AppSize().width(context) * 0.5,
          height: AppSize().height(context) * 0.11,
          decoration: BoxDecoration(
              color: AppColor.white,
              border:
                  Border(bottom: BorderSide(width: 1, color: AppColor.grey))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    width: AppSize().width(context) * 0.1,
                    height: AppSize().height(context) * 0.2,
                    decoration: BoxDecoration(
                      color: AppColor.lightBlue,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                        child: Text(
                      'A',
                      style: TextStyle(color: Colors.red),
                    )),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getBoldText('Justin Oliver',
                          textColor: AppColor.black, fontSize: 16),
                      Padding(
                        padding: EdgeInsets.only(
                            top: AppSize().height(context) * 0.015),
                        child: getBoldText('Online',
                            textColor: AppColor.buttonColor, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColor.white,
      body: Stack(children: [
        ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return index % 2 == 0 ? myreceiverMessageView() : myMessageView();
            }),
        Align(alignment: Alignment.bottomCenter, child: bottomSheet()),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      color: AppColor.white,
      height: AppSize().height(context) * 0.05,
      width: AppSize().width(context),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: AppSize().width(context) * 0.03,
                right: AppSize().width(context) * 0.03),
            child: InkWell(
              onTap: () {
                // locator<NavigationService>().navigateToReplace(urgentmessages);
              },
              child: SvgPicture.asset(
                'assets/images/attachment.svg',
                color: AppColor.buttonColor,
                matchTextDirection: true,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: AppSize().width(context) * 0.03),
            child: InkWell(
              onTap: () {
                // locator<NavigationService>().navigateToReplace(urgentmessages);
              },
              child: Image.asset(
                'assets/images/image.png',
                color: AppColor.buttonColor,
                matchTextDirection: true,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: AppSize().width(context) * 0.03),
            child: InkWell(
              onTap: () {
                locator<NavigationService>().navigateTo(signature);
              },
              child: Image.asset(
                'assets/images/icons_edit.png',
                color: AppColor.buttonColor,
                matchTextDirection: true,
              ),
            ),
          ),
          Container(
              width: AppSize().width(context) * 0.6,
              height: AppSize().height(context) * 0.7,
              child: groupnameFieldWidget()),
          Padding(
            padding: EdgeInsets.only(left: AppSize().width(context) * 0.03),
            child: InkWell(
                onTap: () {
                  // locator<NavigationService>()
                  //     .navigateToReplace(urgentmessages);
                },
                child: Icon(
                  Icons.send,
                  color: AppColor.buttonColor,
                )),
          ),
        ],
      ),
    );
  }

  @override
  userImage(File _image) {
    // TODO: implement userImage
    throw UnimplementedError();
  }

  @override
  userVideo(File _Video) {
    // TODO: implement userVideo
    throw UnimplementedError();
  }
}
