import 'package:adb_mobile/src/feature/profile/domain/entities/result_data_entity.dart';

class TraineeUserDataEntity {
  final int id;
  final String exception;
  final int status;
  final bool isCanceled;
  final bool isCompleted;
  final bool isCompletedSuccessfully;
  final int creationOptions;
  final String asyncState;
  final bool isFaulted;
  final ResultDataEntity? result;

  const TraineeUserDataEntity({
    required this.result,
    required this.id,
    required this.exception,
    required this.status,
    required this.isCanceled,
    required this.isCompleted,
    required this.isCompletedSuccessfully,
    required this.creationOptions,
    required this.asyncState,
    required this.isFaulted,
  });
}
