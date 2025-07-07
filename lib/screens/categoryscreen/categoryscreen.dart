import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/controller/productcontroller.dart';
import 'package:emart_app/screens/categoryscreen/categorydetails.dart';
import 'package:emart_app/widget/bgwidget.dart';
import 'package:get/get.dart';

class Categoryscreen extends StatelessWidget {
  const Categoryscreen({super.key });

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProductController());


    return bgwidget(
      child: Scaffold(
        appBar: AppBar(
          title: categories.text.white.fontFamily(bold).make(),
        ),

        body: 
Container(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
                shrinkWrap: true,
                itemCount: 9,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 200), 
                itemBuilder: (context,index){
                return Column(
             children: [
              Image.asset(categoryimage[index],height: 120,width: 200,fit: BoxFit.cover,),
              10.heightBox,
              categorylist[index].text.color(darkFontGrey).align(TextAlign.center).make()
             ],
      ).box.white.clip(Clip.antiAlias).padding(const EdgeInsets.all(8)).outerShadow.shadowMd.rounded.make().onTap((){
        controller.getsubcategories(categorylist[index]);

        Get.to(()=>Categorydetails(title: categorylist[index]));
      });
              }),
        ),
 ),
    );

  }
}
