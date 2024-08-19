import 'package:adb_mobile/src/feature/notification/domain/entities/notification_data_entity.dart';
import 'package:adb_mobile/src/feature/notification/domain/entities/notification_item_data_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/constants/common_imports.dart';
import '../service/notification_screen_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({
    super.key,
  });

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with AppTheme, NotificationScreenService {
  @override
  void initState() {
    loadNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: clr.appPrimaryColorBlue,
          ),
        ),
        title: Text(
          'আমার নোটিফিকেশন্স',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: clr.appPrimaryColorBlue,
              fontSize: size.textSmall),
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            AppStreamBuilder<NotificationDataEntity>(
              stream: notificationStreamController.stream,
              loadingBuilder: (context) {
                return Center(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 24.w,
                      right: 24.w,
                      top: 24.w,
                      bottom: 24.w,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18.w),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 42.w,
                          width: 42.w,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                              clr.appPrimaryColorBlue,
                            ),
                            strokeWidth: 2.w,
                          ),
                        ),
                        SizedBox(
                          height: 16.w,
                        ),
                        Text(
                          "Please wait..",
                          style: TextStyle(
                            color: clr.appPrimaryColorBlue,
                            fontSize: 20.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
              dataBuilder: (context, data) {
                return NotificationSectionWidget(
                    items: data.records,
                    buildItem: (BuildContext context, int index, item) {
                      return NotificationItemWidget(
                        data: item,
                        onTap: () {},
                      );
                    });
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
          ],
        );
      }),
    );
  }

  @override
  void showWarning(String message) {
    // TODO: implement showWarning
  }
}

class NotificationSectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;

  const NotificationSectionWidget(
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
        return Divider(
          color: clr.greyColor,
        );
      },
    );
  }
}

class NotificationItemWidget<T> extends StatelessWidget with AppTheme {
  final NotificationItemDataEntity data;
  final VoidCallback onTap;

  const NotificationItemWidget(
      {super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  timeago.format(DateTime.parse(data.createdOn),),
                  style: TextStyle(
                      fontSize: size.textXXSmall,
                      color: clr.textGrey,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.comment,
                    color: clr.appPrimaryColorBlue,
                    size: size.r24,
                  ),
                ),
                SizedBox(
                  width: size.w10,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: size.textSmall,
                          color: clr.blackColor),
                    ),
                    Text(
                      data.details,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: size.textXXSmall,
                          color: clr.textGrey),
                    ),


                  ],
                ))
              ],
            ),
            Divider(thickness: 2,color: clr.greyColor.withOpacity(.2),)
          ],
        ));
  }
}
