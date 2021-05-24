import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterdenemechat/MyFiles/core/locator.dart';
import 'package:flutterdenemechat/MyFiles/core/services/db_service.dart';
import 'package:flutterdenemechat/MyFiles/core/services/navigator_service.dart';
import 'package:flutterdenemechat/MyFiles/models/conversation.dart';
import 'package:flutterdenemechat/MyFiles/screens/full_screen_page.dart';
import 'package:flutterdenemechat/MyFiles/viewmodels/conversation_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ConversationPage extends StatefulWidget {
  final String userId;
  final Conversation conversation;

  const ConversationPage({Key key, this.userId, this.conversation})
      : super(key: key);

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage>
    with WidgetsBindingObserver {
  final TextEditingController _editingController = TextEditingController();
  FocusNode _focusNode;
  int _displayMessageLimit = 20;
  final int _displayMessageIncrease = 20;
  ScrollController _scrollController;
  var model = getIt<ConversationModel>();

  @override
  void initState() {
print("initstate çalıştı");
    _focusNode = FocusNode();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    model.chattingWith(widget.conversation.peerUserId, widget.userId);
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        print("app in resumed");
        await model.chattingWith(widget.conversation.peerUserId, widget.userId);
        break;
      case AppLifecycleState.inactive:
        model.chattingWith("", widget.userId);
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        model.chattingWith("", widget.userId);
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        await model.chattingWith("", widget.userId);
        print("app in detached");
        break;
    }
  } //changelifecycle listener

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
    model.chattingWith("", widget.userId);
    WidgetsBinding.instance.removeObserver(this);
    print("dispose çalıştı");
    super.dispose();
  } // dispose listener

  _scrollListener() {
    print("scroll listener activity");
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        _displayMessageLimit = _displayMessageLimit + _displayMessageIncrease;
      });
      print("reach the top" + _displayMessageLimit.toString());
    }
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        _displayMessageLimit = _displayMessageIncrease;
        _displayMessageLimit = _displayMessageIncrease;
      });
      print("reach the bottom" + _displayMessageLimit.toString());
    }
  } // scroll listener for decrease/increase listview's items

  Widget buildConversationList(QueryDocumentSnapshot document) {
    if (!document['message'].isEmpty) {
      return Container(
        padding: EdgeInsets.all(5),
        child: Align(
            alignment: widget.userId != document['senderId']
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: document['message'] == null || document['message'].isEmpty
                ? Container()
                : Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: widget.userId != document['senderId']
                          ? Colors.white
                          : Colors.blue,
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(10),
                        right: Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      document['message'],
                      style: TextStyle(color: Colors.black),
                    ))),
      );
    }
    if (!document['media'].isEmpty) {
      return Container(
        padding: EdgeInsets.all(5),
        child: document['media'] == null || document['media'].isEmpty
            ? Container()
            : Align(
                alignment: widget.userId != document['senderId']
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: GestureDetector(
                  child: Hero(
                    tag: document['media'],
                    child: Material(
                      child: CachedNetworkImage(
                        placeholder: (context, url) => Container(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF262626)),
                          ),
                          width: 200.0,
                          height: 200.0,
                          padding: EdgeInsets.all(70.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Material(
                          child: Image.asset(
                            'images/img_not_available.jpeg',
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          clipBehavior: Clip.hardEdge,
                        ),
                        imageUrl: document['media'],
                        width: 300.0,
                        height: 300.0,
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      clipBehavior: Clip.hardEdge,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return FullScreenPage(url: document['media'],tag: document['media'] );
                    }));
                  },
                ),
              ),
      );
    }
    return Container();
  } // dynamic listview widget
  Widget buildConversationListView (AsyncSnapshot<QuerySnapshot> snapshot){
    print("yeniden kuruldu");
    model.removeAlert(widget.userId,widget.conversation.documentReferenceId,widget.conversation.alertUser);
    return ListView(
      reverse: true,
      controller: _scrollController,
      children: snapshot.data.docs
          .map((document) =>
          buildConversationList(document))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            titleSpacing: -5,
            title: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.conversation.peerProfileImage),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(widget.conversation.peerName),
                )
              ],
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: InkWell(
                  child: Icon(Icons.phone),
                  onTap: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: InkWell(
                  child: Icon(Icons.camera_alt),
                  onTap: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: InkWell(
                  child: Icon(Icons.more_vert),
                  onTap: () {},
                ),
              )
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage("https://placekitten.com/600/800"),
              ),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () => _focusNode.unfocus(),
                    child: StreamBuilder(
                      stream: model.getConversation(
                          widget.conversation.documentReferenceId, _displayMessageLimit),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        return !snapshot.hasData
                            ? CircularProgressIndicator()
                            : buildConversationListView(snapshot);
                      },
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(25),
                            right: Radius.circular(25),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                child: Icon(
                                  Icons.tag_faces,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                focusNode: _focusNode,
                                controller: _editingController,
                                decoration: InputDecoration(
                                  hintText: "Type a message",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            InkWell(
                              child: Icon(
                                Icons.attach_file,
                                color: Colors.grey,
                              ),
                              onTap: () async => await model.uploadMedia(
                                  ImageSource.gallery, widget.userId, widget.conversation.documentReferenceId, widget.conversation.peerUserId),

                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey,
                                ),
                                onTap: () async => await model.uploadMedia(
                                    ImageSource.camera,  widget.userId, widget.conversation.documentReferenceId, widget.conversation.peerUserId),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          print("tek basim");
                          await model.add({
                            'senderId': widget.userId,
                            'message': _editingController.text,
                            'timeStamp': FieldValue.serverTimestamp(),
                            'media': '',
                            'receiveId': widget.conversation.peerUserId
                          }, widget.conversation.documentReferenceId, widget.conversation.peerUserId);

                          _scrollController.animateTo(
                            _scrollController.position.minScrollExtent,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeIn,
                          );
                          _editingController.text = '';
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
  } // build widget
}
