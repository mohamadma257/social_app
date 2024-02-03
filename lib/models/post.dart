import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String uid;
  String displayName;
  String username;
  String profilePic;
  String description;
  String postId;
  String postImage;
  DateTime date;
  dynamic like;

  PostModel({
    required this.uid,
    required this.date,
    required this.displayName,
    required this.username,
    required this.description,
    required this.profilePic,
    required this.like,
    required this.postId,
    required this.postImage,
  });

  factory PostModel.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return PostModel(
      uid: snapshot["uid"],
      date: snapshot["date"],
      displayName: snapshot["displayName"],
      username: snapshot["username"],
      description: snapshot["description"],
      profilePic: snapshot["profilePic"],
      like: snapshot["like"],
      postId: snapshot["postId"],
      postImage: snapshot["postImage"],
    );
  }
  Map<String, dynamic> toJson() => {
        "uid": uid,
        "description": description,
        "displayName": displayName,
        "username": username,
        "profilePic": profilePic,
        "date": date,
        "like": like,
        "postId": postId,
        "postImage": postImage,
      };
}
