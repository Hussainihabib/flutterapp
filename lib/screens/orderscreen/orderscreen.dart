import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/screens/orderscreen/orderdetails.dart';
import 'package:emart_app/services/firestoreservices.dart';
import 'package:get/get.dart';

class Orderscreen extends StatelessWidget {
  const Orderscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,

       appBar: AppBar(
        title: "My Orders".text.color (darkFontGrey). fontFamily (semibold).make(),
        ),
        body: StreamBuilder(
        stream: Firestoreservices.getallorders(),
        builder: (BuildContext context, AsyncSnapshot <QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
        return    const Center(
                 child:CircularProgressIndicator(
                   valueColor: AlwaysStoppedAnimation(bluecolor),
                         ), 
                       
                  ); 
        }
        else if (snapshot.data!.docs.isEmpty){
        return "No orders yet!".text.color(darkFontGrey).makeCentered();}
        else{

          var data = snapshot.data!.docs;
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index){
            return ListTile(
              leading: "${index + 1}".text.color(darkFontGrey).xl.fontFamily(bold).make(),
              title: data[index]['order code'].toString().text.color(bluecolor).fontFamily(semibold).make(),
               subtitle: data[index]['total_amount'].toString().numCurrency.text.fontFamily(bold).make(),
                    onTap: (){
                      Get.to(() => Orderdetails(data: data[index]));
                    },

               trailing: IconButton(onPressed: (){
               },
                icon:const Icon(Icons.arrow_forward_ios_rounded,color: darkFontGrey,) ),
            );
          },
        );

        }

  }), 

    );

}
}


