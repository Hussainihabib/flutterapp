import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart'; 

import 'package:intl/intl.dart' as intl;

Widget senderbubble(DocumentSnapshot data){
   
   var t = data['created_on'] == null ? DateTime.now():  data['created_on'].toDate();
   var time  = intl.DateFormat("h.mma").format(t);

  return    Directionality(
     textDirection:data['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
          color: data['uid'] == currentUser!.uid ? bluecolor : darkFontGrey,
          borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular (20),
          bottomLeft: Radius.circular (20),
          )), // BorderRadius.only // BoxDecoration
    
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          "${data['msg']}".text.white.size(16).make(),
          10.heightBox,
          time.text.color(whiteColor.withOpacity(0.5)).make()
          ]
          ),),
  ) ;
}