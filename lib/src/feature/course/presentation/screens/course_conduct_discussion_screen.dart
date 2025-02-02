import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/common_widgets/custom_toasty.dart';
import '../../domain/entities/course_conduct_data_entity.dart';
import '../widgets/course_discussion_bottomsheet.dart';
import '../../../discussion/presentation/service/discussion_screen_service.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../discussion/domain/entities/discussion_data_entity.dart';

class CourseConductDiscussionScreen extends StatefulWidget {
  final CourseConductDataEntity data;
  const CourseConductDiscussionScreen({super.key, required this.data});

  @override
  State<CourseConductDiscussionScreen> createState() => _CourseConductDiscussionScreenState();
}

class _CourseConductDiscussionScreenState extends State<CourseConductDiscussionScreen>
    with AppTheme, DiscussionScreenService {
  bool _isFabVisible = true;

/*
  void _fetchThirdDropdownItems(String selectedFirstItem, String selectedSecondItem) async {
    // Replace with your API call to get the third dropdown items based on the first and second selections
    List<String> items = await fetchThirdDropdownItemsFromApi(selectedFirstItem, selectedSecondItem);
    setState(() {
      thirdDropdownItems = items;
    });
  }
*/
  void _onFabPressed() {
    setState(() {
      _isFabVisible = false;
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return CourseConductBottomsheet(

            onSelectionDone: (String selectedFirstItem,
                String selectedSecondItem, String selectedThirdItem) {
              // Handle the selections here
              print("Selected First Item: $selectedFirstItem");
              print("Selected Second Item: $selectedSecondItem");
              print("Selected Third Item: $selectedThirdItem");
              setState(() {
                _isFabVisible = true; // Show FAB again after selection is done
              });
            },
            data: widget.data);
      },
    ).then((_) {
      setState(() {
        _isFabVisible = true;
        loadDiscussion(widget.data.course!.id);
      });
    });
  }

  @override
  void initState() {
    loadDiscussion(widget.data.course!.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _isFabVisible
          ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: _onFabPressed,
          child: Container(
            width: 1.sw,
            height: size.h44,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.r4),
                color: clr.addCommentButtonColor),
            padding: EdgeInsets.symmetric(
                horizontal: size.h10, vertical: size.h10),
            child: Center(
              child: Text(
                "মন্তব্য লিখুন",
                style: TextStyle(
                    color: clr.whiteColor, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      )
          : null,
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: Column(
            children: [
              AppStreamBuilder<List<DiscussionDataEntity>>(
                stream: discussionStreamController.stream,
                loadingBuilder: (context) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                dataBuilder: (context, data) {
                  return DiscussionSectionWidget(
                      items: data,
                      buildItem: (BuildContext context, int index, item) {
                        return DiscussionItemWidget(
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
              ),SizedBox(height: size.h64,)
            ],
          ),
        );
      }),
    );
  }

  @override
  void showWarning(String message) {


    CustomToasty.of(context).showWarning(message);  }

  @override
  void showSuccess(String message) {


    CustomToasty.of(context).showWarning(message);  }
}

class DiscussionSectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const DiscussionSectionWidget(
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

class DiscussionItemWidget<T> extends StatelessWidget with AppTheme {
  final DiscussionDataEntity data;
  final VoidCallback onTap;
  const DiscussionItemWidget(
      {super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: size.r24,
                              backgroundColor: clr.greyColor.withOpacity(.2),
                              child: CachedNetworkImage(
                                imageUrl: ApiCredential.mediaBaseUrl + data.imagePath,
                                imageBuilder: (context, imageProvider) => CircleAvatar(
                                  radius: size.r24,
                                  backgroundImage: imageProvider,
                                ),
                                placeholder: (context, url) => CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Icon(Icons.person,),
                              ),
                            ),
                            SizedBox(
                              width: size.w10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.commenterName,
                                  style: TextStyle(
                                    color: clr.blackColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: size.textMedium,
                                  ),
                                ),
                                Text(
                                  " ● ${data.material}",
                                  style: TextStyle(
                                    color: clr.greyColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: size.textXXXSmall,
                                  ),
                                ),
                                Text(
                                  " ● ${data.phoneNumber}",
                                  style: TextStyle(
                                    color: clr.greyColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: size.textXXXSmall,
                                  ),
                                ),
                                SizedBox(
                                  height: size.h10,
                                ),
                                Text(
                                  data.comment,
                                  style: TextStyle(
                                    color: clr.blackColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: size.textSmall,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),

                  ],
                ),
              ],
            ),
            Positioned(
                top: size.h2,right: size.w4,
                child:   Text(
                  timeago.format(
                    DateTime.parse(data.commentTime),
                  ),
                  style: TextStyle(
                      fontSize: size.textXXSmall,
                      color: clr.textGrey,
                      fontWeight: FontWeight.w400),
                ))
          ],
        )
    );
  }
}
