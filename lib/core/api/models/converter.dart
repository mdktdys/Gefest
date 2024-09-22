Iterable<T> parse<T>(List<dynamic> data, converter) {
  return data.map((e) => converter(e));
}
