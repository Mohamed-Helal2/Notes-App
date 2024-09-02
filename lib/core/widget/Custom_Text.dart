import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';

class Custom_Text extends StatelessWidget {
  final String text;
  final double fontsize;
  final Color fontcolor;
  final FontWeight fontWeight;
  // final String googlefont;
  final int? maxlines;
  Custom_Text(
      {super.key,
      required this.text,
      required this.fontsize,
      required this.fontcolor,
      required this.fontWeight,
      // required this.googlefont,
      this.maxlines});

  @override
  Widget build(BuildContext context) {
    return Text(
        //softWrap: true,
        maxLines: maxlines ?? 1,
        text,
        style: TextStyle(
            fontSize: fontsize.sp,
            color: fontcolor,
            fontWeight: fontWeight,
            overflow: TextOverflow.ellipsis,
            fontFamily: "PTSerif"));
    // GoogleFonts.getFont(googlefont).copyWith(
    //     fontSize: fontsize.sp, color: fontcolor, fontWeight: fontWeight),
  }
}
