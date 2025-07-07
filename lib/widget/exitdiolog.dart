import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/widget/button.dart';
import 'package:flutter/services.dart';


Widget exitDialog(context) {

            return Dialog(
            child: Column (
                mainAxisSize: MainAxisSize.min,
            children: [
            "Confirm".text.fontFamily(bold).size(18).color (darkFontGrey).make(),
            const Divider(),
            10.heightBox,
            "Are you sure you want to exit?".text
            .size(16)
            .color(darkFontGrey).
            make(),

            10.heightBox,

            Row(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly ,

            children: [

            ourbutton(color: bluecolor, onpress: (){
                SystemNavigator.pop();
            }, textcolor: whiteColor, title: "Yes"), // Row
            ourbutton(color: bluecolor, onpress: (){
                Navigator.pop(context);
            }, textcolor: whiteColor, title: "No"), // Row

            ]).box.padding(const EdgeInsets.all(12)).color(lightGrey).roundedSM.make(), // Column

        ])
// / Dialog

);
}