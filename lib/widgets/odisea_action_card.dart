import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';

class OdiseaActionCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const OdiseaActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  State<OdiseaActionCard> createState() => _OdiseaActionCardState();
}

class _OdiseaActionCardState extends State<OdiseaActionCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: _isPressed ? const Color(0xFFF9F5EC) : AppColors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.darkBrown, width: 2.0),
            boxShadow: [
              BoxShadow(
                color: AppColors.darkBrown.withValues(alpha: _isPressed ? 0.05 : 0.12),
                offset: Offset(0, _isPressed ? 1 : 3),
                blurRadius: _isPressed ? 2 : 5,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: GoogleFonts.outfit(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBrown,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      widget.subtitle,
                      style: GoogleFonts.rubik(
                        fontSize: 12,
                        color: AppColors.darkBrown.withValues(alpha: 0.7),
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Flecha amarilla fiel al diseño del mockup
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.primaryYellow,
                size: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
