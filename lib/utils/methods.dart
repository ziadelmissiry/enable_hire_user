import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UtilityMethods{
  Future<String> uploadLogoAndGetUrl(dynamic image) async {
    try {
      if (image != null) {
        final firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance.ref(
            'logos/${DateTime.now().millisecondsSinceEpoch}.jpg');

        Uint8List imageData;
        if (image is File) {
          final List<int> bytes = await image.readAsBytes();
          imageData = Uint8List.fromList(bytes);
        } else if (image is PlatformFile) {
          imageData = Uint8List.fromList(image.bytes!);
        } else {
          throw Exception('Unsupported image type');
        }

        final firebase_storage.TaskSnapshot snapshot = await storageRef.putData(imageData);
        final String logoUrl = await snapshot.ref.getDownloadURL();

        return logoUrl;
      }
    } catch (e) {
      print("Error uploading logo: $e");
    }
    return "";
  }


}