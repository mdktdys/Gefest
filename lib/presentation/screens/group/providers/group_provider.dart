import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:gefest/core/api/api.dart';
import 'package:gefest/presentation/screens/load/providers/load_provider.dart';

final groupProvider = FutureProvider.family<Group, int>((ref,id) async {
  return (await ref.watch(groupsProvider.future)).where((group) => group.id == id).first;
});

final groupLinksProvider = FutureProvider.family<List<LoadLink>, int>((ref, int group) async {
  final client = GetIt.I.get<Supabase>().client;
  final List<Map<String, dynamic>> result = await client.from('loadlinkers').select('*').eq('group', group);
  return result.map((final Map<String, dynamic> map) => LoadLink.fromMap(map)).toList();
});