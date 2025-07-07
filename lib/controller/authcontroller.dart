import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Authcontroller extends GetxController {
var isloading = false.obs;

// text controller 

var emailController= TextEditingController();
var passwordscontroller= TextEditingController();





//  login method 

Future<UserCredential?> loginMethod({context})async{
  UserCredential? userCredential;


  try {
       
       userCredential = await auth.signInWithEmailAndPassword(email: emailController.text, password: passwordscontroller.text);
  } on FirebaseAuthException catch (e) {
    VxToast.show(context, msg: e.toString());
  }
  return userCredential ;
}


//  signup method 

Future<UserCredential?> signupMethod({email, password,context})async{
  UserCredential? userCredential;


  try {
    userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    VxToast.show(context, msg: e.toString());
  }
  return userCredential ;
}

// storing data method

storeUserData({name,email,password})async{
  DocumentReference store = firestore.collection(usercollection).doc(currentUser!.uid);
  store.set({
   'name': name,
   'email': email,
   'password': password,
   'imageUrl': '',
   'id': currentUser!.uid,
   'cart_count': "00",
   'wishlist_count': "00",
   'order_count': "00",

  });
}

// signout method 
signoutMethod(context)async{
  try {
    await auth.signOut();
  } catch (e) {
    VxToast.show(context, msg: e.toString());
    
  }
}

}