import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDetailsModel {
  String? description;
  String? farmerId;
  String?cartId;
  String? productName;
  String? productPrice;
  String? productType;
  String? productId;
  String? buyerId;
  String? productQty;
  String? productTotalPrice;


  ProductDetailsModel({
    this.productId,
    this.cartId,
     this.description,
     this.farmerId,
     this.productName,
     this.productPrice,
     this.productType,
    this.buyerId,
    this.productQty,
    this.productTotalPrice

  });

  factory ProductDetailsModel.fromJson(QueryDocumentSnapshot<Object?> json) {
    return ProductDetailsModel(
      productId: json.id,
      description:json['description'] ?? "",
      farmerId: json['farmerId'] ?? "",
      productName: json['productName'] ?? "",
      productPrice: json['productPrice'] ?? "",
      productType: json['productType'] ?? "",
    );
  }

  factory ProductDetailsModel.fromJsonForCart(QueryDocumentSnapshot<Object?> json) {
    return ProductDetailsModel(
      cartId: json.id,
      buyerId:json['buyerId'] ?? "",
      farmerId: json['farmerId'] ?? "",
      productName: json['productName'] ?? "",
      productPrice: json['productPrice'] ?? "",
      productQty: json['productQty'] ?? "",
      productTotalPrice: json['productTotalPrice'] ?? "",
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'farmerId': farmerId,
      'productName': productName,
      'productPrice': productPrice,
      'productType': productType,
    };
  }

  Map<String, dynamic> toJsonForCart() {
    return {
      'farmerId': farmerId,
      'productId': productId,
      'buyerId': buyerId,
      'productQty':productQty,
      'productName':productName,
      'productPrice':productPrice,
      'productTotalPrice':productTotalPrice,
      'productType':productType,
    };
  }

  Map<String, dynamic> toJsonForOrder() {
    return {
      'productId': productId,
      'productName': productName,
      'productQty': productQty,
      'productPrice': productPrice,
      'productTotalPrice': productTotalPrice,
    };
  }
}
