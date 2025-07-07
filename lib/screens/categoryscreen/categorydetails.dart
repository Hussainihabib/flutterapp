import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/controller/productcontroller.dart';
import 'package:emart_app/screens/categoryscreen/item_detail.dart';
import 'package:emart_app/services/firestoreservices.dart';
import 'package:emart_app/widget/bgwidget.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';




class Categorydetails extends StatelessWidget {
 final String? title;
  const Categorydetails  ({Key? key,required this.title}) :super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProductController());


    return bgwidget(
      child: Scaffold(
        appBar: AppBar(
          title: title!.text.fontFamily(bold).white.make(),
        ),
      body: StreamBuilder(
          stream: Firestoreservices.getproduct(title),
         builder: (BuildContext context, AsyncSnapshot <QuerySnapshot> snapshot){

           if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(bluecolor),
                ),
              );
              
            }else if(snapshot.data!.docs.isEmpty){
              return Center(
                child: "No Product Found".text.color(darkFontGrey).make(),
              );

            }else{
              var data = snapshot.data!.docs;

              return   Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
               
                children: List.generate(  controller.subcat.length,
                (index) => "${controller.subcat[index]}"
                .text
                .color(darkFontGrey)
                .fontFamily(semibold)
                .makeCentered()
                .box.white.rounded
                .size(120, 60)
                .margin(const EdgeInsets.symmetric(horizontal: 4))
                .make()),
                        ),
            ),

          20.heightBox,
            // item container

            Expanded(
              child:  GridView.builder(
                shrinkWrap: true,
                itemCount: data.length,
              physics: const BouncingScrollPhysics(),
              
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 300), 
                itemBuilder: (context,index){
          return Column(
                           
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [

           Image.network(data[index]['p_img'][0],height: 200,width: 150,fit: BoxFit.cover,),
                10.heightBox,
               "${data[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                10.heightBox,
                 "${data[index]['p_price']}".numCurrency.text.fontFamily(bold).color(bluecolor).size(16).make(),
         

         
        ],
      ).box.white.roundedSM.margin(const EdgeInsets.symmetric(horizontal: 4)).outerShadowSm.padding(const EdgeInsets.all(10)).make().onTap((){
        Get.to(()=> ItemDetail(title: "${data[index]['p_name']}", data: data[index],));
      } );
 
                } 
              ),
            ),
          ],
        ),
      ) ;
 
            }

         }


         ), 
      
      
      
      
     

      )
    );
    
   
  }
}