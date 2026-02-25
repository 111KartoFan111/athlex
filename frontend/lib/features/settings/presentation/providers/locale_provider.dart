import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:ui';

import '../../../core/network/dio_client.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier(ref);
});

class LocaleNotifier extends StateNotifier<Locale> {
  static const _langKey = 'app_language';
  final storage = const FlutterSecureStorage();
  final Ref ref;

  LocaleNotifier(this.ref) : super(const Locale('en')) {
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    final savedCode = await storage.read(key: _langKey);
    if (savedCode != null) {
      state = Locale(savedCode);
    }
  }

  Future<void> setLocale(String languageCode) async {
    await storage.write(key: _langKey, value: languageCode);
    state = Locale(languageCode);
    
    // Refresh Dio to update interceptor headers
    ref.invalidate(dioProvider); 
  }
}
