import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../domain/entities/course_conduct_data_entity.dart';
import '../../../faq/domain/entities/faq_data_entity.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/constants/common_imports.dart';
import '../service/course_conduct_faq_service.dart';

class CourseConductFaqScreen extends StatefulWidget {
  final CourseConductDataEntity data;
  const CourseConductFaqScreen({super.key, required this.data});

  @override
  State<CourseConductFaqScreen> createState() => _CourseConductFaqScreenState();
}

class _CourseConductFaqScreenState extends State<CourseConductFaqScreen>
    with AppTheme, CourseConductFaqScreenService {
  @override
  void initState() {
    loadFaq(widget.data.course!.id, widget.data.topic!.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child : Column(
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
                      Lottie.asset(ImageAssets.emptyAnimation, height: size.h64 * 3),
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
        ),
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
        return SizedBox(height: size.h10,);
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
          title: Text(
            data.question,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: size.textSmall,
                color: clr.headerColor),
          ),
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(size.w12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.answer,
                    style: TextStyle(
                        fontSize: size.textXSmall,
                        color: clr.textGrey,
                        fontWeight: FontWeight.w400),
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
