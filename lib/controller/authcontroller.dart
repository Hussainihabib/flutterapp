import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';



class Authcontroller extends GetxController {
  var isloading = false.obs;

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordsController = TextEditingController();
  var rePasswordsController = TextEditingController();

var showResetButton = false.obs;


  // 🔒 Validation methods
  String? validateName(String value) {
    if (value.isEmpty) {
      return 'Name is required';
    } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
      return 'Only alphabets allowed';
    }
    return null;
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateRePassword(String value) {
    if (value.isEmpty) {
      return 'Please re-enter password';
    } else if (value != passwordsController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // 🔑 Login method
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordsController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.message ?? e.toString());
    }
    return userCredential;
  }

  // 📝 Signup method
  Future<UserCredential?> signupMethod({context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordsController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.message ?? e.toString());
    }
    return userCredential;
  }

  // 📦 Storing user data in Firestore
  storeUserData() async {
    DocumentReference store = firestore.collection(usercollection).doc(currentUser!.uid);
    await store.set({
      'name': nameController.text.trim(),
      'email': emailController.text.trim(),
      'password': passwordsController.text.trim(),
      'imageUrl': '',
      'id': currentUser!.uid,
      'cart_count': "00",
      'wishlist_count': "00",
      'order_count': "00",
    });
  }

  // 🚪 Sign out
  signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  // 📧 🔑 Forget password - send reset email
  Future<void> sendPasswordResetEmail({required String email, required BuildContext context}) async {
  try {
    await auth.sendPasswordResetEmail(email: email.trim());
    VxToast.show(context, msg: 'Reset link sent to your email');

    // 5 second delay
    Future.delayed(const Duration(seconds: 5), () {
      showResetButton.value = true;
    });
  } on FirebaseAuthException catch (e) {
    VxToast.show(context, msg: e.message ?? e.toString());
  }
}


  // ✏️ Reset password if user is logged in
  Future<void> resetPasswordWhileLoggedIn({required String newPassword, required BuildContext context}) async {
    try {
      await auth.currentUser?.updatePassword(newPassword);
      VxToast.show(context, msg: 'Password updated successfully');
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.message ?? e.toString());
    }
  }
}


// class Authcontroller extends GetxController {
//   var isloading = false.obs;

//   // Text controllers
//   var nameController = TextEditingController();
//   var emailController = TextEditingController();
//   var passwordsController = TextEditingController();
//   var rePasswordsController = TextEditingController();

//   // 🔒 Validation methods
//   String? validateName(String value) {
//     if (value.isEmpty) {
//       return 'Name is required';
//     } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
//       return 'Only alphabets allowed';
//     }
//     return null;
//   }

//   String? validateEmail(String value) {
//     if (value.isEmpty) {
//       return 'Email is required';
//     } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//       return 'Enter a valid email';
//     }
//     return null;
//   }

//   String? validatePassword(String value) {
//     if (value.isEmpty) {
//       return 'Password is required';
//     } else if (value.length < 6) {
//       return 'Password must be at least 6 characters';
//     }
//     return null;
//   }

//   String? validateRePassword(String value) {
//     if (value.isEmpty) {
//       return 'Please re-enter password';
//     } else if (value != passwordsController.text) {
//       return 'Passwords do not match';
//     }
//     return null;
//   }

//   // 🔑 Login method
//   Future<UserCredential?> loginMethod({context}) async {
//     UserCredential? userCredential;

//     try {
//       userCredential = await auth.signInWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: passwordsController.text.trim(),
//       );
//     } on FirebaseAuthException catch (e) {
//       VxToast.show(context, msg: e.toString());
//     }
//     return userCredential;
//   }

//   // 📝 Signup method
//   Future<UserCredential?> signupMethod({context}) async {
//     UserCredential? userCredential;

//     try {
//       userCredential = await auth.createUserWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: passwordsController.text.trim(),
//       );
//     } on FirebaseAuthException catch (e) {
//       VxToast.show(context, msg: e.toString());
//     }
//     return userCredential;
//   }

//   // 📦 Store user data in Firestore
//   Future<void> storeUserData() async {
//     DocumentReference store = firestore.collection(usercollection).doc(currentUser!.uid);
//     await store.set({
//       'name': nameController.text.trim(),
//       'email': emailController.text.trim(),
//       'password': passwordsController.text.trim(),
//       'imageUrl': '',
//       'id': currentUser!.uid,
//       'cart_count': "00",
//       'wishlist_count': "00",
//       'order_count': "00",
//     });
//   }

//   // 🚪 Sign out method
//   Future<void> signoutMethod(context) async {
//     try {
//       await auth.signOut();
//     } catch (e) {
//       VxToast.show(context, msg: e.toString());
//     }
//   }
// }







// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:emart_app/consts/consts.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:get/get_rx/get_rx.dart';
// // import 'package:get/get_state_manager/get_state_manager.dart';

// // class Authcontroller extends GetxController {
// // var isloading = false.obs;

// // // text controller 

// // var emailController= TextEditingController();
// // var passwordscontroller= TextEditingController();





// // //  login method 

// // Future<UserCredential?> loginMethod({context})async{
// //   UserCredential? userCredential;


// //   try {
       
// //        userCredential = await auth.signInWithEmailAndPassword(email: emailController.text, password: passwordscontroller.text);
// //   } on FirebaseAuthException catch (e) {
// //     VxToast.show(context, msg: e.toString());
// //   }
// //   return userCredential ;
// // }


// // //  signup method 

// // Future<UserCredential?> signupMethod({email, password,context})async{
// //   UserCredential? userCredential;


// //   try {
// //     userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
// //   } on FirebaseAuthException catch (e) {
// //     VxToast.show(context, msg: e.toString());
// //   }
// //   return userCredential ;
// // }

// // // storing data method

// // storeUserData({name,email,password})async{
// //   DocumentReference store = firestore.collection(usercollection).doc(currentUser!.uid);
// //   store.set({
// //    'name': name,
// //    'email': email,
// //    'password': password,
// //    'imageUrl': '',
// //    'id': currentUser!.uid,
// //    'cart_count': "00",
// //    'wishlist_count': "00",
// //    'order_count': "00",

// //   });
// // }

// // // signout method 
// // signoutMethod(context)async{
// //   try {
// //     await auth.signOut();
// //   } catch (e) {
// //     VxToast.show(context, msg: e.toString());
    
// //   }
// // }

// // }