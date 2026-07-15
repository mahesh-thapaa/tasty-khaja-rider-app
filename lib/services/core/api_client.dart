import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  static void Function()? onUnauthorized;
  static final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  late final Dio dio;

  ApiClient._internal() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://api.tastykhaja.com/api',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? token = await secureStorage.read(key: 'rider_auth_token');
          if (token != null) {
            options.headers['Cookie'] = 'token=$token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            await secureStorage.delete(key: 'rider_auth_token');
            onUnauthorized?.call();
          }
          return handler.next(error);
        },
      ),
    );
  }
}
