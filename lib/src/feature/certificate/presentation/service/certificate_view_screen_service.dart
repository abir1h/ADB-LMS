import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/routes/app_route_args.dart';

abstract class _ViewModel {
  void showWarning(String msg);
  void showSuccess(String msg);
}

mixin CertificateViewScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;
  CertificateViewScreenArgs? certificateViewScreenArgs;
  String? localPath;

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadPdfFromBytes(String data) {
    try {
      Uint8List bytes = base64Decode(data);
      getTemporaryDirectory().then((tempDir) {
        String tempPath = '${tempDir.path}/certificate.pdf';
        File tempFile = File(tempPath);
        tempFile.writeAsBytes(bytes, flush: true);
        setState(() {
          localPath = tempPath;
        });
      });
    } catch (e) {
      print('Error loading PDF: $e');
    }
  }

  Future<void> downloadFile(
      {required String filename,
      required BuildContext context,
      required Uint8List bytes}) async {
    if (Platform.isIOS) {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        // Proceed with the file download
        downloadFileAction(filename: filename, context: context, bytes: bytes);
      } else {
        // Permission denied
        _view.showSuccess('Storage permission denied');
      }
    } else {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;

      if (deviceInfo.version.sdkInt > 32) {
        var status = await Permission.manageExternalStorage.request();
        if (status.isGranted) {
          // Proceed with the file download
          downloadFileAction(
              filename: filename, context: context, bytes: bytes);
        } else {
          // Permission denied
          _view.showSuccess('Storage permission denied');
        }
      } else {
        var status = await Permission.storage.request();
        if (status.isGranted) {
          // Proceed with the file download
          downloadFileAction(
              filename: filename, context: context, bytes: bytes);
        } else {
          // Permission denied
          _view.showSuccess('Storage permission denied');
        }
      }
    }
  }

  Future<void> downloadFileAction(
      {required String filename,
      required BuildContext context,
      required Uint8List bytes}) async {
    try {
      Directory? downloadDirectory;

      if (Platform.isIOS) {
        downloadDirectory = await getApplicationDocumentsDirectory();

        await getApplicationDocumentsDirectory().then((directory) async {
          await Share.shareFilesWithResult([localPath!]).then((value) {
            if (value.status == ShareResultStatus.unavailable) {
              _view.showWarning("Unable to save file!");
            }
          }).catchError((error) {
            _view.showWarning("Unable to save file!");
          });
        }).catchError((_) {
          _view.showWarning("Unable to save file!");
        });
      } else {
        downloadDirectory = Directory('/storage/emulated/0/Download');
        if (!await downloadDirectory.exists()) {
          downloadDirectory = (await getExternalStorageDirectory());
        }
        String filePathName = "${downloadDirectory?.path}/$filename";
        File savedFile = File(filePathName);
        bool fileExists = await savedFile.exists();

        if (fileExists && context.mounted) {
          _view.showWarning("File already downloaded");
        } else {
          savedFile.writeAsBytes(bytes);
          _view.showSuccess("File downloaded successfully");
        }
      }
    } catch (error) {
      _view.showSuccess("Some error occurred -> $error");
    }
  }
}
