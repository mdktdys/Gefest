part of 'schedule_bloc.dart';

sealed class ScheduleState extends Equatable {
  const ScheduleState();

  ScheduleState fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();

  @override
  List<Object> get props => [];
}

final class ScheduleInitial extends ScheduleState {
  const ScheduleInitial();

  @override
  ScheduleState fromJson(Map<String, dynamic> json) {
    // Возвращаем начальное состояние
    return const ScheduleInitial();
  }

  @override
  Map<String, dynamic> toJson() {
    // Для начального состояния нет дополнительных данных
    return {};
  }
}

final class ScheduleLoading extends ScheduleState {
  const ScheduleLoading();

  @override
  ScheduleState fromJson(Map<String, dynamic> json) {
    // Возвращаем состояние загрузки
    return const ScheduleLoading();
  }

  @override
  Map<String, dynamic> toJson() {
    // Для состояния загрузки нет данных
    return {};
  }
}

final class ScheduleSuccess extends ScheduleState {
  final List<Paras> paras;

  const ScheduleSuccess({required this.paras});

  @override
  List<Object> get props => [paras];

  @override
  ScheduleSuccess fromJson(Map<String, dynamic> json) {
    final List<dynamic> data = json['paras'];
    final jsonParas = data.map((e) => Paras.fromJson(e)).toList();

    return ScheduleSuccess(paras: jsonParas);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'paras': paras.map((para) => para.toJson()).toList(),
    };
  }
}

final class ScheduleFailed extends ScheduleState {
  const ScheduleFailed(this.error, this.trace);

  final String error;
  final String trace;

  @override
  List<Object> get props => [error, trace];

  @override
  ScheduleFailed fromJson(Map<String, dynamic> json) {
    return ScheduleFailed(
      json['error'] as String,
      json['trace'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'trace': trace,
    };
  }
}

// Добавим статический метод для фабричного создания состояний на основе типа
ScheduleState scheduleStateFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'ScheduleInitial':
      return const ScheduleInitial().fromJson(json);
    case 'ScheduleLoading':
      return const ScheduleLoading().fromJson(json);
    case 'ScheduleSuccess':
      return const ScheduleSuccess(paras: []).fromJson(json);
    case 'ScheduleFailed':
      return const ScheduleFailed('', '').fromJson(json);
    default:
      throw Exception('Unknown ScheduleState type: ${json['type']}');
  }
}

// Добавим метод для преобразования состояния в JSON с указанием типа состояния
Map<String, dynamic> scheduleStateToJson(ScheduleState state) {
  final json = state.toJson();
  if (state is ScheduleInitial) {
    json['type'] = 'ScheduleInitial';
  } else if (state is ScheduleLoading) {
    json['type'] = 'ScheduleLoading';
  } else if (state is ScheduleSuccess) {
    json['type'] = 'ScheduleSuccess';
  } else if (state is ScheduleFailed) {
    json['type'] = 'ScheduleFailed';
  }
  return json;
}
