import 'package:emart_app/consts/list.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/cartcontroller.dart';
import 'package:emart_app/screens/homescreen/home.dart';
import 'package:get/get.dart';

import '../../widget/button.dart';

class Paymentmethod extends StatelessWidget {
  const Paymentmethod({super.key});

  @override
  Widget build(BuildContext context) {

     var controller = Get.find<Cartcontroller>();
    return 
       Obx(()=>
        Scaffold(
          backgroundColor: whiteColor,
             bottomNavigationBar: SizedBox(
                 height: 60,
                child: controller.placingorder.value?
                  const Center(
                  child:CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(bluecolor),
                  ), 
                )
                : ourbutton(
                  color: bluecolor,
                  onpress: () async {
                   await
                    controller.placeMyOrder(orderPaymentMethod: paymentmethods[controller.paymentindex.value], totalAmount: controller.totalp.value);
                 await controller.clearcart();
                 VxToast.show(context, msg: "Sucesfully order Placed");

                    Get.offAll(const Home());
                  },
                  textcolor: whiteColor,
                  title: "Place My Order",
                )),
               
           appBar: AppBar(
               title: "Chose Payment Method".text.color (darkFontGrey).fontFamily(semibold)
               .make(),
               ),
               
               
          body: Padding(
               padding
               : const EdgeInsets.all(12.0),
               child: Obx(() =>
          Column(
          children: List.generate (paymentmethodimg.length, (index) {
          return GestureDetector(
          
            onTap: () {
              controller.changepaymenindex(index);
            },
          
            child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
            color:  controller.paymentindex.value ==index ? bluecolor: Colors.transparent,
            width: 4,
            )),
            margin: const EdgeInsets.only(bottom: 8),
            child: Stack(
              alignment: Alignment.topRight,
            children: [
            Image.asset(paymentmethodimg[index], width: double.infinity,
            colorBlendMode:controller.paymentindex.value ==index?  BlendMode.darken : BlendMode.color,
            color:controller.paymentindex.value ==index?  Colors.black.withOpacity(0.4): Colors.transparent,
             height: 120,
            fit: BoxFit.cover),
            controller.paymentindex.value == index ?
            Transform.scale(
              scale: 1.3,
              child: Checkbox(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              ), // RoundedRectangleBorder
              value: true,
              onChanged: (value) {},
              ),
            ):Container(),
               
            // positioned(
            //   bottom: 0,
            //   left: 10,
            //   child: paymentmethods[index].text.white.fontFamily(semibold).make()),
            ]
            ), 
            ),
          );
          },
          ), 
          ),
               ),
               
               
               
          )),
       );
     }



  }
