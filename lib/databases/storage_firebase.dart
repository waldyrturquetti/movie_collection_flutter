
import 'package:firebase_storage/firebase_storage.dart';

class StorageFibase {

  StorageFibase._();
  static final StorageFibase _instance = StorageFibase._();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  static FirebaseStorage get() {
    return StorageFibase._instance._storage;
  }
}