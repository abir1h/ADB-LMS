import 'package:flutter/material.dart';

class PopupWidget extends StatefulWidget {
  final Widget child;
  final bool Function()? onHitTest;
  final Widget Function(Offset globalPosition, Size size, LayerLink layerLink)
      popupBuilder;
  PopupWidget(
      {Key? key,
      required this.child,
      required this.popupBuilder,
      this.onHitTest})
      : assert(child.key == null
            ? throw "Popup widget child has no global or local key"
            : true),
        super(key: key);

  @override
  State<PopupWidget> createState() => _PopupWidgetState();
}

class _PopupWidgetState extends State<PopupWidget> {
  final LayerLink _layerLink = LayerLink();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: CompositedTransformTarget(link: _layerLink, child: widget.child),
        onTap: () {
          if (widget.onHitTest == null ||
              (widget.onHitTest != null && widget.onHitTest!())) {
            _onWidgetTap(context);
          }
        });
  }

  _onWidgetTap(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    if ((widget.child.key as GlobalKey).currentContext != null &&
        (widget.child.key as GlobalKey).currentContext?.findRenderObject() !=
            null) {
      final RenderBox renderBox = (widget.child.key as GlobalKey)
          .currentContext!
          .findRenderObject() as RenderBox;
      final size = renderBox.size;
      final position = renderBox.localToGlobal(Offset.zero);
      Widget child = widget.popupBuilder(position, size, _layerLink);
      Navigator.push(context, PopupWidgetModal(child: child));
    }
  }
}

class PopupWidgetModal extends ModalRoute<void> {
  final Widget child;
  PopupWidgetModal({
    required this.child,
  });

  @override
  Duration get transitionDuration => const Duration(milliseconds: 30);
  @override
  bool get opaque => false;
  @override
  bool get barrierDismissible => true;
  @override
  Color get barrierColor => Colors.white.withOpacity(0);
  @override
  String get barrierLabel => "";
  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      onPanStart: (x) {
        Navigator.pop(context);
      },
      child: Material(
        type: MaterialType.transparency,
        child: GestureDetector(
          onTap: () {},
          child: Stack(children: <Widget>[
            child,
          ]),
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
