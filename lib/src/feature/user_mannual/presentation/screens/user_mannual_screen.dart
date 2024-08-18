import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';

import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../project_details/presentation/widgets/animated_fab_button.dart';
import '../service/user_mannual_screen_service.dart';

class UserMannualScreen extends StatefulWidget {
  @override
  State<UserMannualScreen> createState() => _UserMannualScreenState();
}

class _UserMannualScreenState extends State<UserMannualScreen>
    with AppTheme, UserMannualScreenScreenService {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  final StreamController<int> _totalPage = StreamController.broadcast();
  final StreamController<int> _currentPage = StreamController.broadcast();
  final StreamController<bool> _timerActivationStream =
  StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadFile("https://bbadb.bacbonltd.net/assets/TraineeManual.pdf");
    });
  }

  @override
  void dispose() {
    _totalPage.close();
    _currentPage.close();
    _timerActivationStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: clr.appPrimaryColorBlue,
            )),
        title: Text("প্রজেক্ট সম্পর্কে বিস্তারিত",style: TextStyle(fontWeight: FontWeight.w600,fontSize: size.textSmall,color: clr.appPrimaryColorBlue),),
        actions: [
          PageNumberShowWidget(
            currentPageStream: _currentPage.stream,
            totalPageStream: _totalPage.stream,
          ),
        ],
      ),
      body: StreamBuilder<PageState>(
        stream: pageStateStream,
        initialData: null,
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (data is PdfLoadedState) {
            return Stack(
              fit: StackFit.expand,
              children: [
                ///PDF viewer
                SfPdfViewer.file(
                  data.file,
                  key: _pdfViewerKey,
                  canShowPaginationDialog: false,
                  onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                    _totalPage.sink.add(details.document.pages.count);
                    _timerActivationStream.sink.add(true);
                  },
                  onPageChanged: (PdfPageChangedDetails changed) {
                    _currentPage.sink.add(changed.newPageNumber);
                  },
                ),

                ///Download button
                // if (data.canDownload)
                //   Align(
                //     alignment: Alignment.bottomRight,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.end,
                //       children: [
                //         GestureDetector(
                //           onTap: () {
                //             showCupertinoModalPopup(
                //                 context: context,
                //                 builder: (context) => NoteBottomSheet(
                //                       noteDataEntity: NoteDataEntity(
                //                         bookId: (widget.arguments!
                //                                 as BookViewerScreenArgs)
                //                             .bookId,
                //                         emisUserId: 1,
                //                         note: '',
                //                       ),
                //                     ));
                //           },
                //           child: Container(
                //             padding: EdgeInsets.all(size.h8),
                //             margin: EdgeInsets.only(
                //                 right: size.h16, bottom: size.h16),
                //             decoration: BoxDecoration(
                //               shape: BoxShape.circle,
                //               color: clr.appPrimaryColorBlack,
                //               boxShadow: [
                //                 BoxShadow(
                //                   color: clr.appPrimaryColorBlack.withOpacity(.5),
                //                   blurRadius: size.h12,
                //                 )
                //               ],
                //             ),
                //             child: FittedBox(
                //               child: Icon(
                //                 Icons.note,
                //                 color: clr.whiteColor,
                //               ),
                //             ),
                //           ),
                //         ),
                //         GestureDetector(
                //           onTap: () => onSaveFileToLocalStorage(data.file),
                //           child: Container(
                //             padding: EdgeInsets.all(size.h8),
                //             margin: EdgeInsets.only(
                //                 right: size.h16, bottom: size.h16),
                //             decoration: BoxDecoration(
                //               shape: BoxShape.circle,
                //               color: clr.appPrimaryColorBlack,
                //               boxShadow: [
                //                 BoxShadow(
                //                   color: clr.appPrimaryColorBlack.withOpacity(.5),
                //                   blurRadius: size.h12,
                //                 )
                //               ],
                //             ),
                //             child: FittedBox(
                //               child: Icon(
                //                 Icons.download_rounded,
                //                 color: clr.whiteColor,
                //               ),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: AnimatedFabButton(
                      isDownload: true,
                      onPressed: (e) {
                        if (e == "download") {
                          //onUserBookDownloadCountAction((widget.arguments! as BookViewerScreenArgs).bookId);
                          onSaveFileToLocalStorage(data.file);
                        } else {}
                      },
                      tooltip: "Filters",
                    ),
                  ),
                ),
              ],
            );
          }
          if (data is UnknownFileLoadedState) {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.h32),
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 0.8,
                        child: LayoutBuilder(builder: (context, constraints) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ///TODO
                              // Image.asset(
                              //   AppConstant.getAssetFileIcon(data.file.path),
                              //   height: min(constraints.maxWidth * 0.5, constraints.maxHeight * 0.5),
                              //   width: min(constraints.maxWidth * 0.5, constraints.maxHeight * 0.5),
                              // ),
                              SizedBox(
                                height: size.h16,
                              ),
                              Text(
                                data.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: clr.textColorBlack,
                                  fontSize: size.textXMedium,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: size.h64),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.h24, vertical: size.h24),
                  child: ButtonWidget(
                    title: "Download",
                    expanded: true,
                    onTap: () => onSaveFileToLocalStorage(data.file, true),
                  ),
                ),
              ],
            );
          }
          if (data is ErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: clr.textColorBlack,
                      fontSize: size.textXMedium,
                    ),
                  ),
                  SizedBox(
                    height: size.h24,
                  ),
                  Text(
                    data.message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: clr.textColorBlack,
                      fontSize: size.textMedium,
                    ),
                  )
                ],
              ),
            );
          } else {
            return LoadingProgressView(
              service: this,
            );
          }
        },
      ),
    );
  }

  @override
  void forceClose() {
    Navigator.of(context).pop();
  }

  @override
  void showWarning(String msg) {
    CustomToasty.of(context).showWarning(msg);
  }

  @override
  void showSuccess(String msg) {
    CustomToasty.of(context).showSuccess(msg);
  }
}

class LoadingProgressView extends StatelessWidget with AppTheme {
  final UserMannualScreenScreenService service;
  const LoadingProgressView({Key? key, required this.service})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: size.h42 * 2,
                width: size.h42 * 2,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(clr.blackColor),
                ),
              ),
              StreamBuilder<String>(
                stream: service.loadingProgressStream,
                initialData: "Loading...",
                builder: (context, snapshot) {
                  return Padding(
                    padding: EdgeInsets.only(top: size.h16),
                    child: Text(
                      snapshot.data!,
                      style: TextStyle(
                        fontSize: size.textMedium,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: size.h16, left: size.h42, right: size.h42),
                child: StreamBuilder<String>(
                  stream: service.loadingSizeStream,
                  initialData: "0 Byte",
                  builder: (context, snapshot) {
                    var state = snapshot.data;
                    return Text(
                      state!,
                      style: TextStyle(
                        fontSize: size.textSmall,
                        color: clr.textColorBlack,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PageNumberShowWidget extends StatefulWidget {
  final Stream<int> totalPageStream;
  final Stream<int> currentPageStream;
  const PageNumberShowWidget(
      {Key? key,
        required this.totalPageStream,
        required this.currentPageStream})
      : super(key: key);

  @override
  _PageNumberShowWidgetState createState() => _PageNumberShowWidgetState();
}

class _PageNumberShowWidgetState extends State<PageNumberShowWidget>
    with AppTheme {
  StreamSubscription<int>? _subscriptionTotalPage;
  StreamSubscription<int>? _subscriptionCurrentPage;

  int _totalPage = 0;
  int _currentPage = 1;

  @override
  void initState() {
    _subscriptionTotalPage =
        widget.totalPageStream.listen(_onDataUpdateTotalPage);
    _subscriptionCurrentPage =
        widget.currentPageStream.listen(_onDataUpdateCurrentPage);
    super.initState();
  }

  @override
  void dispose() {
    _subscriptionCurrentPage?.cancel();
    _subscriptionTotalPage?.cancel();
    super.dispose();
  }

  void _onDataUpdateTotalPage(int totalPage) {
    setState(() {
      _totalPage = totalPage;
    });
  }

  void _onDataUpdateCurrentPage(int currentPage) {
    setState(() {
      _currentPage = currentPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _totalPage != 0
        ? Container(
      padding:
      EdgeInsets.symmetric(horizontal: size.h8, vertical: size.h4),
      decoration: BoxDecoration(
          color: clr.blackColor.withOpacity(.7),
          borderRadius: BorderRadius.all(Radius.circular(size.h4))),
      child: Row(
        children: [
          Text(
            '${_currentPage.toString()}/${_totalPage.toString()}',
            style: TextStyle(
                color: clr.whiteColor, fontSize: size.textSmall),
          ),
        ],
      ),
    )
        : const Offstage();
  }
}

class ButtonWidget extends StatelessWidget with AppTheme {
  final VoidCallback onTap;
  final String title;
  final bool expanded;
  const ButtonWidget(
      {Key? key,
        required this.title,
        required this.onTap,
        this.expanded = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          onTap.call();
        },
        child: Container(
          padding:
          EdgeInsets.symmetric(horizontal: size.h32, vertical: size.h4),
          height: size.w44,
          width: expanded ? double.maxFinite : null,
          decoration: BoxDecoration(
            color: clr.blackColor,
            borderRadius: BorderRadius.circular(size.h12),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: size.textMedium,
                color: clr.whiteColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
