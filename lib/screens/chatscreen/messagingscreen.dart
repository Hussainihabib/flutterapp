import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/screens/chatscreen/chatscreen.dart';
import 'package:emart_app/services/firestoreservices.dart';
import 'package:get/get.dart';

class Messagingscreen extends StatelessWidget {
  const Messagingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,

       appBar: AppBar(
        title: "My Messages".text.color (darkFontGrey). fontFamily (semibold).make(),
        ),
        body: StreamBuilder(
        stream: Firestoreservices.getallmessage(),
        builder: (BuildContext context, AsyncSnapshot <QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
        return   const Center(
                 child:CircularProgressIndicator(
                   valueColor: AlwaysStoppedAnimation(bluecolor),
                         ), 
                       
                  ); 
        }
        else if (snapshot.data!.docs.isEmpty){
        return "No messages yet!".text.color(darkFontGrey).makeCentered();}
        else{
          var data = snapshot.data!.docs; 

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(child: 
              ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index){
                  return Card(
                    child: ListTile(
                      onTap: (){
                        Get.to(()=>  const Chatscreen(),
                         arguments : [data[index]['friend_name'].toString(),
                                    data[index]['told'].toString(),
                        ]
                        );
                       
                      },
                      leading: const CircleAvatar(
                        backgroundColor: bluecolor,
                        child: Icon(Icons.person_2_rounded,color:whiteColor,),
                      ),
                          title: "${data[index]['friend_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                          subtitle: "${data[index]['last_msg']}".text.make(),
                    
                    ),
                  );
                })
              )
            ],
          ),
        );

        }

  }), 

    );
  }
}