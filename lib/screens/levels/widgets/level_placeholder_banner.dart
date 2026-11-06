import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';

/// Banner de cabecera con el estilo wireframe (caja con 'X') del mockup,
/// estilizado con la paleta pergamino y estética artesanal de la app.
class LevelPlaceholderBanner extends StatelessWidget {
  final String? imagePath;
  final String levelName;
  final String? subtitle;
  final double height;

  const LevelPlaceholderBanner({
    super.key,
    this.imagePath,
    required this.levelName,
    this.subtitle,
    this.height = 190,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF3EBDD), // Tono pergamino suave
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
          // Líneas diagonales cruzadas (Placeholder en 'X' fiel al mockup)
          Positioned.fill(
            child: CustomPaint(
              painter: _LevelWireframePainter(
                lineColor: AppColors.darkBrown.withValues(alpha: 0.16),
                strokeWidth: 1.6,
              ),
            ),
          ),

          // Imagen de arte si está disponible
          if (imagePath != null)
            Positioned.fill(
              child: Image.asset(
                imagePath!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
              ),
            ),

          // Insignia central que contextualiza la escena del nivel
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.94),
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
                      Icons.videogame_asset_outlined,
                      size: 15,
                      color: AppColors.darkBrown,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      subtitle ?? '$levelName • Concept Art',
                      style: GoogleFonts.outfit(
                        fontSize: 12.5,
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
    );
  }
}

class _LevelWireframePainter extends CustomPainter {
  final Color lineColor;
  final double strokeWidth;

  const _LevelWireframePainter({
    required this.lineColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Diagonal 1: De arriba izquierda a abajo derecha
    canvas.drawLine(Offset.zero, Offset(size.width, size.height), paint);

    // Diagonal 2: De arriba derecha a abajo izquierda
    canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant _LevelWireframePainter oldDelegate) {
    return oldDelegate.lineColor != lineColor || oldDelegate.strokeWidth != strokeWidth;
  }
}
