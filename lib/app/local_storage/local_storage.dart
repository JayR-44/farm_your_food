import 'package:get_storage/get_storage.dart';

import '../modules/models/user_model.dart';
class LocalStorage {
  LocalStorage._();

  static final storage = GetStorage();

  static void setIntro(bool value) => storage.write('intro', value);
  static bool getIntro() => storage.read('intro') ?? false;


  static void setIsUserLoggedIn(bool value) => storage.write('isUserLoggedIn', value);
  static bool isUserLoggedIn() => storage.read('isUserLoggedIn') ?? false;

  static void setUserName(String value) => storage.write('userName', value);
  static String getUserName() => storage.read('userName') ?? "";

  static void setAccountType(String value) => storage.write('accountType', value);
  static String getAccountType() => storage.read('accountType') ?? "";

  static void setUserId(String value) => storage.write('userId', value);
  static String getUserId() => storage.read('userId') ?? "";


  static void saveUserInfo(UserModel userModel) {
    setUserName(userModel.userName  ?? "");
    setUserId(userModel.userId ?? "");
    setAccountType(userModel.accountType ?? "");
  }

  static void removeUserDetails(){
    storage.remove('isUserLoggedIn');
    storage.remove('userName');
    storage.remove('userId');
    storage.remove('accountType');


  }


}