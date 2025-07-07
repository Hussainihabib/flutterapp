import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/cartcontroller.dart';
import 'package:emart_app/screens/cartscreen/shippingscreen.dart';
import 'package:emart_app/services/firestoreservices.dart';
import 'package:emart_app/widget/button.dart';
import 'package:get/get.dart';

class Cartscreen extends StatelessWidget {
  const Cartscreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Cartcontroller());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping cart".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: Firestoreservices.getcart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(bluecolor)),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "Cart is empty add cart".text.color(darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            controller.productsnapshot.value = data; // ✅ update observable list
            controller.calculate(data);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Image.network("${data[index]['img']}", width: 80, fit: BoxFit.fitHeight),
                          title: "${data[index]['title']}  (x${data[index]['qty']})"
                              .text.fontFamily(bold).size(16).make(),
                          subtitle: "${data[index]['tprice']}"
                              .numCurrency.text.fontFamily(bold).color(bluecolor).make(),
                          trailing: const Icon(Icons.delete, color: bluecolor).onTap(() {
                            Firestoreservices.deletedocument(data[index].id);
                          }),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total price".text.fontFamily(semibold).color(darkFontGrey).make(),
                      Obx(() => "${controller.totalp.value}".numCurrency
                          .text.fontFamily(semibold).color(bluecolor).make()),
                    ],
                  )
                      .box
                      .padding(const EdgeInsets.all(12))
                      .color(lightgolden)
                      .width(context.screenWidth - 60)
                      .roundedSM
                      .make(),
                  10.heightBox,
                  Obx(() => controller.isCartEmpty
                      ? const SizedBox()
                      : SizedBox(
                          height: 60,
                          child: ourbutton(
                            color: bluecolor,
                            onpress: () {
                              Get.to(() => const Shippingdetails());
                            },
                            textcolor: whiteColor,
                            title: "Proceed To Shipping",
                          ),
                        )),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}





// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:emart_app/consts/consts.dart';
// import 'package:emart_app/controller/cartcontroller.dart';
// import 'package:emart_app/screens/cartscreen/shippingscreen.dart';
// import 'package:emart_app/services/firestoreservices.dart';
// import 'package:emart_app/widget/button.dart';
// import 'package:get/get.dart';

// class Cartscreen extends StatelessWidget {
//   const Cartscreen({super.key});

//   @override
//   Widget build(BuildContext context) {

//     var controller = Get.put(Cartcontroller());
//         return Scaffold(

//     backgroundColor: whiteColor,
//    bottomNavigationBar: SizedBox(
//   height: 60,
//   child: ourbutton(
//     color: bluecolor,
//     onpress: () {
//       if (controller.productsnapshot == null || controller.productsnapshot.isEmpty) {
//         // Show snackbar if cart is empty
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text("Your cart is empty! Add items before proceeding."),
//             backgroundColor: bluecolor,
//             duration: Duration(seconds: 2),
//           ),
//         );
//       } else {
//         // Proceed to shipping
//         Get.to(() => const Shippingdetails());
//       }
//     },
//     textcolor: whiteColor,
//     title: "Proceed To Shipping",
//   ),
// ),

//     appBar: AppBar(
//     automaticallyImplyLeading: false,
//     title: "Shopping cart".text.color (darkFontGrey).fontFamily(semibold)
//     .make(),
//     ),


//   body: StreamBuilder(

// stream: Firestoreservices.getcart(currentUser!.uid),

//       builder: (BuildContext context, AsyncSnapshot <QuerySnapshot> snapshot){

//       if (!snapshot.hasData) {
//         return const Center(
//         child: CircularProgressIndicator(
//         valueColor: AlwaysStoppedAnimation(bluecolor),
//         ),
//         ); // Center
//         } else if (snapshot.data!.docs.isEmpty) {
//         return Center(
//         child: "Cart is empty add cart".text.color (darkFontGrey).make(),
//         );
//         }else{
//           var data = snapshot.data!.docs;
//         controller.calculate(data);
//         controller.productsnapshot = data;

//         return  Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column (
//         children: [
//         Expanded (child: ListView.builder(
//           itemCount: data.length,
//           itemBuilder: (BuildContext context , int index){
//             return  ListTile(
//               leading: Image.network(
//                 "${data[index]['img']}",
//                 width: 80,
//                 fit: BoxFit.cover,
//                  ),
//                 title: "${data[index]['title']}  (x${data[index]['qty']})" .text.fontFamily(bold).size(16).make(),
//                 subtitle: "${data[index]['tprice']}".numCurrency .text.fontFamily(bold).color(bluecolor).make(),
//                 trailing: const Icon(Icons.delete, color: bluecolor,).onTap((){
//                   Firestoreservices.deletedocument(data[index].id);
//                 }),

             

             
//               );
//           })),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//         "Total price".text.fontFamily(semibold).color(darkFontGrey).make(),


//         Obx(()=> "${controller.totalp.value}".numCurrency.text.fontFamily(semibold).color(bluecolor).make())
//         ]
//         ).box.padding(const EdgeInsets.all(12)).color(lightgolden).width(context.screenWidth -60).roundedSM.make(),
       
//         10.heightBox,

//           // SizedBox(
//           //   width: context.screenWidth -60,

//           //   child: ourbutton(
//           //     color: bluecolor,
//           //     onpress: (){},
//           //     textcolor: whiteColor,
//           //     title: "Proceed To Shipping",
//           //   ))

//         ],
//         ),         )   
        
//          ;
//         }
// }
// ), 


    



// );
//   }
// }