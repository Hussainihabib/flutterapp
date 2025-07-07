
import 'package:emart_app/widget/bgwidget.dart';
import 'package:get/get.dart';
import 'package:emart_app/controller/profilecontroller.dart';

import '../../consts/consts.dart';
import '../../widget/button.dart';
import '../../widget/custom_text.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;

  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<Profilecontroller>();
    

  controller.nameController.text = data['name'] ?? '';
controller.passController.text = data['password'] ?? '';
controller.profileImageLink.value = data['imageUrl'] ?? '';


    
    

    return bgwidget(
      child: Scaffold(
        appBar: AppBar(       
             title: editprofile.text.white.fontFamily(bold).make(),
),
        body: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                20.heightBox,
                controller.profileImgBytes.value == null
                    ? Image.asset('assets/img/profile.png',
                            width: 100, fit: BoxFit.cover)
                        .box
                        .roundedFull
                        .clip(Clip.antiAlias)
                        .make()
                    : Image.memory(controller.profileImgBytes.value!,
                            width: 100, fit: BoxFit.cover)
                        .box
                        .roundedFull
                        .clip(Clip.antiAlias)
                        .make(),
                10.heightBox,
                ElevatedButton(
                  onPressed: () => controller.pickAndUploadImage(data['id']),
                  child: controller.isUploading.value
                      ? const CircularProgressIndicator()
                      : const Text("Change Image",),
                ),
                 const Divider(),
                  20.heightBox,
                  customtextField(controller: controller.nameController, hint: namehint,title: name, isPass: false),
                  customtextField(controller: controller.passController, hint: passwordhint,title: password, isPass: true),
                SizedBox(
                  width: context.screenWidth - 60,
                  child: ourbutton(
                    color: bluecolor, onpress: () async {
                     await controller.saveProfile(data['id']);


                    },textcolor: whiteColor,title: "Save"),
                ),
                   
            ],
          ).box.shadowSm.transparent.padding(const EdgeInsets.all(16)).margin(const EdgeInsets.only(top: 50,right: 12,left: 12)).rounded.make(),
          ),
        ),
      ),
    );
  }
}
