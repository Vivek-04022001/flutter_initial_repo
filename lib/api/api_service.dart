import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:f5_billion/api/api_key_interceptor.dart';
import 'package:f5_billion/api/connectivity_interceptor.dart';

class ApiService {
  static const String baseUrl = 'https://new.tradeconstructionworld.com/api/';
  static const String apiKey = 'TRICEWORK';
  static late Dio _dio;

  //Initialize Dio once in your app lifecycle
  static void init() {
    // Setup default options
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
    );

    _dio = Dio(options);
    _dio.interceptors.add(ApiKeyInterceptor(apiKey));
    _dio.interceptors.add(ConnectivityInterceptor());

    _dio.interceptors.add(
      LogInterceptor(responseBody: false, requestBody: false),
    );
  }

  // Post (JSON)
  static Future<Map<String, dynamic>?> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      // handle the response
      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          return response.data;
        } else if (response.data is String) {
          return jsonDecode(response.data);
        }
      }
      // If we reach here, maybe an error
      return {'success': false, 'message': 'Invalid response format'};
    } on DioException catch (e) {
      return {'success': false, 'message': e.message};
    }
  }

  // Post (Form)
  static Future<Map<String, dynamic>?> postForm(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      FormData formData = FormData.fromMap(data);
      Response response = await _dio.post(endpoint, data: formData);

      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          return response.data;
        } else if (response.data is String) {
          return jsonDecode(response.data);
        }
      }
      return {'success': false, 'message': 'Invalid response format'};
    } on DioException catch (e) {
      return {'success': false, 'message': e.message};
    }
  }

  static Future<Map<String, dynamic>?> get(String endpoint) async {
    try {
      Response response = await _dio.get(endpoint);
      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          return response.data;
        } else if (response.data is String) {
          return jsonDecode(response.data);
        }
      }
      return {'success': false, 'message': 'Invalid response format'};
    } on DioException catch (e) {
      return {'success': false, 'message': e.message};
    }
  }
}
