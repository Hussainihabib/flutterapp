import 'dart:typed_data';
import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profilecontroller extends GetxController {
  var profileImgBytes = Rx<Uint8List?>(null);
  var nameController = TextEditingController();
  var passController = TextEditingController();
  var isUploading = false.obs;
  var profileImageLink = ''.obs;

  final supabase = Supabase.instance.client;

  // Future<void> pickAndUploadImage(String userId) async {
  //   try {
  //     final picked = await ImagePicker().pickImage(
  //       source: ImageSource.gallery,
  //       imageQuality: 70,
  //     );
  //     if (picked == null) return;

  //     final bytes = await picked.readAsBytes();
  //     profileImgBytes.value = bytes;

  //     isUploading.value = true;

  //     final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';

  //     // Upload to Supabase storage
  //     final storageResponse = await supabase.storage
  //         .from('profile-images')
  //         .uploadBinary(
  //           fileName,
  //           bytes,
  //           fileOptions: const FileOptions(upsert: true),
  //         );

  //     // Get public URL
  //     final publicUrl = supabase.storage.from('profile-images').getPublicUrl(fileName);
  //     profileImageLink.value = publicUrl;

  //     // Save public URL to Firestore
  //     await FirebaseFirestore.instance.collection('users').doc(userId).update({
  //       'imageUrl': publicUrl,
  //     });

  //     Get.snackbar("Success", "Image uploaded and saved to Firestore");
  //   } catch (e) {
  //     Get.snackbar("Error", e.toString());
  //   } finally {
  //     isUploading.value = false;
  //   }
  // }
  Future<void> pickAndUploadImage(String userId) async {
  try {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    if (picked == null) return;

    final bytes = await picked.readAsBytes();
    profileImgBytes.value = bytes;
    isUploading.value = true;

    final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';

    // Upload to Supabase
    await supabase.storage
        .from('profile-images')
        .uploadBinary(fileName, bytes, fileOptions: const FileOptions(upsert: true));

    // Get public URL
    final publicUrl = supabase.storage.from('profile-images').getPublicUrl(fileName);
    profileImageLink.value = publicUrl;

    // Save public URL to Firestore
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'imageUrl': publicUrl,
    }, SetOptions(merge: true));

    Get.snackbar("Success", "Image uploaded & URL saved");
  } catch (e) {
    Get.snackbar("Error", e.toString());
  } finally {
    isUploading.value = false;
  }
}


  Future<void> updateProfile(String userId) async {
    try {
      final store = FirebaseFirestore.instance.collection('users').doc(userId);
      await store.set({
        'name': nameController.text,
        'password': passController.text,
        'imageUrl': profileImageLink.value,
      }, SetOptions(merge: true));

      Get.snackbar("Success", "Profile updated");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
 Future<void> saveProfile(String userId) async {
  try {
    isUploading.value = true;

    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'name': nameController.text.trim(),
      'password': passController.text.trim(),
      'imageUrl': profileImageLink.value, // keep the Supabase public URL here
    }, SetOptions(merge: true));

    Get.snackbar("Success", "Profile updated");
  } catch (e) {
    Get.snackbar("Error", e.toString());
  } finally {
    isUploading.value = false;
  }
}

void initProfileData(Map data) {
  nameController.text = data['name'] ?? '';
  passController.text = data['password'] ?? '';
  profileImageLink.value = data['imageUrl'] ?? '';
}

}




// import 'dart:io';
// import 'dart:typed_data';
// import 'package:emart_app/consts/consts.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:path/path.dart';

// class Profilecontroller extends GetxController {
//   var profileImgBytes = Rx<Uint8List?>(null);
//   var nameController = TextEditingController();
//   var passController = TextEditingController();
//   var isUploading = false.obs;
//   var profileimagelink = '';

//   final supabase = Supabase.instance.client;

//   Future<void> pickAndUploadImage(String userId) async {
//     try {
//       final picked = await ImagePicker().pickImage(
//         source: ImageSource.gallery,
//         imageQuality: 70,
//       );

//       if (picked == null) return;

//       final bytes = await picked.readAsBytes();
//       profileImgBytes.value = bytes;

//       isUploading.value = true;

//       // Upload to Supabase
//       final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
//       await supabase.storage.from('profile-images').uploadBinary(
//         fileName,
//         bytes,
//         fileOptions: const FileOptions(
//           upsert: true,
//         ),
//       );

//       final publicUrl =
//           supabase.storage.from('profile-images').getPublicUrl(fileName);

//       // Save to Firestore
//       await FirebaseFirestore.instance.collection('users').doc(userId).update({
//         'imageUrl': publicUrl,
//       });

//       Get.snackbar("Success", "Image uploaded and saved to Firestore");
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//     } finally {
//       isUploading.value = false;
//     }


//   }

//   uploadProfileImage() async {
// var filename = basename(profileImgBytes.value);
// var destination  = 'images/${currentUser!.uid}/$filename';
// Reference ref = FirebaseStorage.instance.ref().child(destination);
// await ref.putFile(File(profileImgBytes.value));
// profileimagelink =destination await ref.getDownloadURL();
// }
// updateProfile() async (
// var store firestore.collection (usersCollection).doc (currentUser.uid); ollection).doc(currentUserl.ui
// store.set(), SetOptions (merge: true));
// }


  
// }
