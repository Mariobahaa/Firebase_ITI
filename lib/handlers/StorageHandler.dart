import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class StorageHandler {
  Future<String> uploadFile(File file, String id) async {
    try {
      firebase_storage.UploadTask task = firebase_storage
          .FirebaseStorage.instance
          .ref('users/$id.${_getFileExtension(file.path)}')
          .putFile(file);

      task.asStream().listen((event) {}); //

      firebase_storage.TaskSnapshot taskSnapshot = await task;
      String uploadedFileUrl = await taskSnapshot.ref.getDownloadURL();
      print("Downloaded file path: $uploadedFileUrl");
      return uploadedFileUrl;
    } on firebase_core.FirebaseException catch (e) {
      print("Error");
    }
  }

  String _getFileExtension(String filePath) {
    String fileName = filePath.split("/").last;
    String fileExtension = fileName.split(".").last;
    return fileExtension;
  }
}
