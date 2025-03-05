import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class ConnectivityInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      // We have no internet connection -> throw error or handle it
      handler.reject(
        DioException(
          requestOptions: options,
          error: 'No internet connection available',
          type: DioExceptionType.connectionError,
        ),
      );
    } else {
      super.onRequest(options, handler);
    }
  }
}
