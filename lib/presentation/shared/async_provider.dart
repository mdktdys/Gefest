import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncProvider<T> extends ConsumerWidget {
  final FutureProvider<T> provider;
  final Widget Function()? loading;
  final Widget Function(T)? data;
  final Widget Function(Object,StackTrace)? error;

  const AsyncProvider({
    required this.provider,
    this.data,
    this.loading,
    this.error,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return ref.watch(provider).when(data: data?? (data){
      return Text(data.toString());
    }, error: error??(e,o){
      return Center(child: Text(e.toString()),);
    }, loading: loading??(){
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}

