import 'package:flutter/material.dart';

import '../responsiveness/responsive.dart';
import 'button/interaction_button.dart';

class SharedPostInteractionsBar extends StatelessWidget {
  const SharedPostInteractionsBar({super.key, required this.interactionsItems});

  final List<InteractionButton> interactionsItems;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: interactionsItems.map((item) {
        final isLast = item == interactionsItems.last;

        return Expanded(
          child: Row(
            children: [
              Expanded(child: item),
              if (!isLast) SizedBox(width: Responsive.getSize(16)),
            ],
          ),
        );
      }).toList(),
    );
  }
}
