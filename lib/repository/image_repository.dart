import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_review_app/databases/storage_firebase.dart';
import 'package:flutter_review_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class ImageRepository extends ChangeNotifier {
  late FirebaseStorage storage;
  late AuthService auth;
  String imageURL = 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';

  ImageRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startStorage();
  }

  _startStorage() {
    storage = StorageFibase.get();
  }

  Future<String> upload(String path) async {
    File file = File(path);
    try {
      String ref = 'images/img-${DateTime.now().toString()}.jpeg';
      final storageRef = FirebaseStorage.instance.ref();
      await storageRef.child(ref).putFile(
        file,
        SettableMetadata(
          cacheControl: "public, max-age=300",
          contentType: "image/jpeg",
          customMetadata: {
            "user": "123",
          },
        ),
      );

      imageURL = await storageRef.child(ref).getDownloadURL();
      notifyListeners();
      return imageURL;

    } on FirebaseException catch (e) {
      throw Exception('Erro no upload: ${e.code}');
    }
  }
}