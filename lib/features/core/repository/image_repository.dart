import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadImage(XFile image) async {
    await storage.ref('posts_images/${image.name}').putFile(File(image.path));
  }

  Future<String> getDownloadURL(String imageName) async {
    String downloadURL =
        await storage.ref('posts_images/${imageName}').getDownloadURL();
    return downloadURL;
  }
}
