import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  final Dio dio = Dio();
  final _secureStorage = const FlutterSecureStorage();

  ApiClient() {
    dio.options.baseUrl = 'https://api.tastykhaja.com/api';
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? token = await _secureStorage.read(key: 'rider_auth_token');
          if (token != null) {
            options.headers['Cookie'] = 'token=$token';
          }
          return handler.next(options);
        },
      ),
    );
  }
}
