import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/screens/orderscreen/components/orderplaced.dart';
import 'package:emart_app/screens/orderscreen/components/orderstatus.dart';
import 'package:intl/intl.dart' as intl;

class Orderdetails extends StatelessWidget {

  final dynamic data;

  const Orderdetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: "order details".text.fontFamily(semibold).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              orderstatus(color: bluecolor,icon: Icons.done,title: "Placed", showDone: data['order_placed']),
              orderstatus(color: Colors.blue,icon: Icons.thumb_up,title: "Confirmed", showDone: data['order_confirmed']),
              orderstatus(color: Colors.green,icon: Icons.car_crash,title: "Shipping", showDone: data['order_on_delivery']),
              orderstatus(color: Colors.purpleAccent,icon: Icons.done_all_rounded,title: "Delivered", showDone: data['order_delivered']),
          
              const Divider(),
              10.heightBox,
          
             orderplacedetail(
              d1: data['order code'],
              d2: data['shipping method'],
              title1: "Order Code ",
              title2: "Shipping Method",
          ),
              orderplacedetail(
              d1: intl.DateFormat().add_yMd().format((data['order_date'].toDate())),
              d2: data['payment_method'],
              title1: "Order Date ",
              title2: "Payment Method",
          
             ),
             
              orderplacedetail(
              d1: "Unpaid",
              d2: "Order Placed",
              title1: "Payment Status",
              title2: "Delivery Status",
          
             ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       "SHIPPING ADDRESS".text.fontFamily(semibold).make(),
                       "${data['order_by_name']}".text.make(),
                       "${data['order_by_email']}".text.make(),
                       "${data['order_by_address']}".text.make(),
                       "${data['order_by_city']}".text.make(),
                       "${data['order_by_state']}".text.make(),
                       "${data['order_by_phone']}".text.make(),
                       "${data['order_by_postalcode']}".text.make(),
               
                    ],
                  ),
          
                  Column(
                    children: [
                      "Total amount".text.fontFamily(semibold).make(),
                       "${data['total_amount']}".text.color(bluecolor).fontFamily(bold).make(),
          
                    ],
                  )
          
                  
                ],
               ),
             ),
             
              
           const Divider(),
          10.heightBox,
          "Ordered Product".text.size(16).color (darkFontGrey).fontFamily(semibold).makeCentered(),
          10.heightBox,
          ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: List.generate(data['orders'].length, (index){
              return orderplacedetail(
                title1: data ['orders'] [index]['title'],
                title2: data ['orders'][index]['tprice'],
                d1:  "${data['orders'] [index]['qty']}x",
              );
            }).toList(),
          )
          
            
            ],
          ),
        ),
      ),
      
      
    ) ;
  }
}