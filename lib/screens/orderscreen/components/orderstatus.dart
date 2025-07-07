import 'package:emart_app/consts/consts.dart';

Widget orderstatus({icon,color,title,showDone}){
  return ListTile(
    leading: Icon(icon,color : color,).box.roundedLg.padding(const EdgeInsets.all(4)).border(color: color).make(),

    trailing: 
    SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          "$title".text.color(darkFontGrey).make(),
          showDone?
           Icon(Icons.done,color: color,)
           :Container()
        ],
      ),
    ),
  );  
}