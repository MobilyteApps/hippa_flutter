// // import 'dart:io';
// // import 'dart:async';
// // import 'dart:convert';
// // import 'package:app/aws/aws_page.dart';
// // import 'package:app/common/colors.dart';
// // import 'package:app/common/constant.dart';
// // import 'package:app/common/size.dart';
// // import 'package:app/network/api_provider.dart';
// // import 'package:app/providers/messagecontroller.dart';
// // import 'package:app/response/chat_details_response.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:file_picker/file_picker.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:url_launcher/url_launcher.dart';
// // import 'package:adhara_socket_io/adhara_socket_io.dart';
// //
// // var args;
// // String? loggedInUser, uId;
// //
// // class ChatScreens extends StatefulWidget {
// //   String? roomId;
// //   String? isFromAccept;
// //
// //   ChatScreens({ required this.roomId,required this.isFromAccept});
// //
// //   @override
// //   _ChatScreensState createState() => _ChatScreensState();
// // }
// //
// // class _ChatScreensState extends State<ChatScreens>
// //     with WidgetsBindingObserver {
// //   String? userID, receiverId;
// //
// //   late SocketIO socket;
// //   late SocketIOManager manager;
// //   final MessageTabController _messageTabController = MessageTabController();
// //   late bool isPerfectFile;
// //
// //   late double height, width;
// //   late TextEditingController messageTextController;
// //   late ScrollController scrollController;
// //
// //   @override
// //   void didChangeAppLifecycleState(AppLifecycleState state) {
// //     super.didChangeAppLifecycleState(state);
// //     if (state == AppLifecycleState.inactive) {
// //       // went to Background
// //       leaveRoom(); //disconnect socket and dispose not needed controllers
// //     }
// //     if (state == AppLifecycleState.resumed) {
// //       // came back to Foreground
// //       if (manager != null) {
// //         initSocket("default");
// //       }
// //     }
// //   }
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     WidgetsBinding.instance!.addObserver(this);
// //
// //     _messageTabController.roomId = widget.roomId!;
// //     // Initializing the TextEditingController and ScrollController
// //     messageTextController = TextEditingController();
// //     scrollController = ScrollController();
// //
// //     initPref(); //init shared pref
// //     manager = SocketIOManager(); //init socket
// //     initSocket("default");
// //   }
// //
// //   @override
// //   @mustCallSuper
// //   Future<void> dispose() async {
// //     WidgetsBinding.instance!.removeObserver(this);
// //
// //     ///disconnectSocket(); //disconnect socket and dispose not needed controllers
// //     leaveRoom();
// //     getChatList();
// //     messageTextController.dispose();
// //     scrollController.dispose();
// //
// //     super.dispose();
// //   }
// //
// //   ///disconnect socket and make user offline..
// //   Future<void> leaveRoom() async {
// //     if (socket != null) {
// //       socket.emit("leave_room", [
// //         {
// //           "roomId": "${widget.roomId}",
// //         }
// //       ]);
// //       await manager.clearInstance(socket);
// //     }
// //   }
// //
// //   Future<void>? joinRoom(String roomId) {
// //     var jsonConnect = {
// //       "roomId": "$roomId",
// //     };
// //     socket.emit("connect_user", [jsonConnect]);
// //     print("Room Joined");
// //     return null;
// //   }
// //
// //   //* init socket here...
// //   initSocket(String identifier) async {
// //     print("initSocket method called");
// //     socket = await manager
// //         .createInstance(SocketOptions("http://3.7.103.50:8091", //add port here
// //             namespace: '/',
// //             //enableLogging: true,
// //             transports: [Transports.webSocket]));
// //     socket.onConnect;
// //
// //     //Disconnected
// //     socket.onDisconnect;
// //
// //     //Error on connecting socket
// //     socket.onError;
// //
// //     socket.connect();
// //
// //     joinRoom(widget.roomId!);
// //
// //     await getPreviousMessages(widget.roomId!);
// //
// //     socket.on("receive_message").listen((data) {
// //       print('receive_message >>>> $data');
// //       //Convert the JSON data received into a Map
// //       // Map<String, dynamic> data = json.decode(jsonData);
// //       // var msg = messagesFromJson(data);
// //       var message = Message(
// //           id: data['_id'],
// //           senderId: data['senderId'],
// //           createdAt: DateTime.now(),
// //           receiverId: data['receiverId'],
// //           msgType: data['msgType'],
// //           msg: data['msg'],
// //           seen: data['seen']);
// //
// //       //   _messageTabController.rxList.add(message);  //working
// //
// //     });
// //
// //     scrollList();
// //     scrollList();
// //   }
// //
// //   ///fetch old messages..
// //   getPreviousMessages(String roomId) async {
// //     // await _messageTabController.getLimitMessages(widget.roomId).then((value) =>  //working
// //     //     (value)                                                                  //working
// //     //         ? passDataToConst(roomId)                                            //working
// //     //         : ApiProvider().showToastMsg('getPrevMessages'));                    //working
// //   }
// //
// //   ///getting data from pref..
// //   void initPref() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     userID = prefs.getString("user_id");
// //     print('my user id is >>>> $userID');
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return WillPopScope(
// //       onWillPop: backPressed,
// //       child: Scaffold(
// //         ///bottom Nav View
// //         bottomNavigationBar: Padding(
// //           padding:
// //               EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
// //           child: Container(
// //             height: 70,
// //             width: AppSize().width(context),
// //             color: AppColor.white,
// //             child: Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Row(
// //                     children: [
// //                       PopupMenuButton(
// //                         shape: RoundedRectangleBorder(
// //                             borderRadius:
// //                                 BorderRadius.all(Radius.circular(10.0))),
// //                         //context: Get.context,
// //                         offset: const Offset(-180, 0),
// //                         icon: Icon(
// //                           Icons.attach_file,
// //                           size: 25,
// //                           // color: AppColors.grayShade_4,
// //                         ),
// //                         onSelected: (newValue) async {
// //                           if (newValue == 0) {
// //                             print('select 0 Document');
// //                             var message = Message(
// //                                 id: "",
// //                                 senderId: "$userID",
// //                                 createdAt: DateTime.now(),
// //                                 receiverId: "$receiverId",
// //                                 msgType: StringConstants.messageTypeDoc,
// //                                 msg: "",
// //                                 seen: false);
// //                             Message msg = await _getDocuments(message);
// //                             print("send_message to socket");
// //                             // MessageTabController.to.rxList.add(msg);
// //                             // MessageTabController.to.update();
// //                             messageTextController.clear();
// //                           }
// //                           if (newValue == 1) {
// //                             print('select 1 Pdf');
// //                             var message = Message(
// //                                 id: "",
// //                                 senderId: "$userID",
// //                                 createdAt: DateTime.now(),
// //                                 receiverId: "$receiverId",
// //                                 msgType: StringConstants.messageTypePdf,
// //                                 msg: "",
// //                                 seen: false);
// //
// //                             Message msg = await _getDocuments(message);
// //                             print("send_message to socket");
// //                             // MessageTabController.to.rxList.add(msg);
// //                             // MessageTabController.to.update();
// //                             messageTextController.clear();
// //                           }
// //                           if (newValue == 2) {
// //                             print('select 2 Image');
// //
// //                             var message = Message(
// //                                 id: "",
// //                                 senderId: "$userID",
// //                                 createdAt: DateTime.now(),
// //                                 receiverId: "$receiverId",
// //                                 msgType: StringConstants.messageTypeImage,
// //                                 msg: "",
// //                                 seen: false);
// //
// //                             Message msg = await _getDocuments(message);
// //                             print("send_message to socket");
// //                             // MessageTabController.to.rxList.add(msg);
// //                             // MessageTabController.to.update();
// //                             messageTextController.clear();
// //                           }
// //                         },
// //                         itemBuilder: (context) => [
// //                           PopupMenuItem(
// //                             child: Row(
// //                               children: [
// //                                 Icon(
// //                                   Icons.file_present,
// //                                   color: Color(0xff6A868F),
// //                                 ),
// //                                 SizedBox(
// //                                   width: 10.0,
// //                                 ),
// //                                 Text(
// //                                   "Document",
// //                                   style: TextStyle(
// //                                       color: Colors.black,
// //                                       fontWeight: FontWeight.bold,
// //                                       fontFamily: 'Montserrat'),
// //                                 ),
// //                               ],
// //                             ),
// //                             value: 0,
// //                           ),
// //                           PopupMenuItem(
// //                             child: Row(
// //                               children: [
// //                                 Icon(
// //                                   Icons.camera_alt_outlined,
// //                                   color: Color(0xff6A868F),
// //                                 ),
// //                                 SizedBox(
// //                                   width: 10.0,
// //                                 ),
// //                                 Text(
// //                                   "Pdf",
// //                                   style: TextStyle(
// //                                       color: Colors.black,
// //                                       fontWeight: FontWeight.bold,
// //                                       fontFamily: 'Montserrat'),
// //                                 ),
// //                               ],
// //                             ),
// //                             value: 1,
// //                           ),
// //                           PopupMenuItem(
// //                             child: Row(
// //                               children: [
// //                                 Icon(
// //                                   Icons.image,
// //                                   color: Color(0xff6A868F),
// //                                 ),
// //                                 SizedBox(
// //                                   width: 10.0,
// //                                 ),
// //                                 Text(
// //                                   "Image",
// //                                   style: TextStyle(
// //                                       color: Colors.black,
// //                                       fontWeight: FontWeight.bold,
// //                                       fontFamily: 'Montserrat'),
// //                                 ),
// //                               ],
// //                             ),
// //                             value: 2,
// //                           ),
// //                         ],
// //                       ),
// //                       Padding(
// //                         padding: const EdgeInsets.only(top: 2.0, left: 6),
// //                         child: Container(
// //                           width: AppSize().width(context) * 0.70,
// //                           child: TextFormField(
// //                             controller: messageTextController,
// //                             inputFormatters: [
// //                               FilteringTextInputFormatter.allow(
// //                                   RegExp("[a-z A-Z]"))
// //                             ],
// //                             decoration: InputDecoration(
// //                                 border: InputBorder.none,
// //                                 hintText: 'Type message here',
// //                                 hintStyle: TextStyle(fontFamily: 'Montserrat')),
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   InkWell(
// //                     onTap: () {
// //                       FocusScope.of(context).unfocus();
// //                       sendMessage(false, '', '');
// //                       scrollList();
// //                     },
// //                     child: Padding(
// //                       padding: const EdgeInsets.only(right: 12.0),
// //                       child: Icon(
// //                         Icons.send,
// //                         // color: AppColors.lightGreenColor,
// //                       ),
// //                     ),
// //                   )
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //         // backgroundColor: AppColors.grayShade_1,
// //         appBar: AppBar(
// //           elevation: 0,
// //           // backgroundColor: AppColors.colorWhite,
// //           leading: GestureDetector(
// //               onTap: () {
// //                 // Get.back();
// //               },
// //               child: Icon(
// //                 Icons.arrow_back_sharp,
// //                 color: Color(0xff6A868F),
// //               )),
// //           centerTitle: true,
// //           // title: Text(
// //           //   (_messageTabController.rxGetPrevMessages == null)
// //           //       ? ''
// //           //       : _messageTabController
// //           //           .rxGetPrevMessages.data.clientId.firstName,
// //           //   style: TextStyle(
// //           //       // color: AppColors.grayShade_7,
// //           //       fontWeight: FontWeight.bold,
// //           //       fontFamily: 'Montserrat'),
// //           // ),
// //         ),
// //
// //         /*actions: [
// //               InkWell(
// //                 onTap: () {
// //                   setState(() {
// //                     _makePhoneCall('tel:98765434210');
// //                   });
// //                 },
// //                 child: Padding(
// //                   padding: const EdgeInsets.only(right: 20.0),
// //                   child: SvgPicture.asset('assets/images/icon_awesome_phone.svg'),
// //                 ),
// //               )
// //             ],*/
// //         // ),
// //         body: Container(
// //           height: double.infinity,
// //           width: double.infinity,
// //           child: Stack(children: <Widget>[
// //             InkWell(
// //                 //${(resp.data.hire) ? (resp.data.hire&&resp.data.offer.payment) ? "View Contract" : "View Offer" : (resp.data.invitation==null) ? "View Proposal" : "View Invitation"}
// //                 onTap: () {
// //                   //   (!_messageTabController.rxGetPrevMessages.value.data.hire)
// //                   //       ? (_messageTabController
// //                   //                   .rxGetPrevMessages.value.data.purposal.id ==
// //                   //               null)
// //                   //           ? Get.to(ViewInvitationChat(_messageTabController
// //                   //               .rxGetPrevMessages.value.data.invitation))
// //                   //           : Get.to(ViewProposalChat(_messageTabController
// //                   //               .rxGetPrevMessages.value.data.purposal))
// //                   //       : (_messageTabController
// //                   //               .rxGetPrevMessages.value.data.offer.payment)
// //                   //           ? Get.to(ViewContractChat(
// //                   //               _messageTabController
// //                   //                   .rxGetPrevMessages.value.data.offer,
// //                   //               _messageTabController
// //                   //                   .rxGetPrevMessages.value.data.clientId))
// //                   //           : Get.to(ViewOfferChat(_messageTabController.rxGetPrevMessages.value.data.offer, (_messageTabController.rxGetPrevMessages.value == null) ? '' : _messageTabController.rxGetPrevMessages.value.data.clientId.firstName, _messageTabController.rxGetPrevMessages.value.data.acceptOffer));
// //                   //
// //                 },
// //                 child: staticView()),
// //             // Container(
// //             //     padding: const EdgeInsets.only(
// //             //         bottom: 2.0, right: 12.0, left: 12.0, top: 45.0),
// //             //     child: (_messageTabController.rxList.isEmpty)
// //             //         ? Center(child: CircularProgressIndicator())
// //             //         : ListView.builder(
// //             //             controller: scrollController,
// //             //             shrinkWrap: true,
// //             //             physics: ClampingScrollPhysics(),
// //             //             itemCount: _messageTabController.rxList.length,
// //             //             itemBuilder: (BuildContext context, int index) {
// //             //               if (_messageTabController.rxList.length - 1 ==
// //             //                   index) {
// //             //                 scrollList();
// //             //               }
// //             //
// //             //               return Container(
// //             //                 child: Column(
// //             //                   children: [
// //             //                     (userID ==
// //             //                             _messageTabController
// //             //                                 .rxList[index].senderId)
// //             //                         ? myMessageView(
// //             //                             _messageTabController.rxList[index])
// //             //                         : userMessageView(
// //             //                             _messageTabController.rxList[index])
// //             //                   ],
// //             //                 ),
// //             //               );
// //             //             })
// //             //     ),
// //           ]),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   ///user message view
// //   Widget userMessageView(Message message) {
// //     return Align(
// //       alignment: Alignment.centerLeft,
// //       child: Padding(
// //         padding: const EdgeInsets.all(4.0),
// //         child: InkWell(
// //           onTap: () {
// //             if (message.msgType != StringConstants.messageTypeTxt) {
// //               _launchURL(message.msg!);
// //             }
// //           },
// //           child: Container(
// //             decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(10),
// //                 color: Color(0xffCDDED4)),
// //             child: Padding(
// //               padding: const EdgeInsets.all(10.0),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   (message.msgType == StringConstants.messageTypeTxt)
// //                       ? Text(
// //                           '${message.msg}',
// //                           style: TextStyle(
// //                               // color: AppColors.grayShade_7,
// //                               fontFamily: 'Montserrat'),
// //                         )
// //                       : Container(
// //                           padding: EdgeInsets.all(10.0),
// //                           decoration: BoxDecoration(
// //                               borderRadius: BorderRadius.circular(10),
// //                               color: Colors.grey[100]),
// //                           child: Row(
// //                             mainAxisSize: MainAxisSize.min,
// //                             children: [
// //                               Icon(Icons.file_present),
// //                               SizedBox(width: 10.0),
// //                               fileName(message.msg!),
// //                               SizedBox(width: 10.0),
// //                             ],
// //                           ),
// //                         ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   ///my message view
// //   Widget myMessageView(Message message) {
// //     return Padding(
// //       padding: const EdgeInsets.all(4.0),
// //       child: Align(
// //         alignment: Alignment.centerRight,
// //         child: InkWell(
// //           onTap: () {
// //             if (message.msgType != StringConstants.messageTypeTxt) {
// //               _launchURL(message.msg!);
// //             }
// //           },
// //           child: Container(
// //             padding: EdgeInsets.all(10.0),
// //             decoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(10),
// //               // color: AppColors.colorWhite
// //             ),
// //             child: (message.msgType == StringConstants.messageTypeTxt)
// //                 ? Text(
// //                     '${message.msg}',
// //                     style: TextStyle(
// //                         // color: AppColors.grayShade_7,
// //                         fontFamily: 'Montserrat'),
// //                   )
// //                 : Container(
// //                     padding: EdgeInsets.all(5.0),
// //                     /*decoration: BoxDecoration(
// //                         borderRadius: BorderRadius.circular(10),
// //                         color: Colors.grey[100]),*/
// //                     child: Row(
// //                       mainAxisSize: MainAxisSize.min,
// //                       children: [
// //                         Icon(
// //                           Icons.file_present,
// //                           // color: AppColors.lightGreenColor
// //                         ),
// //                         SizedBox(width: 10.0),
// //                         fileName(message.msg!),
// //                         SizedBox(width: 10.0),
// //                       ],
// //                     ),
// //                   ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   ///Send Message
// //   void sendMessage(bool isForDocument, String messageType, String filePath) {
// //     // receiverId = _messageTabController.rxGetPrevMessages.value.data.clientId.id;
// //
// //     String messageTxt = (isForDocument)
// //         ? filePath
// //         : (messageTextController.text.trim().isEmpty)
// //             ? showError()
// //             : messageTextController.text;
// //
// //     if (!messageTxt.isEmpty) {
// //       print("send_message");
// //       var jsonSendMessage = {
// //         "roomId": "${widget.roomId}",
// //         "senderId": '$userID',
// //         "receiverId": '$receiverId',
// //         "msg": (isForDocument)
// //             ? filePath
// //             : /*(messageTextController.text.isEmpty) ? Get.snackbar("Error", "Please enter message") :*/ messageTextController
// //                 .text,
// //         "msgType": (isForDocument) ? messageType : "text",
// //         // "caseId":
// //         //     '${_messageTabController.rxGetPrevMessages.value.data.caseId.id}',
// //       };
// //       print('jsonSendMessage >> $jsonSendMessage');
// //       socket.emit('send_message', [jsonSendMessage]);
// //
// //       /// ////////////////
// //       var message = Message(
// //           id: "",
// //           senderId: '$userID',
// //           createdAt: DateTime.now(),
// //           receiverId: '$receiverId',
// //           msgType: (isForDocument) ? messageType : "text",
// //           msg: messageTxt,
// //           seen: false);
// //
// //       // _messageTabController.rxList.add(message);
// //       // _messageTabController.update();
// //       messageTextController.clear();
// //     }
// //   }
// //
// //   ///ScrollList
// //   void scrollList() {
// //     Timer(
// //         Duration(milliseconds: 200),
// //         () =>
// //             scrollController.jumpTo(scrollController.position.maxScrollExtent));
// //   }
// //
// //   ///Get documents
// //   Future<Message> _getDocuments(Message msg) async {
// //     print('doc clicked !!!!!!!!');
// //     String _documentPath;
// //
// //     try {
// //       var file = await FilePicker.platform.pickFiles(
// //         type: FileType.custom,
// //         allowedExtensions: (msg.msgType == StringConstants.messageTypeDoc)
// //             ? ['doc', 'docx']
// //             : (msg.msgType == StringConstants.messageTypeImage)
// //                 ? ['jpg', 'jpeg']
// //                 : ['pdf'],
// //       );
// //
// //       if (file != null) {
// //         _documentPath = file.files.single.path!;
// //         var list = [];
// //         list = _documentPath.split('.');
// //         String _fileExtension = list[list.length - 1].toString();
// //         if (_fileExtension.toLowerCase() == 'jpg' ||
// //             _fileExtension.toLowerCase() == 'jpeg' ||
// //             _fileExtension.toLowerCase() == 'png' ||
// //             _fileExtension.toLowerCase() == 'pdf' ||
// //             _fileExtension.toLowerCase() == 'doc' ||
// //             _fileExtension.toLowerCase() == 'docx') {
// //           /// check msg
// //           if (msg.msgType == StringConstants.messageTypeDoc) {
// //             isPerfectFile = (_fileExtension.toLowerCase() == 'doc' ||
// //                 _fileExtension.toLowerCase() == 'docx');
// //           } else if (msg.msgType == StringConstants.messageTypePdf) {
// //             isPerfectFile = (_fileExtension.toLowerCase() == 'pdf');
// //           } else if (msg.msgType == StringConstants.messageTypeImage) {
// //             isPerfectFile = (_fileExtension.toLowerCase() == 'jpg' ||
// //                 _fileExtension.toLowerCase() == 'jpeg');
// //           }
// //           (isPerfectFile)
// //               ? uploadFileAndSendMessage(
// //                   File(file.files.single.path!), msg, _fileExtension.toLowerCase())
// //               : fileSelectionError();
// //         } else {
// //           print('You can only upload image, word or pdf.');
// //           fileSelectionError();
// //           msg.msg = "";
// //         }
// //       } else {
// //         print('File not selected!');
// //         msg.msg = "";
// //       }
// //       return msg;
// //     } catch (e) {
// //       print("Error while picking the file: " + e.toString());
// //       return msg;
// //     }
// //   }
// //
// //   ///Launch URl
// //   _launchURL(String url) async {
// //     if (await canLaunch(url)) {
// //       await launch(url);
// //     } else {
// //       throw 'Could not launch $url';
// //     }
// //   }
// //
// //   ///fileName
// //   Widget fileName(String link) {
// //     var list = [];
// //     list = link.split('/');
// //     String _filename = list[list.length - 1].toString();
// //     //print('$_filename');
// //     return Text(
// //       '$_filename',
// //       style: TextStyle(
// //           // color: AppColors.lightGreenColor,
// //           fontFamily: 'Montserrat',
// //           fontWeight: FontWeight.bold),
// //     );
// //   }
// //
// //   ///static view
// //   Widget staticView() {
// //     return ListView(
// //       children: [
// //         Container(
// //           height: 0.5,
// //           // color: AppColors.grayShade_5,
// //         ),
// //         Container(
// //           height: 40.0,
// //           alignment: Alignment.center,
// //           padding: EdgeInsets.only(left: 15.0),
// //           decoration: BoxDecoration(
// //             border: Border.all(
// //               color: Colors.white,
// //             ),
// //             color: Colors.white,
// //           ),
// //           child: Text(
// //             "${_messageTabController.title}",
// //             style: TextStyle(
// //                 // color: AppColors.colorBtnGreen,
// //                 fontSize: 16,
// //                 fontFamily: 'Montserrat',
// //                 fontWeight: FontWeight.bold),
// //           ),
// //         ),
// //         /*Container(
// //             height: 0.5,
// //             color: AppColors.grayShade_5,
// //           ),*/
// //         SizedBox(
// //           height: 2,
// //         )
// //       ],
// //     );
// //   }
// //
// //   /// passDataToConst
// //   passDataToConst(String roomId) {
// //     ChatScreens(isFromAccept: "false", roomId: "$roomId");
// //     scrollList();
// //     scrollList();
// //   }
// //
// //   ///showError
// //   String showError() {
// //     ApiProvider().showToastMsg("Error\nYour message is empty");
// //     return "";
// //   }
// //
// //   ///backPressed
// //   Future<bool> backPressed() async {
// //     // (widget.isFromAccept)
// //     //     ? Get.offAll(HomeScreenV())
// //     //     : _messageTabController.rxList.clear();
// //     // _messageTabController.rxChatListResp.value =
// //     //     await RemoteServices.fetchAllChatList();
// //     // _messageTabController.chatList.clear();
// //     // _messageTabController.chatList
// //     //     .addAll(_messageTabController.rxChatListResp.value.data);
// //     // _messageTabController.update();
// //     return true;
// //   }
// //
// //   ///getChatList
// //   Future<void> getChatList() async {
// //     // _messageTabController.rxChatListResp.value =
// //     //     await RemoteServices.fetchAllChatList();
// //     // _messageTabController.chatList.clear();
// //     // _messageTabController.chatList
// //     //     .addAll(_messageTabController.rxChatListResp.value.data);
// //     // _messageTabController.update();
// //     // print(" to refresh getChatList");
// //   }
// //
// //   ///uploadFileAndSendMessage
// //   uploadFileAndSendMessage(File? file, Message msg, contentType) {
// //     /// ContentType
// //     String type = getContentType(contentType);
// //
// //     ///upload File
// //     AwsPage()
// //         .upload(
// //       file!,
// //       // type
// //     )
// //         .then((onValue) {
// //       // Get.back();
// //       print("file uploaded >>> $onValue");
// //       msg.msg = onValue;
// //       msg.msgType = contentType;
// //       //print("Message type >>> ${msg.msgType}");
// //       //print("Message msg >>> ${msg.msg}");
// //       sendMessage(true, msg.msgType!, msg.msg!);
// //     });
// //   }
// //
// //   ///fileSelectionError
// //   fileSelectionError() {
// //     // Get.back();
// //     ApiProvider().showToastMsg("Error\nPlease select valid file");
// //   }
// // }
// //
// // ///_makePhoneCall
// // Future<void> _makePhoneCall(String url) async {
// //   if (await canLaunch(url)) {
// //     await launch(url);
// //   } else {
// //     throw 'Could not launch $url';
// //   }
// // }
// //
// // ///getContentType
// // String getContentType(String lowerCase) {
// //   int? mt;
// //   if (lowerCase == 'jpg' || lowerCase == 'jpeg' || lowerCase == 'png') {
// //     mt = 0;
// //   } else if (lowerCase == 'pdf') {
// //     mt = 1;
// //   } else if (lowerCase == 'doc' || lowerCase == 'docx') {
// //     mt = 2;
// //   }
// //   return (mt == 0)
// //       ? 'image/$lowerCase'
// //       : (mt == 1)
// //           ? 'application/$lowerCase'
// //           : 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
// // }
//
// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:app/common/chat_image.dart';
// import 'package:app/common/colors.dart';
// import 'package:app/common/constant.dart';
// import 'package:app/helpers/constants.dart';
// import 'package:app/helpers/image_picker_handler.dart';
// import 'package:app/models/loader.dart';
// import 'package:app/models/message_model.dart';
// import 'package:app/models/trip_res.dart';
// import 'package:app/providers/sign_in_provider.dart';
// import 'package:app/providers/signin_provider.dart';
// import 'package:app/screens/initiate_Survey.dart';
// import 'package:app/screens/membersScreen.dart';
// import 'package:app/screens/take_view_survey.dart';
// import 'package:azblob/azblob.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:chewie/chewie.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:mime/mime.dart';
// import 'package:path/path.dart';
// import 'package:provider/provider.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
// import 'package:socket_io_client/socket_io_client.dart';
// import 'package:video_player/video_player.dart';
//
// class AlertChatScreen extends StatefulWidget {
//   bool amIOrganizer;
//   String tripId;
//
//   AlertChatScreen(this.amIOrganizer, this.tripId);
//
//   @override
//   _AlertChatScreenState createState() => _AlertChatScreenState();
// }
//
// class _AlertChatScreenState extends State<AlertChatScreen>
//     with TickerProviderStateMixin, ImagePickerListener {
//   final messageTextController = TextEditingController();
//   Color blackColor = Colors.black;
//
//   bool shouldWait = false;
//
//   //messageList..
//   List<MessageBubble> messages = [];
//
//   // select image
//   var bytes;
//   late File image;
//   late File _cameraVideo;
//   late Socket socket;
//   late double height;
//   late double width;
//
//   int msgItemLength = 0;
//
//   //CheckForSurvey_Response checkSurveyData;
//   ImagePickerHandler imagePicker;
//   late AnimationController _controller;
//
//   // ItemScrollController itemScrollController = ItemScrollController();
//   // ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
//
//   late SignInProvider signInProvider;
//   late Loader loader;
//   String storageAccountConnectionString =
//       'DefaultEndpointsProtocol=https;AccountName=sunny75;AccountKey=7CJjx9TVC9WC2kRVhJT4S5LDlXmiExLwNVE6oTsEd2873Vf5/21MH7OCyZo9VW3LHJRZMjD9NL824xYg61i2rA==;EndpointSuffix=core.windows.net';
//   String containerAzure = 'chat';
//   String baseUrlAzure = 'https://sunny75.blob.core.windows.net/chat/';
//   String mediaUrl = '';
//   bool showSendButton = false;
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final signInProvider = Provider.of<SignInProvider>(this.context);
//     final loader = Provider.of<Loader>(this.context);
//
//     if (this.signInProvider != signInProvider || this.loader != loader) {
//       this.signInProvider = signInProvider;
//       this.loader = loader;
//       Future.microtask(() async {
//         // await signInProvider.checkForSurvey(loader, widget.tripId);
//         // await signInProvider.getTripMembersList(
//         //     loader, widget.tripId, signInProvider.userResponse);
//         getPreviousMessages();
//         _connectSocket01();
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     //WidgetsBinding.instance.removeObserver(true);
//     socket.destroy(); //disconnect socket and dispose not needed controllers
//     messageTextController.dispose();
//
//     // signInProvider.messagesResponse = null;
//     // signInProvider.checkForSurveyRes = null;
//     // signInProvider.tripMembersRes = null;
//     super.dispose();
//   }
//
//   //disconnect socket
//   disconnectSocket() async {
//     if (socket != null) {
//       socket.destroy();
//     }
//   }
//
//   void getPreviousMessages() async {
//     // await signInProvider.getChatMessagesList(
//     //     loader, signInProvider.userResponse, widget.tripId, 1, 100);
//     //
//     // if (signInProvider.messagesResponse != null &&
//     //     signInProvider.messagesResponse.data?.isNotEmpty) {
//     //   for (var i = 0; i < signInProvider.messagesResponse.data.length; i++) {
//     //     addMessagesToList(signInProvider.messagesResponse.data[i]);
//     //   }
//     // }
//   }
//
//   // void addMessagesToList(Data data) {
//   //   final checkUser = data.senderId.sId.toString() ==
//   //       signInProvider.userResponse.data.id.toString();
//   //
//   //   final msgBubble = MessageBubble(
//   //     sender: data.senderId.sId,
//   //     content: data.message,
//   //     avatar: data.senderId.image,
//   //     timestamp: data.createdAt,
//   //     isMe: checkUser,
//   //     messageType: data.messageType,
//   //     messageCategory: data.messageCategory,
//   //     senderName: data.senderId.fullName,
//   //     tripName: '${signInProvider.tripMembersRes.data?.tripName}',
//   //   );
//   //   setState(() {
//   //     messages.add(msgBubble);
//   //   });
//   // }
//
//   void _connectSocket01() {
//     //update your domain before using
//     // Dart client
//     socket = io(
//         //'http://api.sunny-75.com:8087/',
//         //'http://10.10.30.20:8087/',
//         //'http://sunny75.mobilytedev.com:8087/',
//
//         /// this is commeted for now,
//         'http://203.190.154.100:8087/',
//
//         /// for performance tesing
//         // 'https://qa-sunny75.azurewebsites.net',
//         OptionBuilder()
//             .setTransports(['websocket']) // for Flutter or Dart VM
//             .disableAutoConnect() // disable auto-connection
//             .setExtraHeaders({'foo': 'bar'}) // optional
//             .build());
//     // ignore: cascade_invocations
//     socket.connect();
//
//     // ignore: cascade_invocations
//     socket.onConnect((_) {
//       socket.emit('joinChannel', widget.tripId);
//     });
//
//     // ignore: cascade_invocations
//     socket.on('getMessage', (data) {
//       //messageTextController.clear();
//       final messageData = Data.fromJson(data);
//
//       addMessagesToList(messageData);
//
//       // ignore: cascade_invocations
//       if (messages != null && messages.length > 2) {
//         itemScrollController.scrollTo(
//             index: messages.length - 1,
//             // ignore: cascade_invocations
//             duration: Duration(milliseconds: 200),
//             curve: Curves.decelerate);
//       }
//     });
//
//     socket.onDisconnect((_) => print('disconnect'));
//     socket.on('fromServer', (_) => print(_));
//   }
//
//   String profileImage =
//       'https://cultivatedculture.com/wp-content/uploads/2019/12/LinkedIn-Profile-Picture-Example-Madeline-Mann.jpeg';
//
// // stack avatar showing avatar of person who text on particular list
//   Widget positionedAvatar(InvitedData invitiesData) {
//     return Align(
//       heightFactor: 0.75,
//       widthFactor: 0.75,
//       alignment: Alignment.centerLeft,
//       child: CircleAvatar(
//         radius: 12,
//         backgroundColor: Colors.white,
//         child: CircleAvatar(
//           radius: 11,
//           backgroundImage:
//               invitiesData.image != null && invitiesData.image != ''
//                   ? NetworkImage(invitiesData.image)
//                   : AssetImage(
//                       'assets/images/profile.png',
//                     ),
//         ),
//       ),
//     );
//   }
//
// // total message on particular conversation
//   Widget totalMessageCircle(int count) {
//     return Align(
//       heightFactor: 0.75,
//       widthFactor: 0.9,
//       alignment: Alignment.centerLeft,
//       child: CircleAvatar(
//         radius: 12,
//         backgroundColor: appColor,
//         child: CircleAvatar(
//           backgroundColor: Colors.white,
//           radius: 11,
//           child: Text(
//             '+${count - 3}',
//             style: TextStyle(color: appColor, fontSize: 12),
//           ),
//         ),
//       ),
//     );
//   }
//
// // header of chat screen
//   Widget header() {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         SizedBox(
//           width: width * 0.02,
//         ),
//         InkWell(
//           onTap: () {
//             Navigator.pop(this.context);
//           },
//           child: Icon(
//             Icons.arrow_back,
//             size: width * 0.09,
//           ),
//         ),
//         InkWell(
//             onTap: () async {
//               // TripMembersResModel response = await signInProvider.getTripMembersList(loader,widget.tripId,signInProvider.userResponse);
//               await Navigator.push(
//                   this.context,
//                   MaterialPageRoute(
//                       builder: (context) =>
//                           Members(signInProvider.tripMembersRes.data)));
//             },
//             child: headerTitle())
//       ],
//     );
//   }
//
// //header title with image
//   Widget headerTitle() {
//     return Container(
//       padding: EdgeInsets.all(width * 0.02),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CircleAvatar(
//             radius: width * 0.07,
//             backgroundImage:
//                 NetworkImage(signInProvider.tripMembersRes.data.image),
//           ),
//           SizedBox(
//             width: width * 0.02,
//           ),
//           Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: width * 0.65,
//                 child: Text(
//                   signInProvider.tripMembersRes.data?.tripName ?? "",
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(color: blackColor, fontSize: width * 0.05),
//                 ),
//               ),
//               SizedBox(
//                 height: 35,
//                 width: width * 0.65,
//                 child: ListView.builder(
//                   itemCount: signInProvider
//                       .tripMembersRes.data.totalInviteeGoing.length,
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (BuildContext context, int index) {
//                     if (index < 3) {
//                       return positionedAvatar(signInProvider
//                           .tripMembersRes.data.totalInviteeGoing[index]);
//                     } else if (index == 3) {
//                       return totalMessageCircle(signInProvider
//                           .tripMembersRes.data.totalInviteeGoing.length);
//                     } else {
//                       return Container();
//                     }
//                   },
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//
//     imagePicker = ImagePickerHandler(this, _controller);
//     imagePicker.init();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     height = MediaQuery.of(context).size.height;
//     width = MediaQuery.of(context).size.width;
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: signInProvider.checkForSurveyRes != null &&
//                 signInProvider.tripMembersRes != null &&
//                 signInProvider.messagesResponse != null
//             ? SafeArea(
//                 child: Stack(children: [
//                   Container(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         header(),
//                         if (messages != null && messages.length > 0)
//                           Expanded(
//                             child: ScrollablePositionedList.builder(
//                               physics: ClampingScrollPhysics(),
//                               itemCount: messages.length,
//                               scrollDirection: Axis.vertical,
//                               initialScrollIndex: (messages.length) - 1,
//                               itemScrollController: itemScrollController,
//                               itemPositionsListener: itemPositionsListener,
//                               itemBuilder: (BuildContext context, int index) {
//                                 return MessageBubble(
//                                   isFirst: index == 0 ? 'true' : 'false',
//                                   sender: messages[index].sender,
//                                   content: messages[index].content,
//                                   timestamp: messages[index].timestamp,
//                                   isMe: messages[index].isMe,
//                                   senderName: messages[index].senderName,
//                                   messageType: messages[index].messageType,
//                                   avatar: messages[index].avatar,
//                                   messageCategory:
//                                       messages[index].messageCategory,
//                                   tripName:
//                                       '${signInProvider.tripMembersRes.data?.tripName}',
//                                 );
//                               },
//                             ),
//                           )
//                         else
//                           Container(),
//                         Container(
//                           decoration: BoxDecoration(
//                             border: Border(
//                               top: BorderSide(
//                                   color: Colors.grey.withOpacity(0.6),
//                                   width: 1.0),
//                             ),
//                           ),
//                           padding: EdgeInsets.all(10),
//                           width: MediaQuery.of(context).size.width,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               if (image != null)
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Stack(
//                                       children: [
//                                         SizedBox(
//                                           height: 100,
//                                           child: Image.file(
//                                             File(image?.path ?? ""),
//                                           ),
//                                         ),
//                                         Positioned.fill(
//                                           child: Align(
//                                             alignment: Alignment.center,
//                                             child: InkWell(
//                                               onTap: () {
//                                                 setState(() {
//                                                   image = null;
//                                                 });
//                                               },
//                                               child: CircleAvatar(
//                                                 backgroundColor: Colors.black
//                                                     .withOpacity(0.3),
//                                                 child: Icon(Icons.close),
//                                               ),
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                     FlatButton(
//                                       onPressed: () {
//                                         setState(() {
//                                           var messageData = {
//                                             'sender': signInProvider
//                                                 .userResponse.data.id,
//                                             'trip': widget.tripId,
//                                             'room': widget.tripId,
//                                             'message': mediaUrl,
//                                             'messageType': 'image'
//                                           };
//                                           socket.emit(
//                                               'sendMessage', messageData);
//                                           image = null;
//                                         });
//                                       },
//                                       child: CircleAvatar(
//                                         backgroundColor: appColor,
//                                         child: Icon(Icons.check, size: 25),
//                                       ),
//                                     )
//                                   ],
//                                 )
//                               else
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Expanded(
//                                       child: Padding(
//                                         padding: const EdgeInsets.only(
//                                             left: 8, top: 8, bottom: 8),
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.all(
//                                               Radius.circular(15),
//                                             ),
//                                           ),
//                                           child: Row(
//                                             children: [
//                                               Expanded(
//                                                 child: TextFormField(
//                                                   onTap: () {
//                                                     // Future.delayed(Duration(
//                                                     //         milliseconds: 200))
//                                                     //     .then((value) =>
//                                                     //         scrollController
//                                                     //             .animateTo(
//                                                     //           scrollController
//                                                     //               .position
//                                                     //               .maxScrollExtent,
//                                                     //           duration: Duration(
//                                                     //               milliseconds:
//                                                     //                   600),
//                                                     //           curve:
//                                                     //               Curves.ease,
//                                                     //         ));
//                                                   },
//                                                   textInputAction:
//                                                       TextInputAction.done,
//                                                   minLines: 1,
//                                                   maxLines: 4,
//                                                   controller:
//                                                       messageTextController,
//                                                   style: TextStyle(
//                                                     color: Colors.black,
//                                                   ),
//                                                   onChanged: (val) {
//                                                     setState(() {
//                                                       showSendButton =
//                                                           val.isNotEmpty;
//                                                     });
//                                                   },
//                                                   decoration: InputDecoration(
//                                                     enabledBorder:
//                                                         OutlineInputBorder(
//                                                       borderRadius:
//                                                           BorderRadius.all(
//                                                         Radius.circular(5),
//                                                       ),
//                                                       borderSide: BorderSide(
//                                                         color: Colors.grey,
//                                                       ),
//                                                     ),
//                                                     focusedBorder:
//                                                         OutlineInputBorder(
//                                                       borderRadius:
//                                                           BorderRadius.all(
//                                                         Radius.circular(5),
//                                                       ),
//                                                       borderSide: BorderSide(
//                                                         color: Colors.black54,
//                                                       ),
//                                                     ),
//                                                     border: OutlineInputBorder(
//                                                       borderRadius:
//                                                           BorderRadius.all(
//                                                         Radius.circular(5),
//                                                       ),
//                                                       borderSide: BorderSide(
//                                                         color: Colors.black54,
//                                                       ),
//                                                     ),
//                                                     contentPadding:
//                                                         EdgeInsets.symmetric(
//                                                             vertical: 15,
//                                                             horizontal: 10),
//                                                     filled: false,
//                                                     hintText:
//                                                         'Type your message',
//                                                     hintStyle: TextStyle(
//                                                       color: Colors.black12,
//                                                     ),
//                                                   ),
//                                                   onFieldSubmitted: (value) {
//                                                     if (value.trim() != '') {
//                                                       final messageData = {
//                                                         'sender': signInProvider
//                                                             .userResponse
//                                                             .data
//                                                             .id,
//                                                         'trip': widget.tripId,
//                                                         'room': widget.tripId,
//                                                         'message': value,
//                                                         'messageType': 'text'
//                                                       };
//                                                       socket.emit('sendMessage',
//                                                           messageData);
//                                                       messageTextController
//                                                           .clear();
//                                                       setState(() {
//                                                         showSendButton = false;
//                                                       });
//                                                     }
//                                                   },
//                                                 ),
//                                               ),
//                                               if (showSendButton) ...{
//                                                 GestureDetector(
//                                                   onTap: () {
//                                                     if (messageTextController
//                                                             .text
//                                                             .trim() !=
//                                                         '') {
//                                                       final messageData = {
//                                                         'sender': signInProvider
//                                                             .userResponse
//                                                             .data
//                                                             .id,
//                                                         'trip': widget.tripId,
//                                                         'room': widget.tripId,
//                                                         'message':
//                                                             messageTextController
//                                                                 .text,
//                                                         "messageType": 'text'
//                                                       };
//                                                       socket.emit('sendMessage',
//                                                           messageData);
//                                                       messageTextController
//                                                           .clear();
//                                                       setState(() {
//                                                         showSendButton = false;
//                                                       });
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     padding:
//                                                         const EdgeInsets.all(3),
//                                                     child: SvgPicture.asset(
//                                                         'assets/images/send_button_chat.svg',
//                                                         height: width * 0.1,
//                                                         width: width * 0.1),
//                                                   ),
//                                                 ),
//                                               } else ...{
//                                                 IconButton(
//                                                     icon: Icon(
//                                                       Icons.attach_file,
//                                                       color: appColor,
//                                                     ),
//                                                     onPressed: () async {
//                                                       if (Platform.isIOS) {
//                                                         FocusScope.of(context)
//                                                             .requestFocus(
//                                                                 FocusNode());
//                                                       }
//
//                                                       imagePicker.showDialog(
//                                                           context,
//                                                           isVideo: 'true');
//                                                     })
//                                               }
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     InkWell(
//                                       onTap: () async {
//                                         if (!shouldWait) {
//                                           shouldWait = true;
//                                           await signInProvider.surveyDetails(
//                                               loader,
//                                               signInProvider.checkForSurveyRes
//                                                       .checkSurvey.isNotEmpty
//                                                   ? signInProvider
//                                                       .checkForSurveyRes
//                                                       .checkSurvey[0]
//                                                       .sid
//                                                   : '0',
//                                               signInProvider.userResponse,
//                                               widget.tripId);
//                                           if (widget.amIOrganizer == true) {
//                                             await Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) => InitiateSurvey(
//                                                       signInProvider
//                                                               .checkForSurveyRes
//                                                               .checkSurvey
//                                                               .isNotEmpty
//                                                           ? signInProvider
//                                                               .checkForSurveyRes
//                                                               .checkSurvey[0]
//                                                               .sid
//                                                           : "0",
//                                                       widget.tripId,
//                                                       widget.amIOrganizer)),
//                                             );
//                                           } else {
//                                             if (signInProvider.checkForSurveyRes
//                                                 .checkSurvey.isNotEmpty) {
//                                               await Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         TakeViewSurvey(
//                                                             surveyId: signInProvider
//                                                                 .checkForSurveyRes
//                                                                 .checkSurvey[0]
//                                                                 .sid,
//                                                             tripId:
//                                                                 widget.tripId,
//                                                             surveyType: widget
//                                                                 .amIOrganizer)),
//                                               );
//                                             }
//                                           }
//                                         }
//
//                                         await Future.delayed(
//                                             Duration(seconds: 1), () {
//                                           shouldWait = false;
//                                         });
//                                       },
//                                       child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Stack(
//                                             children: [
//                                               SvgPicture.asset(
//                                                 'assets/images/poll.svg',
//                                                 height: 25,
//                                                 width: 25,
//                                                 // color: Colors.black,
//                                               ),
//                                               if (signInProvider
//                                                   .checkForSurveyRes
//                                                   .checkSurvey
//                                                   .isNotEmpty) ...{
//                                                 Container(
//                                                   margin:
//                                                       EdgeInsets.only(left: 13),
//                                                   child: ClipRRect(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             50),
//                                                     child: Container(
//                                                       // margin:  EdgeInsets.only(left:10),
//                                                       color: Colors.red,
//                                                       width:
//                                                           MediaQuery.of(context)
//                                                                   .size
//                                                                   .width *
//                                                               0.04,
//                                                       height:
//                                                           MediaQuery.of(context)
//                                                                   .size
//                                                                   .width *
//                                                               0.04,
//                                                       child: Center(
//                                                         child: Text(
//                                                           '1',
//                                                           style: TextStyle(
//                                                             color: Colors.white,
//                                                             fontSize: 10,
//                                                             fontFamily:
//                                                                 'TitilliumWebBold',
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               }
//                                             ],
//                                           )),
//                                     )
//                                   ],
//                                 ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // loader.loader ? LoaderTransparent() : Container()
//                 ]),
//               )
//             : Center(child: CircularProgressIndicator()));
//   }
//
//   @override
//   userImage(File _image) {
//     if (_image != null) {
//       uploadFileToAzure(_image, 'image').then((value) {
//         mediaUrl = value!;
//         image = _image;
//         setState(() {});
//       });
//     }
//   }
//
//   Future<String?> uploadFileToAzure(File image, String type) async {
//     mediaUrl = '';
//     try {
//       var fileName = basename(image.path);
//       if (type == 'video') {
//         fileName = fileName.replaceAll('.jpg', '.mp4');
//       }
//
//       // read file as Uint8List
//       final content = await image.readAsBytes();
//       var storage = AzureStorage.parse(storageAccountConnectionString);
//       final container = containerAzure;
//       // get the mine type of the file
//       final contentType = lookupMimeType(fileName);
//       await storage.putBlob('/$container/$fileName',
//           bodyBytes: content,
//           contentType: contentType,
//           type: BlobType.BlockBlob);
//
//       final responseUrl = baseUrlAzure + fileName;
//
//       return responseUrl;
//     } on AzureStorageException catch (ex) {
//       // ignore: avoid_catches_without_on_clauses
//     } catch (err) {
//       //print(err);
//     }
//   }
//
//   @override
//   userVideo(File _video) {
//     if (_video != null) {
//       uploadFileToAzure(_video, 'video').then((value) {
//         mediaUrl = value;
//
//         final messageData = {
//           'sender': signInProvider.userResponse.data!.user!.sId,
//           'trip': widget.tripId,
//           'room': widget.tripId,
//           'message': mediaUrl,
//           'messageType': 'video'
//         };
//
//         socket.emit("sendMessage", messageData);
//       });
//     }
//   }
// }
//
// class MessageBubble extends StatefulWidget {
//   const MessageBubble(
//       {@required this.sender,
//       @required this.content,
//       @required this.timestamp,
//       this.messageImage,
//       this.isLocal = false,
//       this.avatar,
//       this.isMe,
//       this.messageType,
//       this.messageCategory,
//       this.isFirst,
//       this.tripName,
//       this.senderName});
//
//   final String? sender;
//   final String? content;
//   final String? timestamp;
//   final String? avatar;
//   final bool? isMe;
//   final bool? isLocal;
//   final File? messageImage;
//   final String? messageType;
//   final String? messageCategory;
//   final String? senderName;
//   final String? isFirst;
//   final String? tripName;
//
//   @override
//   _MessageBubbleState createState() => _MessageBubbleState();
// }
//
// class _MessageBubbleState extends State<MessageBubble> {
//   SignInProvider? signInProvider;
//   Loader? loader;
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final signInProvider = Provider.of<SignInProvider>(this.context);
//     final loader = Provider.of<Loader>(this.context);
//
//     if (this.signInProvider != signInProvider || this.loader != loader) {
//       this.signInProvider = signInProvider;
//       this.loader = loader;
//       Future.microtask(() async {});
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     String? removedName;
//     String? removedcontent;
//     if (widget.messageCategory == 'removal') {
//       removedName = widget.content!.substring(0, widget.content!.indexOf(' '));
//       removedcontent =
//           widget.content!.substring(widget.content!.indexOf(' ') + 1);
//     }
//     final contentSplit = widget.content!.split('\n');
//     return widget.messageCategory != 'removal'
//         ? Padding(
//             padding: const EdgeInsets.only(
//               left: 8,
//               right: 8,
//             ),
//             child: GestureDetector(
//               onTap: () {
//                 if (widget.messageType == 'image') {
//                   Navigator.of(context).push(MaterialPageRoute<Null>(
//                       builder: (BuildContext context) {
//                         return Container();
//                           // ChatImageScreen(widget.content);
//                       },
//                       fullscreenDialog: true));
//                   // ApiProvider().showToastMsg('Yes');
//                 }
//               },
//               onLongPressEnd: (_) {},
//               child: Column(
//                 crossAxisAlignment: widget.isMe!
//                     ? CrossAxisAlignment.end
//                     : CrossAxisAlignment.start,
//                 children: [
//                   if (widget.messageImage != null)
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(8.0),
//                       child: Image.file(
//                         File(widget.messageImage!.path ?? ""),
//                         width: MediaQuery.of(context).size.width / 2,
//                       ),
//                     )
//                   else
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           if (!widget.isMe!)
//                             widget.avatar != null &&
//                                     widget.avatar.toString().trim() != ''
//                                 ? CircleAvatar(
//                                     radius: 16,
//                                     backgroundImage:
//                                         NetworkImage(widget.avatar!))
//                                 : CircleAvatar(
//                                     radius: 16,
//                                     backgroundImage: AssetImage(
//                                       'assets/images/profile.png',
//                                     ),
//                                   ),
//                           SizedBox(
//                             width: 5,
//                           ),
//                           Column(
//                             crossAxisAlignment: widget.isMe!
//                                 ? CrossAxisAlignment.end
//                                 : CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 widget.senderName!,
//                                 style: kChatSender,
//                               ),
//                               if (widget.messageType == 'text')
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 2),
//                                   child: Material(
//                                     //elevation: 5.0,
//                                     borderRadius: widget.isMe!
//                                         ? kChatMyMessageBubble
//                                         : kChatNotMyMessageBubble,
//                                     color: widget.isMe!
//                                         ? Colors.orangeAccent
//                                         : Colors.grey[200],
//                                     child: Padding(
//                                         padding: EdgeInsets.symmetric(
//                                           vertical: 10.0,
//                                           horizontal: 20,
//                                         ),
//                                         child: widget.content!
//                                                     .toLowerCase()
//                                                     .contains(
//                                                         'published trip') &&
//                                                 widget.content!
//                                                     .toLowerCase()
//                                                     .contains(
//                                                         '${widget.tripName}'
//                                                             .toLowerCase())
//                                             ? InkWell(
//                                                 onTap: () async {
//                                                   // signInProvider
//                                                   //     .getPlanTrip(loader);
//                                                   // Navigator.pop(context);
//                                                 },
//                                                 child: Column(
//                                                   children: [
//                                                     ConstrainedBox(
//                                                       constraints:
//                                                           BoxConstraints(
//                                                         maxWidth: MediaQuery.of(
//                                                                     context)
//                                                                 .size
//                                                                 .width /
//                                                             1.435,
//                                                       ),
//                                                       child: RichText(
//                                                         text: TextSpan(
//                                                           text: '',
//                                                           style: DefaultTextStyle
//                                                                   .of(context)
//                                                               .style,
//                                                           children: <TextSpan>[
//                                                             TextSpan(
//                                                               text:
//                                                                   '${contentSplit[0]}',
//                                                               style: TextStyle(
//                                                                   decoration:
//                                                                       TextDecoration
//                                                                           .underline,
//                                                                   fontSize: 12,
//                                                                   color: Colors
//                                                                       .blue,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w500),
//                                                             ),
//                                                             TextSpan(
//                                                               text:
//                                                                   ' ${contentSplit[1] != "" ? contentSplit[1] : ""}',
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 color: Colors
//                                                                     .black,
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               )
//                                             : Column(
//                                                 children: [
//                                                   ConstrainedBox(
//                                                     constraints: BoxConstraints(
//                                                       maxWidth:
//                                                           MediaQuery.of(context)
//                                                                   .size
//                                                                   .width /
//                                                               1.435,
//                                                     ),
//                                                     child: Text(
//                                                       '${widget.content}',
//                                                       style: widget.isMe!
//                                                           ? kChatMyMessage
//                                                           : kChatText,
//                                                       textAlign:
//                                                           TextAlign.start,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               )),
//                                   ),
//                                 )
//                               else
//                                 (widget.messageType == 'image')
//                                     ? Align(
//                                         alignment: widget.isMe!
//                                             ? Alignment.topRight
//                                             : Alignment.topLeft,
//                                         child: Container(
//                                           height: 250,
//                                           width: 250,
//                                           child: (widget.content != null &&
//                                                   widget.content != '')
//                                               ? CachedNetworkImage(
//                                                   imageUrl: widget.content!,
//                                                   imageBuilder: (context,
//                                                           imageProvider) =>
//                                                       Container(
//                                                     decoration: BoxDecoration(
//                                                       image: DecorationImage(
//                                                         image: imageProvider,
//                                                         fit: BoxFit.fill,
//                                                       ),
//                                                       borderRadius:
//                                                           BorderRadius.only(
//                                                               bottomLeft: Radius
//                                                                   .circular(
//                                                                       8.0),
//                                                               bottomRight:
//                                                                   Radius
//                                                                       .circular(
//                                                                           8.0)),
//                                                     ),
//                                                   ),
//                                                   placeholder: (context, url) =>
//                                                       Center(
//                                                     child:
//                                                         CircularProgressIndicator(),
//                                                   ),
//                                                   errorWidget:
//                                                       (context, url, error) =>
//                                                           Icon(Icons.error),
//                                                 )
//                                               : CachedNetworkImage(
//                                                   imageUrl:
//                                                       'https://homepages.cae.wisc.edu/~ece533/images/arctichare.png',
//                                                   imageBuilder: (context,
//                                                           imageProvider) =>
//                                                       Container(
//                                                     decoration: BoxDecoration(
//                                                       image: DecorationImage(
//                                                         image: imageProvider,
//                                                         fit: BoxFit.fill,
//                                                       ),
//                                                       borderRadius:
//                                                           BorderRadius.only(
//                                                               bottomLeft: Radius
//                                                                   .circular(
//                                                                       8.0),
//                                                               bottomRight:
//                                                                   Radius
//                                                                       .circular(
//                                                                           8.0)),
//                                                     ),
//                                                   ),
//                                                   placeholder: (context, url) =>
//                                                       Center(
//                                                     child:
//                                                         CircularProgressIndicator(),
//                                                   ),
//                                                   errorWidget:
//                                                       (context, url, error) =>
//                                                           Icon(Icons.error),
//                                                 ),
//                                         ),
//                                       )
//                                     : Align(
//                                         alignment: widget.isMe!
//                                             ? Alignment.topRight
//                                             : Alignment.topLeft,
//                                         child: VideoPlayerRemote(
//                                             videoUrl: widget.content!),
//                                       ),
//                             ],
//                           )
//                           // Padding(
//                         ],
//                       ),
//                     )
//                 ],
//               ),
//             ),
//           )
//         : Padding(
//             padding: const EdgeInsets.only(
//                 left: 8.0, right: 8.0, top: 5.0, bottom: 5.0),
//             child: Container(
//               alignment: Alignment.center,
//               child: RichText(
//                 text: TextSpan(
//                   text: '',
//                   style: DefaultTextStyle.of(context).style,
//                   children: <TextSpan>[
//                     TextSpan(
//                       text: '$removedName',
//                       style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.black,
//                           fontWeight: FontWeight.w500),
//                     ),
//                     TextSpan(
//                       text: ' $removedcontent',
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ));
//   }
// }
//
// // ignore: must_be_immutable
// class VideoPlayerRemote extends StatefulWidget {
//   int playBackTime;
//   int playBackTotalTime;
//   String setPlayTime;
//   String setPlayDuration;
//   double aspectRatio;
//   String videoUrl;
//   bool isForward;
//   bool isFullScreen;
//   bool allowFullScreen;
//   bool showControls;
//   bool isAutoPlay;
//   int startWithinSeconds;
//
//   VideoPlayerRemote({
//     Key? key,
//     this.playBackTime = 0,
//     this.playBackTotalTime = 0,
//     this.setPlayTime = '00:00',
//     this.setPlayDuration = '00:00',
//     this.aspectRatio = 16 / 9,
//     this.videoUrl = "",
//     this.isForward = true,
//     this.isFullScreen = false,
//     this.allowFullScreen = false,
//     this.showControls = true,
//     this.isAutoPlay = false,
//     this.startWithinSeconds = 0,
//   }) : super(key: key);
//
//   @override
//   _VideoPlayerRemoteState createState() => _VideoPlayerRemoteState();
// }
//
// class _VideoPlayerRemoteState extends State<VideoPlayerRemote> {
//   //VideoPlayerController _controller;
//   late ChewieController _chewieController;
//   late VideoPlayerController _videoPlayerController1;
//
//   // VideoPlayerController _videoPlayerController2;
//
//   void initPlayer() async {
//     _videoPlayerController1 = VideoPlayerController.network(widget.videoUrl);
//     // _videoPlayerController2 = VideoPlayerController.network(
//     //     'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4');
//     await Future.wait([
//       _videoPlayerController1.initialize(),
//       // _videoPlayerController2.initialize()
//     ]);
//     _chewieController = ChewieController(
//       videoPlayerController: _videoPlayerController1,
//       autoPlay: false,
//       looping: false,
//       // Try playing around with some of these other options:
//
//       // showControls: false,
//       // materialProgressColors: ChewieProgressColors(
//       //   playedColor: Colors.red,
//       //   handleColor: Colors.blue,
//       //   backgroundColor: Colors.grey,
//       //   bufferedColor: Colors.lightGreen,
//       // ),
//       // placeholder: Container(
//       //   color: Colors.grey,
//       // ),
//       // autoInitialize: true,
//     );
//     setState(() {});
//     // _controller = VideoPlayerController.network(widget.videoUrl);
//     // print(widget.videoUrl);
//     // await _controller.initialize();
//     // _controller.setLooping(false);
//     // _controller.seekTo(Duration(seconds: widget.startWithinSeconds));
//     // if (widget.isAutoPlay) {
//     //   _controller.play();
//     // }
//     // _controller.addListener(() {
//     //   setState(() {
//     //     print("duration !!!!!!! " +
//     //         _controller.value.duration.inSeconds.toString());
//     //     print(" play duration !!!!!!! " +
//     //         _controller.value.position.inSeconds.toString());
//     //   });
//     // });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     initPlayer(); //initialize the VideoPlayer
//   }
//
//   @override
//   void dispose() {
//     _videoPlayerController1.dispose();
//     // _videoPlayerController2.dispose();
//     _chewieController?.dispose();
//     //_controller.dispose();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeRight,
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         alignment: Alignment.center,
//         height: 200,
//         width: 300,
//         child: //(_controller.value.initialized) ?
//             Stack(
//           children: [
//             SizedBox.expand(
//               child: FittedBox(
//                 fit: BoxFit.fill,
//                 child: SizedBox(
//                   width: 300,
//                   height: 200,
//                   //------------------------------------------
//                   child: _chewieController != null
//                       ? Chewie(
//                           controller: _chewieController,
//                         )
//                       : Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: const [
//                             CircularProgressIndicator(),
//                             SizedBox(height: 20),
//                             Text('Loading'),
//                           ],
//                         ),
//                   //    Chewie(
//                   //   controller: _chewieController,
//                   // )
//                   //  AspectRatio(
//                   //   aspectRatio: 16 / 12,
//                   //   child: BetterPlayer.network(
//                   //     widget.videoUrl,
//                   //     betterPlayerConfiguration: BetterPlayerConfiguration(
//                   //       aspectRatio: 16 / 12,
//                   //     ),
//                   //   ),
//                   // )
//                   //--------------------------------------------------------------
//                 ),
//               ),
//             ),
//             // Center(
//             //     child: InkWell(
//             //   onTap: () {
//             //     if (_controller.value.isPlaying) {
//             //       _controller.pause();
//             //
//             //     }else if(_controller.value.position.inSeconds.toString() == _controller.value.duration.inSeconds.toString()) {
//             //
//             //       _controller.pause();
//             //       _controller.addListener(() {
//             //         _controller.setLooping(false);
//             //         setState(() {
//             //           print("duration !!!!!!! "+ _controller.value.duration.inSeconds.toString());
//             //           print(" play duration !!!!!!! "+ _controller.value.position.inSeconds.toString());
//             //         });
//             //       });
//             //
//             //
//             //     }else{
//             //       _controller.play();
//             //
//             //
//             //     }
//             //   },
//             //   child: Icon(
//             //     _controller.value.isPlaying
//             //         ? Icons.pause
//             //         : Icons.play_arrow,
//             //     color: Colors.black87,
//             //     size: 42,
//             //   ),
//             // )),
//           ],
//         )
//         // : Container(),
//         );
//   }
// }
