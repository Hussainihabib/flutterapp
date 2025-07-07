import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/authcontroller.dart';
import 'package:emart_app/widget/applogowid.dart';
import 'package:emart_app/widget/bgwidget.dart';
import 'package:emart_app/widget/button.dart';
import 'package:emart_app/widget/custom_text.dart';
import 'package:get/get.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});

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
              "RESET PASSWORD".text.fontFamily(bold).black.size(18).make(),
              10.heightBox,
              Form(
                key: formKey,
                child: Column(
                  children: [
                    customtextField(
                      hint: passwordhint,
                      title: "New Password",
                      isPass: true,
                      controller: controller.passwordsController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    customtextField(
                      hint: passwordhint,
                      title: "Confirm Password",
                      isPass: true,
                      controller: controller.rePasswordsController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please re-enter password';
                        } else if (value != controller.passwordsController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    20.heightBox,
                    ourbutton(
                      color: bluecolor,
                      title: "Reset Password",
                      textcolor: whiteColor,
                      onpress: () async {
                        if (formKey.currentState!.validate()) {
                          await controller.resetPasswordWhileLoggedIn(
                            newPassword: controller.passwordsController.text,
                            context: context,
                          );
                        }
                      },
                    ).box.width(context.screenWidth - 50).make(),
                  ],
                )
                    .box
                    .transparent
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
