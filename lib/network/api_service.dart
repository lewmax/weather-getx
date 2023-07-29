import 'dart:convert';
import 'package:get/get.dart';
import '../utils/snackbar_utils.dart';
import 'network_response.dart';

enum ApiRequestType { get, post, put, delete }

class ApiService {
  final _connect = GetConnect();

  Future<NetworkResponse<T>> request<T>(
    String path, {
    required ApiRequestType type,
    dynamic body,
    Map<String, dynamic>? query,
    T Function(dynamic)? fromJson,
  }) async {
    Response? response;
    switch (type) {
      case ApiRequestType.get:
        response = await _connect.get(path, query: query);
      case ApiRequestType.post:
        response = await _connect.post(path, body, query: query);
      case ApiRequestType.put:
        response = await _connect.put(path, body, query: query);
      case ApiRequestType.delete:
        response = await _connect.delete(path, query: query);
    }
    if (!response.isOk) {
      return NetworkResponse.error(response.statusCode, response.statusText);
    }
    Object? mappedObj;
    try {
      if (fromJson != null && response.body != null) {
        if (response.body is String) {
          mappedObj = fromJson(response.body);
        } else if (response.body is Map<String, dynamic>) {
          mappedObj = fromJson(jsonEncode(response.body));
        }
      }
    } on Exception catch (e) {
      final error = response.body['message'] ?? e.toString();
      final title = response.body['message'] ?? e.toString();
      SnackbarUtils.error(title as String, error as String);
    }

    return NetworkResponse(
      fromJson == null ? response.body as T : mappedObj as T,
      response.statusCode,
      null,
    );
  }
}
