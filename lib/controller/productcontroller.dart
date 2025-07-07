import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/models/categorymodel.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{
  var quantity = 0.obs;
  var colorindex = 0.obs;
  var totalprice = 0.obs;


var subcat = [];
 var isfav = false.obs; 

  SetOptions? get setop => null;

  getsubcategories(title) async{
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/categorymodel.json");
    var decoded = categorymodelFromJson(data);
    var s = decoded.categories.where((element) => element.name == title).toList();
    for (var e in s[0].subcategory) {
      subcat.add(e); 
    }


}
// color index 

changecolorindex(index){
  colorindex = index;
}

// quantity increase & decrease 

increasequantity(totalquantity){
  if (quantity.value < totalquantity) {
  quantity.value++;
    
  }
}

decreasequantity(){
  if (quantity.value >0) {
  quantity.value--;
    
  }
}

// for total price 

calctotalprice(price){
  totalprice.value = price * quantity.value;
}


addToCart({title, img, sellername, color, qty, tprice, context,vendorID}) async{

await firestore.collection (cartcollection).doc().set({

'title':

title,

'img': img,

'sellername': sellername,

'color': color,

'qty': qty,

'vendor_id': vendorID,

'tprice': tprice,

'added_by': currentUser!.uid

}).catchError((error) {

VxToast.show(context, msg: error.toString());

});}


resetvalues(){
  totalprice.value = 0;
  quantity.value = 0;
  colorindex.value = 0;

}

addtowishlist(docId , context) async {
   await firestore.collection(productcollection).doc(docId).set({

    'p_wishlist' : FieldValue.arrayUnion([currentUser!.uid])
   } , SetOptions(merge: true));
   isfav(true);
VxToast.show(context, msg: "Add To Wishlist");

}

removefromwishlist(docId , context) async {
   await firestore.collection(productcollection).doc(docId).set({

    'p_wishlist' : FieldValue.arrayRemove([currentUser!.uid])
   } , SetOptions(merge: true));
  isfav(false);

VxToast.show(context, msg: "Remove From wishlist");
}

checkiffav(data) async{
 if (data['p_wishlist'].contains(currentUser!.uid)) {
   isfav(true);
 }else{
  isfav(false);
 }
}


}