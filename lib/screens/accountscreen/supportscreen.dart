import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widget/bgwidget.dart';
import '../../widget/button.dart';
import '../../widget/custom_text.dart';

class SupportScreen extends StatelessWidget {
  SupportScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  final faqList = [
    {'question': 'How to track my order?', 'answer': 'Go to Order History and click on Track Order.'},
    {'question': 'How to reset password?', 'answer': 'Use Forgot Password option on login screen.'},
    {'question': 'What are shipping charges?', 'answer': 'Shipping is free above PKR 5000.'},
  ];

  @override
  Widget build(BuildContext context) {
    return bgwidget(
      child: Scaffold(
        appBar: AppBar(
          title: "Help & Support".text.fontFamily(bold).white.make(),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              "Need help? Send us your message:"
                  .text.size(16).fontFamily(semibold).white.make(),
              10.heightBox,

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    customtextField(
                      hint: "Enter your name",
                      title: "Name",
                      controller: nameController,
                      isPass: false,
                      validator: (value) => value!.isEmpty ? 'Name required' : null,
                    ),
                    customtextField(
                      hint: "Enter your email",
                      title: "Email",
                      controller: emailController,
                      isPass: false,
                      validator: (value) {
                        if (value!.isEmpty) return 'Email required';
                        if (!value.contains('@')) return 'Enter valid email';
                        return null;
                      },
                    ),
                    customtextField(
                      hint: "Write your message",
                      title: "Message",
                      controller: messageController,
                      isPass: false,
                      validator: (value) => value!.isEmpty ? 'Message required' : null,
                    ),
                    10.heightBox,
                    ourbutton(
                      color: bluecolor,
                      title: "Send Message",
                      textcolor: whiteColor,
                      onpress: () async {
                        if (_formKey.currentState!.validate()) {
                          await FirebaseFirestore.instance.collection('support_messages').add({
                            'name': nameController.text,
                            'email': emailController.text,
                            'message': messageController.text,
                            'timestamp': FieldValue.serverTimestamp(),
                          });
                          Get.snackbar("Success", "Your message has been sent",
                              backgroundColor: bluecolor, colorText: whiteColor);
                          nameController.clear();
                          emailController.clear();
                          messageController.clear();
                        }
                      },
                    ).box.transparent.width(context.screenWidth - 50).make(),
                  ],
                ),
              ),

              20.heightBox,
              "Frequently Asked Questions"
                  .text.size(16).fontFamily(semibold).white.make(),
              10.heightBox,

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: faqList.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: lightgolden,
                    child: ExpansionTile(
                      title: faqList[index]['question']!.text.fontFamily(semibold).make(),
                      children: [
                        faqList[index]['answer']!.text.make().p8(),
                      ],
                    ),
                  ).box.roundedSM.shadowSm.make();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
