import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spex/feature/authentication/model/user_model.dart';

import '../helpers/constants/constants.dart';

class LocalServices {
  Future<void> saveUser(User user) async {
    var box = await Hive.openBox<User>(ServicesConstants.USER_BOX);
    await box.put(ServicesConstants.USER_TEXT, user);
  }
  
  Future<User?> getUser() async{
    var box = await Hive.openBox<User>(ServicesConstants.USER_BOX);
    return box.get(ServicesConstants.USER_TEXT);
  }
  
  Future<void> deleteUser() async {
    var box = await Hive.openBox<User>(ServicesConstants.USER_BOX);
    await box.delete(ServicesConstants.USER_TEXT);
  }
  //
  // Future<void> deleteUserBox() async {
  //   await Hive.deleteBoxFromDisk(ServicesConstants.userBox);
  // }

  // Future<void> saveOnBoarding() async {
  //   var box = await Hive.openBox<bool>(ServicesConstants.ONBOARDING_BOX);
  //   await box.put(ServicesConstants.ONBOARDING_TEXT, true);
  // }

  // Future<bool> getOnBoarding() async {
  //   var box = await Hive.openBox<bool>(ServicesConstants.ONBOARDING_BOX);
  //   return box.get(ServicesConstants.ONBOARDING_TEXT) ?? false;
  // }

  Future<void> saveTheme(bool isDark) async {
    var box = await Hive.openBox<bool>(ServicesConstants.THEME_BOX);
    await box.put(ServicesConstants.THEME_TEXT, isDark);
  }

  Future<bool> getTheme() async {
    var box = await Hive.openBox<bool>(ServicesConstants.THEME_BOX);
    return box.get(ServicesConstants.THEME_TEXT) ?? true;
  }

  // Future<void> savePassword(String password) async {
  //   await getIt<FlutterSecureStorage>().write(key: ServicesConstants.PASSWORD_TEXT, value: password);
  // }
  // Future<String?> getPassword() async {
  //   return  await getIt<FlutterSecureStorage>().read(key:ServicesConstants.PASSWORD_TEXT,  );
  // }
  // Future<void> deletePassword() async {
  //   await getIt<FlutterSecureStorage>().delete(key:ServicesConstants.PASSWORD_TEXT,  );
  // }
}
