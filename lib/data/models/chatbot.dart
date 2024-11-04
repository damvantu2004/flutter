class ChatBotMessage {
  List<String> content;
  Map<String, dynamic> contenButton;

  ChatBotMessage({
    required this.content,
    required this.contenButton,
  });

  factory ChatBotMessage.fromMap(Map<String, dynamic> map) {
    return ChatBotMessage(
      content: List.from((map['content'])),
      contenButton: map['button'] != null
          ? Map<String, dynamic>.from(
              (map['button'] as Map<String, dynamic>),
            )
          : {},
    );
  }
}
