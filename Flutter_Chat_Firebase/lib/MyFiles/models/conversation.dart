import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterdenemechat/MyFiles/models/profile.dart';

class Conversation {
  String documentReferenceId;
  String peerName;
  String peerProfileImage;
  String peerUserId;
  String lastMessage;
  int alertUser;
  int alertPeer;
  Timestamp lastMessageTime;

  Conversation({this.documentReferenceId, this.peerName, this.peerProfileImage, this.lastMessage, this.peerUserId, this.lastMessageTime, this.alertUser, this.alertPeer});

  factory Conversation.fromSnapshot(DocumentSnapshot snapshot, Profile peerProfile, String userId) {

        return Conversation(
        documentReferenceId: snapshot.id,
        peerName: peerProfile.userName,
        peerProfileImage: peerProfile.image,
        peerUserId: peerProfile.id,
        lastMessage: snapshot.data()['lastMessage'],
        lastMessageTime: snapshot.data()["lastMessageTime"],
        alertUser: snapshot.data()["alertUserId-$userId"],
        alertPeer: snapshot.data()["alertUserId-"+peerProfile.id]);
  }
}
