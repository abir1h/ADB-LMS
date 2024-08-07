import 'package:flutter/material.dart';

class AppDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? hint;
  final String? label;
  final Widget? icon;
  final bool isDense;
  final double? elevation;
  final TextStyle? hintStyle;
  final TextStyle? itemStyle;
  final Color? dropdownColor;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Color? borderColor;
  final double? borderWidth;

  const AppDropdown({
    Key? key,
    required this.items,
    this.value,
    this.onChanged,
    this.hint,
    this.label,
    this.icon,
    this.isDense = false,
    this.elevation,
    this.hintStyle,
    this.itemStyle,
    this.dropdownColor,
    this.padding,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
  }) : super(key: key);

  @override
  _AppDropdownState<T> createState() => _AppDropdownState<T>();
}

class _AppDropdownState<T> extends State<AppDropdown<T>> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: widget.value,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        contentPadding: widget.padding ?? EdgeInsets.symmetric(horizontal: 12.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.0),
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.grey,
            width: widget.borderWidth ?? 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.0),
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.grey,
            width: widget.borderWidth ?? 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.0),
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.blue,
            width: widget.borderWidth ?? 1.0,
          ),
        ),
        hintText: widget.hint,
        hintStyle: widget.hintStyle,
        labelText: widget.label,
      ),
      icon: widget.icon,
      elevation: widget.elevation?.toInt() ?? 8,
      dropdownColor: widget.dropdownColor ?? Colors.white,
      isDense: widget.isDense,
      items: widget.items.map<DropdownMenuItem<T>>((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(
            item.toString(),
            style: widget.itemStyle,
          ),
        );
      }).toList(),
    );
  }
}
