import 'user_model.dart';

// Simple shared storage for registered users and the current logged-in user.
class AuthStore {
  static final List<AppUser> users = [];
  static AppUser? currentUser;

  static bool emailExists(String email) {
    return users.any((u) => u.email.toLowerCase() == email.toLowerCase());
  }

  static String? signUp(String name, String email, String password) {
    if (emailExists(email)) {
      return 'An account with this email already exists';
    }
    final newUser = AppUser(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      password: password,
    );
    users.add(newUser);
    currentUser = newUser;
    return null; // null means success
  }

  static String? logIn(String email, String password) {
    final matches = users.where(
      (u) => u.email.toLowerCase() == email.toLowerCase() && u.password == password,
    );
    if (matches.isEmpty) {
      return 'Incorrect email or password';
    }
    currentUser = matches.first;
    return null; // null means success
  }

  static void logOut() {
    currentUser = null;
  }
}