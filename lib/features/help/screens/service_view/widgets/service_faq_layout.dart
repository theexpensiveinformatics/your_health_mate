import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';


class YHMServiceFAQLayout extends StatefulWidget {
  final String question;
  final String answer;

  const YHMServiceFAQLayout({super.key, required this.question, required this.answer});

  @override
  _YHMServiceFAQLayoutState createState() => _YHMServiceFAQLayoutState();
}

class _YHMServiceFAQLayoutState extends State<YHMServiceFAQLayout> with SingleTickerProviderStateMixin {
  late final ValueNotifier<bool> _isExpandedNotifier;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _isExpandedNotifier = ValueNotifier<bool>(false);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _isExpandedNotifier.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    _isExpandedNotifier.value = !_isExpandedNotifier.value;
    if (_isExpandedNotifier.value) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(

        decoration: BoxDecoration(
          color: YHMColors.lightGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(widget.question,style: Theme.of(context).textTheme.bodyLarge),
              trailing: ValueListenableBuilder<bool>(
                valueListenable: _isExpandedNotifier,
                builder: (context, isExpanded, child) {
                  return AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(Icons.keyboard_arrow_down_sharp),

                  );
                },
              ),
              onTap: _toggleExpansion,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _isExpandedNotifier,
              builder: (context, isExpanded, child) {
                return AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  child: ConstrainedBox(
                    constraints: isExpanded
                        ? const BoxConstraints()
                        : const BoxConstraints(maxHeight: 0),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16,right: 16,bottom: 20),
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          widget.answer,
                          textAlign: TextAlign.start,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
