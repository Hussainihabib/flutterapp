import 'package:emart_app/consts/consts.dart';

Widget Homebuttons({width, height , icon , String? title ,onPressed}){
return  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(icon, width: 26),
      10 .heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  )
.box.rounded.white.size(width, height).shadowSm.make();
}