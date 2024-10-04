
import 'package:cloud_firestore/cloud_firestore.dart';

import '../modules/models/user_model.dart';

class UserServices {
  static Future<UserModel> getUserById(String userId) async {
    UserModel userModel = UserModel();
    try {
      DocumentSnapshot<Map<String, dynamic>> docSnapShot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get();

      if (docSnapShot.exists) {
        Map<String, dynamic> userData = docSnapShot.data() ?? {};
        if (userData.isNotEmpty) {
          userData['userId'] = docSnapShot.id;
          userModel = UserModel.fromJson(userData);
        }
      }
      return userModel;
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }




}
