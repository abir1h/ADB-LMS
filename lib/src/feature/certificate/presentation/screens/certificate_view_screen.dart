import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/routes/app_route_args.dart';
import '../service/certificate_view_screen_service.dart';

class CertificateViewScreen extends StatefulWidget {
  final Object? arguments;
  const CertificateViewScreen({super.key, this.arguments});

  @override
  _CertificateViewScreenState createState() => _CertificateViewScreenState();
}

class _CertificateViewScreenState extends State<CertificateViewScreen>  with CertificateViewScreenService{

  @override
  void initState() {
    super.initState();
    certificateViewScreenArgs = widget.arguments as CertificateViewScreenArgs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadPdfFromBytes(certificateViewScreenArgs!.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('সার্টিফিকেশন'),
        actions: [
          IconButton(
            icon: FaIcon(FontAwesomeIcons.download, size: 22.r),
            onPressed: () => downloadFile(
                filename: "certificate${Random().nextInt(100)}.pdf",
                // filename: "certificate.pdf",
                bytes: base64Decode(certificateViewScreenArgs!.data),
                context: context),
          ),
        ],
      ),
      body: localPath != null
          ? PDFView(
              filePath: localPath,
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  @override
  void showSuccess(String msg) {
    CustomToasty.of(context).showSuccess(msg);
  }

  @override
  void showWarning(String msg) {
    CustomToasty.of(context).showWarning(msg);
  }
}
