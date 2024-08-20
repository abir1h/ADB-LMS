import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/common_imports.dart';
import '../../domain/entities/certificate_data_entity.dart';
import '../service/certificate_screen_service.dart';
import '../widgets/name_change_bottom_sheet.dart';

class CertificateListScreen extends StatefulWidget {
  const CertificateListScreen({super.key});

  @override
  State<CertificateListScreen> createState() => _CertificateListScreenState();
}

class _CertificateListScreenState extends State<CertificateListScreen>
    with AppTheme, CertificateListScreenService {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: clr.appPrimaryColorBlue,
            )),
        title: Text(
          "সার্টিফিকেশন",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: size.textSmall,
              color: clr.appPrimaryColorBlue),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return NameChangeButtomSheet(
                      context2: context,
                    );
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.w10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: clr.appPrimaryColorBlue,
                ),
                child: Center(
                  child: Text(
                    " নাম পরিবর্তন করুন ",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: clr.whiteColor,
                        fontSize: size.textXXSmall),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
        physics: const BouncingScrollPhysics(),
        child: AppStreamBuilder<List<CertificateDataEntity>>(
          stream: certificateStreamController.stream,
          loadingBuilder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          dataBuilder: (context, data) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CertificateSectionWidget(
                    items: data,
                    buildItem: (BuildContext context, int index, item) {
                      return CertificateItemWidget(
                          data: item,
                          /* onTap: () => Navigator.of(context).pushNamed(
                            AppRoute.courseOverViewScreen,
                            arguments: CourseDetailsScreenArgs(data: item)),*/
                          onTap: () {
                            downloadCertificate(item.courseId, context);
                          });
                    }),
                SizedBox(
                  height: size.h64 + size.h32,
                ),
              ],
            );
          },
          emptyBuilder: (context, message, icon) => Padding(
              padding: EdgeInsets.all(size.h24),
              child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Lottie.asset(ImageAssets.animEmpty, height: size.h64 * 3),
                  SizedBox(height: size.h8),
                  Text(
                    message,
                    style: TextStyle(
                      color: clr.blackColor,
                      fontSize: size.textSmall,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ]),
              )),
        ),
      ),
    );
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }

  @override
  void showSuccess(String message) {
    CustomToasty.of(context).showSuccess(message);
  }
}

class CertificateSectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const CertificateSectionWidget(
      {super.key, required this.items, required this.buildItem});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return buildItem(context, index, items[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: size.h20);
      },
    );
  }
}

class CertificateItemWidget extends StatelessWidget with AppTheme {
  final CertificateDataEntity data;
  final VoidCallback onTap;

  const CertificateItemWidget(
      {super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.w), // Responsive padding
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8.r,
              offset: Offset(0, 4.r),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "প্রশিক্ষণের নাম",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: size.textXXSmall,
                  color: clr.textGrey),
            ),
            Text(
              data.title,
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: size.textSmall),
            ),
            SizedBox(
              height: size.h4,
            ),
            Text(
              "সনদ প্রদানের তারিখ",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: size.textXXSmall,
                  color: clr.textGrey),
            ),
            Text(
              data.date.isEmpty
                  ? "N/A"
                  : DateFormat('dd MMMM yyyy')
                      .format(DateTime.parse(data.date)),
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: size.textSmall),
            ),
            SizedBox(
              height: size.h10,
            ),
            Container(
              width: 1.sw,
              padding:
                  EdgeInsets.symmetric(horizontal: size.w10, vertical: size.h4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: clr.appPrimaryColorBlue,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    data.date.isEmpty
                        ? FontAwesomeIcons.award
                        : FontAwesomeIcons.download,
                    color: clr.whiteColor,
                    size: size.r16,
                  ),
                  SizedBox(
                    width: size.w6,
                  ),
                  Text(
                    data.date.isEmpty
                        ? " সার্টিফিকেট প্রস্তুত করুন "
                        : " সার্টিফিকেট ডাউনলোড করুন ",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: clr.whiteColor,
                        fontSize: size.textSmall),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
