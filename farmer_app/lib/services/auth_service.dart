import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _isLoggedInKey = "isLoggedIn";
  static const String _userNameKey = "userName";
  static const String _userPhoneKey = "userPhone";
  static const String _userEmailKey = "userEmail";
  static const String _userLocationKey = "userLocation";
  static const String _userImageKey = "userImage";

  // Save user data after login/signup/edit
  static Future<void> saveUser(String name, String phone,
      {String? email, String? location, String? imagePath}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setString(_userNameKey, name);
    await prefs.setString(_userPhoneKey, phone);
    if (email != null) await prefs.setString(_userEmailKey, email);
    if (location != null) await prefs.setString(_userLocationKey, location);
    if (imagePath != null) await prefs.setString(_userImageKey, imagePath);
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Get user name
  static Future<String?> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey);
  }

  // Get user phone
  static Future<String?> getUserPhone() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userPhoneKey);
  }

  // Get user email
  static Future<String?> getUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmailKey);
  }

  // Get user location
  static Future<String?> getUserLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userLocationKey);
  }

  // Get user image path
  static Future<String?> getUserImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userImageKey);
  }

  // Logout (Clear session)
  static Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clears all data
  }
}
