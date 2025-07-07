import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/cartcontroller.dart';
import 'package:emart_app/screens/cartscreen/paymentmethod.dart';
import 'package:emart_app/widget/button.dart';
import 'package:emart_app/widget/custom_text.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart'; // <-- required for filtering digits

class Shippingdetails extends StatelessWidget {
  const Shippingdetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<Cartcontroller>();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping info".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourbutton(
          color: bluecolor,
          onpress: () {
            // ✅ trim and check all fields
            if (controller.addressController.text.trim().isEmpty ||
                controller.cityController.text.trim().isEmpty ||
                controller.stateController.text.trim().isEmpty ||
                controller.postalcodeController.text.trim().isEmpty ||
                controller.phoneController.text.trim().isEmpty) {
              VxToast.show(context, msg: "All fields are required");
            } else {
              Get.to(() => const Paymentmethod());
            }
          },
          textcolor: whiteColor,
          title: "Continue",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customtextField(
              hint: "Address",
              isPass: false,
              title: "Address",
              controller: controller.addressController,
            ),
            customtextField(
              hint: "City",
              isPass: false,
              title: "City",
              controller: controller.cityController,
            ),
            customtextField(
              hint: "State",
              isPass: false,
              title: "State",
              controller: controller.stateController,
            ),
            customtextField(
              hint: "Postal Code",
              isPass: false,
              title: "Postal Code",
              controller: controller.postalcodeController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            customtextField(
              hint: "Phone",
              isPass: false,
              title: "Phone",
              controller: controller.phoneController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ],
        ),
      ),
    );
  }
}





// import 'package:emart_app/consts/consts.dart';
// import 'package:emart_app/controller/cartcontroller.dart';
// import 'package:emart_app/screens/cartscreen/paymentmethod.dart';
// import 'package:emart_app/widget/button.dart';
// import 'package:emart_app/widget/custom_text.dart';
// import 'package:get/get.dart';

// class Shippingdetails extends StatelessWidget {
//   const Shippingdetails({super.key});

//   @override
//   Widget build(BuildContext context) {

//     var controller = Get.find<Cartcontroller>();
//     return Scaffold(
//       backgroundColor: whiteColor,
//        appBar: AppBar(
//     title: "Shipping info".text.color (darkFontGrey).fontFamily(semibold)
//     .make(),
//     ),
//     bottomNavigationBar: SizedBox(
//              height: 60,
//             child: ourbutton(
//               color: bluecolor,
//               onpress: (){
              
//              if (controller.addressController.text.length > 8){
              
//                  Get.to(() => const Paymentmethod());               
//              }else{
//               VxToast.show(context, msg: "Please fill the form");
//              }
//           },
//               textcolor: whiteColor,
//               title: "Continue",
//             )),

//          body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//         children:[
//         customtextField(hint: "Address", isPass: false, title: "Address", controller: controller.addressController),
        
//         customtextField(hint: "City", isPass: false, title: "City", controller: controller.cityController),
//         customtextField(hint: "State", isPass: false, title: "State", controller: controller.stateController),
//         customtextField(
//         hint: "Postal Code", isPass: false, title: "Postal Code", controller: controller.postalcodeController), customtextField(hint: "Phone", isPass: false, title: "Phone", controller: controller.phoneController),
//         ]
//         ), 
//         ), 



//     );
//   }
// }