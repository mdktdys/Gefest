import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:gefest/core/api/api.dart';
import 'package:gefest/core/api/data/data.dart';
import 'package:gefest/core/basics.dart';
import 'package:gefest/presentation/screens/load/providers/load_provider.dart';
import 'package:gefest/presentation/shared/async_provider.dart';
import 'package:gefest/theme.dart';

class LoadScreenParameters extends QueryParameters {
  LoadScreenParameters(super.context);

  // int get teacherId => int.parse(getParams['id']!);
}

class LoadScreen extends ScreenPageWidget<LoadScreenParameters> {
  LoadScreen(BuildContext context)
      : super(params: LoadScreenParameters(context));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncProvider(
      provider: loadProvider,
      data: (data) {
        final dataProvider_ = ref.watch(dataProvider);
        final employeeDataSource = EmployeeDataSource(
            data: data, dataProvider: dataProvider_, context: context);
        return SfDataGridTheme(
          data: SfDataGridThemeData(
            gridLineColor: Colors.white.withOpacity(0.05),
          ),
          child: SfDataGrid(
            highlightRowOnHover: false,
            columnWidthMode: ColumnWidthMode.fill,
            allowColumnsDragging: true,
            allowColumnsResizing: true,
            allowFiltering: true,
            allowMultiColumnSorting: true,
            allowExpandCollapseGroup: true,
            allowSorting: true,
            showHorizontalScrollbar: true,
            allowTriStateSorting: true,
            source: employeeDataSource,
            columns: [
              GridColumn(
                  columnName: 'group',
                  label: Text("Группа",
                      style: Fa.smedium.copyWith(color: Colors.white)),
                  columnWidthMode: ColumnWidthMode.fitByColumnName),
              GridColumn(
                  columnName: 'code',
                  label: Text("Код",
                      style: Fa.smedium.copyWith(color: Colors.white)),
                  columnWidthMode: ColumnWidthMode.fitByColumnName),
              GridColumn(
                  columnName: 'course',
                  label: Text("Предмет",
                      style: Fa.smedium.copyWith(color: Colors.white))),
              GridColumn(
                  columnName: 'teacher',
                  label: Text("Препод",
                      style: Fa.smedium.copyWith(color: Colors.white)),
                  columnWidthMode: ColumnWidthMode.fitByCellValue)
            ],
          ),
        );
      },
    );
  }
}

class EmployeeDataSource extends DataGridSource {
  final BuildContext context;
  EmployeeDataSource(
      {required List<LoadLink> data,
      required DataProvider dataProvider,
      required this.context}) {
    _employees = data
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'group',
                  value: dataProvider.getGroupById(e.group!)?.name),
              DataGridCell<String>(
                  columnName: 'code',
                  value:
                      dataProvider.getDisciplineCode(e.codediscipline!)?.name),
              DataGridCell<Course>(
                  columnName: 'course',
                  value: dataProvider.getCourseById(e.course!)),
              DataGridCell<Teacher>(
                  columnName: 'teacher',
                  value: dataProvider.getTeacherById(e.teacher!)),
            ]))
        .toList();
  }

  List<DataGridRow> _employees = [];

  @override
  List<DataGridRow> get rows => _employees;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      switch (dataGridCell.columnName) {
        case 'teacher':
          final value = dataGridCell.value as Teacher;
          return GridCell(
            onTap: () {
                context.go(Uri(
                    path: '/teacher',
                    queryParameters: {'id': value.id.toString()}).toString());
              },
            text: value.name.toString()
          );
         case 'course':
          final value = dataGridCell.value as Course;
          return GridCell(
            onTap: () {
                context.go(Uri(
                    path: '/course',
                    queryParameters: {'id': value.id.toString()}).toString());
              },
            text: value.name.toString()
          );
        default:
          return GridCell(onTap: null, text: dataGridCell.value.toString());
      }
    }).toList());
  }
}

class GridCell extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  const GridCell({required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        hoverColor: Theme.of(context).colorScheme.onSurface,
        onTap: () {
          onTap?.call();
        },
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Text(text, style: Fa.small.copyWith(color: Colors.white)),
        ),
      ),
    );
  }
}
