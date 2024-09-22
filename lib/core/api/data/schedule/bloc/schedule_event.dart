part of 'schedule_bloc.dart';

sealed class ScheduleEvent extends Equatable {
  const ScheduleEvent();
}

final class LoadItemSchedule extends ScheduleEvent{
  final ScheduleRequest request;
  const LoadItemSchedule(this.request);

  @override
  List<Object> get props => [request];
}

final class ReloadItemSchedule extends ScheduleEvent{

  @override
  List<Object> get props => [];
}