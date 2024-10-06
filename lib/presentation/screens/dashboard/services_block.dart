import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gefest/core/api/models/DTO/containers.dart';
import 'package:gefest/presentation/screens/dashboard/providers/test_provider.dart';
import 'package:gefest/presentation/shared/outline_area.dart';
import 'package:gefest/theme.dart';

class ServicesBlock extends ConsumerStatefulWidget {
  const ServicesBlock({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ServicesBlockState();
}

class _ServicesBlockState extends ConsumerState<ServicesBlock> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Инфраструктура",
          style: Fa.big,
        ),
        SizedBox(
          height: 5,
        ),
        Builder(builder: (context) {
          return ref.watch(testProvider).when(data: (data) {
            return Wrap(
                runAlignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.start,
                spacing: 5,
                runSpacing: 5,
                children: data!.containers.where((c)=>!c.name.contains("dokploy"))
                    .map((e) => ServiceTile(e:e))
                    .toList());
          }, error: (e, o) {
            return Center(
              child: Text(e.toString()),
            );
          }, loading: () {
            return CircularProgressIndicator();
          });
        })
      ],
    );
  }
}

class ServiceTile extends StatelessWidget {
  final DockerContainerInfo e;
  const ServiceTile({
    super.key,
    required this.e
  });

  @override
  Widget build(BuildContext context) {
    final name = e.name;

    return OutlineArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name, style: Fa.medium,
            ),
            Text(
              e.status,
              style: Fa.small.copyWith(
                  color: e.status == "running"
                      ? Colors.green
                      : Colors.red),
            ),
          ],
        ));
  }
}
