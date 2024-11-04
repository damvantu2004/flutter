import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_app/data/models/chatbot.dart';

class ChatBotRepository {
  Future<ChatBotMessage> getChatBotMessage(String id) async {
    CollectionReference collection = FirebaseFirestore.instance.collection('chatbot');
    ChatBotMessage chatBotMess = ChatBotMessage(content: [], contenButton: {});
    await collection.doc(id).get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        chatBotMess = ChatBotMessage.fromMap(data);
      }
    });
    return chatBotMess;
  }
}
