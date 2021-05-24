import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterdenemechat/MyFiles/core/locator.dart';
import 'package:flutterdenemechat/MyFiles/core/services/chat_service.dart';
import 'package:flutterdenemechat/MyFiles/core/services/navigator_service.dart';
import 'package:flutterdenemechat/MyFiles/models/profile.dart';
import 'package:flutterdenemechat/MyFiles/screens/conversation_page.dart';

import 'base_model.dart';
class ContactsModel extends BaseModel {

  Future<List<Profile>> getContacts(String query) async {
    var contacts = await getIt<ChatService>().getContacs();

    var filteredContacts = contacts
        .where(
          (profile) => profile.userName.startsWith(query ?? ""),
        )
        .toList();

    return filteredContacts;
  }

  Future<void> startConversation(User user, Profile profile) async {
    var conversation = await getIt<ChatService>().startConversation(user, profile);

    return getIt<NavigatorService>().navigateTo(
      ConversationPage(
        conversation: conversation,
        userId: user.uid,
      ),
    );
  }
}
