import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/ai_chat/representation/ai_chat_screen/message.dart';
import 'package:shyraq_ai/features/ai_chat/representation/ai_chat_screen/widgets/chat_list_view.dart';
import 'package:shyraq_ai/features/ai_chat/representation/ai_chat_screen/widgets/message_input_field.dart';
import 'package:shyraq_ai/features/ai_chat/topic.dart';
import 'package:shyraq_ai/features/ai_chat/widgets/topic_card.dart';

class AiChatScreen extends StatefulWidget {
  final Topic topic;
  const AiChatScreen({super.key, required this.topic});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool isOverallScoreVisible = true;

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(Message(text: text, isMe: true));
    });

    _controller.clear();

    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('Chat'),
        actions: [
          GestureDetector(
            onTap:
                () => setState(() {
                  isOverallScoreVisible = !isOverallScoreVisible;
                }),
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  const Text(
                    "Overall score: 10.3",
                    style: TextStyle(fontSize: 22),
                  ),
                  Icon(
                    size: 30,
                    Icons.arrow_drop_down_rounded,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TopicCard(topic: widget.topic, index: null),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(20, 20, 20, 1),
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Expanded(
                    child: ChatListView(
                      messages: _messages,
                      scrollController: _scrollController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MessageInputField(
                      controller: _controller,
                      onSend: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
