import 'package:flutter/material.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class AuraSprite extends StatelessWidget {
  final List<String> auras;
  const AuraSprite({super.key, required this.auras});

  @override
  Widget build(BuildContext context) {
    return (auras.isEmpty)
        ? const SizedBox()
        : Align(
            alignment: Alignment.center,
            child: TransparentPointer(
              transparent: true,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 56, 61, 84).withAlpha(15),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color.fromARGB(255, 56, 61, 84).withAlpha(30),
                    width: 0.3,
                  ),
                ),
              ),
            ),
          );
  }
}
