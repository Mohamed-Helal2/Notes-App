import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Custom_TextField extends StatelessWidget {
  Widget? LLabel;
  TextEditingController? controllerl;
  int? max_lines;
  String? Function(String?)? validator;
  Color? textcolor;
  Color? border_color;
  Widget? SSuffixIcon;
  String? HHintText;
  Color? HHintColor;
  double? HHintSize;
  Function(String)? onChanges;
  void Function(String)? onFieldSubmitted;
  InputBorder? border;
  final double fontsize;
  final Color fontcolor;
  final FontWeight fontWeight;
  Custom_TextField({
    super.key,
    this.LLabel,
    this.controllerl,
    this.validator,
    this.textcolor,
    this.onChanges,
    this.border_color,
    this.SSuffixIcon,
    this.HHintText,
    this.HHintColor,
    this.HHintSize,
    this.onFieldSubmitted,
    this.max_lines,
    this.border,
    required this.fontsize,
    required this.fontcolor,
    required this.fontWeight,
  });

  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: max_lines,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanges,
      controller: controllerl,
      validator: validator,
      style: TextStyle(
          fontSize: fontsize.sp,
          color: fontcolor,
          fontWeight: fontWeight,
          fontFamily: 'PTSerif'),
      decoration: InputDecoration(
        hintText: HHintText,
        hintStyle: TextStyle(
          color: HHintColor,
        ),
        suffixIcon: SSuffixIcon,
        label: LLabel,
        labelStyle: TextStyle(color: Colors.white, fontSize: 15),
        border: border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 5, color: Colors.white),
            ),
      ),
    );
  }
}
