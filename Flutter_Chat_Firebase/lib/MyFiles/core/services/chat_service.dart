import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterdenemechat/MyFiles/core/services/db_service.dart';
import 'package:flutterdenemechat/MyFiles/models/conversation.dart';
import 'package:flutterdenemechat/MyFiles/models/profile.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutterdenemechat/MyFiles/core/locator.dart';

class ChatService {
  Stream<List<Conversation>> getConversations(String userId) {
    var ref = getIt<DbService>()
        .firestore
        .collection('conversations')
        .where('members', arrayContains: userId).orderBy('lastMessageTime', descending: true);

    var conversationsStream = ref.snapshots();

    var profilesStream = getContacs().asStream();

    return Rx.combineLatest2(
      conversationsStream,
      profilesStream,
      (QuerySnapshot conversations, List<Profile> profiles) =>
          conversations.docs.map(
        (snapshot) {
          List<String> members = List.from(snapshot['members']);
          var profile = profiles.firstWhere(
            (element) =>
                element.id == members.firstWhere((member) => member != userId),
          );
          if (profile != null) {}
          return Conversation.fromSnapshot(snapshot, profile, userId);
        },
      ).toList(),
    );
  }


  ///////////////////////////////////dont take into account. This is for contact page//////////////////////
  Future<List<Profile>> getContacs() async {
    var ref = getIt<DbService>().firestore.collection("profile");

    var documents = await ref.get();

    return documents.docs
        .map((snapshot) => Profile.fromSnapshot(snapshot))
        .toList();
  }
  Future<Conversation> startConversation(User user, Profile peerProfile) async {
    var ref = getIt<DbService>().firestore.collection('conversations');

    var documentRef = await ref.add({
      'lastMessage': '',
      'lastMessageTime': FieldValue.serverTimestamp(),
      'alertUserId-'+user.uid: 0,
      'alertUserId-'+peerProfile.id: 0,
      'members': [user.uid, peerProfile.id]
    });

    return Conversation(
      documentReferenceId: documentRef.id,
      lastMessage: '',
      peerName: peerProfile.userName,
      peerProfileImage: peerProfile.image,
    );
  }

}
