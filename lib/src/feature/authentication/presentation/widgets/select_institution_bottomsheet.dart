import 'package:adb_mobile/src/core/common_widgets/custom_toasty.dart';
import 'package:adb_mobile/src/core/constants/app_theme.dart';
import 'package:adb_mobile/src/feature/authentication/presentation/services/registration_screen_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../discussion/presentation/service/discussion_screen_service.dart';

class SelectInstitutionBottomsheet extends StatefulWidget {
  final BuildContext context2;
  final List<DropDownItem> items;

  const SelectInstitutionBottomsheet({
    super.key,
    required this.context2,
    required this.items,
  });

  @override
  _SelectInstitutionBottomsheetState createState() =>
      _SelectInstitutionBottomsheetState();
}

class _SelectInstitutionBottomsheetState extends State<SelectInstitutionBottomsheet>
    with AppTheme, RegistrationScreenService {
  TextEditingController _searchController = TextEditingController();
  List<DropDownItem> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items; // Initialize with the full list
    _searchController.addListener(_filterItems);
  }

  void _filterItems() {
    setState(() {
      String query = _searchController.text.toLowerCase();
      filteredItems = widget.items.where((item) {
        return item.value!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterItems);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
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
                  children: [
                    SizedBox(height: size.h20),
                    Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        CupertinoIcons.clear,
                        color: Colors.black,
                        size: size.r24,
                      ),
                    ),
                    SizedBox(height: size.h20),
                    TextField(
                      controller: _searchController,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 1,
                      style: TextStyle(
                        color: clr.textColorBlack,
                        fontSize: size.textSmall,
                        fontWeight: FontWeight.w400,
                        fontFamily: StringData.fontFamilyOpenSans,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        hintText: "আর্থিক প্রতিষ্ঠানের নাম নির্বাচন করুন...",
                        hintStyle: TextStyle(
                          color: clr.placeHolderTextColorGray,
                          fontSize: size.textSmall,
                          fontWeight: FontWeight.w400,
                          fontFamily: StringData.fontFamilyPoppins,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: clr.greyColor,
                            width: size.w1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(size.w8)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: clr.boxStrokeColor,
                            width: size.w1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(size.w8)),
                        ),
                      ),
                      onChanged: (v) {
                        _filterItems(); // Trigger filter whenever the text changes
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    color: clr.whiteColor,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: SelectDistrictSectionWidget(
                      items: filteredItems, // Use the filtered list
                      buildItem: (BuildContext context, int index, item) {
                        return SelectDistrictItemWidget(
                          data: item,
                          onTap: () {

                            Navigator.pop(context,item);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
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

  @override
  void onClose() {
    // TODO: implement onClose
  }

  @override
  void onSubmit() {
    // TODO: implement onSubmit
  }
}

class SelectDistrictSectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;

  const SelectDistrictSectionWidget({
    super.key,
    required this.items,
    required this.buildItem,
  });

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
        return Padding(
          padding: EdgeInsets.symmetric(vertical: size.h2),
          child: Container(
            height: size.h2,
            width: 1.sw,
            color: clr.greyColor.withOpacity(.2),
          ),
        );
      },
    );
  }
}

class SelectDistrictItemWidget extends StatelessWidget with AppTheme {
  final DropDownItem data;
  final VoidCallback onTap;

  const SelectDistrictItemWidget({
    super.key,
    required this.data,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.value!,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: size.textSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
