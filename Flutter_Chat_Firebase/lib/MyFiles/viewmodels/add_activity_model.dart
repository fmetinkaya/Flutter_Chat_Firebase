import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterdenemechat/MyFiles/core/locator.dart';
import 'package:flutterdenemechat/MyFiles/core/services/db_service.dart';
import 'package:location/location.dart';

import 'base_model.dart';

class AddActivityModel extends BaseModel {

  Future<DocumentSnapshot> getUserProfile(String userId) {
    return getIt<DbService>()
        .firestore
        .collection('profile')
        .doc(userId).get();
  }

String _userId;

  String get userId => _userId;

  set userId(String userId) {
    _userId = userId;
  }
String _score;

  String get score => _score;

  set score(String score) {
    _score = score;
  }
String _mainImage = "https://placekitten.com/200/200";

  String get mainImage => _mainImage;

  set mainImage(String mainImage) {
    _mainImage = mainImage;
    notifyListeners();
  }
String _activityName;

  String get activityName => _activityName;

  set activityName(String activityName) {
    _activityName = activityName;
    notifyListeners();
  }
String _explanation;

  String get explanation => _explanation;

  set explanation(String explanation) {
    _explanation = explanation;
    notifyListeners();
  }
Map<String, String> _tags;

  Map<String, String> get tags => _tags;

  set tags(Map<String, String> tags) {
    _tags = tags;
    notifyListeners();
  }
LocationData _location;

  LocationData get location => _location;

  set location(LocationData location) {
    _location = location;
    notifyListeners();
  }
Map<String, String> _images;

  Map<String, String> get images => _images;

  set images(Map<String, String> images) {
    _images = images;
    notifyListeners();
  }
String _price;

  String get price => _price;

  set price(String price) {
    _price = price;
    notifyListeners();
  }
Timestamp _startTime;

  Timestamp get startTime => _startTime;

  set startTime(Timestamp startTime) {
    _startTime = startTime;
    notifyListeners();
  }
Timestamp _endTime;

  Timestamp get endTime => _endTime;

  set endTime(Timestamp endTime) {
    _endTime = endTime;
    notifyListeners();
  }


//getIt<LocationService>


}