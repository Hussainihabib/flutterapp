import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/controller/authcontroller.dart';
import 'package:emart_app/controller/profilecontroller.dart';
import 'package:emart_app/screens/accountscreen/components/detailcard.dart';
import 'package:emart_app/screens/accountscreen/editprofilescreen.dart';
import 'package:emart_app/screens/auth/login_screen.dart';
import 'package:emart_app/screens/chatscreen/messagingscreen.dart';
import 'package:emart_app/screens/orderscreen/orderscreen.dart';
import 'package:emart_app/screens/wishlistscreen/wishlistscreen.dart';
import 'package:emart_app/services/firestoreservices.dart';
import 'package:emart_app/widget/bgwidget.dart';
import 'package:get/get.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  @override
  Widget build(BuildContext context) {

 var controller = Get.put(Profilecontroller());
 
    return bgwidget(
      child: Scaffold(
        body: StreamBuilder(stream: Firestoreservices.getUser(currentUser!.uid), 
        builder: (BuildContext context, AsyncSnapshot <QuerySnapshot> snapshot){
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(bluecolor),
                ),
              );
              
            }else{
              var data = snapshot.data!.docs[0];     
              return SafeArea(child: Column(
                  children: [
                
                
                // edit profile button 
                
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.edit,color:Colors.white,)).onTap((){

                          controller.nameController.text = data['name'];
                          controller.passController.text = data['password'];
                        Get.to(() => EditProfileScreen(data: data,));
                
                      }),
                  ),
                
                    
                // user detail
                
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                     child: Row(
                      children: [
                    (data['imageUrl'] == null || data['imageUrl'] == '')
    ? Image.asset(imgProfile2, width: 100, fit: BoxFit.cover,)
    : Image.network(data['imageUrl'], width: 100, fit: BoxFit.cover,),


                        10.widthBox,
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "${data['name']}".text.fontFamily(semibold).white.make(),
                            5.heightBox,
                             "${data['email']}".text.white.make(),
                            
                     
                          ],
                     
                        )),
                     
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color:Colors.white
                            )
                          ),
                          onPressed: 
                        ()async{
                          await Get.put(Authcontroller()).signoutMethod(context);
                          Get.offAll(() => const LoginScreen());
                        }, child: 
                        logout.
                        text.color(bluecolor).
                        fontFamily(semibold).
                        make())
                     
                      ],
                     ),
                   ),
                
                   20.heightBox,
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      detailcard(count: data['cart_count'],title: "In Your Cart",width: context.screenWidth /3.4),
                      detailcard(count: data['wishlist_count'],title: "In Your Wishlist",width: context.screenWidth /3.4),
                      detailcard(count: data['order_count'],title: "Your Orders",width: context.screenWidth /3.4),
                    ],
                   ),
                   
                
                // buttons sec
                30.heightBox,
                ListView.separated( 
                  shrinkWrap: true,
                
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: lightGrey,
                    );
                  },
                  itemCount: profilrbuttonlist.length,
                  
                  itemBuilder: (BuildContext context, int index){
                 return  ListTile(
                  onTap: (){
                    switch (index) {
                      case 0:
                        Get.to(() => const Orderscreen());
                        break;
                          case 1:
                        Get.to(() => const Wishlistscreen());
                        break;  case 2:
                        Get.to(() => const Messagingscreen());
                        break;
                    }
                  },
                
                  leading: Image.asset(profilrbuttonicon[index], width: 22,),
                  title: profilrbuttonlist[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                 );
                
                  }).box.white.rounded.shadowSm.padding(const EdgeInsets.symmetric(horizontal: 16)).make()
                
                
                  ],
                ));
            }


          
        },),
//
//ERROR CODE 
//
// StreamBuilder(
           
          
//       stream: Firestoreservices.getUser(currentUser!.uid),
     
//      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//      if (!snapshot.hasData) {
//        return Center(
//         child: CircularProgressIndicator(
//           valueColor: AlwaysStoppedAnimation(bluecolor),
//         ) ,
//        );
//      }else{
//         return SafeArea(child: Container(
//         padding: const EdgeInsets.all(8),
//         child: Column(
//           children: [


// // edit profile button 

//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: const Align(
//               alignment: Alignment.topRight,
//               child: Icon(Icons.edit,color: whiteColor,)).onTap((){
//                 Get.to(() => const Editprofilescreen());

//               }),
//           ),

            
//         // user detail

//            Padding(
//              padding: const EdgeInsets.symmetric(horizontal: 8.0),
//              child: Row(
//               children: [
//                 Image.asset(imgProfile2,width: 100,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make(),
//                 10.widthBox,
//                 Expanded(child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     "dummy user ".text.fontFamily(semibold).white.make(),
//                     5.heightBox,
//                      "dummy@gmail.com ".text.white.make(),
                    
             
//                   ],
             
//                 )),
             
//                 OutlinedButton(
//                   style: OutlinedButton.styleFrom(
//                     side: const BorderSide(
//                       color: whiteColor
//                     )
//                   ),
//                   onPressed: 
//                 ()async{
//                   await Get.put(Authcontroller()).signoutMethod(context);
//                   Get.offAll(() => const LoginScreen());
//                 }, child: 
//                 logout.
//                 text.
//                 fontFamily(semibold).
//                 make())
             
//               ],
//              ),
//            ),

//            20.heightBox,
//            Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               detailcard(count: "00",title: "In Your Cart",width: context.screenWidth /3.4),
//               detailcard(count: "00",title: "In Your Wishlist",width: context.screenWidth /3.4),
//               detailcard(count: "00",title: "Your Orders",width: context.screenWidth /3.4),
//             ],
//            ),
           

// // buttons sec
// 30.heightBox,
// ListView.separated( 
//   shrinkWrap: true,

//   separatorBuilder: (context, index) {
//     return const Divider(
//       color: lightGrey,
//     );
//   },
//   itemCount: profilrbuttonlist.length,
  
//   itemBuilder: (BuildContext context, int index){
//  return  ListTile(

//   leading: Image.asset(profilrbuttonicon[index], width: 22,),
//   title: profilrbuttonlist[index].text.fontFamily(semibold).color(darkFontGrey).make(),
//  );

//   }).box.white.rounded.shadowSm.padding(const EdgeInsets.symmetric(horizontal: 16)).make()


//           ],
//         ),

//         ));
//      }
      
//      },
      
      
      
      
      )
        
        
      );


  }
}