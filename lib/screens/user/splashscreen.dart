import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/screens/auth/login_screen.dart';
import 'package:emart_app/screens/homescreen/home.dart';
import 'package:emart_app/widget/applogowid.dart';
import 'package:emart_app/widget/bgwidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  // create a method to change screen 
  changeScreen(){
    Future.delayed(const Duration(seconds:3),(){
      // using get x
      // Get.to(()=>const LoginScreen());  

      auth.authStateChanges().listen((User? user ){
      if (user == null && mounted) {
        Get.to(() => const LoginScreen());
      }else{
        Get.to(() => const Home()); 
      }
      });


    });
  }

  @override
  void initState() {
    // TODO: implement initState
    changeScreen();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return bgwidget(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
            Align
            
            (alignment: Alignment.topLeft, child: Image.asset(icSplashBg,width: 220)),
            20.heightBox,
            applogowidget(),
            5.heightBox,
            appversion.text.black.make(),
      
            ],
          ),
        ),
      ),
    );
  }
}