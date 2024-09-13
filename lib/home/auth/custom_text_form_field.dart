import 'package:flutter/material.dart';
import 'package:todoappp/appcolor.dart';

//typedef MyValidator = String? Function(String?);

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  String label;
  TextInputType keyboardType;
  TextEditingController controller;
  bool obscureText;
  //MyValidator validator;
  String? Function(String?) validator;
  CustomTextFormField(
      {required this.label,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      required this.validator});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: appcolor.primarycolor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: appcolor.primarycolor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: appcolor.primarycolor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: appcolor.redcolor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: appcolor.redcolor),
          ),
          errorMaxLines: 2,
        ),
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: appcolor.blackcolor),
            cursorColor: appcolor.primarycolor,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
      ),
    );
  }
}
/*border: OutlineInputBorder(
borderRadius:
 BorderRadius.circular(15),
 borderSide: BorderSide(
  color: 
  appcolor.primarycolor,
 )*/