import 'package:emart_app/consts/consts.dart';

Widget orderplacedetail({title1,title2,d1,d2}){
  return   Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    
                    children: [
                      "$title1".text.fontFamily(semibold).make(),
                      "$d1".text.color(bluecolor).fontFamily(semibold).make()
              
                    ],
                  ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "$title2".text.fontFamily(semibold).make(),
                      "$d2".text.fontFamily(semibold).make()
              
                    ],
                  ),
                ],
              ),
            )
  ;
}