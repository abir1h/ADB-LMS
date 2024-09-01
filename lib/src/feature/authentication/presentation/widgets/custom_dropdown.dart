///Name: Md. Abdur Rouf
///Email: official.rouf69nb@gmail.com
///Created at: Mar 03, 2022

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/popup_widget.dart';
import '../../../../core/constants/app_theme.dart';


class SelectorDropDownList<T> extends StatefulWidget {
  final Future<List<T>> Function() onLoadData;
  final String Function(T item) onGenerateTitle;
  final void Function(T item) onSelected;
  final String hintText;
  const SelectorDropDownList({Key? key,required this.onLoadData, required this.onSelected, this.hintText="Select",required this.onGenerateTitle,}) : super(key: key);

  @override
  _SelectorDropDownListState<T> createState() => _SelectorDropDownListState<T>();
}
class _SelectorDropDownListState<T> extends State<SelectorDropDownList<T>> with AppTheme {
  T? _selectedItem;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return PopupWidget(
      child: Container(
        key: GlobalKey(),
        width: double.maxFinite,
        padding: EdgeInsets.only(left: 16.w,top:6.w,bottom: 6.w,right: 8.w),
        decoration: BoxDecoration(
          color: clr.whiteColor,
          borderRadius: BorderRadius.circular(size.r12),
          border: Border.all(color:clr.whiteColor, width: 1.w),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                _selectedItem != null ? widget.onGenerateTitle(_selectedItem as T):widget.hintText,
                style: TextStyle(
                  color: _selectedItem != null?clr.blackColor:clr.greyColor,
                  fontSize: size.textSmall,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: clr.blackColor.withOpacity(.3),
              size: 32.sp,
            ),
          ],
        ),
      ),
      popupBuilder: (position, _size, link){
        return Positioned(
          left: position.dx,
          top: position.dy,
          child: CompositedTransformFollower(
            link: link,
            child: Container(
              width: _size.width,
              margin: EdgeInsets.only(top: _size.height + 4.w ),
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height - position.dy - 8.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.w),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.5),
                    blurRadius: 8.w,
                    offset: Offset(0.0,2.w),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.w),
                child: FutureBuilder<List<T>>(
                    future: widget.onLoadData(),
                    builder: (context,snapshot) {
                      ///Data state
                      if(snapshot.hasData && snapshot.data != null && snapshot.data!.isNotEmpty){
                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: snapshot.data!.map((m)=>
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.of(context).pop();
                                        if(mounted) {
                                          setState(() {
                                            _selectedItem = m;
                                          });
                                        }
                                        widget.onSelected.call(m);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(left: 17.w, top: 12.w, right: 16.w, bottom: 12.w),
                                        width: double.infinity,
                                        color: Colors.white,
                                        child: Text(
                                          widget.onGenerateTitle(m),
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black.withOpacity(.78),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 1.2.w,
                                      width: double.infinity,
                                      color: Colors.grey.withOpacity(.08),
                                    )
                                  ],
                                ),
                            ).toList(),
                          ),
                        );
                      }
                      ///Empty state
                      else if(snapshot.hasData && snapshot.data != null && snapshot.data!.isEmpty){
                        return SizedBox(
                          width: double.maxFinite,
                          height: size.h64,
                          child: const Center(
                            child: Text(
                              "No item found!",
                            ),
                          ),
                        );
                      }
                      ///Loading state
                      else{
                        return SizedBox(
                          width: double.maxFinite,
                          height: size.h64,
                          child: Center(
                            child: SizedBox(
                              height: size.h20,width: size.w20,
                              child: CircularProgressIndicator(
                                color: clr.appPrimaryColorBlue,
                                strokeWidth: 1.6.w,
                              ),
                            ),
                          ),
                        );
                      }
                    }
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}