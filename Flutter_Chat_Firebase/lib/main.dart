import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterdenemechat/MyFiles/core/services/notification_service.dart';
import 'package:flutterdenemechat/MyFiles/screens/whatsapp_main.dart';
import 'package:flutterdenemechat/MyFiles/viewmodels/add_activity_model.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

import 'MyFiles/core/locator.dart';
import 'MyFiles/core/services/auth_service.dart';
import 'MyFiles/core/services/chat_service.dart';
import 'MyFiles/core/services/navigator_service.dart';
import 'MyFiles/screens/signup_page.dart';
import 'MyFiles/viewmodels/sign_in_model.dart';

bool USE_FIRESTORE_EMULATOR = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (USE_FIRESTORE_EMULATOR) {
    FirebaseFirestore.instance.settings = Settings(
        host: 'localhost:8080', sslEnabled: false, persistenceEnabled: false);
  }

  setupLocators();
  await getIt<NotificationService>().localNotification();
  await getIt<NotificationService>().tokenRegister();
  getIt<NotificationService>().cloudNotificationListenerConfigure();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (BuildContext context) => AddActivityModel())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Erkek Oder',
          navigatorKey: getIt<NavigatorService>().navigatorKey,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: IntroScreen(),
        ));
  }
}

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        title: Text('Erkek Oder'),
        seconds: 2,
        navigateAfterSeconds: getIt<AuthService>().currentUser != null
            ? WhatsAppMain()
            : SignUpPage());
  }
}
