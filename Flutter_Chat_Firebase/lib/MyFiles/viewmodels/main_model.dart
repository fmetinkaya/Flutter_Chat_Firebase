import 'package:flutterdenemechat/MyFiles/core/locator.dart';
import 'package:flutterdenemechat/MyFiles/screens/contacts_page.dart';
import 'package:flutterdenemechat/MyFiles/core/services/navigator_service.dart';
import 'base_model.dart';


class MainModel extends BaseModel {
  Future<void> navigateToContacts() {
    return getIt<NavigatorService>().navigateTo(ContactsPage());
  }
}
