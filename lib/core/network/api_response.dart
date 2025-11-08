class ApiResponse<T> {
  final bool result;     // true/false from API
  final T? data;         // single object or primitive
  final List<T>? dataList; // list form when data is a List

  const ApiResponse({
    required this.result,
    this.data,
    this.dataList,
  });

  /// Generic parser:
  /// - If `data` is a List -> fills `dataList`
  /// - Else -> fills `data`
  factory ApiResponse.fromJson(
      Map<String, dynamic> json, {
        T Function(Object? value)? fromJsonT,
      }) {
    final res = (json['result'] == true);

    final mapper = fromJsonT ?? (Object? v) => v as T;

    final raw = json['data'];

    if (raw is List) {
      // List payload
      final list = raw.map<T>(mapper).toList();
      return ApiResponse<T>(result: res, dataList: list);
    } else {
      // Single payload (could be null/primitive/map)
      final single = raw == null ? null : mapper(raw);
      return ApiResponse<T>(result: res, data: single);
    }
  }

  /// Convenience when you *know* it's a list.
  factory ApiResponse.fromJsonList(
      Map<String, dynamic> json, {
        required T Function(Object? value) fromJsonT,
      }) {
    final res = (json['result'] == true);
    final raw = json['data'];
    final list = (raw is List) ? raw.map<T>(fromJsonT).toList() : <T>[];
    return ApiResponse<T>(result: res, dataList: list);
  }

  /// Convenience when you *know* it's a single value.
  factory ApiResponse.fromJsonSingle(
      Map<String, dynamic> json, {
        T Function(Object? value)? fromJsonT,
      }) {
    final res = (json['result'] == true);
    final raw = json['data'];
    final mapper = fromJsonT ?? (Object? v) => v as T;
    final single = raw == null ? null : mapper(raw);
    return ApiResponse<T>(result: res, data: single);
  }
}