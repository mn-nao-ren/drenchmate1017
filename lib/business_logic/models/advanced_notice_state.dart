part of 'advanced_notice_cubit.dart';

@immutable
abstract class AdvancedNoticeState {}

class AdvancedNoticeInitial extends AdvancedNoticeState {}

class NextDrenchDateCalculated extends AdvancedNoticeState {
  final DateTime nextDrenchDate;

  NextDrenchDateCalculated(this.nextDrenchDate);
}

class AdvancedNoticeError extends AdvancedNoticeState {
  final String message;

  AdvancedNoticeError(this.message);
}
