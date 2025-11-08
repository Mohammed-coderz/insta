import 'dart:convert';
import 'package:http/http.dart' as http;

import '../const/app_constants.dart';
import '../errors/server_exceptions.dart';
import '../utils/io.dart';
import '../utils/shared_preferences_helper.dart';
import 'api_response.dart';

class ApiClient {
  // ---------- Base & Headers ----------

  static String get _base => AppConstants.Base_URL;

  static Map<String, String> _authHeaders({bool jsonContent = false}) {
    final headers = <String, String>{};
    final token = SharedPreferencesHelper.getString("access_token") ?? '';
    if (token != "") headers['Authorization'] = 'Bearer $token';
    if (jsonContent) headers['Content-Type'] = 'application/json';
    return headers;
  }

  // ---------- Parsing helpers ----------

  static ApiResponse<T> _okSingle<T>(
      String decodedBody, {
        T Function(Object? data)? fromJsonT,
      }) {
    final map = json.decode(decodedBody) as Map<String, dynamic>;
    return ApiResponse<T>.fromJson(
      map,
      fromJsonT: fromJsonT,
    );
  }

  static ApiResponse<T> _okList<T>(
      String decodedBody, {
        required T Function(Object? data) fromJsonT,
      }) {
    final map = json.decode(decodedBody) as Map<String, dynamic>;
    return ApiResponse<T>.fromJsonList(
      map,
      fromJsonT: fromJsonT,
    );
  }

  static Never _throwError(http.Response res) {
    // Parse common error shapes safely; fall back to status text
    try {
      final decoded = utf8.decode(res.bodyBytes);
      final obj = json.decode(decoded);
      if (obj is Map<String, dynamic>) {
        final bool? result = obj['result'] is bool ? obj['result'] as bool : null;
        final dynamic data = obj['data'];
        final String? message = (obj['message'] as String?) ??
            (obj['error'] as String?) ??
            (data is String ? data : null);

        throw ServerException(
          status: result,
          showMessageToUser: null,
          message: message ?? 'Request failed',
          statusCode: res.statusCode,
        );
      }
      throw ServerException(
        status: false,
        showMessageToUser: null,
        message: decoded.isNotEmpty ? decoded : 'Request failed',
        statusCode: res.statusCode,
      );
    } catch (_) {
      throw ServerException(
        status: false,
        showMessageToUser: null,
        message: 'Request failed with status ${res.statusCode}',
        statusCode: res.statusCode,
      );
    }
  }

  // ---------- GET ----------

  static Future<ApiResponse<T>> getData<T>({
    required String endpoint,
    T Function(Object? data)? fromJsonT,
  }) async {
    final res = await http.get(
      Uri.parse('$_base$endpoint'),
      headers: _authHeaders(),
    );

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return _okSingle<T>(
        utf8.decode(res.bodyBytes),
        fromJsonT: fromJsonT,
      );
    }
    _throwError(res);
  }

  static Future<ApiResponse<T>> getDataList<T>({
    required String endpoint,
    required T Function(Object? data) fromJsonT,
  }) async {
    final res = await http.get(
      Uri.parse('$_base$endpoint'),
      headers: _authHeaders(),
    );

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return _okList<T>(
        utf8.decode(res.bodyBytes),
        fromJsonT: fromJsonT,
      );
    }
    _throwError(res);
  }

  // ---------- POST (JSON) ----------

  static Future<ApiResponse<T>> postData<T>({
    required String endpoint,
    Map<String, dynamic>? body,
    T Function(Object? data)? fromJsonT,
  }) async {
    final res = await http.post(
      Uri.parse('$_base$endpoint'),
      headers: _authHeaders(jsonContent: true),
      body: body == null ? null : jsonEncode(body),
    );


    if (res.statusCode >= 200 && res.statusCode < 300) {
      IO.printOk(res.statusCode.toString());
      IO.printOk(res.body.toString());
      return _okSingle<T>(
        utf8.decode(res.bodyBytes),
        fromJsonT: fromJsonT,
      );
    }
    _throwError(res);
  }

  static Future<ApiResponse<T>> postDataList<T>({
    required String endpoint,
    Map<String, dynamic>? body,
    required T Function(Object? data) fromJsonT,
  }) async {
    final res = await http.post(
      Uri.parse('$_base$endpoint'),
      headers: _authHeaders(jsonContent: true),
      body: body == null ? null : jsonEncode(body),
    );

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return _okList<T>(
        utf8.decode(res.bodyBytes),
        fromJsonT: fromJsonT,
      );
    }
    _throwError(res);
  }

  /// For endpoints where you want `data` coerced to String.
  static Future<ApiResponse<String>> postDataString({
    required String endpoint,
    required Map<String, dynamic> body,
  }) async {
    final res = await http.post(
      Uri.parse('$_base$endpoint'),
      headers: _authHeaders(jsonContent: true),
      body: jsonEncode(body),
    );

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return _okSingle<String>(
        utf8.decode(res.bodyBytes),
        fromJsonT: (v) => v?.toString() ?? '',
      );
    }
    _throwError(res);
  }

  // ---------- POST (Multipart) ----------

  static Future<ApiResponse<T>> postMultiPartData<T>({
    required String endpoint,
    required Map<String, String> fields,
    required List<http.MultipartFile> files,
    required T Function(Object? data) fromJsonT,
  }) async {
    final uri = Uri.parse('$_base$endpoint');
    final request = http.MultipartRequest('POST', uri);

    // Auth only (Multipart sets its own content-type)
    final token = SharedPreferencesHelper.getString("access_token") ?? '';
    if (token != "") {
      request.headers['Authorization'] = 'Bearer $token';
    }

    request.fields.addAll(fields);
    request.files.addAll(files);

    final streamed = await request.send();
    final res = await http.Response.fromStream(streamed);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return _okSingle<T>(
        utf8.decode(res.bodyBytes),
        fromJsonT: fromJsonT,
      );
    }
    _throwError(res);
  }
}