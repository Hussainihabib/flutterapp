import 'package:emart_app/consts/consts.dart';

Widget ourbutton({onpress, color, textcolor, String? title}){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      
      padding: const EdgeInsets.all(12),
      backgroundColor: color
    ),
    
   
    onPressed: onpress,
     
    child: title!.text.color(textcolor).fontFamily(bold).make());
}