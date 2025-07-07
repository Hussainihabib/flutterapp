import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/controller/homecontroller.dart';
import 'package:emart_app/screens/categoryscreen/item_detail.dart';
import 'package:emart_app/screens/homescreen/components/featcategory.dart';
import 'package:emart_app/screens/homescreen/searchscreen.dart';
import 'package:emart_app/services/firestoreservices.dart';
import 'package:emart_app/widget/homebutton.dart';
import 'package:get/get.dart';


class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
var controller = Get.find<Homecontroller>();

    return Container(
      padding: const EdgeInsets.all(12),
      color: whiteColor,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 60,
            color: lightGrey,
            child: TextFormField(
              controller: controller.SearchController,
              decoration:  InputDecoration(
                border: InputBorder.none,
                suffixIcon: const Icon(Icons.search).onTap((){
if (controller.SearchController.text.isNotEmptyAndNotNull) {
                  Get.to(() => Searchscreen(title: controller.SearchController.text,));
  
}

                }),
                filled: true,
                fillColor: whiteColor,
                hintText: searchanything,
                hintStyle: const TextStyle(
                  color: textfieldGrey,
                )
              ),
            ),
          ),

          20.heightBox,
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
              // swipper brands
              VxSwiper.builder(
              aspectRatio: 16/9,
              autoPlay: true,
              height: 150,
              enlargeCenterPage: true,
              
                itemCount: sliderlist.length, 
                itemBuilder: (context,index){
                return Image.asset(sliderlist[index],
                fit: BoxFit.fill,
                ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make()
                ;
              }),
              20.heightBox,

           Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(2, (index) => Homebuttons(
              height: context.screenHeight *0.15,
              width: context.screenWidth /2.5,
              icon: index == 0?icTodaysDeal :icFlashDeal,
              title: index == 0? todaydeal : flashsale
              
              )),
                      ),
              
          20.heightBox,
              
                      //2nd swipper
              
               VxSwiper.builder(
              aspectRatio: 16/9,
              autoPlay: true,
              height: 150,
              enlargeCenterPage: true,
              
                itemCount: sliderlist.length, 
                itemBuilder: (context,index){
                return Image.asset(sliderlist[index],
                fit: BoxFit.fill,
                ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make()
                ;
              }),
              
              10.heightBox,
               Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(3, (index) => Homebuttons(
              height: context.screenHeight *0.15,
              width: context.screenWidth /3.5,
              icon: index == 0? icTopCategories: index == 1? icBrands : icTopSeller,
              title: index == 0? topcategories: index == 1? topbrand : topseller
              
              )),
                      ),
              
                      //  featured categories
              20.heightBox,
              Align(
              alignment: Alignment.centerLeft,
              child: featuredcategories.text.color(darkFontGrey).size(22).fontFamily(semibold).make()),
              20.heightBox,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(3,
                   (index) => Column(
                    children: [
                        Feauturedbutton(icon: featuredimg1[index], title: featuredtitle1[index]),
                        10.heightBox,
                        Feauturedbutton(icon: featuredimg2[index], title: featuredtitle2[index]),
                    ],
                   )).toList(),
                ),
              ),
              
            // featued product sec
     20.heightBox,
     Container(
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      decoration: const BoxDecoration(color: bluecolor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          featuredproduct.text.white.fontFamily(bold).size(18).make(),
          10.heightBox,

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(6, (index) => Column(
                  children: [
                Image.asset(imgP1,width: 150,fit: BoxFit.cover,),
                10.heightBox,
                "laptop 4 / 64".text.fontFamily(semibold).color(darkFontGrey).make(),
                10.heightBox,
                 "\$450 ".text.fontFamily(bold).color(bluecolor).size(16).make(),
              
              
                  ],
              
                ).box.white.rounded.margin(const EdgeInsets.symmetric(horizontal: 4)).padding(const EdgeInsets.all(8)).make()),
                        ),
            ),
        ],
      ),
     ),

     20.heightBox,
    //  3rdswipper
    
               VxSwiper.builder(
              aspectRatio: 16/9,
              autoPlay: true,
              height: 150,
              enlargeCenterPage: true,
              
                itemCount: sliderlist.length, 
                itemBuilder: (context,index){
                return Image.asset(sliderlist[index],
                fit: BoxFit.fill,
                ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make()
                ;
              }),
               
              // allproduct
            20.heightBox,
              Align(
              alignment: Alignment.centerLeft,
              child: allproduct.text.color(darkFontGrey).size(22).fontFamily(semibold).make()),
              20.heightBox,

              StreamBuilder(stream: Firestoreservices.allproduct(),
               builder:(BuildContext context, AsyncSnapshot <QuerySnapshot> snapshot){
                if (!snapshot.hasData) {
                  return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(bluecolor),
                  ),
               );
                }else{

                  var allproductsdata = snapshot.data!.docs;

                  return   GridView.builder(
                shrinkWrap: true,
                itemCount: allproductsdata.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 300), 
                itemBuilder: (context,index){
                return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
         
                children: [
              Image.network(allproductsdata[index]['p_img'][0]
              ,height: 170,width: 150,fit: BoxFit.cover,),
              10.heightBox,
              "${allproductsdata[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
              10.heightBox,
               "${allproductsdata[index]['p_price']}".numCurrency.text.fontFamily(bold).color(bluecolor).size(16).make(),
            
            
                ],
              ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).shadowSm.padding(const EdgeInsets.all(16)).rounded.make().onTap((){
                  Get.to(() => ItemDetail(title: "${allproductsdata[index]['p_name']}", data: allproductsdata[index],));
              });
              });
                }
               } 
               ),
                ],
              ),
            ),
          ),
                 ],
      )),
      
    );
  }
}



