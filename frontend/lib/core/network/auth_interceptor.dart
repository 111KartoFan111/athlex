import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage;
  final GoRouter _router;

  AuthInterceptor(this._storage, this._router);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _storage.read(key: 'jwt_token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Clear token and force navigation to login
      await _storage.delete(key: 'jwt_token');
      _router.go('/login');
    }
    super.onError(err, handler);
  }
}
