import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterdenemechat/MyFiles/core/locator.dart';
import 'package:flutterdenemechat/MyFiles/core/services/auth_service.dart';
import 'package:flutterdenemechat/MyFiles/core/services/navigator_service.dart';
import 'package:flutterdenemechat/MyFiles/screens/whatsapp_main.dart';
import 'base_model.dart';

class LogInModel extends BaseModel {
  Future<void> logIn(String email, String password) async {
    busy = true;
    var user = await getIt<AuthService>().logIn(email, password);
    if (user != null) {
      await getIt<NavigatorService>().navigateToReplace(WhatsAppMain());
      busy = false;
    }
    busy = false;
  }
}
