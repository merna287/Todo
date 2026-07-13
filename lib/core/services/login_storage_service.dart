import 'dart:convert';
import 'package:todo/features/auth/presentation/models/remembered_account.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginStorageService {
  static const _storage = FlutterSecureStorage();
  static const _accountsKey = 'remembered_accounts';

  static Future<List<RememberedAccount>> getAccounts() async {
    final data = await _storage.read(key: _accountsKey);

    if (data == null) return [];

    final decoded = jsonDecode(data) as List;

    return decoded
        .map((e) => RememberedAccount.fromJson(e))
        .toList();
  }

  static Future<void> saveAccount(
  RememberedAccount account,
) async {
  final accounts = await getAccounts();

  accounts.removeWhere(
    (e) => e.email == account.email,
  );

  accounts.add(account);

  await _storage.write(
    key: _accountsKey,
    value: jsonEncode(
      accounts.map((e) => e.toJson()).toList(),
    ),
  );
}

  static Future<String?> getEmail() async {
    return await _storage.read(key: 'email');
  }

  static Future<String?> getPassword() async {
    return await _storage.read(key: 'password');
  }

  static Future<void> clear() async {
    await _storage.deleteAll();
  }
}