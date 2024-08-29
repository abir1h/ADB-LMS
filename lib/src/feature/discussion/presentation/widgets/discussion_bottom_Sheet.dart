import 'package:adb_mobile/src/core/constants/app_theme.dart';
import 'package:adb_mobile/src/feature/course/domain/entities/course_overview_data_entity.dart';
import 'package:adb_mobile/src/feature/discussion/presentation/service/discussion_screen_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/common_imports.dart';
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
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust the padding when the keyboard is open
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(size.r16),
              topRight: Radius.circular(size.r16),
            ),
            color: clr.whiteColor,
          ),
          width: 1.sw,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
              SizedBox(height: size.h4),
              DropdownButton<DropDownItem>(
                isExpanded: true,
                dropdownColor: clr.whiteColor,
                elevation: 2,
                hint: const Text('Select Topic'),
                value: _selectedTopicItem,
                items: _topicItems.map((DropDownItem item) {
                  return DropdownMenuItem<DropDownItem>(
                    value: item,
                    child: Text(item.value!),
                  );
                }).toList(),
                onChanged: (DropDownItem? newValue) {
                  setState(() {
                    _selectedTopicItem = newValue;
                    _selectedVideoItem = null; // Reset third dropdown
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
                          _selectedVideoItem = null; // Reset third dropdown
                          _fetchThirdDropdownItems(
                            widget.data.id,
                            "0",
                            _selectedTopicItem!.id!,
                          );
                        });
                      },
                    ),
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
                  ],
                ),
              if (_selectedTopicItem != null &&
                  _selectedTypeItem != null &&
                  _selectedVideoItem != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      onTap: (){
                        uploadComments(commentController.text.trim(),widget.data.id,_selectedTopicItem!.id!,_selectedVideoItem!.id!,0,context);
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
  }

  @override
  void showWarning(String message) {
    // TODO: implement showWarning
  }
}

