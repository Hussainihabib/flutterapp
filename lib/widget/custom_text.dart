import 'package:emart_app/consts/consts.dart';


Widget  customtextField({String? title, String? hint, controller,isPass}){
  return  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(bluecolor).size(16).fontFamily(semibold).make(),
      5.heightBox,
      TextFormField(
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            fontFamily: semibold,
            color: textfieldGrey,

          ),
          hintText: hint,
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border:InputBorder.none,
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color:   bluecolor)),
        ),
      ),
      5.heightBox,
    ],
  );
}
