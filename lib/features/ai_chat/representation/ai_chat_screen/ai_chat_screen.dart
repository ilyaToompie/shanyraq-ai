import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/ai_chat/representation/ai_chat_screen/message.dart';
import 'package:shyraq_ai/features/ai_chat/representation/ai_chat_screen/widgets/chat_list_view.dart';
import 'package:shyraq_ai/features/ai_chat/representation/ai_chat_screen/widgets/message_input_field.dart';
import 'package:shyraq_ai/features/ai_chat/representation/ai_chat_screen/widgets/overall_score_info.dart';
import 'package:shyraq_ai/features/ai_chat/topic.dart';
import 'package:shyraq_ai/features/ai_chat/widgets/topic_card.dart';

class AiChatScreen extends StatefulWidget {
  final Topic topic;
  const AiChatScreen({super.key, required this.topic});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final List<Message> _messages = [
    const Message(text: 'Сәлем! Менің атым Алия. Мен 17 жастамын.', isMe: true),
    const Message(
      text: 'Сәлем, Алия! Жасыңды дұрыс айттың. Өзің қай қаладансың?',
      isMe: false,
    ),

    const Message(text: 'Мен Шымкенттенмін. Мен мектепте оқимын.', isMe: true),
    const Message(text: 'Керемет! Қай сыныпта оқисың?', isMe: false),

    const Message(
      text: '11 сыныптамын. Менің хоббиім – сурет салу.',
      isMe: true,
    ),
    const Message(
      text: 'Өте жақсы! «Хоббиім – сурет салу» деген сөйлем сәтті шыққан.',
      isMe: false,
    ),

    const Message(text: 'Менде әпкем бар. Аты – Айжан.', isMe: true),
    const Message(
      text: 'Жақсы. «Менде әпкем бар» орнына «Менің әпкем бар» деуге болады.',
      isMe: false,
    ),

    const Message(
      text: 'Ол университетте оқиды. Мен онымен жиі сөйлесемін.',
      isMe: true,
    ),
    const Message(
      text: 'Керемет! Сөйлем құрылымы дұрыс. Жарайсың.',
      isMe: false,
    ),
  ];
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
        title: Text('chat'.tr()),
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
                  Row(
                    children: [
                      Text(
                        "overall-score".tr(),
                        style: const TextStyle(fontSize: 22),
                      ),
                    ],
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
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TopicCard(topic: widget.topic, index: null),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(20, 20, 20, 1),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
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

          Positioned(
            top: 10,
            left: 24,
            right: 24,
            child: Visibility(
              visible: isOverallScoreVisible,
              child: const OverallScoreInfo(),
            ),
          ),
        ],
      ),
    );
  }
}
