import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gefest/core/api/api.dart';
import 'package:gefest/theme.dart';

class TeachersScreen extends ConsumerStatefulWidget {
  const TeachersScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TeachersScreenState();
}

class _TeachersScreenState extends ConsumerState<TeachersScreen> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [
          Text(
            "Преподаватели",
            style: Fa.big,
          ),
          Builder(builder: (context) {
            return ref.watch(teachersProvider).when(data: (data) {
              return Column(
                children: data.map((e) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: Theme.of(context).colorScheme.onSurface)),
                      padding: const EdgeInsets.all(10),
                      child: Text(e.name??'',style: Fa.medium,));
                }).toList(),
              );
            }, error: (e, o) {
              return Center(
                child: Text("Ошибка ${e.toString()} ${o.toString()}"),
              );
            }, loading: () {
              return const Center(child: CircularProgressIndicator());
            });
          })
        ],
      ),
    );
  }
}