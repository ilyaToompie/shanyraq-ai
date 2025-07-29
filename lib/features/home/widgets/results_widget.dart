import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ResultsWidget extends StatefulWidget {
  const ResultsWidget({super.key});

  @override
  State<ResultsWidget> createState() => _ResultsWidgetState();
}

class _ResultsWidgetState extends State<ResultsWidget> {
  late int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [BoxShadow(blurRadius: 4, offset: Offset(2, 2))],
        borderRadius: BorderRadius.circular(48),
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 8),
                  _buildTabButton(context, "grammar", 0),
                  _buildTabButton(context, "vocabulary", 1),
                  _buildTabButton(context, "listening", 2),
                  _buildTabButton(context, "speaking", 3),
                  SizedBox(width: 8),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64.0),
            child: Divider(
              color: Theme.of(context).colorScheme.primary.withAlpha(200),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      const SizedBox(width: 24),
                      const Text(
                        "3",
                        style: TextStyle(fontSize: 48),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        "hours".tr(),
                        style: TextStyle(
                          fontSize: 22,
                          color: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.color?.withAlpha(150),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "17",
                        style: TextStyle(fontSize: 48),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        "minutes".tr(),
                        style: TextStyle(
                          fontSize: 22,
                          color: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.color?.withAlpha(150),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 24.0),
                        child: Text(
                          "overall-time-spend".tr(),
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Transform.translate(
                offset: const Offset(0, -8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        const SizedBox(width: 24),
                        const Text(
                          "3",
                          style: TextStyle(fontSize: 48),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          "/",
                          style: TextStyle(
                            fontSize: 22,
                            color: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.color?.withAlpha(150),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "17",
                          style: TextStyle(
                            fontSize: 22,
                            color: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.color?.withAlpha(150),
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 24.0),
                      child: Text(
                        "variants-solved".tr(),
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        SizedBox(width: 24),
                        Text(
                          "28",
                          style: TextStyle(fontSize: 48),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 24.0),
                      child: Text(
                        "mistakes-made".tr(),
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(BuildContext context, String key, int index) {
    final isSelected = _pageIndex == index;
    final baseColor = Theme.of(context).textTheme.bodyLarge?.color;
    return TextButton(
      onPressed: () {
        setState(() {
          _pageIndex = index;
        });
      },
      child: Text(
        key.tr(),
        style: TextStyle(
          color: isSelected ? baseColor : baseColor?.withAlpha(50),
        ),
      ),
    );
  }
}
