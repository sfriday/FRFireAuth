import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FRAuthRepositoryBase {
  Stream<User?> get authStateChange;
  User? get currentUser;
  Future<void> sendSmsToLogin(String phoneNumber, Function(String) callback);
  Future<UserCredential?> verifyNumber(String phoneNumber, String code);
  Future<void> signOut();
}

class FRAuthRepository implements FRAuthRepositoryBase {
  final auth = FirebaseAuth.instance;
  final functions = FirebaseFunctions.instance;

  @override
  Stream<User?> get authStateChange => auth.authStateChanges();

  @override
  User? get currentUser => auth.currentUser;

  @override
  Future<void> sendSmsToLogin(
    String phoneNumber,
    Function(String) callback,
  ) async {
    try {
      // Отправляем СМС
      final result = await functions
          .httpsCallable("sendSms")
          .call({"phoneNumber": phoneNumber});
      final json = jsonDecode(result.data);

      final status = json["status"];
      final message = json["message"];

      if (status == "error") {
        throw UnimplementedError(message);
      } else {
        callback(message);
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<UserCredential?> verifyNumber(
    String phoneNumber,
    String code,
  ) async {
    try {
      // Мы проверяем что код сходить в бд с кодом отправленной СМСки
      final result = await functions.httpsCallable("checkCode").call({
        "phoneNumber": phoneNumber,
        "code": code,
      });
      final json = jsonDecode(result.data);

      final status = json["status"];
      final message = json["message"];

      if (status == "error") {
        throw UnimplementedError(message);
      }

      return await auth.signInWithCustomToken(message);
    } catch (error) {
      rethrow;
    }
  }

  @override
  signOut() async {
    await auth.signOut();
  }
}
