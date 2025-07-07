import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/controller/authcontroller.dart';
import 'package:emart_app/screens/homescreen/home.dart';
import 'package:emart_app/widget/applogowid.dart';
import 'package:emart_app/widget/bgwidget.dart';
import 'package:emart_app/widget/button.dart';
import 'package:emart_app/widget/custom_text.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(Authcontroller());

  final _formKey = GlobalKey<FormState>(); // <-- form key

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
              "Sign up".text.fontFamily(bold).black.size(18).make(),
              5.heightBox,
              Obx(
                () => Form(
                  key: _formKey, // <-- attach form key
                  child: Column(
                    children: [
                      customtextField(
                        hint: namehint,
                        title: name,
                        controller: controller.nameController,
                        isPass: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Name is required';
                          } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                            return 'Only alphabets allowed';
                          }
                          return null;
                        },
                      ),
                      customtextField(
                        hint: emailhint,
                        title: email,
                        controller: controller.emailController,
                        isPass: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email is required';
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      customtextField(
                        hint: passwordhint,
                        title: password,
                        controller: controller.passwordsController,
                        isPass: true,
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
                        title: repassword,
                        controller: controller.rePasswordsController,
                        isPass: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please re-enter password';
                          } else if (value != controller.passwordsController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      5.heightBox,
                      Row(
                        children: [
                          Checkbox(
                            checkColor: bluecolor,
                            value: isCheck,
                            onChanged: (newvalue) {
                              setState(() {
                                isCheck = newvalue;
                              });
                            },
                          ),
                          10.widthBox,
                          Expanded(
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                      text: "i agree to the ",
                                      style: TextStyle(
                                          fontFamily: regular, color: bluecolor)),
                                  TextSpan(
                                      text: termcond,
                                      style: TextStyle(
                                          fontFamily: regular, color: bluecolor)),
                                  TextSpan(
                                      text: " & ",
                                      style: TextStyle(
                                          fontFamily: regular, color: lightgolden)),
                                  TextSpan(
                                      text: privacypolicy,
                                      style: TextStyle(
                                          fontFamily: regular, color: bluecolor)),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      5.heightBox,
                      controller.isloading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(bluecolor),
                            )
                          : ourbutton(
                              color: isCheck == true ? bluecolor : lightGrey,
                              title: signup,
                              textcolor:Colors.black,
                              onpress: () async {
                                if (isCheck != false) {
                                  if (_formKey.currentState!.validate()) {
                                    controller.isloading(true);
                                    try {
                                      await controller.signupMethod(context: context)
                                          .then((value) {
                                        return controller.storeUserData();
                                      }).then((value) {
                                       Get.snackbar(
                                      "Success",                      // Title
                                      "Login successful!",            // Message
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: bluecolor,
                                      colorText: Colors.white,
                                      duration: const Duration(seconds: 2),
                                    );
                                        Get.offAll(() => const Home());
                                      });
                                    } catch (e) {
                                      auth.signOut();
                                      VxToast.show(context, msg: e.toString());
                                      controller.isloading(false);
                                    }
                                  }
                                } else {
                                  VxToast.show(context,
                                      msg: "Please agree to terms & conditions");
                                }
                              },
                            ).box.width(context.screenWidth - 50).make(),
                      10.heightBox,
                      accountwith.text.color(bluecolor).make(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: lightGrey,
                              radius: 25,
                              child: Image.asset(
                                socialiconlist[index],
                                width: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          alreadyaccount.text.color(bluecolor).make(),
                          login.text.color(lightgolden).make().onTap(() {
                            Get.back();
                          }),
                        ],
                      )
                    ],
                  )
                      .box
                      .transparent
                      .rounded
                      .width(context.screenWidth - 70)
                      .shadowSm
                      .padding(const EdgeInsets.all(12))
                      .make(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}







// import 'package:emart_app/consts/consts.dart';
// import 'package:emart_app/consts/list.dart';
// import 'package:emart_app/controller/authcontroller.dart';
// import 'package:emart_app/screens/homescreen/home.dart';
// import 'package:emart_app/widget/applogowid.dart';
// import 'package:emart_app/widget/bgwidget.dart';
// import 'package:emart_app/widget/button.dart';
// import 'package:emart_app/widget/custom_text.dart';
// import 'package:get/get.dart';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> 


// {

// bool? isCheck = false;
// var controller  = Get.put(Authcontroller());

// // text controller

// var nameController = TextEditingController();
// var emailController = TextEditingController();
// var passwordscontroller = TextEditingController();
// var passwordREtyeController = TextEditingController();


//   @override
//   Widget build(BuildContext context) {
//     return bgwidget(child: Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Center(
//         child: Column(
//           children: [
//             (context.screenHeight * 0.1).heightBox,
//             applogowidget() ,
//             "Sign up ".text.fontFamily(bold).black.size(18).make(),
//             5.heightBox,
//             Obx(() =>
//               Column( 
//                 children: [
//                   customtextField(hint: namehint,title: name ,controller: nameController ,isPass: false),
//                   customtextField(hint: emailhint,title: email , controller: emailController, isPass: false),
//                   customtextField(hint: passwordhint,title: password , controller: passwordscontroller, isPass: true),
//                   customtextField(hint: passwordhint, title: repassword ,controller: passwordREtyeController,isPass: true),
                  
                 
                   
//                     5.heightBox,
              
//                     Row(
//                       children: [
//                         Checkbox(
                          
//                           checkColor: bluecolor,
//                           value: isCheck , onChanged: (newvalue){
//                             setState(() {
//                               isCheck = newvalue;
//                             });
//                           }
//                         ),
//                         10.widthBox,
//                         Expanded(
//                           child: RichText(text: const TextSpan(
//                             children :[
//                               TextSpan(
//                               text: "i agree to the ",style: TextStyle(
//                                 fontFamily: regular,
//                                 color: bluecolor
//                               )),
//                                   TextSpan(
//                               text: termcond,style: TextStyle(
//                                 fontFamily: regular,
//                                 color: bluecolor
//                               )),
//                                   TextSpan(
//                               text: " & ",style: TextStyle(
//                                 fontFamily: regular,
//                                 color: lightgolden
//                               )),
//                                   TextSpan(
//                               text: privacypolicy,style: TextStyle(
//                                 fontFamily: regular,
//                                 color: bluecolor
//                               ))
                          
//                             ],
//                           )),
//                         )
//                       ],
//                     ),
              
                      
//                     5.heightBox,
//                    controller.isloading.value? const CircularProgressIndicator(
//                         valueColor: AlwaysStoppedAnimation(bluecolor),
//                         ):
//                     ourbutton(color:isCheck== true? bluecolor: lightGrey,title: signup,textcolor: whiteColor,onpress: ()
//                     async{
//                       if (isCheck != false) {

//                         controller.isloading(true);
//                               try {
//                                 await controller.signupMethod(context: context, email: emailController.text, password: passwordscontroller.text).then((
//                                   value){
//                                     return controller.storeUserData(
//                                   email: emailController.text, password: passwordscontroller.text,name: nameController.text
//                                 );
//                                 }).then((value){
//                                   VxToast.show(context, msg: loggedin );
//                                   Get.offAll(() => const Home());
//                                 });
//                               } catch (e) {
//                                 auth.signOut();
//                                   VxToast.show(context, msg: e.toString());
//                                   controller.isloading(false);
//                               }                  
//                       }
//                     },
//                     ).box.width(context.screenWidth  -50).make(),
              
//                      10.heightBox,
//                      accountwith.text.color(bluecolor).make(),
              
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children:List.generate(3,(index) => Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: CircleAvatar(
//                           backgroundColor: lightGrey,
//                           radius: 25,
//                           child: Image.asset(socialiconlist[index],
//                           width: 30,),
//                         ),
//                       )),
//                     ),
              
              
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           alreadyaccount.text.color(bluecolor).make(),
//                           login.text.color(lightgolden).make().onTap((){
//                             Get.back();
//                           }),
//                         ],
//                     )
//                 ],
              
              
//               ).box.transparent.rounded.width(context.screenWidth - 70).shadowSm.padding( const EdgeInsets.all(12)).make(),
//             )



//           ],
//         ),
//       ),
//     ));
//   }
// }