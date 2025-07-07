import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/chatscontroller.dart';
import 'package:emart_app/screens/chatscreen/components/senderbubble.dart';
import 'package:emart_app/services/firestoreservices.dart';
import 'package:get/get.dart';

class Chatscreen extends StatelessWidget {
  const Chatscreen({super.key});

  @override
  Widget build(BuildContext context) {
 var controller = Get.put(Chatscontroller());
 
            return Scaffold(
              backgroundColor: whiteColor,
          appBar:AppBar( 
        title: "${controller.friendName}".text.fontFamily(semibold).color (darkFontGrey).make(),
        ), // AppBar
        body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
        children:[
        Obx(()=> controller.isloading.value? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(bluecolor),
                  ),
               ):
         Expanded(child: StreamBuilder(
            
            stream: Firestoreservices.getchatsmessage(controller.chatDocId.toString()),
          builder: (BuildContext context, AsyncSnapshot <QuerySnapshot> snapshot){
             if (!snapshot.hasData) {
               return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(bluecolor),
                  ),
               );
             }else if(snapshot.data!.docs.isEmpty){
              return Center(
                child: "Send a Message....".text.color(darkFontGrey).make(),
              );
             }else{
              return  ListView(
            children:snapshot.data!.docs.mapIndexed((currentvalue, index){

              var data = snapshot.data!.docs[index];
              return Align(
                alignment: data['uid'] == currentUser!.uid? Alignment.centerRight : Alignment.centerLeft,
                child: senderbubble(data));
            }).toList(),
          );
             }
          
          } ),
          ),
        ),
        10.heightBox,
         Row(
              children: [
              Expanded(
              child: TextFormField(
                controller: controller.msgController,
              decoration: const InputDecoration(
              border: OutlineInputBorder(
              borderSide: BorderSide(
              color: textfieldGrey,
              )), 
              focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
              color: textfieldGrey,
              )), 
              hintText: "Type a message...",
              ), 
              )), 
              IconButton(onPressed: (){

                controller.sendMsg(controller.msgController.text);
                controller.msgController.clear();
              }, icon: const Icon(Icons.send, color:bluecolor))
              ]
              ).box.height(90).padding(const EdgeInsets.all(12)).margin(const EdgeInsets.only(bottom: 8)).make(),
        



        ]), 
        ), 
        );
  }
}


