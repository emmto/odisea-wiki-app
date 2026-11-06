import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../level_model.dart';

class LevelCard extends StatefulWidget {
  final LevelItem level;
  final VoidCallback onTap;

  const LevelCard({
    super.key,
    required this.level,
    required this.onTap,
  });

  @override
  State<LevelCard> createState() => _LevelCardState();
}

class _LevelCardState extends State<LevelCard> {
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
              // Insignia numérica del nivel con estilo cartoon
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: AppColors.primaryYellow.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.darkBrown,
                    width: 1.8,
                  ),
                ),
                child: Center(
                  child: Text(
                    '${widget.level.number}',
                    style: GoogleFonts.outfit(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: AppColors.darkBrown,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Contenido: Título, resumen de reto y metadatos
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título del nivel (e.g. "Nivel 1: El Mercado Vertical")
                    Text(
                      widget.level.fullTitle,
                      style: GoogleFonts.outfit(
                        fontSize: 15.5,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBrown,
                        height: 1.25,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),

                    // Resumen del reto
                    Text(
                      widget.level.challenge,
                      style: GoogleFonts.rubik(
                        fontSize: 12,
                        color: AppColors.darkBrown.withValues(alpha: 0.72),
                        height: 1.35,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 6),

                    // Etiqueta de tipo y ubicación
                    Row(
                      children: [
                        Icon(
                          widget.level.icon,
                          size: 13,
                          color: AppColors.mangroveGreen,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            '${widget.level.characteristics.first.value} • ${widget.level.locationZone}',
                            style: GoogleFonts.rubik(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: AppColors.darkBrown.withValues(alpha: 0.65),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Flecha hacia la vista individual del nivel
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
