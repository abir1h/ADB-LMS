import 'dart:async';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalDatabase {
  static LocalDatabase? _instance;
  static LocalDatabase get instance =>
      _instance ?? (_instance = LocalDatabase._());
  LocalDatabase._();
  Future<void> initDatabase() async {
    Hive.init((await getApplicationSupportDirectory()
        .then((value) => value.path)
        .catchError((_) async => await getApplicationDocumentsDirectory()
            .then((value) => value.path))));
  }

  //============= Watch Session History ===========
  Future<int> storeLectureWatchSession(VideoWatchSession session) async {
    Completer<int> completer = Completer();
    try {
      var box = await Hive.openBox('videoWatchSession');
      var data = jsonEncode(session.toJson());
      await box.put(session.guid, data);

      completer.complete(1);
    } catch (e) {
      completer.complete(-1);
    }
    return completer.future;
  }

  Future<List<VideoWatchSession>> getLectureWatchSessions() async {
    Completer<List<VideoWatchSession>> completer = Completer();
    try {
      List<VideoWatchSession> list = [];
      var box = await Hive.openBox('videoWatchSession');

      for (var x in box.values) {
        var data = jsonDecode(x);
        list.add(VideoWatchSession.fromJson(data));
      }
      completer.complete(list);
    } catch (e) {
      completer.complete([]);
    }
    return completer.future;
  }

  Future<bool> removeLectureWatchSessions(List<String?> guids) async {
    try {
      var box = await Hive.openBox('videoWatchSession');
      await box.deleteAll(guids);
      return true;
    } catch (e) {
      return Future.value(false);
    }
  }
}

class VideoWatchSession {
  int circularVideoId;
  int lastPlayedDuration;
  int totalDuration;
  List<int> videoQuestionSeenId;
  String startTime;
  String endTime;
  String guid;

  VideoWatchSession(
      {
      required this.circularVideoId,
      required this.startTime,
      required this.endTime,
      required this.guid,
      required this.totalDuration,
      required this.lastPlayedDuration,
      required this.videoQuestionSeenId});

  factory VideoWatchSession.empty() {
    return VideoWatchSession(
        startTime: "",
        guid: "",
        endTime: "",
        circularVideoId: 0,
        totalDuration: 0,
        lastPlayedDuration: 0,
        videoQuestionSeenId: []);
  }

  factory VideoWatchSession.fromJson(Map<String, dynamic> json) {
    return VideoWatchSession(
      circularVideoId: json['circular_video_id'] ?? 0,
      startTime: json['start_time'] ?? "",
      endTime: json['end_time'] ?? "",
      totalDuration: json['total_duration'] ?? 0,
      guid: json['guid'] ?? "",
      lastPlayedDuration: json['last_played_duration'] ?? 0,
      videoQuestionSeenId: json['seen_question_id'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['last_played_duration'] = lastPlayedDuration;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['total_duration'] = totalDuration;
    data['guid'] = guid;
    data['circular_video_id'] = circularVideoId;
    data['seen_question_id'] = videoQuestionSeenId;
    return data;
  }
}
