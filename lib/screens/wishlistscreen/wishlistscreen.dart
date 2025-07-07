import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestoreservices.dart';

class Wishlistscreen extends StatelessWidget {
  const Wishlistscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
       appBar: AppBar(

        title: "My wishlist".text.color (darkFontGrey). fontFamily (semibold).make(),
        ),
        body: StreamBuilder(
        stream: Firestoreservices.getwishlist(),
        builder: (BuildContext context, AsyncSnapshot <QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
        return   const Center(
                 child:CircularProgressIndicator(
                   valueColor: AlwaysStoppedAnimation(bluecolor),
                         ), 
                       
                  ); 
        }
        else if (snapshot.data!.docs.isEmpty){
        return "No Wishlist yet!".text.color(darkFontGrey).makeCentered();}
        else{
           var data = snapshot.data!.docs;
        return Column (
        children: [
        Expanded (child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context , int index){
            return  ListTile(
              leading: Image.network(
                "${data[index]['p_img'][0]}",
                width: 80,
                fit: BoxFit.cover,
                 ),
                title: "${data[index]['p_name']}" .text.fontFamily(bold).size(16).make(),
                subtitle: "${data[index]['p_price']}".numCurrency .text.fontFamily(bold).color(bluecolor).make(),
                trailing: const Icon(Icons.favorite, color: bluecolor,).onTap(() async{
                  await firestore.collection(productcollection).doc(data[index].id).set({
                    'p_wishlist':FieldValue.arrayRemove([currentUser!.uid])
                  }, SetOptions(merge: true));
                }),

             

             
              );
          })),
        ]

         ); }

  }), 

    );
  }
}