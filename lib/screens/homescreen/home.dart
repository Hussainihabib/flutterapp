import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/homecontroller.dart';
import 'package:emart_app/screens/accountscreen/profilescreen.dart';
import 'package:emart_app/screens/cartscreen/cartscreen.dart';
import 'package:emart_app/screens/categoryscreen/categoryscreen.dart';
import 'package:emart_app/screens/homescreen/homescreen.dart';
import 'package:emart_app/widget/exitdiolog.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // init home controller 
     var controller = Get.put(Homecontroller());



    var navbaritem =[
      BottomNavigationBarItem(icon: Image.asset(icHome,width: 26,), label: home),
      BottomNavigationBarItem(icon: Image.asset(icCategories,width: 26,), label: categories),
      BottomNavigationBarItem(icon: Image.asset(icCart,width: 26,), label: cart),
      BottomNavigationBarItem(icon: Image.asset(icProfile,width: 26,), label: profile),

    ];

    var navbody =[
     const Homescreen(),
     const Categoryscreen(),
     const Cartscreen(),
     const Profilescreen(),


    ] ;

    return WillPopScope(
      onWillPop: () async{
        showDialog(
          barrierDismissible: false,
          context: context, builder: (context) => exitDialog(context));
        return false;
      },

      child: Scaffold(
        body: Column(
          children: [
            Obx(()=> Expanded(child: navbody.elementAt(controller.currentnavindex.value))),
          ],
        ),
        bottomNavigationBar: Obx(
         ()=> BottomNavigationBar(
          currentIndex: controller.currentnavindex.value,
            selectedItemColor: bluecolor,
            selectedLabelStyle: const TextStyle(fontFamily:semibold),
            type: BottomNavigationBarType.fixed ,
            backgroundColor: whiteColor,
            items: navbaritem,
            onTap: (value){
              controller.currentnavindex.value = value  ;
            },
            
            
            ),
        ),
      ),
    );
  }
}