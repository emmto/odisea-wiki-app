import 'package:flutter/material.dart';

class OdiseaLogoBadge extends StatelessWidget {
  final double size;

  const OdiseaLogoBadge({super.key, this.size = 110});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.28), // Squircle
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2B1E16).withValues(alpha: 0.18),
            offset: const Offset(0, 8),
            blurRadius: 16,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.28),
        child: Image.asset(
          'assets/images/logo.png',
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
