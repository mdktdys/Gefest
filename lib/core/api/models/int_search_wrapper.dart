import 'package:gefest/core/api/api.dart';

class SearchInt extends SearchItem {
  final int value;

  SearchInt({required this.value}) : super(searchText: value.toString(), type: SearchType.number, searchID: value);
}