import 'package:flutterdenemechat/MyFiles/core/services/chat_service.dart';
import 'package:flutterdenemechat/MyFiles/core/services/db_service.dart';
import 'package:flutterdenemechat/MyFiles/core/services/location_service.dart';
import 'package:flutterdenemechat/MyFiles/core/services/navigator_service.dart';
import 'package:flutterdenemechat/MyFiles/core/services/notification_service.dart';
import 'package:flutterdenemechat/MyFiles/viewmodels/add_activity_model.dart';
import 'package:flutterdenemechat/MyFiles/viewmodels/chats_model.dart';
import 'package:flutterdenemechat/MyFiles/viewmodels/contacts_model.dart';
import 'package:flutterdenemechat/MyFiles/viewmodels/conversation_model.dart';
import 'package:flutterdenemechat/MyFiles/viewmodels/log_in_model.dart';
import 'package:flutterdenemechat/MyFiles/viewmodels/main_model.dart';
import 'package:flutterdenemechat/MyFiles/viewmodels/sign_in_model.dart';
import 'package:flutterdenemechat/MyFiles/core/services/storage_service.dart';
import 'package:get_it/get_it.dart';

import 'services/auth_service.dart';


GetIt getIt = GetIt.instance;


setupLocators() {
  getIt.registerLazySingleton(() => NavigatorService());
  getIt.registerLazySingleton(() => ChatService());
  getIt.registerLazySingleton(() => AuthService());
  getIt.registerLazySingleton(() => DbService());
  getIt.registerLazySingleton(() => StorageService());
  getIt.registerLazySingleton(() => NotificationService());
  getIt.registerLazySingleton(() => LocationService());

  getIt.registerFactory(() => MainModel());
  getIt.registerFactory(() => ChatsModel());
  getIt.registerFactory(() => SignInModel());
  getIt.registerFactory(() => LogInModel());
  getIt.registerFactory(() => ContactsModel());
  getIt.registerFactory(() => ConversationModel());
  getIt.registerFactory(() => AddActivityModel());
}
