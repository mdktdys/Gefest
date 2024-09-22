part of 'schedule_bloc.dart';

sealed class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

final class ScheduleInitial extends ScheduleState {}

final class ScheduleLoading extends ScheduleState {}

final class ScheduleSuccess extends ScheduleState {
  final List<Paras> paras;

  const ScheduleSuccess({required this.paras});

  @override
  List<Object> get props => [paras];
}

final class ScheduleFailed extends ScheduleState {
  const ScheduleFailed(this.error,this.trace);

  final String error;
  final String trace;

  @override
  List<Object> get props => [error];
}
