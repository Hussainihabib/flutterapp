import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:emart_app/models/categorymodel.dart';

class ProductController extends GetxController {
  var quantity = 1.obs;
  var colorindex = 0.obs;
  var totalprice = 0.obs;
  var isfav = false.obs;
  var subcat = [];

  // Load subcategories
  getsubcategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/categorymodel.json");
    var decoded = categorymodelFromJson(data);
    var s = decoded.categories.where((e) => e.name == title).toList();
    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  changecolorindex(index) {
    colorindex.value = index;
  }

  increasequantity(int totalquantity) {
    if (quantity.value < totalquantity) {
      quantity.value++;
    } else {
      VxToast.show(Get.context!, msg: "Maximum stock limit reached");
    }
    calctotalprice(totalprice.value ~/ (quantity.value == 0 ? 1 : quantity.value));
  }

  decreasequantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
    calctotalprice(totalprice.value ~/ (quantity.value == 0 ? 1 : quantity.value));
  }

  calctotalprice(int price) {
    totalprice.value = price * quantity.value;
  }

  addToCart({
    required String title,
    required String img,
    required String sellername,
    required color,
    required int qty,
    required int tprice,
    required context,
    required String vendorID,
    required String productId,
    required int availableStock,
  }) async {
    try {
      if (qty > availableStock) {
        VxToast.show(context, msg: "Not enough stock available");
        return;
      }

      var existing = await firestore
          .collection(cartcollection)
          .where('added_by', isEqualTo: currentUser!.uid)
          .where('title', isEqualTo: title)
          .where('color', isEqualTo: color)
          .limit(1)
          .get();

      if (existing.docs.isNotEmpty) {
        var docId = existing.docs.first.id;
        var prevQty = existing.docs.first['qty'];
        var prevTprice = existing.docs.first['tprice'];

        int newQty = prevQty + qty;
        if (newQty > availableStock) {
          VxToast.show(context, msg: "Stock limit reached");
          return;
        }

        await firestore.collection(cartcollection).doc(docId).update({
          'qty': newQty,
          'tprice': prevTprice + tprice,
        });
        VxToast.show(context, msg: "Item quantity updated in cart");
      } else {
        await firestore.collection(cartcollection).doc().set({
          'title': title,
          'img': img,
          'sellername': sellername,
          'color': color,
          'qty': qty,
          'vendor_id': vendorID,
          'tprice': tprice,
          'added_by': currentUser!.uid,
          'product_id': productId,
        });
        VxToast.show(context, msg: "Added to cart");
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  resetvalues() {
    totalprice.value = 0;
    quantity.value = 1;
    colorindex.value = 0;
  }

  addtowishlist(docId, context) async {
    await firestore.collection(productcollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isfav(true);
    VxToast.show(context, msg: "Added to Wishlist");
  }

  removefromwishlist(docId, context) async {
    await firestore.collection(productcollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isfav(false);
    VxToast.show(context, msg: "Removed from Wishlist");
  }

  checkiffav(data) async {
    if (data['p_wishlist'].contains(currentUser!.uid)) {
      isfav(true);
    } else {
      isfav(false);
    }
  }
}




// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:emart_app/consts/consts.dart';
// import 'package:emart_app/models/categorymodel.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';

// class ProductController extends GetxController{
//   var quantity = 0.obs;
//   var colorindex = 0.obs;
//   var totalprice = 0.obs;


// var subcat = [];
//  var isfav = false.obs; 

//   SetOptions? get setop => null;

//   getsubcategories(title) async{
//     subcat.clear();
//     var data = await rootBundle.loadString("lib/services/categorymodel.json");
//     var decoded = categorymodelFromJson(data);
//     var s = decoded.categories.where((element) => element.name == title).toList();
//     for (var e in s[0].subcategory) {
//       subcat.add(e); 
//     }


// }
// // color index 

// changecolorindex(index){
//   colorindex = index;
// }

// // quantity increase & decrease 

// increasequantity(totalquantity){
//   if (quantity.value < totalquantity) {
//   quantity.value++;
    
//   }
// }

// decreasequantity(){
//   if (quantity.value >0) {
//   quantity.value--;
    
//   }
// }

// // for total price 

// calctotalprice(price){
//   totalprice.value = price * quantity.value;
// }


// addToCart({title, img, sellername, color, qty, tprice, context,vendorID}) async{

// await firestore.collection (cartcollection).doc().set({

// 'title':

// title,

// 'img': img,

// 'sellername': sellername,

// 'color': color,

// 'qty': qty,

// 'vendor_id': vendorID,

// 'tprice': tprice,

// 'added_by': currentUser!.uid

// }).catchError((error) {

// VxToast.show(context, msg: error.toString());

// });}


// resetvalues(){
//   totalprice.value = 0;
//   quantity.value = 0;
//   colorindex.value = 0;

// }

// addtowishlist(docId , context) async {
//    await firestore.collection(productcollection).doc(docId).set({

//     'p_wishlist' : FieldValue.arrayUnion([currentUser!.uid])
//    } , SetOptions(merge: true));
//    isfav(true);
// VxToast.show(context, msg: "Add To Wishlist");

// }

// removefromwishlist(docId , context) async {
//    await firestore.collection(productcollection).doc(docId).set({

//     'p_wishlist' : FieldValue.arrayRemove([currentUser!.uid])
//    } , SetOptions(merge: true));
//   isfav(false);

// VxToast.show(context, msg: "Remove From wishlist");
// }

// checkiffav(data) async{
//  if (data['p_wishlist'].contains(currentUser!.uid)) {
//    isfav(true);
//  }else{
//   isfav(false);
//  }
// }


// }