import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/ai_chat/topic.dart';
import 'package:shyraq_ai/features/ai_chat/widgets/topic_card.dart';

class TopicCarousel extends StatefulWidget {
  final List<Topic> topics;
  final ValueChanged<int> onIndexChanged;
  const TopicCarousel({
    super.key,
    required this.topics,
    required this.onIndexChanged,
  });

  @override
  State<TopicCarousel> createState() => _TopicCarouselState();
}

class _TopicCarouselState extends State<TopicCarousel> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: widget.topics.length,
      itemBuilder: (context, index, realIndex) {
        final topic = widget.topics[index];
        return TopicCard(topic: topic, index: index);
      },
      options: CarouselOptions(
        height: 300,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        onPageChanged: (index, reason) {
          widget.onIndexChanged(index);
        },
      ),
    );
  }
}
