import 'package:cloud_firestore/cloud_firestore.dart';

class StoreServices {
  static final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  static Future<void> createStore(
      Map<String,dynamic> data) async {
    try {
      await fireStore.collection('store').add(data);
    } catch (e) {
      throw Exception("Email already exists");
    }

  }


}