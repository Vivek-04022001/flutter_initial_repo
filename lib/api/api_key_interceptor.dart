import 'package:dio/dio.dart';

class ApiKeyInterceptor extends Interceptor {
  final String apiKey;

  ApiKeyInterceptor(this.apiKey);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add the API key to every request as query param
    final queryParams = Map<String, dynamic>.from(options.queryParameters);
    queryParams['API_KEY'] = apiKey;
    options.queryParameters = queryParams;

    // Continue with the request
    super.onRequest(options, handler);
  }
}
