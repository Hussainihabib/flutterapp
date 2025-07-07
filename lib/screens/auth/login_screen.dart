import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/controller/authcontroller.dart';
import 'package:emart_app/screens/auth/signup_screen.dart';
import 'package:emart_app/screens/homescreen/home.dart';
import 'package:emart_app/widget/applogowid.dart';
import 'package:emart_app/widget/bgwidget.dart';
import 'package:emart_app/widget/button.dart';
import 'package:emart_app/widget/custom_text.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Authcontroller());
    return bgwidget(child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogowidget() ,
          5.heightBox,
            "LOG IN  ".text.fontFamily(bold).black.size(18).make(),
            5.heightBox,
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              child: 
              Obx(() => Column( 
                  children: [
                    customtextField(hint: emailhint,title: email,isPass: false, controller: controller.emailController),
                    customtextField(hint: passwordhint, title: password, isPass: true, controller: controller.passwordscontroller),
                    Align
                    (alignment: Alignment.centerRight,
                      child: TextButton(onPressed: (){}, child: fp.text.color(whiteColor).make())),
                      5.heightBox,
                      // ourbutton().box.width(context.screenWidth - 50).make(),
                       controller.isloading.value? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(bluecolor),
                        )
                       : ourbutton(color: bluecolor,title: login,textcolor: whiteColor,onpress: ()async{
                        controller.isloading(true);

                        await controller.loginMethod(context: context).then((value){
                          if (value != null) {
                            VxToast.show(context, msg: loggedin);
                            Get.offAll(() => const Home());
                          }else{
                            
                            controller.isloading(false);
                          }
                        });
                      }).box.width(context.screenWidth  -50).make(),
                      5.heightBox,
                      createnewaccount.text.color(bluecolor).make(),
                      5.heightBox,
                      ourbutton(color: lightgolden,title: signup,textcolor: bluecolor,onpress: (){
                        Get.to(()=> const SignupScreen());
                      }).box.width(context.screenWidth  -50).make(),
                      10.heightBox,
                      loginwith.text.color(bluecolor).make(),
                      5.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:List.generate(3,(index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: lightGrey,
                            radius: 25,
                            child: Image.asset(socialiconlist[index],
                            width: 30,),
                          ),
                        )),
                      )
                  ],
                ).box.transparent.rounded.width(context.screenWidth - 70).shadowSm.padding( const EdgeInsets.all(16)).make(),
              ),
            )

          ],
        ),
      ),
    ));
  }
}