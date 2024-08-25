import 'dart:async';
import 'package:flutter/material.dart';

mixin AppEventsNotifier<T extends StatefulWidget> on State<T>
    implements _EventHandler {
  static final StreamController<EventAction> _eventStreamController =
      StreamController.broadcast();
  static Sink<EventAction>? get _notifier =>
      !_eventStreamController.isClosed ? _eventStreamController.sink : null;
  static Stream<EventAction> get _stream => _eventStreamController.stream;
  static void notify(EventAction event) {
    _notifier?.add(event);
  }

  late _EventHandler _handler;
  StreamSubscription<EventAction>? _subscription;
  @override
  void initState() {
    _handler = this;
    _subscription = _stream.listen(_handler.onEventReceived);
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

abstract class _EventHandler {
  void onEventReceived(EventAction action);
}

enum EventAction {
  bottomNavAllScreen,
  dashBoardScreen,
  coursesScreen,
  notesScreen,
  profileScreen,
  onGoingCoursesScreen,
  courseDetailsScreen,
  bottomNavBar,
  graphChart,
  drawer,
  discussion,
  assignmentSubmitScreen,
  assignmentScreen,
  videoWidget,
  showYoutube,
  updateUrl,
}
