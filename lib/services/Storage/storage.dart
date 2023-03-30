import 'dart:io';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
class ImageStorage{
    final firebase_storage.FirebaseStorage storage=firebase_storage.FirebaseStorage.instance;
    Future<void> uploadImage(String user_id,String filePath)async{
        final File img=File(filePath);
        try{
          await storage.ref('personal_images/$user_id').putFile(img );

        } on firebase_core.FirebaseException catch(e){
          print(e.toString());
        }

    }
    Future<String> getdownloadurl(String user_id)async
    {
      String url=await storage.ref('personal_images/$user_id').getDownloadURL();
      return url.toString();
    }

}