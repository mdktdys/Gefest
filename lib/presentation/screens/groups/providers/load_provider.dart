

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gefest/core/api/api.dart';


class Request{
  
}

final loadProvider = FutureProvider.family<List<SearchItem>,Request>((ref,type) async {
  return List.of([Group(id: 1, name: "", department: 1)]);
});