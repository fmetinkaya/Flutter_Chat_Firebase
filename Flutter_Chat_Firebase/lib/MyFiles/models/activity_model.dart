

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';

class ActivityModel {
  String documentReferenceId;
  String userId;
  String score;
  String mainImage;
  String activityName;
  String explanation;
  Map<String, String> tags;
  Location location;
  Map<String, String> images;
  String price;
  Timestamp startTime;
  Timestamp endTime;


  ActivityModel({this.documentReferenceId, this.userId, this.score, this.mainImage, this.activityName, this.explanation, this.tags, this.location, this.images, this.price, this.startTime, this.endTime,});
}