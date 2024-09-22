import 'package:gefest/core/api/data/schedule/types.dart';

abstract class SearchItem {
  final String searchText;
  final SearchType type;
  final int searchID;

  SearchItem(
      {required this.searchText, required this.type, required this.searchID});
}
