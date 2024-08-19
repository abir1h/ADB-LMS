import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:adb_mobile/src/core/routes/app_route_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CertificateViewScreen extends StatefulWidget {
  final Object? arguments;
  const CertificateViewScreen({super.key, this.arguments});


  @override
  _CertificateViewScreenState createState() => _CertificateViewScreenState();
}

class _CertificateViewScreenState extends State<CertificateViewScreen> {
  String? localPath;
  CertificateViewScreenArgs? certificateViewScreenArgs;

  @override
  void initState() {
    super.initState();

    _loadPdfFromBytes();
  }

  Future<void> _loadPdfFromBytes() async {
    try {
      certificateViewScreenArgs=widget.arguments as CertificateViewScreenArgs;
      Uint8List bytes = base64Decode(certificateViewScreenArgs!.data);
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = '${tempDir.path}/temp_pdf.pdf';
      File tempFile = File(tempPath);
      await tempFile.writeAsBytes(bytes, flush: true);
      setState(() {
        localPath = tempPath;
      });
    } catch (e) {
      print('Error loading PDF: $e');
    }
  }

/*  Future<void> _downloadPdf() async {
    if (await Permission.storage.request().isGranted) {
      Uint8List bytes = base64Decode(widget.pdfBytes);

      Directory? directory = await getExternalStorageDirectory();
      String downloadsPath = '${directory?.path}/downloaded_pdf.pdf';
      File downloadFile = File(downloadsPath);
      await downloadFile.writeAsBytes(bytes, flush: true);

      await FlutterFileSaver.saveFile('downloaded_pdf.pdf', bytes, 'application/pdf');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF downloaded to $downloadsPath')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission not granted')),
      );
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
        actions: [
        /*  IconButton(
            icon: Icon(Icons.download),
            onPressed: _downloadPdf,
          ),*/
        ],
      ),
      body: localPath != null
          ? PDFView(
        filePath: localPath,
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
