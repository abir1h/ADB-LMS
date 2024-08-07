import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class AppEventSubscriber<T, T2 extends EventNotifier<T>>
    extends StatefulWidget {
  final String uniqueKey;
  final T2 controller;
  final T initialData;
  final bool Function(T data)? willUpdate;
  final Widget Function(BuildContext context, T data) builder;
  const AppEventSubscriber({
    Key? key,
    required this.uniqueKey,
    required this.controller,
    required this.initialData,
    required this.builder,
    this.willUpdate,
  }) : super(key: key);

  @override
  State<AppEventSubscriber<T, T2>> createState() =>
      _AppEventSubscriberState<T, T2>();
}

class _AppEventSubscriberState<T, T2 extends EventNotifier<T>>
    extends State<AppEventSubscriber<T, T2>> {
  late StreamSubscription<MapEntry<String, T>> _subscription;
  late T _currentData;

  @override
  void initState() {
    _currentData = widget.initialData;
    _subscription =
        widget.controller._eventController.stream.listen(_onEventReceived);
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _currentData);
  }

  void _onEventReceived(MapEntry<String, T> event) {
    if (mounted && widget.uniqueKey == event.key) {
      if (widget.willUpdate == null || widget.willUpdate!(event.value)) {
        setState(() {
          _currentData = event.value;
        });
      }
    }
  }
}

abstract class EventNotifier<T> {
  final _eventController = PublishSubject<MapEntry<String, T>>();

  void notifyListeners(String uniqueKey, T data) {
    if (!_eventController.isClosed) {
      _eventController.sink.add(MapEntry<String, T>(uniqueKey, data));
    }
  }
}
