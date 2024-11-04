import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/Order.dart';
import '../servers/order_api_server.dart';

class OrderRepository {
  OrderAPIServer orderAPIServer = OrderAPIServer();
  Future<void> addToOrder(MyOrder order) async {
    order.userID = FirebaseAuth.instance.currentUser!.uid;
    await orderAPIServer.add(order.toMap());
  }

  Future<List<MyOrder>> getOrders() async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('orders');
    List<MyOrder> orders = [];
    var userID = FirebaseAuth.instance.currentUser!.uid;
    await collection
        .where('userID', isEqualTo: userID)
        .get()
        .then((QuerySnapshot querySnapshot) {
      orders = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          MyOrder a = MyOrder.fromMap(data, id: doc.id);
          a.time = dateTimeStatusRecently(a);
          return a;
        }
        return MyOrder.empty();
      }).toList();
    });
    return orders;
  }

  static String statusOrderToString(MyOrder order) {
    Map<int, String> value = {
      0: "Ordered",
      1: "Preparing",
      2: "Delivery in progress",
      3: "Completed"
    };
    for (int i = 0; i < order.status.length; i++) {
      if (order.status[i].date == null) {
        return value[i - 1].toString();
      }
    }
    return "Completed";
  }

  int statusOrderToInt(MyOrder order) {
    for (int i = 0; i < order.status.length; i++) {
      if (order.status[i].date == null) {
        return i;
      }
    }
    return 4;
  }

  static DateTime dateTimeStatusRecently(MyOrder order) {
    for (int i = 3; i >= 0; i--) {
      if (order.status[i].date != null) {
        return order.status[i].date!;
      }
    }
    return order.status[0].date!;
  }

Future<int> countOrder() async {
  var userID = FirebaseAuth.instance.currentUser!.uid;
  AggregateQuerySnapshot _myDoc = await FirebaseFirestore.instance
      .collection('orders')
      .where('userID', isEqualTo: userID)
      .count()
      .get();
  if (_myDoc.count != null) {
    return _myDoc.count as int;
  } else {
    // Xử lý trường hợp count null (ví dụ: trả về 0, ném ngoại lệ)
    return 0; // Thay thế bằng cách xử lý phù hợp cho ứng dụng của bạn
  }
}

  Future<MyOrder?> getOrderWithID(String id) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('orders');
    MyOrder? order;
    await collection.doc(id).get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        order = MyOrder.fromMap(data, id: doc.id);
      }
    });
    return order;
  }
}
