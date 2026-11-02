import 'package:flutter/material.dart';

class QuickRepliesBar extends StatelessWidget {
  final List<String> prompts;
  final void Function(String) onSelected;

  const QuickRepliesBar({
    super.key,
    required this.prompts,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (prompts.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        itemBuilder: (_, i) => ActionChip(
          label: Text(prompts[i]),
          onPressed: () => onSelected(prompts[i]),
        ),
        separatorBuilder: (_, __) => const SizedBox(width: 6),
        itemCount: prompts.length,
      ),
    );
  }
}
