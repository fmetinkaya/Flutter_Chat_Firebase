import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterdenemechat/MyFiles/core/locator.dart';
import 'package:flutterdenemechat/MyFiles/core/services/db_service.dart';
import 'package:flutterdenemechat/MyFiles/core/services/storage_service.dart';
import 'package:image_picker/image_picker.dart';

import 'base_model.dart';

class ConversationModel extends BaseModel {

  removeAlert(String userId, String documentReferenceId, int userAlert) async{
    if(userAlert!=0){
      await getIt<DbService>().firestore.doc('conversations/$documentReferenceId').update({"alertUserId-$userId":0});
    }
  }


Stream<QuerySnapshot> getConversation(String documentReferenceId, int displayMessageLimit) {
  CollectionReference ref = getIt<DbService>().firestore.collection('conversations/$documentReferenceId/messages');

    return ref.orderBy('timeStamp', descending: true).limit(displayMessageLimit).snapshots();
  }

  add(Map<String, dynamic> message, String documentReferenceId, String peerUserId) {
    DocumentReference addMessageRef = FirebaseFirestore.instance.collection('conversations/$documentReferenceId/messages').doc();
    DocumentReference alertRef = getIt<DbService>().firestore.doc('conversations/$documentReferenceId');

    var batch = getIt<DbService>().firestore.batch();
    batch.set(addMessageRef, message);
    batch.update(alertRef, {"alertUserId-$peerUserId": FieldValue.increment(1)});

    batch.commit();
  }

  uploadMedia(ImageSource source, String userId, String documentReferenceId, String peerUserId) async {
    CollectionReference ref = FirebaseFirestore.instance.collection('conversations/$documentReferenceId/messages');
    var pickedFile = await ImagePicker().getImage(
        source: source, maxWidth: 450, maxHeight: 450, imageQuality: 100);

    if (pickedFile == null) return;
    String imageUrl = await getIt<StorageService>().uploadMedia(File(pickedFile.path));
    await add({
      'senderId': userId,
      'message': "",
      'timeStamp': FieldValue.serverTimestamp(),
      'media': imageUrl
    },documentReferenceId, peerUserId);
  }
  chattingWith(String _chattingWith, String userId) async {
  print(_chattingWith+" "+userId+ "chaat with çalıştı");
   await getIt<DbService>().firestore.collection("profile").doc(userId).update({"chattingWith": _chattingWith});
  }
}
