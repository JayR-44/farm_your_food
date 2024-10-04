class OrderModel {
  final String buyerId;
  final String formerId;
  final String totalPrice;
  final List<TotalOrderModel> totalOrder;

  OrderModel({
    required this.buyerId,
    required this.formerId,
    required this.totalPrice,
    required this.totalOrder,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      buyerId: map['buyerId'],
      formerId: map['formerId'],
      totalPrice: map['totalPrice'],
      totalOrder: List<TotalOrderModel>.from(
        map['totalOrder'].map((record) => TotalOrderModel.fromMap(record)),
      ),
    );
  }
}


class TotalOrderModel {
  final String productName;
  final String productPrice;
  final String productTotalPrice;
  final String productQty;

  TotalOrderModel({
    required this.productName,
    required this.productPrice,
    required this.productTotalPrice,
    required this.productQty,
  });

  factory TotalOrderModel.fromMap(Map<String, dynamic> map) {
    return TotalOrderModel(
      productName: map['productName'],
      productQty: map['productQty'],
      productPrice: map['productPrice'],
      productTotalPrice: map['productTotalPrice'],
    );
  }
}
