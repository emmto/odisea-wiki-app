import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../story_data.dart';

class StoryPartCard extends StatefulWidget {
  final StoryPart part;
  final VoidCallback onTap;

  const StoryPartCard({
    super.key,
    required this.part,
    required this.onTap,
  });

  @override
  State<StoryPartCard> createState() => _StoryPartCardState();
}

class _StoryPartCardState extends State<StoryPartCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.985 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: _isPressed ? const Color(0xFFF9F6EE) : AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isPressed ? AppColors.darkBrown : AppColors.doughBeige,
              width: 1.8,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.darkBrown.withValues(alpha: _isPressed ? 0.04 : 0.08),
                offset: Offset(0, _isPressed ? 1 : 3),
                blurRadius: _isPressed ? 3 : 6,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icono temático del acto
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: widget.part.badgeColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: widget.part.badgeColor.withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  widget.part.icon,
                  color: widget.part.badgeColor == AppColors.primaryYellow
                      ? AppColors.darkBrown
                      : widget.part.badgeColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),

              // Contenido: Título del Acto y Líneas de Previsualización (como en el mockup)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título exacto del mockup
                    Text(
                      widget.part.fullTitle,
                      style: GoogleFonts.outfit(
                        fontSize: 15.5,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBrown,
                        height: 1.25,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),

                    // Extracto de dos líneas de la historia real
                    Text(
                      widget.part.summary,
                      style: GoogleFonts.rubik(
                        fontSize: 12,
                        color: AppColors.darkBrown.withValues(alpha: 0.72),
                        height: 1.35,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 6),

                    // Metadatos sutiles: tiempo de lectura y ubicación
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 12,
                          color: AppColors.darkBrown.withValues(alpha: 0.5),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.part.estimatedReadTime,
                          style: GoogleFonts.rubik(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: AppColors.darkBrown.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Flecha de navegación a la vista completa
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.doughBeige.withValues(alpha: 0.4),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.darkBrown,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
