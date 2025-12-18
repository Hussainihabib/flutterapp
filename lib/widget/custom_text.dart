import 'package:flutter/services.dart'; // <-- for inputFormatters
import 'package:emart_app/consts/consts.dart';

Widget customtextField({
  required String hint,
  required String title,
  required TextEditingController controller,
  required bool isPass,
  FormFieldValidator<String>? validator, // <-- already added
  TextInputType? keyboardType,           // <-- new
  List<TextInputFormatter>? inputFormatters, // <-- new
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title.text.color(bluecolor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        controller: controller,
        obscureText: isPass,
        validator: validator,
        keyboardType: keyboardType,                  // <-- added
        inputFormatters: inputFormatters,            // <-- added
        decoration: InputDecoration(
          hintText: hint,
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: bluecolor),
          ),
        ),
      ),
      5.heightBox,
    ],
  );
}
