import 'package:emart_app/consts/consts.dart';

Widget detailcard({width,String? title,String?count}){
  return  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

      // count
         count!.text.fontFamily(semibold).color(darkFontGrey).size(16).make(),
          5.heightBox,

      //  title

        title!.text.color(darkFontGrey).make(),

    ],
  ).box.white.rounded.width(width).height(80).padding(const EdgeInsets.all(4)).make();
}