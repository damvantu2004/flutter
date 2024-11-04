import 'dart:convert';

class Message {
  String? userID;
  String? userName;
  String? userAvataPath;
  bool isAdmin = false;
  String? adminID;
  String? content;
  String? productId;
  String? productName;
  double? productPrice;
  String? productImage;
  DateTime time;

  Message({
    this.userID,
    this.userName = "",
    this.userAvataPath,
    this.isAdmin = false,
    this.adminID,
    this.content,
    this.productId,
    this.productName,
    this.productPrice,
    this.productImage,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userID': userID,
      'user_name': userName,
      'user_avata_path': userAvataPath,
      'is_admin': isAdmin,
      'adminID': adminID,
      'content': content,
      'productID': productId,
      'product_name': productName,
      'product_price': productPrice,
      'product_image_path': productImage,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      userID: map['userID'] != null ? map['userID'] as String : null,
      userName: map['user_name'] != null ? map['user_name'] as String : null,
      userAvataPath: map['user_avata_path'] != null ? map['user_avata_path'] as String : null,
      isAdmin: map['is_admin'] as bool,
      adminID: map['adminID'] != null ? map['adminID'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      productId: map['productID'] != null ? map['productID'] as String : null,
      productName: map['product_name'] != null ? map['product_name'] as String : null,
      productPrice: map['product_price'] != null ? map['product_price'] as double : null,
      productImage: map['product_image_path'] != null ? map['product_image_path'] as String : null,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
    );
  }
}
