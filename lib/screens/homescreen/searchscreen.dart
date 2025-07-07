import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/screens/categoryscreen/item_detail.dart';
import 'package:emart_app/services/firestoreservices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/styles.dart';

class Searchscreen extends StatelessWidget {
  final String? title;
  const Searchscreen({super.key ,this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).make()
      ),
      body: FutureBuilder(future: Firestoreservices.searchproduct(title), 
      builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot){
        if (!snapshot.hasData) {
          return const Center(
             child:CircularProgressIndicator(
                   valueColor: AlwaysStoppedAnimation(bluecolor),
                         ), 
          );
        }else if(snapshot.data!.docs.isEmpty){
          return "No Product Find".text.make();

        }else{
          var data = snapshot.data!.docs;
          var filtered = data.where((element) => element['p_name'].toString().toLowerCase().contains(title!.toLowerCase())).toList();
          print(data[0]['p_name']);
          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView(
               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 300),
              children: filtered.mapIndexed((currentValue , index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Image.network(filtered[index]['p_img'][0]
                ,height: 170,width: 150,fit: BoxFit.cover,),
                10.heightBox,
                "${filtered[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                10.heightBox,
                 "${filtered[index]['p_price']}".numCurrency.text.fontFamily(bold).color(bluecolor).size(16).make(),
              
              
                  ],
             
                
              ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).shadowSm.padding(const EdgeInsets.all(16)).rounded.make().onTap(
                (){
                  Get.to(() => ItemDetail(title: "${filtered[index]['p_name']}", data: data[index],));}
              )).toList(),
                   ),
          );
      }}),
    );
  }
}