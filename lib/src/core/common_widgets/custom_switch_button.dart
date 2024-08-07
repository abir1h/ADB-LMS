import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../service/notifier/app_events_notifier.dart';
import '../constants/app_theme.dart';
import '../constants/strings.dart';
import '../utility/app_label.dart';

class CustomSwitchButton extends StatefulWidget {
  @required
  final bool value;
  final double width;

  @required
  final Function(bool) onChanged;
  final String textOff;
  final String textOn;
  final double textSize;
  final Duration animationDuration;
  final Function onTap;
  final Function onDoubleTap;
  final Function onSwipe;
  final Widget buttonHolder;
  final Color bgColor;

  const CustomSwitchButton({
    super.key,
    this.value = false,
    this.width = 130,
    this.textOff = "Off",
    this.textOn = "On",
    this.textSize = 14.0,
    this.animationDuration = const Duration(milliseconds: 100),
    required this.onTap,
    required this.onDoubleTap,
    required this.onSwipe,
    required this.onChanged,
    required this.buttonHolder,
    this.bgColor = Colors.white,
  });

  @override
  State<CustomSwitchButton> createState() => _RollingSwitchState();
}

class _RollingSwitchState extends State<CustomSwitchButton>
    with SingleTickerProviderStateMixin, AppTheme, AppEventsNotifier
    implements App {
  /// Late declarations
  late AnimationController animationController;
  late Animation<double> animation;
  late bool turnState;

  double value = 0.0;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: widget.animationDuration);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    animationController.addListener(() {
      setState(() {
        value = animation.value;
      });
    });
    turnState = widget.value;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (turnState) {
          animationController.forward();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Color? transitionColor =
        Color.lerp(widget.bgColor, clr.appSecondaryColorFlagRed, value);
    var style = TextStyle(
        color: clr.appPrimaryColorGreen,
        fontWeight: FontWeight.w400,
        fontFamily: StringData.fontFamilyRoboto,
        fontSize: widget.textSize);
    return GestureDetector(
      onDoubleTap: () {
        _action();
        widget.onDoubleTap();
      },
      onTap: () {
        _action();
        widget.onTap();
      },
      onPanEnd: (details) {
        _action();
        widget.onSwipe();
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        width: widget.width,
        decoration: BoxDecoration(
            border: Border.all(color: clr.strokeToggleColor),
            color: transitionColor,
            borderRadius: BorderRadius.circular(50)),
        child: Stack(
          children: [
            Transform.translate(
              offset: isRTL(context)
                  ? Offset(-10 * value, 0)
                  : Offset(10 * value, 0), //original
              child: Opacity(
                opacity: (1 - value).clamp(0.0, 1.0),
                child: Container(
                  padding: isRTL(context)
                      ? const EdgeInsets.only(left: 5)
                      : const EdgeInsets.only(right: 5),
                  alignment: isRTL(context)
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  height: 20,
                  child: Text(
                    widget.textOff,
                    style: style,
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: isRTL(context)
                  ? Offset(-10 * (1 - value), 0)
                  : Offset(10 * (1 - value), 0), //original
              child: Opacity(
                opacity: value.clamp(0.0, 1.0),
                child: Container(
                  padding: isRTL(context)
                      ? const EdgeInsets.only(right: 5)
                      : const EdgeInsets.only(left: 5),
                  alignment: isRTL(context)
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  height: 20,
                  child: Text(
                    widget.textOn,
                    style: TextStyle(
                        color: clr.whiteColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: StringData.fontFamilyRoboto,
                        fontSize: widget.textSize),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: isRTL(context)
                  ? Offset((-widget.width + 45) * value, 0)
                  : Offset((widget.width - 45) * value, 0),
              child: turnState == true
                  ? Container(
                      height: 20,
                      width: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: clr.whiteColor),
                      child: widget.buttonHolder,
                    )
                  : Container(
                      height: 20,
                      width: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: clr.appPrimaryColorGreen),
                      child: widget.buttonHolder,
                    ),
            )
          ],
        ),
      ),
    );
  }

  _action() {
    _determine(changeState: true);
  }

  _determine({bool changeState = false}) {
    setState(() {
      if (changeState) turnState = !turnState;
      (turnState)
          ? animationController.forward()
          : animationController.reverse();

      widget.onChanged(turnState);
    });
  }

  @override
  void onEventReceived(EventAction action) {
    if (mounted) {
      setState(() {
        if (App.currentAppLanguage == AppLanguage.english) {
          animationController.forward();
          turnState = true;
        } else {
          animationController.reverse();
          turnState = false;
        }
      });
    }
  }
}

bool isRTL(BuildContext context) {
  return Bidi.isRtlLanguage(Localizations.localeOf(context).languageCode);
}
