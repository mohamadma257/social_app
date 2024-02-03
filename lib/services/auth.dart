import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media/models/user.dart';

class AuthMethods {
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection("users");

  getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot documentSnapshot = await users.doc(currentUser.uid).get();
    return UserModel.fromSnap(documentSnapshot);
  }

  signUp({
    required String email,
    required String password,
    required String username,
    required String display,
  }) async {
    String res = "Some Error";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          display.isNotEmpty) {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);
        UserModel userModel = UserModel(
          uid: userCredential.user!.uid,
          email: email,
          displayName: display,
          username: username,
          bio: "",
          profilePic: "",
          followers: [],
          following: [],
        );
        users.doc(userCredential.user!.uid).set(userModel.toJson());
        res = "success";
      } else {
        res = "Enter all fields";
      }
    } on Exception catch (e) {
      return e.toString();
    }
    return res;
  }

  signIn({
    required String email,
    required String password,
  }) async {
    String res = "Some Error";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Enter all fields";
      }
    } on Exception catch (e) {
      print(e);
    }
    return res;
  }
}
