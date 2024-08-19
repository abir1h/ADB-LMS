import 'package:adb_mobile/src/core/constants/app_theme.dart';
import 'package:adb_mobile/src/feature/course/domain/entities/course_overview_data_entity.dart';
import 'package:adb_mobile/src/feature/faq/domain/entities/faq_data_entity.dart';
import 'package:adb_mobile/src/feature/faq/presentation/service/faq_screen_service.dart';
import 'package:adb_mobile/src/feature/notification/domain/entities/notification_item_data_entity.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/constants/common_imports.dart';
import '../service/notification_screen_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key,});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with AppTheme, NotificationScreenService {
  @override
  void initState() {
    loadNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          AppStreamBuilder<List<NotificationItemDataEntity>>(
            stream: notificationStreamController.stream,
            loadingBuilder: (context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            dataBuilder: (context, data) {
              return NotificationSectionWidget(
                  items: data,
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
    });
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
  const NotificationItemWidget({super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Row(
          children: [
            Container(
              width: size.w6,
              decoration: BoxDecoration(
                color: clr.appPrimaryColorBlue
              ),
            ),
            SizedBox(width: size.w10,),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.title,style: TextStyle(fontWeight: FontWeight.w600,fontSize: size.textSmall,color: clr.blackColor),)
              ],
            ))
          ],
        )
      ),
    );
  }
}
