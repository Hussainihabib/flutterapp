import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

class Homecontroller extends GetxController{

    @override
  void onInit() {
    getusername();
    super.onInit();
  }

    var currentnavindex =0.obs;

    var username = '';
    var SearchController = TextEditingController();

    getusername() async {
      var n = await  firestore.collection(usercollection).where('id', isEqualTo: currentUser!.uid).get().then((value){
        if (value.docs.isNotEmpty) {
          return value.docs.single['name'];
        }
      });

            username = n ;
        print(username);
    }

}