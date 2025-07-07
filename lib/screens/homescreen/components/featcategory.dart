import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/screens/categoryscreen/categorydetails.dart';
import 'package:get/get.dart';


Widget Feauturedbutton({String? title, icon}){
  return Row(
    children: [
      Image.asset(icon,width: 60,fit: BoxFit.fill,),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()

    ],
  ).box.width(200).margin(const EdgeInsets.symmetric(horizontal: 4)).white.padding(const EdgeInsets.all(4)).roundedSM.outerShadowSm.make().onTap((){
    Get.to(() => Categorydetails(title: title));
  }) ;

}