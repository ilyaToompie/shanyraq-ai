import 'package:flutter/material.dart';

class ResultsWidget extends StatefulWidget {
  @override
  State<ResultsWidget> createState() => _ResultsWidgetState();
}

class _ResultsWidgetState extends State<ResultsWidget> {
  late int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 4, offset: const Offset(2, 2))],
        borderRadius: BorderRadius.circular(48),
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Column(
        children: [
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _pageIndex = 0;
                  });
                },
                child: Text(
                  "Grammar",
                  style: TextStyle(
                    color:
                        _pageIndex == 0
                            ? Theme.of(context).textTheme.bodyLarge?.color
                            : Theme.of(
                              context,
                            ).textTheme.bodyLarge?.color!.withAlpha(50),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _pageIndex = 1;
                  });
                },
                child: Text(
                  "Vocabulary",
                  style: TextStyle(
                    color:
                        _pageIndex == 1
                            ? Theme.of(context).textTheme.bodyLarge?.color
                            : Theme.of(
                              context,
                            ).textTheme.bodyLarge?.color!.withAlpha(50),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _pageIndex = 2;
                  });
                },
                child: Text(
                  "Listening",
                  style: TextStyle(
                    color:
                        _pageIndex == 2
                            ? Theme.of(context).textTheme.bodyLarge?.color
                            : Theme.of(
                              context,
                            ).textTheme.bodyLarge?.color!.withAlpha(50),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _pageIndex = 3;
                  });
                },
                child: Text(
                  "Speaking",
                  style: TextStyle(
                    color:
                        _pageIndex == 3
                            ? Theme.of(context).textTheme.bodyLarge?.color
                            : Theme.of(
                              context,
                            ).textTheme.bodyLarge?.color!.withAlpha(50),
                  ),
                ),
              ),
            ],
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
                      SizedBox(width: 24),
                      Text(
                        "3",
                        style: TextStyle(fontSize: 48),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        "h",
                        style: TextStyle(
                          fontSize: 22,
                          color: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.color?.withAlpha(150),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "17",
                        style: TextStyle(fontSize: 48),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        "min",
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
                        padding: const EdgeInsets.only(right: 24.0),
                        child: Text(
                          "Overall time spend",
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
                        SizedBox(width: 24),
                        Text(
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
                        SizedBox(width: 8),
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
                      padding: const EdgeInsets.only(right: 24.0),
                      child: Text(
                        "Variants solved",
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
                      padding: const EdgeInsets.only(right: 24.0),
                      child: Text(
                        "Mistakes made",
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
}
