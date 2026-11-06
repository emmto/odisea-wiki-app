import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../storyboard_data.dart';
import 'storyboard_scene_card.dart';

class StoryboardChapterSection extends StatelessWidget {
  final StoryboardChapter chapter;
  final Function(StoryboardScene scene) onSceneTap;
  final VoidCallback onPlayAllTap;

  const StoryboardChapterSection({
    super.key,
    required this.chapter,
    required this.onSceneTap,
    required this.onPlayAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.doughBeige, width: 1.8),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkBrown.withValues(alpha: 0.06),
            offset: const Offset(0, 3),
            blurRadius: 8,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabecera del Capítulo / Acto
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icono temático
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: chapter.badgeColor == AppColors.primaryYellow
                      ? AppColors.primaryYellow.withValues(alpha: 0.25)
                      : chapter.badgeColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: chapter.badgeColor == AppColors.primaryYellow
                        ? AppColors.darkBrown
                        : chapter.badgeColor,
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  chapter.icon,
                  color: chapter.badgeColor == AppColors.primaryYellow
                      ? AppColors.darkBrown
                      : chapter.badgeColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),

              // Título y Referencia al Nivel
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2.5),
                          decoration: BoxDecoration(
                            color: chapter.badgeColor == AppColors.primaryYellow
                                ? AppColors.primaryYellow
                                : chapter.badgeColor.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: chapter.badgeColor == AppColors.primaryYellow
                                  ? AppColors.darkBrown
                                  : chapter.badgeColor,
                              width: 1.0,
                            ),
                          ),
                          child: Text(
                            chapter.orderLabel.toUpperCase(),
                            style: GoogleFonts.outfit(
                              fontSize: 10.5,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkBrown,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ),
                        if (chapter.levelReference != null) ...[
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              chapter.levelReference!,
                              style: GoogleFonts.rubik(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.mangroveGreen,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      chapter.title,
                      style: GoogleFonts.outfit(
                        fontSize: 16.5,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBrown,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Resumen narrativo del capítulo
          Text(
            chapter.summary,
            style: GoogleFonts.rubik(
              fontSize: 12.5,
              color: AppColors.darkBrown.withValues(alpha: 0.78),
              height: 1.35,
            ),
          ),

          const SizedBox(height: 14),

          // Contenido: Si está disponible muestra las viñetas, si no muestra placeholder de "Próximamente"
          if (chapter.isAvailable) ...[
            // Barra de acción rápida: Ver todas en modo cine
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.collections_rounded,
                        size: 14, color: AppColors.darkBrown),
                    const SizedBox(width: 5),
                    Text(
                      '${chapter.sceneCount} viñetas ilustradas',
                      style: GoogleFonts.rubik(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkBrown,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: onPlayAllTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.primaryYellow,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: AppColors.darkBrown, width: 1.2),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.play_arrow_rounded,
                            size: 16, color: AppColors.darkBrown),
                        const SizedBox(width: 4),
                        Text(
                          'Ver en Visor',
                          style: GoogleFonts.outfit(
                            fontSize: 11.5,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkBrown,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Carrusel horizontal o cuadrícula responsiva de viñetas
            SizedBox(
              height: 208,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: chapter.scenes.length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final scene = chapter.scenes[index];
                  return SizedBox(
                    width: 220,
                    child: StoryboardSceneCard(
                      scene: scene,
                      onTap: () => onSceneTap(scene),
                    ),
                  );
                },
              ),
            ),
          ] else ...[
            // Tarjeta de Próximamente para futuros niveles
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F2E8),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.doughBeige,
                  width: 1.5,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.doughBeige.withValues(alpha: 0.6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.brush_rounded,
                      size: 20,
                      color: AppColors.darkBrown,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bocetos en Producción',
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkBrown,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Las viñetas para este nivel se publicarán en una próxima actualización.',
                          style: GoogleFonts.rubik(
                            fontSize: 11,
                            color: AppColors.darkBrown.withValues(alpha: 0.7),
                            height: 1.25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
