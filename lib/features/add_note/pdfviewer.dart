import 'dart:io';

import 'package:flutter/material.dart';
import 'package:note/core/widget/Custom_Text.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class pdfviewer extends StatelessWidget {
  final String pdftitle;
  const pdfviewer({super.key, required this.path, required this.pdftitle});
  final String path;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Custom_Text(
              text: pdftitle,
              fontsize: 20,
              fontcolor: const Color(0xff4C0E03),
              fontWeight: FontWeight.w600,
              ),
        ),
        body: SfPdfViewer.file(File(path)));
  }
}
