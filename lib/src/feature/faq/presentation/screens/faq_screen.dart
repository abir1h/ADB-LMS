import 'package:adb_mobile/src/core/constants/app_theme.dart';
import 'package:adb_mobile/src/feature/course/domain/entities/course_overview_data_entity.dart';
import 'package:adb_mobile/src/feature/faq/domain/entities/faq_data_entity.dart';
import 'package:adb_mobile/src/feature/faq/presentation/service/faq_screen_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/constants/common_imports.dart';

class FaqScreen extends StatefulWidget {
  final CourseOverViewDataEntity data;
  const FaqScreen({super.key, required this.data});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> with AppTheme, FaqScreenService {
  @override
  void initState() {
    print('dsf');
    loadFaq(widget.data.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          AppStreamBuilder<List<FaqDataEntity>>(
            stream: faqStreamController.stream,
            loadingBuilder: (context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            dataBuilder: (context, data) {
              return FaqSectionWidget(
                  items: data,
                  buildItem: (BuildContext context, int index, item) {
                    return FaqItemWidget(
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

class FaqSectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const FaqSectionWidget(
      {Key? key, required this.items, required this.buildItem})
      : super(key: key);

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

class FaqItemWidget<T> extends StatelessWidget with AppTheme {
  final FaqDataEntity data;
  final VoidCallback onTap;
  const FaqItemWidget({Key? key, required this.data, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ExpansionTile(
          title: Text(data.question,style: TextStyle(fontWeight: FontWeight.w500,fontSize: size.textSmall,color: clr.headerColor),),
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(size.w12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.answer,
                    style: TextStyle(fontSize: size.textXSmall,color: clr.textGrey,fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
