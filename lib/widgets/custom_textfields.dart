import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customTextfields(String hintText,TextEditingController? controller, TextInputType? keyboardType){
  return TextField(
    keyboardType: keyboardType,
    controller: controller,
    decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black,fontFamily: 'Poppins',fontWeight: FontWeight.w500),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.white),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 12)
    ),
    style: const TextStyle(color: Colors.black),
  );
}
Widget mediumSpacing(BuildContext context,double height){
  return SizedBox(
    height: MediaQuery.of(context).size.height*height,
  );
}