import 'package:flutter/material.dart';

class Neubox extends StatelessWidget {
  final Widget? child;

  const Neubox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            blurRadius: 15,
            offset: const Offset(4,4),
          ),
          const BoxShadow(
            color: Colors.white,
            blurRadius: 15,
            offset: Offset(-4,-4),
          )
        ]
      ),
      padding: const EdgeInsets.all(2),
      child: child,
    );
  }
}
