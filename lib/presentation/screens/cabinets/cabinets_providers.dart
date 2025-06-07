import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'package:gefest/core/api/data/data.dart';
import 'package:gefest/core/api/models/cabinet.dart';


final cabinetStringFilterProvider = StateProvider<String>((ref) {
  return '';
});

final filteredCabinetProvider = FutureProvider<List<Cabinet>>((ref) async {
  final allCabinets = await ref.watch(cabinetsProvider.future);
  final String filter = ref.watch(cabinetStringFilterProvider).toLowerCase();
  return allCabinets.where((final Cabinet cabinet) => cabinet.name.toLowerCase().contains(filter)).toList();
});