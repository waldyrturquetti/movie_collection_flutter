import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_review_app/databases/dbfirestore.dart';
import 'package:flutter_review_app/models/user_model.dart';
import 'package:flutter_review_app/services/auth_service.dart';

class UserRepository extends ChangeNotifier {
  late AuthService auth;
  late FirebaseFirestore db;
  UserModel userModel = UserModel.myUser;

  UserRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  Future<UserModel> copyUser(
      {String? imagePath,
      String? name,
      String? phone,
      required String email}) async {
    userModel = userModel.copy(imagePath: imagePath, name: name, phone: phone);
    notifyListeners();
    return userModel;
  }

  saveUserInfo() {
    db.collection('users').doc(auth.user?.uid).set(userModel.toJson());
  }

  Future<UserModel> getUserInfo() async {
    var userByFirestore =
        await db.collection('users').doc(auth.user?.uid).get();
    userModel = UserModel.fromJson(userByFirestore.data());
    userModel = userModel.copy(email: auth.user?.email!);

    notifyListeners();
    return userModel;
  }
}
