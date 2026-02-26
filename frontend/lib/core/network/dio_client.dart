import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../features/settings/presentation/providers/locale_provider.dart';
import '../router/app_router.dart';
import 'auth_interceptor.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final dioProvider = Provider<Dio>((ref) {
  final storage = ref.watch(secureStorageProvider);
  final currentLocale = ref.watch(localeProvider);
  final router = ref.watch(routerProvider);
  
  // Use appropriate localhost for emulator/simulator
  String baseUrl = 'http://localhost:8080/api/v1';
  if (!kIsWeb) {
    baseUrl = Platform.isAndroid ? 'http://10.0.2.2:8080/api/v1' : 'http://localhost:8080/api/v1';
  }
  
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Accept-Language': currentLocale.languageCode,
      },
    ),
  );
  
  dio.interceptors.add(AuthInterceptor(storage, router));
  // Add a log interceptor for debugging during development
  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  
  return dio;
});
