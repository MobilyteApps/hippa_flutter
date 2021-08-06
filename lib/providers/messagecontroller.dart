import 'dart:convert';
import 'package:app/response/chat_details_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MessageTabController  {


  var roomId ='';
  var txtVisible = false;
  var title = "View";
  var isTitleDisable = false;

  // String accessToken = LocalService().getData("access_token").toString();
  //
  //
  // GetPrevMessages rxGetPrevMessages = GetPrevMessages();
  // Rx<ChatListResp> rxChatListResp = Rx(ChatListResp());
  //
  // var rxList = <Message>[];
  // var chatList = <ChatListDataItem>[];
  //
  //
  // final _message = <Message>[];
  // final _paginationFilter = PaginationFilter();
  // final _lastPage = false;
  //
  // List<Message> get users => _message.toList();
  // int get limit => _paginationFilter.value.limit;
  // int get _page => _paginationFilter.value.page;
  // bool get lastPage => _lastPage;
  //
  // @override
  // onInit() {
  //   getChatList();
  // }
  //
  // Future<bool> getLimitMessages(String roomId) async {
  //   print('get limit message >>> $roomId');
  //   final GetPrevMessages resp = await RemoteServices.getLimitMessages(roomId);
  //   if (resp.data.messages.isEmpty) {
  //     _lastPage.value = true;
  //   }
  //   rxGetPrevMessages.value = resp;
  //   rxList.clear();
  //   title.value = '${(!resp.data.hire) ? (resp.data.purposal.id!=null) ? "View Proposal" : "View Invitation" : (resp.data.hire && resp.data.offer.payment) ? "View Contract" : "View Offer"}';
  //   isTitleDisable.value = resp.data.acceptOffer;
  //   rxList.addAll(resp.data.messages);
  //   return true;
  // }
  //
  // Future<void> getChatList() async {
  //   final ChatListResp rsp = await RemoteServices.fetchAllChatList();
  //   rxChatListResp.value = rsp;
  //   chatList.clear();
  //   chatList.addAll(rsp.data);
  // }


}
