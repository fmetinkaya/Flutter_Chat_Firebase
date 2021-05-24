import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterdenemechat/MyFiles/core/locator.dart';
import 'package:flutterdenemechat/MyFiles/core/services/auth_service.dart';
import 'package:flutterdenemechat/MyFiles/core/services/chat_service.dart';
import 'package:flutterdenemechat/MyFiles/models/conversation.dart';
import 'package:flutterdenemechat/MyFiles/viewmodels/chats_model.dart';
import 'package:flutterdenemechat/MyFiles/viewmodels/sign_in_model.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'conversation_page.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key key}) : super(key: key);

  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) {
    var modelChat = getIt<ChatsModel>();
    var user = getIt<AuthService>().currentUser;

    return  StreamBuilder<List<Conversation>>(
        stream: modelChat.conversations(user.uid).distinct(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Conversation>> snapshot) {
          if (snapshot.hasData == null) {
            return Text('data boş');
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }

          return ListView(
            children: snapshot.data
                .map((doc) => buildChatList(doc, context, user))
                .toList(),
          );
        },
      );
  }

  Widget buildChatList(Conversation doc, BuildContext context, User user) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(doc.peerProfileImage),
      ),
      title: Text(doc.peerName),
      subtitle: Text(
        doc.lastMessage,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
      trailing: Column(
        children: <Widget>[
          Container(
            child: Text(
              DateFormat("yyyy-MM-dd")
                  .format(doc.lastMessageTime.toDate())
                  .toString(),
              textAlign: TextAlign.center,
            ),
          ),
          doc.alertUser > 0
              ? Container(
                  width: 20,
                  height: 20,
                  margin: EdgeInsets.only(top: 8),
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                  child: Center(
                    child: Text(
                      doc.alertUser.toString(),
                      textScaleFactor: 0.8,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                )
              : Container(
                  width: 0,
                  height: 0,
                ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (content) => ConversationPage(
              userId: user.uid,
              conversation: doc,
            ),
          ),
        );
      },
    );
  }
}
