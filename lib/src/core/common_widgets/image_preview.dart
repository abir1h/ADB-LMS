import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

mixin ImagePreviewDialog {
  static Future showImagePreview(BuildContext context, String imagePath) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      useRootNavigator: true,
      builder: (BuildContext context) =>
          _InstructionVideoWrapper(filePath: imagePath),
    );
  }
}

class _InstructionVideoWrapper extends StatefulWidget {
  final String filePath;
  const _InstructionVideoWrapper({Key? key, required this.filePath})
      : super(key: key);
  @override
  _InstructionVideoWrapperState createState() =>
      _InstructionVideoWrapperState();
}

class _InstructionVideoWrapperState extends State<_InstructionVideoWrapper>
    with AppTheme {
  final _transformationController = TransformationController();
  late TapDownDetails _doubleTapDetails;

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails.localPosition;
      // For a 3x zoom
      _transformationController.value = Matrix4.identity()
        // ..translate(-position.dx * 2, -position.dy * 2)
        // ..scale(3.0);
        // Fox a 2x zoom
        ..translate(-position.dx, -position.dy)
        ..scale(2.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white.withOpacity(.4),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Align(
            alignment: Alignment.center,
            child: Stack(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  height: double.maxFinite,
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: size.w16),
                  child: GestureDetector(
                    onDoubleTapDown: _handleDoubleTapDown,
                    onDoubleTap: _handleDoubleTap,
                    child: InteractiveViewer(
                        transformationController: _transformationController,
                        boundaryMargin: const EdgeInsets.all(80),
                        panEnabled: false,
                        scaleEnabled: true,
                        minScale: 0.5,
                        maxScale: 4.5,
                        child: CachedNetworkImage(
                          fit: BoxFit.fitWidth,
                          imageUrl: widget.filePath,
                          placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        )),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      margin: const EdgeInsets.only(left: 16, top: 16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.close,
                          color: Colors.redAccent,
                          size: 36,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
