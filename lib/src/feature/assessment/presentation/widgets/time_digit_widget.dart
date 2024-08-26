import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/constants/app_theme.dart';

class TimeDigitWidget<T> extends StatefulWidget {
  final Stream<Duration> timerStream;
  final Stream<DataState<T>> examStateStream;
  final bool Function(DataState<T>? snapshot) isExamRunning;
  const TimeDigitWidget(
      {Key? key,
      required this.timerStream,
      required this.examStateStream,
      required this.isExamRunning})
      : super(key: key);

  @override
  _TimeDigitWidgetState<T> createState() => _TimeDigitWidgetState<T>();
}

class _TimeDigitWidgetState<T> extends State<TimeDigitWidget<T>> with AppTheme {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DataState<T>>(
        stream: widget.examStateStream,
        builder: (context, snapshot) {
          if (widget.isExamRunning(snapshot.data)) {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: size.w8,
                vertical: size.h6,
              ),
              decoration: BoxDecoration(
                color: clr.shadeWhiteColor2,
                borderRadius: BorderRadius.circular(size.h4),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                      spreadRadius: 0,
                      color: clr.blackColor.withOpacity(.2))
                ],
              ),
              child: StreamBuilder<Duration>(
                  initialData: const Duration(),
                  stream: widget.timerStream,
                  builder: (context, snapshot) {
                    int min = snapshot.data!.inMinutes;
                    int sec = snapshot.data!.inSeconds % 60;

                    var minMsbRaw = min ~/ 10;
                    var minMMsb = minMsbRaw ~/ 10;
                    var minMsb = minMsbRaw % 10;
                    var minLsb = min % 10;

                    var secMsb = sec ~/ 10;
                    var secLsb = sec % 10;
                    return Row(
                      children: [
                        if (minMMsb > 0) _buildDigitBox(minMMsb),
                        if (minMMsb > 0)
                          SizedBox(
                            width: 2.w,
                          ),
                        _buildDigitBox(minMsb),
                        SizedBox(
                          width: 2.w,
                        ),
                        _buildDigitBox(minLsb),
                        SizedBox(
                          width: 2.w,
                        ),
                        _buildDigitSeparatorBox(":"),
                        SizedBox(
                          width: 2.w,
                        ),
                        _buildDigitBox(secMsb),
                        SizedBox(
                          width: 2.w,
                        ),
                        _buildDigitBox(secLsb),
                      ],
                    );
                  }),
            );
          } else {
            return const Offstage();
          }
        });
  }

  Widget _buildDigitBox(int value) {
    return Container(
      height: size.h24,
      width: size.w20,
      decoration: BoxDecoration(
        color: clr.iconColorSweetRed,
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: FittedBox(
        child: Text(
          value.toString(),
          style: TextStyle(
            fontSize: 100,
            color: clr.whiteColor,
            height: 1.1,
          ),
        ),
      ),
    );
  }

  Widget _buildDigitSeparatorBox(String value) {
    return Container(
      height: size.h24,
      width: size.w12,
      decoration: BoxDecoration(
        color: clr.iconColorSweetRed,
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: FittedBox(
        child: Text(
          value,
          style: TextStyle(
            fontSize: 100,
            color: clr.whiteColor,
            height: 1,
          ),
        ),
      ),
    );
  }
}
