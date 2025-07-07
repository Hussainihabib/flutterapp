import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/authcontroller.dart';
import 'package:emart_app/screens/auth/resetpassword.dart';
import 'package:emart_app/widget/applogowid.dart';
import 'package:emart_app/widget/bgwidget.dart';
import 'package:emart_app/widget/button.dart';
import 'package:emart_app/widget/custom_text.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final controller = Get.put(Authcontroller());

  @override
  Widget build(BuildContext context) {
    return bgwidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogowidget(),
              10.heightBox,
              "FORGOT PASSWORD".text.fontFamily(bold).black.size(18).make(),
              10.heightBox,
              Form(
                key: formKey,
                child: Column(
                  children: [
                    customtextField(
                      hint: emailhint,
                      title: email,
                      isPass: false,
                      controller: controller.emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email is required';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    20.heightBox,
                    ourbutton(
                      color: bluecolor,
                      title: "Send Reset Link",
                      textcolor: whiteColor,
                      onpress: () async {
                        if (formKey.currentState!.validate()) {
                          controller.showResetButton(false); // pehle hide
                          await controller.sendPasswordResetEmail(
                            email: controller.emailController.text,
                            context: context,
                          );
                        }
                      },
                    ).box.width(context.screenWidth - 50).make(),
                    20.heightBox,

                    // 👇 Button show after 5 seconds
                    Obx(() => controller.showResetButton.value
                        ? ourbutton(
                            color: bluecolor,
                            title: "Go to Reset Password",
                            textcolor: whiteColor,
                            onpress: () {
                              Get.to(() => ResetPassword());
                            },
                          ).box.width(context.screenWidth - 50).make()
                        : const SizedBox()),

                  ],
                )
                    .box
                    .white
                    .rounded
                    .shadowSm
                    .padding(const EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .make(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
