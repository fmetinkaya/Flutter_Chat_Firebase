import 'package:flutter/material.dart';
import 'package:flutterdenemechat/MyFiles/core/locator.dart';
import 'package:flutterdenemechat/MyFiles/viewmodels/main_model.dart';

import 'status_page.dart';
import 'add_activity_page.dart';
import 'camera_page.dart';
import 'chats_page.dart';

class WhatsAppMain extends StatefulWidget {
  WhatsAppMain({Key key}) : super(key: key);

  @override
  _WhatsAppMainState createState() => _WhatsAppMainState();
}

class _WhatsAppMainState extends State<WhatsAppMain>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool _showMessage = true;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 4, initialIndex: 1);
    _tabController.addListener(() {
      _showMessage = _tabController.index != 0;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var model = getIt<MainModel>();
    return Scaffold(
      body: SafeArea(
        child: Column(
                children: <Widget>[
                  TabBar(
                    labelColor: Colors.black12,
                    controller: _tabController,
                    tabs: <Widget>[
                      Tab(
                        icon: Icon(Icons.camera),
                      ),
                      Tab(
                        text: "Chats",
                      ),
                      Tab(text: "Status"),
                      Tab(text: "Calls"),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: _tabController,
                        children: <Widget>[
                          CameraPage(),
                          ChatsPage(),
                          StatusPage(),
                          AddActivityPage(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
      /*floatingActionButton: _showMessage
          ? FloatingActionButton(
              child: Icon(
                Icons.message,
                color: Colors.white,
              ),
              onPressed: () async {
                await model.navigateToContacts();
              },
            )
          : null,*/
    );
  }
}
