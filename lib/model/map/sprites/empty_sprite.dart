import 'package:flutter/material.dart';

class EmptySprite extends StatelessWidget {
  const EmptySprite({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned(top: 0, left: 0, child: SizedBox());
  }
}
