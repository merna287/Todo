import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/features/auth/presentation/models/remembered_account.dart';

class AuthLocalService {
  static const _secureStorage = FlutterSecureStorage();

  // Keys for SharedPreferences
  static const _emailHistoryKey = 'email_history';
  static const _nameHistoryKey = 'name_history';
  static const _rememberedAccountKey = 'remembered_account';

  /// ===== EMAIL HISTORY =====

  /// Get all previously used emails
  static Future<List<String>> getSavedEmails() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getStringList(_emailHistoryKey) ?? [];
    } catch (e) {
      print('Error getting saved emails: $e');
      return [];
    }
  }

  /// Save email to history (prevents duplicates, trims email)
  static Future<void> saveEmailHistory(String email) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final emails = prefs.getStringList(_emailHistoryKey) ?? [];

      final trimmedEmail = email.trim().toLowerCase();

      // Check if email already exists (case-insensitive)
      if (!emails.any((e) => e.toLowerCase() == trimmedEmail)) {
        emails.insert(0, trimmedEmail); // Add to beginning
        await prefs.setStringList(_emailHistoryKey, emails);
      }
    } catch (e) {
      print('Error saving email history: $e');
    }
  }

  /// Remove specific email from history
  static Future<void> removeEmailFromHistory(String email) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final emails = prefs.getStringList(_emailHistoryKey) ?? [];

      emails.removeWhere((e) => e.toLowerCase() == email.trim().toLowerCase());
      await prefs.setStringList(_emailHistoryKey, emails);
    } catch (e) {
      print('Error removing email from history: $e');
    }
  }

  /// Clear all email history
  static Future<void> clearEmailHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_emailHistoryKey);
    } catch (e) {
      print('Error clearing email history: $e');
    }
  }

  /// ===== NAME HISTORY =====

  /// Get all previously used names
  static Future<List<String>> getSavedNames() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getStringList(_nameHistoryKey) ?? [];
    } catch (e) {
      print('Error getting saved names: $e');
      return [];
    }
  }

  /// Save name to history (prevents duplicates)
  static Future<void> saveNameHistory(String name) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final names = prefs.getStringList(_nameHistoryKey) ?? [];

      final trimmedName = name.trim();

      // Check if name already exists
      if (!names.contains(trimmedName)) {
        names.insert(0, trimmedName); // Add to beginning
        await prefs.setStringList(_nameHistoryKey, names);
      }
    } catch (e) {
      print('Error saving name history: $e');
    }
  }

  /// Remove specific name from history
  static Future<void> removeNameFromHistory(String name) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final names = prefs.getStringList(_nameHistoryKey) ?? [];

      names.removeWhere((n) => n == name.trim());
      await prefs.setStringList(_nameHistoryKey, names);
    } catch (e) {
      print('Error removing name from history: $e');
    }
  }

  /// Clear all name history
  static Future<void> clearNameHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_nameHistoryKey);
    } catch (e) {
      print('Error clearing name history: $e');
    }
  }

  /// ===== REMEMBERED ACCOUNT =====

  /// Save email-password pair when "Remember Me" is enabled
  static Future<void> saveRememberedAccount({
    required String email,
    required String password,
  }) async {
    try {
      final account = RememberedAccount(
        email: email.trim(),
        password: password,
        savedAt: DateTime.now(),
      );

      await _secureStorage.write(
        key: _rememberedAccountKey,
        value: account.toJsonString(),
      );

      // Also add to email history
      await saveEmailHistory(email);
    } catch (e) {
      print('Error saving remembered account: $e');
    }
  }

  /// Get the remembered account (if any)
  static Future<RememberedAccount?> getRememberedAccount() async {
    try {
      final jsonString = await _secureStorage.read(key: _rememberedAccountKey);
      if (jsonString == null) return null;

      return RememberedAccount.fromJsonString(jsonString);
    } catch (e) {
      print('Error getting remembered account: $e');
      return null;
    }
  }

  /// Check if there's a remembered account
  static Future<bool> hasRememberedAccount() async {
    try {
      final account = await getRememberedAccount();
      return account != null;
    } catch (e) {
      print('Error checking remembered account: $e');
      return false;
    }
  }

  /// Get password for a specific email (if it was remembered)
  static Future<String?> getPasswordForEmail(String email) async {
    try {
      final account = await getRememberedAccount();
      if (account != null && account.email.toLowerCase() == email.trim().toLowerCase()) {
        return account.password;
      }
      return null;
    } catch (e) {
      print('Error getting password for email: $e');
      return null;
    }
  }

  /// Remove remembered account
  static Future<void> removeRememberedAccount() async {
    try {
      await _secureStorage.delete(key: _rememberedAccountKey);
    } catch (e) {
      print('Error removing remembered account: $e');
    }
  }

  /// ===== UTILITY METHODS =====

  /// Clear all stored data (useful for logout)
  static Future<void> clearAllData() async {
    try {
      await _secureStorage.deleteAll();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_emailHistoryKey);
      await prefs.remove(_nameHistoryKey);
    } catch (e) {
      print('Error clearing all data: $e');
    }
  }

  /// Get recent suggestions (emails or names)
  static Future<List<String>> getRecentEmails({int limit = 5}) async {
    try {
      final emails = await getSavedEmails();
      return emails.take(limit).toList();
    } catch (e) {
      print('Error getting recent emails: $e');
      return [];
    }
  }

  static Future<List<String>> getRecentNames({int limit = 5}) async {
    try {
      final names = await getSavedNames();
      return names.take(limit).toList();
    } catch (e) {
      print('Error getting recent names: $e');
      return [];
    }
  }
}
