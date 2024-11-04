import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:furniture_app/data/models/card.dart';
import 'package:furniture_app/data/models/cart.dart';

class MyOrder {
  String? id;
  String? userID;
  List<Cart> carts;
  List<StatusOrder> status;
  bool paymentInCash;
  // Card? paymentByCard;
  String? discountID;
  double priceOrder;
  double priceDelivery;
  double priceDiscount;
  double priceTotal;
  DateTime? time;
  MyOrder({this.id, required this.carts, required this.status,  required this.paymentInCash,   required this.priceOrder, required this.priceDelivery, required this.priceDiscount, required this.priceTotal, this.userID});

  factory MyOrder.empty() {
    return MyOrder(
      carts: [],
      status: [],
      paymentInCash: true,
      priceOrder: 0,
      priceDelivery: 0,
      priceDiscount: 0,
      priceTotal: 0,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'carts': carts.map((x) => x.toJson()).toList(),
      'status': status.map((x) => x.toMap()).toList(),
      'paymentInCash': paymentInCash,
      // 'paymentByCard': paymentByCard != null ? paymentByCard!.toMap() : null,
      'discountID': discountID,
      'priceOrder': priceOrder,
      'priceDelivery': priceDelivery,
      'priceDiscount': priceDiscount,
      'priceTotal': priceTotal,
      'userID': userID
    };
  }

  factory MyOrder.fromMap(Map<String, dynamic> map, {String? id}) {
    return MyOrder(
      id: id,
      status: List<StatusOrder>.from(
        (map['status'] as List<dynamic>).map<StatusOrder>(
          (x) => StatusOrder.fromMap(x as Map<String, dynamic>),
        ),
      ),
      carts: List<Cart>.from(
        (map['carts'] as List<dynamic>).map<Cart>(
          (x) => Cart.fromJson(x as Map<String, dynamic>),
        ),
      ),
      paymentInCash: map['paymentInCash'] as bool,
      // paymentByCard: map['paymentByCard'] != null ? Card.fromMap(map['paymentByCard'] as Map<String, dynamic>) : null,
      // discountID: map['discountID'] != null ? map['discountID'] as String : null,
      priceOrder: map['priceOrder'] as double,
      priceDelivery: map['priceDelivery'] as double,
      priceDiscount: map['priceDiscount'] as double,
      priceTotal: map['priceTotal'] as double,
      userID: map['userID'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyOrder.fromJson(String source) => MyOrder.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(id: $id, carts: $carts, status: $status,  paymentInCash: $paymentInCash,  discountID: $discountID, priceOrder: $priceOrder, priceDelivery: $priceDelivery, priceDiscount: $priceDiscount, priceTotal: $priceTotal)';
  }
}

class StatusOrder {
  String status;
  DateTime? date;
  StatusOrder({
    required this.status,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'date': date != null ? Timestamp.fromDate(date!) : null,
    };
  }

  factory StatusOrder.fromMap(Map<String, dynamic> map) {
    return StatusOrder(
      status: map['status'] as String,
      date: map['date'] != null ? (map['date'] as Timestamp).toDate() : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StatusOrder.fromJson(String source) => StatusOrder.fromMap(json.decode(source) as Map<String, dynamic>);
}
