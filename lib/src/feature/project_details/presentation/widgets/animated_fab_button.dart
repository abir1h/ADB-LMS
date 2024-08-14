import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_theme.dart';


class AnimatedFabButton extends StatefulWidget {
  final Function(String value) onPressed;
  final String tooltip;
  final bool isDownload;

  const AnimatedFabButton({super.key, required this.onPressed, required this.tooltip, required this.isDownload,});

  @override
  State<AnimatedFabButton> createState() => _AnimatedFabButtonState();
}

class _AnimatedFabButtonState extends State<AnimatedFabButton>
    with SingleTickerProviderStateMixin,AppTheme {
  bool isOpened = false;
  late AnimationController _animationController;
  late Animation<double> _animateIcon;
  late Animation<double> _translateButton;
  final Curve _curve = Curves.easeOut;
  final double _fabHeight = 56.0;

  @override
  initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 250))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -16.0.w,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future animate() async {
    if (!isOpened) {
      await _animationController.forward();
    } else {
      await _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget toggle() {
    return FloatingActionButton(
      backgroundColor: clr.appPrimaryColorBlue,
      onPressed: animate,
      tooltip: 'Toggle',
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _animateIcon,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: animate,
          child: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            color: _animationController.value == 1? Colors.transparent : null,
            child: child,
          ),
        );
      },
      child: widget.isDownload?Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children:[
          ...["Download"].map((val) => MenuButtonWidget(
            title: val,
            translation: _translateButton,
            scale: _animateIcon,
            controller: _animationController,
            onSelect: ()=> _onItemSelect(val),
          )).toList(),
          toggle(),
        ],
      ):Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children:[
          ...["Note"].map((val) => MenuButtonWidget(
            title: val,
            translation: _translateButton,
            scale: _animateIcon,
            controller: _animationController,
            onSelect: ()=> _onItemSelect(val),
          )).toList(),
          toggle(),
        ],
      ),
    );
  }

  _onItemSelect(String val)async {
    await animate();
    widget.onPressed(val.toLowerCase());
  }
}



class MenuButtonWidget extends StatefulWidget {
  final String title;
  final Animation<double> translation;
  final Animation<double> scale;
  final AnimationController controller;
  final VoidCallback? onSelect;
  const MenuButtonWidget({Key? key,required this.title,required  this.translation,required  this.scale,required this.controller, this.onSelect}) : super(key: key);

  @override
  State<MenuButtonWidget> createState() => _MenuButtonWidgetState();
}

class _MenuButtonWidgetState extends State<MenuButtonWidget> with AppTheme {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.translationValues(
            0.0,
            widget.translation.value,
            0.0,
          ),
          child: Transform.scale(
            scale: widget.scale.value,
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: widget.onSelect,
        child: Container(
          margin: EdgeInsets.only(top: 8.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100.w),
            boxShadow: [
              BoxShadow(
                color: Colors.black87.withOpacity(.4),
                blurRadius: 12.w,
              ),
            ],
            border: Border.all(color:Colors.white,width: 1.6.w),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal:16.w, vertical: 10.w),
            decoration: BoxDecoration(
              // color: getStatusColor(widget.title.toLowerCase())?.withOpacity(.92),
              color: clr.appPrimaryColorBlue,
              borderRadius: BorderRadius.circular(100.w),
            ),
            child: Text(
              widget.title,
              style: TextStyle(
                // color: getStatusColor(title.toLowerCase()),
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600
              ),
            ),
          ),
        ),
      ),
    );
  }
}
