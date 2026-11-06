import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../storyboard_data.dart';

class StoryboardSceneCard extends StatefulWidget {
  final StoryboardScene scene;
  final VoidCallback onTap;

  const StoryboardSceneCard({
    super.key,
    required this.scene,
    required this.onTap,
  });

  @override
  State<StoryboardSceneCard> createState() => _StoryboardSceneCardState();
}

class _StoryboardSceneCardState extends State<StoryboardSceneCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _isPressed ? AppColors.darkBrown : AppColors.doughBeige,
              width: 1.6,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.darkBrown.withValues(alpha: _isPressed ? 0.04 : 0.08),
                offset: Offset(0, _isPressed ? 1 : 3),
                blurRadius: _isPressed ? 2 : 6,
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Viñeta 16:9 con badge de número
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.asset(
                      widget.scene.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.doughBeige,
                        child: const Center(
                          child: Icon(Icons.image_not_supported_outlined,
                              size: 28, color: AppColors.darkBrown),
                        ),
                      ),
                    ),
                  ),

                  // Insignia de número de viñeta en esquina
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.darkBrown.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '#${widget.scene.sceneNumber}',
                        style: GoogleFonts.outfit(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryYellow,
                        ),
                      ),
                    ),
                  ),

                  // Icono indicador de zoom / pantalla completa
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.darkBrown.withValues(alpha: 0.75),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.fullscreen_rounded,
                        size: 16,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),

              // Contenido descriptivo breve
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.scene.title,
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkBrown,
                          height: 1.15,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        widget.scene.description,
                        style: GoogleFonts.rubik(
                          fontSize: 11,
                          color: AppColors.darkBrown.withValues(alpha: 0.75),
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
