import 'package:flutter/material.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/chatbot/controller/chatbot_controller.dart';
import 'package:furniture_app/screen/chatbot/view/chatmessage.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:furniture_app/data/values/colors.dart';

class ChatBotPage extends GetView<ChatBotController> {
  ChatBotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatBotController>(
        builder: (value) => Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBarChat(context),
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.history.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          if (controller.history[index].chatMessage != null) {
                            ChatMessage chatMessage = controller.history[index].chatMessage!;
                            return ChatMessage(messageContent: chatMessage.messageContent, messageButton: chatMessage.messageButton, messageType: chatMessage.messageType);
                          } else {
                            if (controller.history[index].widget != null) {
                              return controller.history[index].widget;
                            }
                          }
                          return Container();
                        },
                      ),
                    ),
                    if (controller.loadMess)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.centerLeft,
                        child: LoadingAnimationWidget.waveDots(
                          color: Colors.black.withOpacity(0.7),
                          size: 25,
                        ),
                      ),
                    _buildTextComposer(),
                  ],
                ),
              ),
            ));
  }

  AppBar AppBarChat(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      flexibleSpace: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                  avatar_chatbot,
                ),
                maxRadius: 20,
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "ChatBot",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Online",
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.settings,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return Container(
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: TextField(
                controller: controller.textInput,
                onSubmitted: (value) {
                  controller.chooseButton(controller.textInput.text, "");
                },
                decoration: const InputDecoration.collapsed(hintText: 'Send a Message'),
              ),
            ),
            IconButton(
              onPressed: () {
                controller.chooseButton(controller.textInput.text, "");
              },
              icon: const Icon(Icons.send),
            ),
          ],
        ));
  }
}
