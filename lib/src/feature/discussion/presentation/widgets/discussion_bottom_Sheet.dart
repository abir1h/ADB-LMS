import 'package:adb_mobile/src/core/common_widgets/custom_toasty.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../course/domain/entities/course_overview_data_entity.dart';
import '../service/discussion_screen_service.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../authentication/presentation/widgets/custom_dropdown.dart';

class CustomBottomSheet extends StatefulWidget {
  final CourseOverViewDataEntity data;
  final Function(String selectedFirstItem, String selectedSecondItem,
      String selectedThirdItem) onSelectionDone;

  const CustomBottomSheet(
      {Key? key, required this.onSelectionDone, required this.data})
      : super(key: key);

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet>
    with AppTheme, DiscussionScreenService {
  List<DropDownItem> _topicItems = [];
  DropDownItem? _selectedTopicItem;
  String? _selectedTypeItem;
  List<DropDownItem> _videoItems = [];
  DropDownItem? _selectedVideoItem;
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchFirstDropdownItems();
  }

  void _fetchFirstDropdownItems() async {
    String courseId = widget.data.id;
    List<DropDownItem> items = await fetchFirstDropdownItemsFromApi(courseId);
    setState(() {
      _topicItems = items;
    });
  }

  void _fetchThirdDropdownItems(
      String courseId, String type, String topicId) async {
    List<DropDownItem> items =
        await fetchThirdDropdownItemsFromApi(courseId, type, topicId);
    setState(() {
      _videoItems = items
          .map((value) => DropDownItem(id: value.id, value: value.value))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(size.r16),
                  topRight: Radius.circular(size.r16),
                ),
                color: clr.scaffoldBackgroundColor2,
              ),
              width: 1.sw,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text.rich(
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: size.textSmall,
                              color: clr.appPrimaryColorBlue),
                          TextSpan(
                            text: 'মন্তব্য লিখুন',
                            children: <InlineSpan>[],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          CupertinoIcons.clear_fill,
                          color: clr.iconColorRed,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.h10),
                  Text.rich(
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: size.textSmall,
                        color: clr.textGrey),
                    TextSpan(
                      text: 'Select Topic',
                      children: <InlineSpan>[
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: size.textSmall,
                              color: Colors.red),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: size.h10),
                  SelectorDropDownList<DropDownItem>(
                    onLoadData: () async => _topicItems,
                    onGenerateTitle: (x) => x.value!,
                    hintText: 'Select Topic',
                    onSelected: (value) {
                      setState(() {
                        _selectedTopicItem = value;
                        _selectedVideoItem = null;
                      });
                    },
                  ),
                  if (_selectedTopicItem != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.h10),
                        Text.rich(
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: size.textSmall,
                              color: clr.textGrey),
                          TextSpan(
                            text: 'Select Types',
                            children: <InlineSpan>[
                              TextSpan(
                                text: '*',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: size.textSmall,
                                    color: Colors.red),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: size.h10),
                        SelectorDropDownList<String>(
                          onLoadData: () async => ["Video"],
                          onGenerateTitle: (x) => x,
                          hintText: 'Select Types',
                          onSelected: (value) {
                            setState(() {
                              _selectedTypeItem = value;
                              _selectedVideoItem = null; // Reset third dropdown
                              _fetchThirdDropdownItems(
                                widget.data.id,
                                "0",
                                _selectedTopicItem!.id!,
                              );
                            });
                          },
                        ),

/*
                        DropdownButton<String>(
                          isExpanded: true,
                          dropdownColor: clr.whiteColor,
                          elevation: 2,
                          hint: const Text('Select Types'),
                          value: _selectedTypeItem,
                          items: ["Video"].map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedTypeItem = newValue;
                              _selectedVideoItem =
                              null; // Reset third dropdown
                              _fetchThirdDropdownItems(
                                widget.data.id,
                                "0",
                                _selectedTopicItem!.id!,
                              );
                            });
                          },
                        ),
*/
                      ],
                    ),
                  if (_selectedTopicItem != null && _selectedTypeItem != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.h10),
                        Text.rich(
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: size.textSmall,
                              color: clr.textGrey),
                          TextSpan(
                            text: 'Select Video',
                            children: <InlineSpan>[
                              TextSpan(
                                text: '*',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: size.textSmall,
                                    color: Colors.red),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: size.h10),
                        SelectorDropDownList<DropDownItem>(
                          onLoadData: () async => _videoItems,
                          onGenerateTitle: (x) => x.value!,
                          hintText: 'Select Video',
                          onSelected: (value) {
                            setState(() {
                              _selectedVideoItem = value;
                            });
                          },
                        ),

/*
                        DropdownButton<DropDownItem>(
                          isExpanded: true,
                          dropdownColor: clr.whiteColor,
                          elevation: 2,
                          hint: const Text('Select Video'),
                          value: _selectedVideoItem,
                          items: _videoItems.map((DropDownItem item) {
                            return DropdownMenuItem<DropDownItem>(
                              value: item,
                              child: Text(item.value!),
                            );
                          }).toList(),
                          onChanged: (DropDownItem? newValue) {
                            setState(() {
                              _selectedVideoItem = newValue;
                            });
                          },
                        ),
*/
                      ],
                    ),
                  if (_selectedTopicItem != null &&
                      _selectedTypeItem != null &&
                      _selectedVideoItem != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.h20),
                        TextField(
                          controller: commentController,
                          keyboardType: TextInputType.multiline,
                          minLines: 5,
                          maxLines: 5,
                          style: TextStyle(
                              color: clr.textColorBlack,
                              fontSize: size.textSmall,
                              fontWeight: FontWeight.w400,
                              fontFamily: StringData.fontFamilyOpenSans),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            hintText: "Write your comment here",
                            fillColor: clr.whiteColor,
                            filled: true,
                            hintStyle: TextStyle(
                                color: clr.placeHolderTextColorGray,
                                fontSize: size.textSmall,
                                fontWeight: FontWeight.w400,
                                fontFamily: StringData.fontFamilyPoppins),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: clr.greyColor, width: size.w1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(size.w8)),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: clr.boxStrokeColor, width: size.w1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(size.w8))),
                          ),
                        ),
                        SizedBox(height: size.h20),
                        GestureDetector(
                          onTap: () {
                            if (commentController.text.isEmpty) {
                              CustomToasty.of(context)
                                  .showWarning("Please write your comment");
                            } else {
                              uploadComments(
                                  commentController.text.trim(),
                                  widget.data.id,
                                  _selectedTopicItem!.id!,
                                  _selectedVideoItem!.id!,
                                  0,
                                  context);
                            }
                          },
                          child: Container(
                            width: 1.sw,
                            padding: EdgeInsets.symmetric(vertical: size.h10),
                            decoration: BoxDecoration(
                                color: clr.addCommentButtonColor,
                                borderRadius: BorderRadius.circular(size.r10)),
                            child: Center(
                              child: Text(
                                "Post",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: size.textSmall,
                                    color: clr.whiteColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
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
