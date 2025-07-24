import 'package:flutter/material.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';
import 'package:shyraq_ai/features/ai_chat/representation/ai_chat_screen/message.dart';

class ChatListView extends StatelessWidget {
  final List<Message> messages;
  final ScrollController scrollController;

  const ChatListView({
    super.key,
    required this.messages,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollShadow(
      color: const Color.fromRGBO(20, 20, 20, 1),
      size: 32,
      child: ListView.builder(
        controller: scrollController,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final msg = messages[index];
          final alignment =
              msg.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
          final bubbleColor =
              msg.isMe
                  ? Theme.of(context).colorScheme.surface
                  : Colors.grey.shade300;

          return Column(
            crossAxisAlignment: alignment,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                padding: const EdgeInsets.all(12),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                decoration: BoxDecoration(
                  color: bubbleColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  msg.text,
                  style: const TextStyle(color: Colors.black87, fontSize: 16),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
