import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_app/data/models/message.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/models/user_profile.dart';
import 'package:furniture_app/data/repository/product_repository.dart';
import 'package:furniture_app/data/servers/message_api_server.dart';

class MessageRepository {
  // ProductAPIServer productAPIServer = ProductAPIServer();

  // Future<List<Message>> getMessage() async {
  //   String userID = FirebaseAuth.instance.currentUser?.uid ?? "";
  //   CollectionReference collection = FirebaseFirestore.instance.collection('chatroom').doc(userID).collection('message');
  //   List<Message> message = [];
  //   await collection.orderBy('time', descending: true).get().then((QuerySnapshot querySnapshot) {
  //     message = querySnapshot.docs.map((doc) {
  //       if (doc.exists) {
  //         Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //         Message a = Message.fromMap(data, id: doc.id);
  //         return a;
  //       }
  //       return Message(time: DateTime.now());
  //     }).toList();
  //   });
  //   for (int i = 0; i < message.length; i++) {
  //     if (message[i].productId != null) {
  //       message[i].product = await ProductRepository().getProduct(message[i].productId.toString());
  //     }
  //   }
  //   return message;
  // }

  Future<bool> checkOrigin() async {
    String userID = FirebaseAuth.instance.currentUser?.uid ?? "";
    CollectionReference collection = FirebaseFirestore.instance.collection('chatroom');
    List<Message> message = [];
    await collection.where('userID', isEqualTo: userID).limit(1).get().then((QuerySnapshot querySnapshot) {
      message = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          Message a = Message.fromMap(data);
          return a;
        }
        return Message(time: DateTime.now());
      }).toList();
    });
    if (message.length > 0) return false;
    return true;
  }

  Future<void> sendProduct(Product product, UserProfile user) async {
    Message mess = Message(
      userID: user.id,
      userName: user.name,
      userAvataPath: user.avatarPath,
      isAdmin: false,
      adminID: null,
      content: null,
      productId: product.id,
      productName: product.name,
      productPrice: product.price,
      productImage: product.imagePath?[0] ?? null,
      time: DateTime.now(),
    );
    if (await checkOrigin()) {
      await MessageAPIServer().setChatRoom(mess.toMap());
    } else {
      await MessageAPIServer().updateChatRoom(mess.toMap());
    }
    await MessageAPIServer().add(mess.toMap());
  }

  Future<void> sendMessage(String content, UserProfile user) async {
    if (content.trim() == "") return;
    Message mess = Message(
      userID: user.id,
      userName: user.name,
      userAvataPath: user.avatarPath,
      isAdmin: false,
      adminID: null,
      content: content,
      productId: null,
      productName: null,
      productPrice: null,
      productImage: null,
      time: DateTime.now(),
    );
    if (await checkOrigin()) {
      await MessageAPIServer().setChatRoom(mess.toMap());
    } else {
      await MessageAPIServer().updateChatRoom(mess.toMap());
    }
    await MessageAPIServer().add(mess.toMap());
  }
}
