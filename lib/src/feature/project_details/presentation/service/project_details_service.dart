import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saf/saf.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:http/http.dart' as http;



abstract class _ViewModel {
  void forceClose();
  void showWarning(String msg);

  void showSuccess(String msg);
}

mixin ProjectDetailsScreenService<T extends StatefulWidget> on State<T>
implements _ViewModel {
  VoidCallback? onFileCached;
  int _readingTime = 0;
  Timer? _timer;

  late _ViewModel _view;

/*  final NoteUseCase _noteUseCase = NoteUseCase(
      noteRepository:
      NoteRepositoryImp(noteRemoteDataSource: NoteRemoteDataSourceImp()));

  final BookUseCase _bookUseCase = BookUseCase(
      bookRepository:
      BookRepositoryImp(bookRemoteDataSource: BookRemoteDataSourceImp()));

  Future<ResponseEntity> createNotes(NoteDataEntity noteDataEntity) async {
    return _noteUseCase.createNotesUseCase(noteDataEntity);
  }

  Future<ResponseEntity> userBookDownloadCountAction(int bookId) async {
    return _bookUseCase.userBookDownloadCountActionUseCase(bookId);
  }*/

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
    WakelockPlus.enable();
    super.initState();
  }

  @override
  void dispose() {
    WakelockPlus.disable();

    ///Cancel timer
    _timer?.cancel();

    ///Close streams
    _pageStateStreamController.close();
    _loadingProgressStreamController.close();
    _loadingSizeStreamController.close();
    super.dispose();
  }


  final StreamController<PageState> _pageStateStreamController =
  StreamController.broadcast();
  Stream<PageState> get pageStateStream => _pageStateStreamController.stream;
  Sink<PageState>? get _pageStateSink => !_pageStateStreamController.isClosed
      ? _pageStateStreamController.sink
      : null;

  final StreamController<String> _loadingProgressStreamController =
  StreamController.broadcast();
  Stream<String> get loadingProgressStream =>
      _loadingProgressStreamController.stream;
  Sink<String>? get _loadingProgressSink =>
      !_loadingProgressStreamController.isClosed
          ? _loadingProgressStreamController.sink
          : null;

  final StreamController<String> _loadingSizeStreamController =
  StreamController.broadcast();
  Stream<String> get loadingSizeStream => _loadingSizeStreamController.stream;
  Sink<String>? get _loadingSizeSink => !_loadingSizeStreamController.isClosed
      ? _loadingSizeStreamController.sink
      : null;

  void loadFile() async {
    // _screenArgs.url = "https://www.orimi.com/pdf-test.pdf";

    _downloadFile('https://bbadb.bacbonltd.net/assets/Leaflet.pdf',
        filename: 'https://bbadb.bacbonltd.net/assets/Leaflet.pdf'
            .substring('https://bbadb.bacbonltd.net/assets/Leaflet.pdf'.lastIndexOf("/") + 1)
            .replaceAll("?", "")
            .replaceAll("=", ""));
  }

  void _downloadFile(String url, {required String filename}) async {
    try {
      var httpClient = http.Client();
      var request = http.Request('GET', Uri.parse(url));
      // request.headers.addAll({"Authorization": "${App.currentSession.tokenType} ${App.currentSession.accessToken}"},);
      var response = httpClient.send(request);
      String dir = (await getTemporaryDirectory()).path;

      List<List<int>> chunks = [];
      int downloaded = 0;

      ///Reset timer
      _timer?.cancel();
      _readingTime = 0;

      response.asStream().listen(
            (http.StreamedResponse r) {
          r.stream.listen(
                (List<int> chunk) {
              chunks.add(chunk);
              downloaded += chunk.length;

              if ((downloaded / r.contentLength! * 100).floor() == 100) {
                _loadingProgressSink?.add('Loading complete');
              } else {
                _loadingProgressSink?.add('Loading..');
              }

              _loadingSizeSink?.add(formatBytes(downloaded, 2));
            },
            onDone: () async {
              /// Save the file
              File file = File('$dir/$filename');

              final Uint8List bytes = Uint8List(r.contentLength!);
              int offset = 0;
              for (List<int> chunk in chunks) {
                bytes.setRange(offset, offset + chunk.length, chunk);
                offset += chunk.length;
              }
              await file.writeAsBytes(bytes);

              ///Get mime type and if it is PDF file then render to ui, otherwise show unknown file preview
              if ((lookupMimeType(filename) ?? "").toLowerCase() ==
                  "application/pdf") {
                ///PDF File loaded to screen
                if (!_pageStateStreamController.isClosed) {
                  _pageStateSink
                      ?.add(PdfLoadedState(file, true));

                  ///Start timer
                  _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
                    _readingTime += 1;
                  });
                }
              } else {
                ///Unknown File loaded to screen
                if (!_pageStateStreamController.isClosed) {
                  _pageStateSink
                      ?.add(UnknownFileLoadedState(file, "Project Details"));
                }
              }

              return;
            },
            onError: _onDownloadFailed,
          );
        },
        onError: _onDownloadFailed,
      );
    } catch (e) {
      _onDownloadFailed("");
    }
  }

  void _onDownloadFailed(dynamic x) {
    if (!_pageStateStreamController.isClosed) {
      _pageStateSink?.add(ErrorState("Download failed!",
          "Something error occurred while downloading your requested file."));
    }
  }

  Future<bool> onGoBack() {
    _view.forceClose();
    // _screenArgs.onReadingEnded?.call(_screenArgs.docId,_readingTime);
    return Future.value(false);
  }


  void onSaveFileToLocalStorage(File file, [bool restartTimer = false]) async {
    if (Platform.isAndroid) {
      await saveFileToAndroidStorage(file: file);
    } else if (Platform.isIOS) {
      await saveFileToiOSStorage(file: file);
    }

    ///Start timer if the file is not pdf file
    if (restartTimer) {
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _readingTime += 1;
      });
    }
  }

  Future<void> saveFileToAndroidStorage({
    required File file,
  }) async {
    try {
      if (((await DeviceInfoPlugin().androidInfo).version.sdkInt ?? 0) < 30) {
        if (!(await Permission.storage.request()).isGranted) {
          _view.showWarning("Storage permission denied!");
          return;
        }
      }
      final Saf _saf = Saf("~/");
      await _saf.clearCache();
      List<String>? persistedDirs;
      bool? isGranted = await _saf.getDirectoryPermission(
          grantWritePermission: true, isDynamic: true);
      if (isGranted != null && isGranted) {
        persistedDirs = await Saf.getPersistedPermissionDirectories();
      } else {
        return;
      }

      persistedDirs?.forEach((path) async {
        var _localStorage = "/storage/emulated";
        var _userIndex = "0";
        await getExternalStorageDirectory().then((d) {
          if (d != null &&
              d.path.toLowerCase().contains("/storage/emulated/")) {
            _userIndex = d.path.substring(18, 19);
          }
        }).catchError((_) {});

        await file
            .copy(
            "$_localStorage/$_userIndex/$path/${file.path.split("/").last}")
            .then((value) {
          _view.showSuccess("File saved successfully!");
        }).catchError((error) async {
          _view.showWarning(
              'Unable to save to this directory! Please select "Documents" directory.');
        });
      });
      await _saf.releasePersistedPermission();
    } catch (_) {}
  }

  Future<void> saveFileToiOSStorage({
    required File file,
  }) async {
    await getApplicationDocumentsDirectory().then((directory) async {
      await Share.shareFilesWithResult([file.path]).then((value) {
        if (value.status == ShareResultStatus.unavailable) {
          _view.showWarning("Unable to save file!");
        }
      }).catchError((error) {
        _view.showWarning("Unable to save file!");
      });
    }).catchError((_) {
      _view.showWarning("Unable to save file!");
    });
  }



}

String formatBytes(int bytes, int decimals) {
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return '${(bytes / pow(1024, i)).toStringAsFixed(i > 1 ? decimals : 0)} ${suffixes[i]}';
}

abstract class PageState {}

class PdfLoadedState extends PageState {
  final File file;
  final bool canDownload;
  PdfLoadedState(this.file, this.canDownload);
}

class UnknownFileLoadedState extends PageState {
  final File file;
  final String title;

  UnknownFileLoadedState(this.file, this.title);
}

class ErrorState extends PageState {
  String message;
  String title;
  ErrorState(this.title, this.message);
}
