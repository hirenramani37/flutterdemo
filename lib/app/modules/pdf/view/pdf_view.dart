import 'dart:io';

import 'package:customer/app/constant/LocalColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfView extends StatefulWidget {
  const PdfView({Key? key}) : super(key: key);

  @override
  _PdfViewState createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  dynamic arguments = Get.arguments;

  String path = "";

  @override
  void initState() {
    super.initState();
    if (arguments != null && arguments is Map<String, dynamic>) {
      if (arguments.containsKey('path')) {
        path = arguments['path'];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: themeColor,
        title: const Text("Document"),
      ),
      body: SafeArea(
        child: Container(
          child: SfPdfViewer.file(File(path)),
        ),
      ),
    );
  }
}
