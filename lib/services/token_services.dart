import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenServices {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  AndroidOptions secureOption() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  Future<void> createToken(String value) async {
    await storage.write(key: "token", value: value, aOptions: secureOption());
  }

  Future<void> setUserType(String type) async {
    await storage.write(key: "type", value: type, aOptions: secureOption());
  }

  Future<void> setUserId(String userId) async {
    await storage.write(
        key: "user_id", value: userId, aOptions: secureOption());
  }

  Future<String> getToken() async {
    return await storage.read(key: 'token', aOptions: secureOption()) ?? "";
  }

  Future<String> getUserType() async {
    return await storage.read(key: 'type', aOptions: secureOption()) ?? "";
  }

  Future<String> getUserId() async {
    return await storage.read(key: 'user_id', aOptions: secureOption()) ?? "";
  }

  Future<void> clearToken() async {
    await storage.deleteAll(aOptions: secureOption());
  }
}

TokenServices tokenServices = TokenServices();
