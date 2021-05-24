import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutterdenemechat/MyFiles/core/locator.dart';
import 'package:flutterdenemechat/MyFiles/core/services/auth_service.dart';
import 'package:flutterdenemechat/MyFiles/viewmodels/add_activity_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class AddActivityPage extends StatefulWidget {
  const AddActivityPage({Key key}) : super(key: key);

  @override
  _AddActivityPageState createState() => _AddActivityPageState();
}

class _AddActivityPageState extends State<AddActivityPage> {
  AddActivityModel addActivityModel = getIt<AddActivityModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildScaffold(context);
  }

  Widget buildScaffold(BuildContext context) {
    CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
          future: addActivityModel
              .getUserProfile(getIt<AuthService>().currentUser.uid),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData == null) {
              return Text('data boş');
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading...');
            }
            return SafeArea(
              child: Container(
                color: Colors.black12,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 180,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: double.infinity,
                              child: Card(
                                margin: EdgeInsets.all(4),
                                child: Image(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Card(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Selda Bağcan",
                                      textScaleFactor: 1.5,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Divider(
                                      thickness: 1,
                                      indent: 5,
                                      endIndent: 5,
                                    ),
                                    Badge(
                                      badgeContent: Text(
                                        '!',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      child: Text(
                                        "Konum",
                                        textScaleFactor: 1.2,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                      indent: 5,
                                      endIndent: 5,
                                    ),
                                    Badge(
                                      badgeContent: Text(
                                        '!',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      child: Text(
                                        "Yayın Süresi",
                                        textScaleFactor: 1.2,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                      indent: 5,
                                      endIndent: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Badge(
                                          position: BadgePosition.topEnd(end:-5),
                                          badgeContent: Text(
                                            '!',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          child: Icon(
                                            Icons.add_circle_outline,
                                            size: 40,
                                          ),
                                        )
                                      ],
                                    ),
                                  ]),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 150,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        margin: EdgeInsets.all(10),
                        child: Column(children: [

                          Badge(
                            badgeContent: Text(
                              '!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            child: Text(
                              "Başlık",
                              textScaleFactor: 1.5,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            indent: 50,
                            endIndent: 50,
                          ),
                          Badge(
                            badgeContent: Text(
                              '!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            child: Text(
                              "Açıklamayı Buraya Girin",
                              textScaleFactor: 1,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ]),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        margin: EdgeInsets.only(left: 8, right: 8),
                        child: DefaultTabController(
                          length: 4,
                          child: SizedBox(
                            child: Column(
                              children: <Widget>[
                                TabBar(
                                  tabs: <Widget>[
                                    Badge(
                                      position: BadgePosition.topEnd(top: -5),
                                      badgeContent: Text(
                                        '!',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      child: Badge(
                                        position: BadgePosition.topEnd(top: -5),
                                        badgeContent: Text(
                                          '!',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        child: Tab(
                                          icon: Icon(Icons.image,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    Badge(
                                      position: BadgePosition.topEnd(top: -5),
                                      badgeContent: Text(
                                        '!',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      child: Tab(
                                        icon: Icon(Icons.comment,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Badge(
                                      position: BadgePosition.topEnd(top: -5),
                                      badgeContent: Text(
                                        '!',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      child: Tab(
                                        icon: Icon(Icons.location_on,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Badge(
                                      position: BadgePosition.topEnd(top: -5),
                                      badgeContent: Text(
                                        '!',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      child: Tab(
                                        icon: Icon(Icons.attach_money,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: TabBarView(
                                    children: <Widget>[
                                      Container(
                                      ),
                                      Container(
                                      ),
                                      Container(
                                        child: GoogleMap(
                                          //liteModeEnabled: true,
                                          mapType: MapType.normal,
                                          initialCameraPosition: _kGooglePlex,
                                          zoomControlsEnabled: false,
                                          myLocationEnabled: true,

                                          onMapCreated: (GoogleMapController
                                              controller) {},
                                        ),
                                      ),
                                      Container(
                                        child: Container(
                                          width: double.infinity,
                                          child: Card(
                                            child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("Hesabı Kim Öder", textScaleFactor: 1.7),
                                                Text("Üst Limit Ne Kadar", textScaleFactor: 1.3),
                                                Divider(
                                                  thickness: 3,
                                                  indent: 30,
                                                  endIndent: 30,
                                                ),
                                                Text("Yol Ücretini Kim Öder", textScaleFactor: 1.7),
                                                Text("Ne Kadar", textScaleFactor: 1.3),
                                              ],
                                            ),
                                          ),
                                        )
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
         await showInformationDialog(context);
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.green,
      ),
    );
  }

  showInformationDialog(BuildContext context) async {
    bool firstDialogBusy =false;
    String searchWord = "";
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: firstDialogBusy ? LinearProgressIndicator():
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.black38.withAlpha(10),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search Flutter Topic",
                              hintStyle: TextStyle(
                                color: Colors.black.withAlpha(120),
                              ),
                              border: InputBorder.none,
                            ),
                            onChanged: (String keyword) {
                              searchWord=keyword;
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () async{
                            setState(() {
                              firstDialogBusy=true;
                            });
                          },
                          child: Icon(
                            Icons.search,
                            color: Colors.black.withAlpha(120),
                          ),
                        )
                      ],
                    ),
                  ),

                ],
              ),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  textColor: Theme.of(context).primaryColor,
                  child: const Text('Close'),
                ),
              ],
            );
          });
        });
  }

}
