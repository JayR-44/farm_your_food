import 'package:cloud_firestore/cloud_firestore.dart';

import '../local_storage/local_storage.dart';
import '../modules/models/order_model.dart';
import '../modules/models/product_model.dart';

class ProductServices {
  static final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  static Future<void> addProduct(
      Map<String,dynamic> data) async {
    try {
      await fireStore.collection('products').add(data);
    } catch (e) {
      throw Exception("Email already exists");
    }

  }


  static Future<List<ProductDetailsModel>> fetchFruitProducts(productType) async {
    List<ProductDetailsModel> products = [];
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('productType', isEqualTo: productType)
          .get();

      for (var doc in snapshot.docs) {
        products.add(ProductDetailsModel.fromJson(doc));
      }
    } catch (e) {
      throw Exception(e);
    }

    return products;
  }


  static Future<void> addToCart(ProductDetailsModel data) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await fireStore.collection("carts").where('productId', isEqualTo : data.productId).where('buyerId', isEqualTo : data.buyerId).get();
      if(querySnapshot.size > 0){
        throw AddToCartEnum.alreadyAdded;
      }
      await fireStore.collection('carts').add(data.toJsonForCart());
    } catch (e) {
      if (e is AddToCartEnum) {
        String errorMessage = "";
        switch (e) {
          case AddToCartEnum.alreadyAdded:
            errorMessage = "This product is already in cart";
            break;
        }
        throw Exception(errorMessage);
      } else {
        throw Exception("$e");
      }

  }
  }

  static Future<List<ProductDetailsModel>> fetchUserCarts() async {
    List<ProductDetailsModel> products = [];
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('carts')
          .where('buyerId', isEqualTo: LocalStorage.getUserId())
          .get();

      for (var doc in snapshot.docs) {
        products.add(ProductDetailsModel.fromJsonForCart(doc));
      }
    } catch (e) {
      throw Exception(e);
    }

    return products;
  }

  static Future<void> addOrder(List<ProductDetailsModel> data,totalPrice) async {
    try {
      List<ProductDetailsModel> data2 = [];
      for(var test in data){
        String formerId = test.farmerId!;
        for(var dd in data){
          if(dd.farmerId! == formerId){
            data2.add(dd);
          }
        }
        DocumentReference orderRef = await FirebaseFirestore.instance.collection("orders").add({
          'formerId': formerId,
          'buyerId': LocalStorage.getUserId(),
          'totalPrice': totalPrice,
        });
        CollectionReference totalOrderRef = orderRef.collection("totalOrder");
        for(var d2 in data2){
          totalOrderRef.add(d2.toJsonForOrder());
        }
      }
      for(var carts in data){
        await FirebaseFirestore.instance.collection("carts").doc(carts.cartId).delete();
      }
    } catch (e) {
      throw Exception("$e");
      }

  }

 static Future<List<OrderModel>> fetchOrders() async {
    List<OrderModel> orders = [];
    try {
      QuerySnapshot ordersSnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('formerId', isEqualTo: LocalStorage.getUserId())
          .get();

      for (var orderDoc in ordersSnapshot.docs) {
        List<TotalOrderModel> totalOrders = [];

        QuerySnapshot totalOrderSnapshot = await orderDoc.reference
            .collection('totalOrder')
            .get();

        for (var totalOrderDoc in totalOrderSnapshot.docs) {
          TotalOrderModel totalOrder = TotalOrderModel.fromMap(totalOrderDoc.data() as Map<String,dynamic>);
          totalOrders.add(totalOrder);
        }

        OrderModel order = OrderModel(
          buyerId: orderDoc['buyerId'],
          formerId: orderDoc['formerId'],
          totalPrice: orderDoc['totalPrice'].toString(),
          totalOrder: totalOrders,
        );

        orders.add(order);
      }

    } catch (e) {
      throw Exception('Error fetching orders: $e');
    }
    return orders;
  }

}






enum AddToCartEnum {
  alreadyAdded
  }
