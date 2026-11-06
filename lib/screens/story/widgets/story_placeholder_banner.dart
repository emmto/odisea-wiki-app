import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';

class StoryPlaceholderBanner extends StatelessWidget {
  final String? imagePath;
  final String title;
  final String? subtitle;
  final double height;
  final VoidCallback? onTap;

  const StoryPlaceholderBanner({
    super.key,
    this.imagePath,
    this.title = 'El Llamado a la Cocina',
    this.subtitle = 'Boceto de Arte / Escena Principal',
    this.height = 190,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFF3EBDD), // Tono pergamino claro suave
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.doughBeige,
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkBrown.withValues(alpha: 0.08),
              offset: const Offset(0, 3),
              blurRadius: 8,
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Líneas cruzadas fieles al mockup de wireframe (Placeholder de Imagen con 'X')
            Positioned.fill(
              child: CustomPaint(
                painter: _WireframeXPainter(
                  lineColor: AppColors.darkBrown.withValues(alpha: 0.18),
                  strokeWidth: 1.6,
                ),
              ),
            ),

            // Si hay una imagen real suministrada, se muestra con fallback elegante
            if (imagePath != null)
              Positioned.fill(
                child: Image.asset(
                  imagePath!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                ),
              ),

            // Insignia / Tag central informativo que contextualiza el placeholder
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.92),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.doughBeige,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.darkBrown.withValues(alpha: 0.1),
                      offset: const Offset(0, 2),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryYellow,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.palette_outlined,
                        size: 14,
                        color: AppColors.darkBrown,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        subtitle ?? 'Arte Conceptual en Producción',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkBrown,
                          letterSpacing: 0.2,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WireframeXPainter extends CustomPainter {
  final Color lineColor;
  final double strokeWidth;

  const _WireframeXPainter({
    required this.lineColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Diagonal 1: Esquina superior izquierda a inferior derecha
    canvas.drawLine(Offset.zero, Offset(size.width, size.height), paint);

    // Diagonal 2: Esquina superior derecha a inferior izquierda
    canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant _WireframeXPainter oldDelegate) {
    return oldDelegate.lineColor != lineColor || oldDelegate.strokeWidth != strokeWidth;
  }
}
