import 'package:emart_app/consts/firebaseconst.dart';

class Firestoreservices {
// get user data 


  static getUser(uid){
    return firestore.collection(usercollection).where('id', isEqualTo: uid).snapshots();
  }


   static getproduct(category){
    return firestore.collection(productcollection).where('p_category', isEqualTo: category).snapshots();
  }
  

  // get cart 

  
   static getcart(uid){
    return firestore.collection(cartcollection).where('added_by', isEqualTo: uid).snapshots();
  }

  // delete cart 

  static deletedocument(docId){
    return firestore.collection(cartcollection).doc(docId).delete();
  }

  // get all charts messages
  static getchatsmessage(docId){
    return firestore.collection(chatscollection).doc(docId).collection(messagecollection).orderBy('created_on', descending: false).snapshots();
  }
    
// get all orders

   static getallorders(){
    return firestore.collection(ordercollection).where('order_by',isEqualTo: currentUser!.uid).snapshots();
  }
// get all wishlist
     static getwishlist(){
    return firestore.collection(productcollection).where('p_wishlist',arrayContains:  currentUser!.uid).snapshots();
  }
// get all messages 
    static getallmessage(){
    return firestore.collection(chatscollection).where('fromId',isEqualTo:  currentUser!.uid).snapshots();
  }

// // profile screen 
// static getCounts() async {
// var res =  await Future.wait([
// firestore.collection(cartcollection).where('added_by', isEqualTo: currentUser!.uid).get().then((value){
//          return value.docs.length;
// }) ,
// firestore.collection(productcollection).where('p_wishlist',arrayContains:  currentUser!.uid).get().then((value){
//          return value.docs.length;
// }),
// firestore.collection(ordercollection).where('order_by', isEqualTo:   currentUser!.uid).get().then((value){
//          return value.docs.length;
// })

// ]);
// return res;
// }

 static allproduct(){
    return firestore.collection(productcollection).snapshots();
  }
static searchproduct(title){
    return firestore.collection(productcollection).get();
  }

static Future<void> sendSupportMessage(Map<String, dynamic> data) {
  return firestore.collection('support_messages').add(data);
}

}