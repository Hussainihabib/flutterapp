import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/controller/productcontroller.dart';
import 'package:emart_app/screens/chatscreen/chatscreen.dart';
import 'package:emart_app/widget/button.dart';
import 'package:get/get.dart';

class ItemDetail extends StatelessWidget {
   final String? title;
   final dynamic data;
  const ItemDetail  ({Key? key,required this.title,this.data}) :super(key: key);
  @override
  Widget build(BuildContext context) {
    
    var controller = Get.put(ProductController());

    return WillPopScope(
      onWillPop: ()async{
        controller.resetvalues();
        Get.back();
        return false ;
      },
      child: Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            leading: IconButton(onPressed: (){
              controller.resetvalues();
              Get.back();
      
            }, icon: const Icon(Icons.arrow_back))
            ,
      title: title!.text.color(darkFontGrey).fontFamily(bold).make() ,
      
              actions: [
                  IconButton(onPressed: (){}, icon:  const Icon(Icons.share,)),
                  Obx(()=>
                    IconButton(onPressed: (){
                      if (controller.isfav.value) {
                        controller.removefromwishlist(data.id,context);
                        controller.isfav(false);
                      }else{
                        controller.addtowishlist(data.id,context);
                        
                      }
                    
                    }, icon:  Icon(Icons.favorite_outlined,
                    color: controller.isfav.value? bluecolor:darkFontGrey,
                    )),
                  ),
              ],
          ),
      
          body:  Column(
              children: [
                  Expanded(child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SingleChildScrollView(
                         child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          
                      children: [  
      
                          // swipper section
                          VxSwiper.builder(
                          aspectRatio: 16/9,
                          viewportFraction: 1.0,
                          autoPlay: true,
                          height: 300,
                          itemCount: data['p_img'].length,
                           itemBuilder: (context,index){
                  return Image.network(data["p_img"][index],width: double.infinity,fit: BoxFit.cover,
                          
                  );
                          }),
      
                          10.heightBox,
                          title!.text.size(16).color(fontGrey).fontFamily(bold).make(),
                          10.heightBox,
                          VxRating(
                            isSelectable: false,
                            value: double.parse(data['p_rating']),
                            onRatingUpdate: (Value){},
                          normalColor: textfieldGrey,
                          selectionColor: lightgolden,
                          count: 5,
                          size: 25,
                          maxRating: 5,
                          
                          
                          
                          
                          ),
      
                  10.heightBox,
                 
                   "${data['p_price']}".numCurrency.text.fontFamily(bold).color(bluecolor).size(16).make(),  
                   10.heightBox,
      
      
                 Row(
                      children: [
                        Expanded(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          "Seller".text.white.fontFamily(semibold).make(),
                          5.heightBox,
                          "${data['p_seller']}".text.fontFamily(semibold).color(darkFontGrey).make()
                      
      
                          ],
                        )),
                       const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.message_rounded,color: darkFontGrey,),
                          ).onTap((){
                            Get.to(() => const Chatscreen(),
                            arguments: [data['p_seller'], data['vendor_id']]
                            );
                          })
                      ],
                   ) .box.height(70).padding(const EdgeInsets.symmetric(horizontal: 18)).color(textfieldGrey).make(),
      
                    // color section
                    20.heightBox,
                    Obx( 
                      () => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Color".text.color(textfieldGrey).make(),
                              ),
                      
                              Row(
                                children: 
                                  List.generate(data['p_colors'].length, (index)=> 
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      VxBox().size(40, 40).roundedFull.
                                      color(Color(data['p_colors'][index]).
                                      withOpacity(1.0)).margin(const EdgeInsets.symmetric(horizontal: 4))
                                      .make().onTap(
                                        (){
                                        controller.changecolorindex(index);
                                      }
                      
                                      ),
                                      Visibility(
                                        visible: index == controller.colorindex.value,
                                        child:
                                      const Icon(Icons.done, color: Colors.blue,)
                                      
                                      )
                                    ],
                                  )),
                                
                      
                              )
                            ],
                          ).box.blue100.padding(const EdgeInsets.all(8)).make(),
                      
                      // quality row
                                      Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Quantity:".text.color(textfieldGrey).make(),
                              ),
                      
                              Obx(() => Row(
                                children: [
                                    
                                    IconButton(onPressed: (){
                                      controller.decreasequantity();
                                    controller.calctotalprice(
                                           int.parse(data['p_price'])
                                        );
                                    }, icon:  const Icon(Icons.remove,)),
                                    controller.quantity.value.text.size(16).color(darkFontGrey).fontFamily(bold).make(),
                                
                                      IconButton(onPressed: (){
                                        controller.increasequantity(
                                          int.parse(data['p_quantity'])
                                        );
      
                                        controller.calctotalprice(
                                           int.parse(data['p_price'])
                                        );
                                      }, icon:  const Icon(Icons.add,)),
                                      10.widthBox,
                                    "(${data['p_quantity']} available)".text.color(textfieldGrey).make(),
                                   
                                
                                ],
                                  
                                
                                ),
                              ),                        
                         ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                      
                      
                          // total row 
                      
                      
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Total".text.color(textfieldGrey).make(),
                              ),
                      
                              "${controller.totalprice.value}".numCurrency.text.color(bluecolor).size(16).fontFamily(bold).make()
                      
                                                  
                         ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                      
                        ],
                      ).box.white.shadowSm.make(),
                    ),
      
                    10.heightBox,
      
      
                        "Description".text.color(darkFontGrey).fontFamily(bold).make(),
                          "${data['p_desc']}".text.color(darkFontGrey).make(),
                          // button sec
                          10.heightBox,
      
      
                    ListView(
                      physics:const  NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                        idbuttonlist.length
                        , (index)=> ListTile(
      
                        title:   idbuttonlist[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                        trailing: const Icon(Icons.arrow_forward),
                      )),
                    ),
      
      
                    // product list sec
                    20.heightBox,
                    products.text.fontFamily(bold).color(darkFontGrey).size(16).make(),
                    20.heightBox,
      
                    // this is taken  by home screen 
      
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
                
                  ).box.white.rounded.shadowMd.margin(const EdgeInsets.symmetric(horizontal: 4)).padding(const EdgeInsets.all(8)).make()),
                          ),
              ),
      
      
      
                     ],           
                    ),
                    ),
                  )),
      
                  SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ourbutton(
                          color: bluecolor,
                        onpress: () {
  if (controller.quantity.value > 0) {
    controller.addToCart(
      title: data['p_name'],
      img: data['p_img'][0],
      sellername: data['p_seller'],
      color: data['p_colors'][controller.colorindex.value],
      qty: controller.quantity.value,
      tprice: controller.totalprice.value,
      vendorID: data['vendor_id'],
      productId: data.id,
      availableStock: int.parse(data['p_quantity'].toString()),
      context: context,
    );
  } else {
    VxToast.show(context, msg: "Quantity can't be 0");
  }
},

                          textcolor: whiteColor,
                          title: "ADD TO CART",
                      ),
                  )
              ],
          ),
      ),
    );
  }
}