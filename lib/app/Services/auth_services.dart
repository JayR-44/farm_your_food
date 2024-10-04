
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../local_storage/local_storage.dart';
import '../modules/models/user_model.dart';

class AuthService {
  static final FirebaseFirestore fireStore = FirebaseFirestore.instance;


  static Future<String?> registerWithEmail(
      String email, String password) async {
    try {
      String? userId = '';
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = userCredential.user!;
      userId = user.uid;
      return userId;
    } catch (e) {
      print('Error registering user: $e');
    }
  }

  static Future<void> registerUser(UserModel userModel) async {
    try {
      QuerySnapshot<Map<String, dynamic>> existingUsersSnapshot =
      await fireStore
          .collection('users')
          .where('email', isEqualTo: userModel.email)
          .get();

      if (existingUsersSnapshot.docs.isNotEmpty &&
          existingUsersSnapshot.docs[0].id != LocalStorage.getUserId()) {
        throw EmailAlreadyExistsException();
      }
      String userId = await registerWithEmail(userModel.email!, userModel.password!) ?? "";
        await fireStore
            .collection('users')
            .doc(userId)
            .set(userModel.toJsonForRegistration());

    } catch (e) {

      if (e is EmailAlreadyExistsException) {
        throw Exception("Email already exists");
      } else {
        throw Exception("Registration failed");
      }
    }
  }



  static Future<UserModel> loginUser(UserModel userModel) async {
    try {
      QuerySnapshot<Map<String, dynamic>> matchingUsersSnapshot =
      await fireStore
          .collection('users')
          .where('email', isEqualTo: userModel.email)
          .get();

      if (matchingUsersSnapshot.docs.isEmpty) {
        throw LoginError.userNotFound; // User with provided email not found
      }

      QueryDocumentSnapshot<Map<String, dynamic>> userDoc =
      matchingUsersSnapshot.docs[0];

      if (userDoc.data()['password'] != userModel.password) {
        throw LoginError.invalidPassword; // Invalid password
      }

      Map<String, dynamic> userData = userDoc.data();
      userData['userId'] = userDoc.id;
      print('USER DATA ${userData.toString()}');

      UserModel user = UserModel.fromJson(userData);

      return user;
    } catch (e) {
      if (e is LoginError) {
        String errorMessage = "";
        switch (e) {
          case LoginError.userNotFound:
            errorMessage = "User not found";
            break;
          case LoginError.invalidPassword:
            errorMessage = "Invalid password";
            break;
          case LoginError.loginFailed:
            errorMessage = "Login failed";
            break;
        }
        throw Exception(errorMessage);
      } else {
        throw Exception("Login failed");
      }
    }
  }

}

enum LoginError {
  userNotFound,
  invalidPassword,
  loginFailed,
}

class EmailAlreadyExistsException implements Exception {}
