import 'package:flutter/material.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/screen/chatbot/controller/chatbot_controller.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';

class ChatMessage extends GetView<ChatBotController> {
  List<String> messageContent;
  Map<String, dynamic>? messageButton;
  String messageType;
  ChatMessage({super.key, required this.messageContent, this.messageButton, required this.messageType});

  List<Widget> content = [];
  List<Widget> button = [];
  void loadData() {
    for (int i = 0; i < messageContent.length; i++) {
      content.add(_buildText(i));
    }
    if (messageButton != null) {
      content.add(_buildButton(messageButton!.keys.toList() as List<String>));
    }
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    var margin = EdgeInsets.only(right: Get.width * 0.1);
    if (messageType != 'admin') margin = EdgeInsets.only(left: Get.width * 0.1);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      margin: margin,
      alignment: (messageType == "admin" ? Alignment.topLeft : Alignment.topRight),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: content),
    );
  }

  Widget _buildButton(List<String> content) {
    if (content.length == 0) return Container();
    return Container(
      height: 175,
      child: SingleChildScrollView(
        child: GroupButton(
          onSelected: (value, index, isSelected) {
            controller.chooseButton(value, messageButton?[value] ?? "");
          },
          buttons: content,
          options: GroupButtonOptions(borderRadius: BorderRadius.circular(10), spacing: 10),
        ),
      ),
    );
  }

  Container _buildText(int index) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: (messageType == "user" ? Colors.grey.shade200 : buttonColor),
        ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Text(
          messageContent[index],
          style: const TextStyle(fontSize: 15),
        ));
  }
}
