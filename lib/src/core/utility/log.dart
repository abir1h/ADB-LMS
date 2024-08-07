import 'dart:developer';

import 'package:flutter/foundation.dart';

appPrint(message) {
  if (kDebugMode) log(message);
}
