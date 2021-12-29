import 'package:flutter/material.dart';
import 'package:e_store_space/Utils/styles.dart';
import 'package:e_store_space/settings/color_palates.dart';

class MyTextField extends StatelessWidget {
  TextEditingController controller;
  String label;
  bool obsecureText =false;
  IconButton suffixIcon;
  final ValueChanged<String> onChanged;
  Function onEditingComplete;
  GestureTapCallback onTap;
  bool enabled=true;
  int maxLines;
  String hintText;
  TextInputType keyboardType;
  bool autoFocus;
  double height;
  double width;
  int maxLength;
  int minLines;
  FocusNode focusNode;
  bool phoneNumber=false;
  double fontSize;
  ///Constructor
  MyTextField({
    @required this.controller,
    @required this.label,
    this.obsecureText,
    this.onChanged,
    this.suffixIcon,
    this.onEditingComplete,
    this.enabled,
    this.onTap,
    this.maxLines,
    this.hintText,
    this.keyboardType,
    this.autoFocus,
    this.height,
    this.width,
    this.maxLength,
    this.focusNode,
    this.phoneNumber,
    this.fontSize,
    this.minLines
  });

  @override
  Widget build(BuildContext context) {
    bool _passwordVisible = false;
    return Container(
      height: height??45,
      width: width,
      child: GestureDetector(
        onTap: onTap,
        child: TextField(
          minLines: minLines,
          focusNode: focusNode,
          maxLength: maxLength,
          autofocus: autoFocus??false,
          keyboardType: keyboardType,
          maxLines: maxLines??1,
          enabled: enabled,
          onTap: onTap,
          onEditingComplete: onEditingComplete,
          onChanged:onChanged,
          controller: controller,
          obscureText: obsecureText??false,
          cursorColor: ColorPalette.orange,
          style: phoneNumber??false ? Styles.phoneNumberTextStyle() : Styles.textFieldTextStyle().copyWith(fontSize: fontSize??15),
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            fillColor: ColorPalette.orange,
              focusColor: ColorPalette.orange,
              hoverColor: ColorPalette.orange,
              labelText: label,
              hintStyle: const TextStyle(
                color: Colors.black54,
                fontSize: 12
              ),
              labelStyle: const TextStyle(
                color: Colors.black,
                fontSize: 16
              ),
              disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorPalette.orange
                  )
              ),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorPalette.orange
                  )
              ),
              focusedBorder:  const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorPalette.orange
                  )
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorPalette.orange
                )
              ),
              // hintText: label,
          ),
        ),
      ),
    );
  }
}
