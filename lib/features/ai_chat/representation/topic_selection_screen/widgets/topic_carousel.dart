import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/ai_chat/topic.dart';

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
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blueGrey.shade100),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textAlign: TextAlign.center,
                topic.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                topic.description,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text("#${index + 1}"),
              ),
            ],
          ),
        );
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
