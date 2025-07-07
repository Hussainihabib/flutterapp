import 'package:cloud_firestore/cloud_firestore.dart' show FieldValue;
import 'package:emart_app/controller/homecontroller.dart';
import 'package:get/get.dart';

import '../consts/consts.dart';

class Cartcontroller extends GetxController {
  var totalp = 0.obs;

  // text controller for shipping

var addressController =TextEditingController();
var cityController =TextEditingController();
var stateController =TextEditingController();
var postalcodeController =TextEditingController();
var phoneController =TextEditingController();

var paymentindex = 0.obs;

late dynamic productsnapshot;

var products =[];

var placingorder  =false.obs;

calculate (data) {
  totalp.value = 0;
for (var i=0; i< data.length; i++) {

totalp.value = totalp.value + int.parse(data[i]['tprice'].toString());

}
}

changepaymenindex(index){
  paymentindex.value = index ;
}

placeMyOrder({required orderPaymentMethod,required totalAmount}) async {

placingorder(true);

await getProductDetails();
await firestore.collection(ordercollection).doc().set({
'order code': "233981237",
'order_date': FieldValue.serverTimestamp(),
'order_by': currentUser!.uid,
'order_by_name': Get.find<Homecontroller>().username,
'order_by_email': currentUser!.email,
'order_by_address': addressController.text,
'order_by_state': stateController.text,
'order_by_city': cityController.text,
'order_by_phone': phoneController.text,
'order_by_postalcode': postalcodeController.text,
'shipping method': "Home Delivery",
'payment_method': orderPaymentMethod,
'order_placed': true,
'order_confirmed': false,
'order_delivered': false,
'order_on_delivery': false,
'total_amount': totalAmount,
'orders': FieldValue.arrayUnion (products),
});
placingorder(false);

}



getProductDetails() {
  products.clear();
for (var i = 0; i < productsnapshot.length; i++) {
products.add({
'color': productsnapshot[i]['color'],
'vendor_id': productsnapshot[i]['vendor_id'],
'tprice': productsnapshot[i]['tprice'],
'img' :  productsnapshot[i]['img'],
'qty':   productsnapshot[i]['qty'],
'title': productsnapshot[i]['title']
});
}

}

clearcart(){
  for (var i = 0; i < productsnapshot.length; i++) {
    firestore.collection(cartcollection).doc(productsnapshot[i].id).delete();
  } 
}
}