import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterdenemechat/MyFiles/core/services/db_service.dart';
import 'package:flutterdenemechat/MyFiles/core/locator.dart';
import 'package:flutterdenemechat/MyFiles/core/services/auth_service.dart';
import 'package:flutterdenemechat/MyFiles/core/services/navigator_service.dart';
import 'package:flutterdenemechat/MyFiles/screens/whatsapp_main.dart';
import 'base_model.dart';

class SignInModel extends BaseModel {

  Future<void> signInAndRegisterDatabase (String email, String password, String name) async {
    if (name.isEmpty) return;
    busy = true;

    var user = await getIt<AuthService>().signIn(email, password);

    if (user != null) {
      try {
        await getIt<DbService>().firestore.collection('profile').doc(user.uid).set(
            {'userName': name, 'image': 'https://placekitten.com/200/200', "chattingWith": ""});

        await getIt<NavigatorService>().navigateToReplace(WhatsAppMain());
      } catch (e) {
        print("bunlar");
        print(e);
        busy = false;
      }
    }
    busy = false;
  }
}
