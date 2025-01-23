// import 'package:catfish_mobile/features/authentication/models/user.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final initialUser = User(
//   firstName: "",
//   lastName: "",
//   token: "",
//   firstTimeOpen: true,
// );

// final class UserNotifier extends StateNotifier<User> {
//   UserNotifier() : super(initialUser);

//   void setFirstTimeOpen(bool firstTimeOpen) {
//     state = state.copyWith(firstTimeOpen: firstTimeOpen);
//   }
// }

// final userProvider = StateNotifierProvider<UserNotifier, User>((ref) {
//   return UserNotifier();
// });

// import 'dart:convert';
// import 'package:catfish_mobile/features/authentication/models/user.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// // Default initial user data
// final initialUser = User(
//   firstName: "",
//   lastName: "",
//   token: "",
//   firstTimeOpen: true,
// );

// // UserNotifier with persistence logic
// final class UserNotifier extends StateNotifier<User> {
//   UserNotifier() : super(initialUser) {
//     _loadUserData();
//   }

//   // Load user data from SharedPreferences
//   Future<void> _loadUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userData = prefs.getString('user_data');
//     if (userData != null) {
//       final Map<String, Object> userMap = jsonDecode(userData);
//       state = User.fromJson(userMap);
//     }
//   }

//   // Set the firstTimeOpen flag and persist user data
//   void setFirstTimeOpen(bool firstTimeOpen) async {
//     state = state.copyWith(firstTimeOpen: firstTimeOpen);
//     _saveUserData();
//   }

//   // Save user data to SharedPreferences
//   Future<void> _saveUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userJson = jsonEncode(state.toJson());
//     prefs.setString('user_data', userJson);
//   }
// }

// // Define a UserProvider
// final userProvider = StateNotifierProvider<UserNotifier, User>((ref) {
//   return UserNotifier();
// });

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:catfish_mobile/features/authentication/models/user.dart';

final initialUser = User(
  firstName: "",
  lastName: "",
  token: "",
  firstTimeOpen: true,
);

class UserNotifier extends StateNotifier<User> {
  final SharedPreferences _prefs;

  UserNotifier(this._prefs) : super(_loadUserFromPrefs(_prefs));

  static User _loadUserFromPrefs(SharedPreferences prefs) {
    final userJson = prefs.getString('user');
    return userJson != null ? User.fromJson(json.decode(userJson)) : initialUser;
  }

  void setFirstTimeOpen(bool firstTimeOpen) {
    final newState = state.copyWith(firstTimeOpen: firstTimeOpen);
    _saveUserToPrefs(newState);
    state = newState;
  }

  void _saveUserToPrefs(User user) {
    _prefs.setString('user', json.encode(user.toJson()));
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return UserNotifier(prefs);
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Must be overridden');
});
