import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class QueryParameters {
  final BuildContext context;

  QueryParameters(this.context);

  Map<String, String> get getParams => GoRouterState.of(context).uri.queryParameters;
}

abstract class ScreenPageWidget<T extends QueryParameters> extends ConsumerWidget {
  final T params;

  const ScreenPageWidget({
    required this.params,
    super.key,
  });
}
