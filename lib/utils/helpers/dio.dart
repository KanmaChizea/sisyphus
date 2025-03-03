import 'package:dio/dio.dart';

/// Dio singleton for the entire application
///
class DioHelper {
  static final Dio _dio = Dio(BaseOptions(baseUrl: ''));

  static Dio get instance {
    setupInterceptors();
    return _dio;
  }

  /// Interceptors to handle all the common logic of network requests
  /// On error, displays error dialog box with error message returned from
  /// the backend
  ///
  /// On request, fetches bearer token from db and adds to request headers
  ///
  static void setupInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper());
  }
}
