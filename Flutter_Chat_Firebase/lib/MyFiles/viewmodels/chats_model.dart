import 'package:flutterdenemechat/MyFiles/core/locator.dart';
import 'package:flutterdenemechat/MyFiles/core/services/chat_service.dart';
import 'package:flutterdenemechat/MyFiles/models/conversation.dart';
import 'package:get_it/get_it.dart';
import 'base_model.dart';

class ChatsModel extends BaseModel {

  Stream<List<Conversation>> conversations(String userId) {
    return getIt<ChatService>().getConversations(userId);
  }
}
