import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import 'storyboard_data.dart';
import 'storyboard_viewer_screen.dart';
import 'widgets/storyboard_chapter_section.dart';

class StoryboardScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const StoryboardScreen({super.key, this.onBack});

  @override
  State<StoryboardScreen> createState() => _StoryboardScreenState();
}

class _StoryboardScreenState extends State<StoryboardScreen> {
  String _selectedFilter = 'all';

  void _showStoryboardInfoDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.backgroundCream,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: AppColors.darkBrown, width: 2),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryYellow,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.darkBrown, width: 1.5),
              ),
              child: const Icon(
                Icons.auto_stories_rounded,
                color: AppColors.darkBrown,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Guía del Storyboard',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  color: AppColors.darkBrown,
                ),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Narrativa Visual y Cinemáticas',
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBrown,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Explora los bocetos de las cinemáticas organizados en estricto orden cronológico de la aventura:',
                style: GoogleFonts.rubik(
                  fontSize: 13,
                  color: AppColors.darkBrown.withValues(alpha: 0.8),
                ),
              ),
              const SizedBox(height: 12),
              _buildMiniInfo(
                icon: Icons.fireplace_rounded,
                title: 'Prólogo (8 viñetas)',
                description: 'Decreto de Don Lupe y la aparición de Madame Circe en San Blas.',
              ),
              _buildMiniInfo(
                icon: Icons.storefront_rounded,
                title: 'Acto I: Mercado (6 viñetas)',
                description: 'Nivel 1: Escalada de huacales y búsqueda de los plátanos machos reales.',
              ),
              _buildMiniInfo(
                icon: Icons.exit_to_app_rounded,
                title: 'Salida del Mercado (3 viñetas)',
                description: 'Clímax del Nivel 1: Estallido de harina, rescate del fruto y escape.',
              ),
              _buildMiniInfo(
                icon: Icons.brush_rounded,
                title: 'Niveles 2 y 3 (En producción)',
                description: 'Panadería y Manglares de La Tovara disponibles próximamente.',
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryYellow,
              foregroundColor: AppColors.darkBrown,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: AppColors.darkBrown, width: 1.5),
              ),
            ),
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              '¡Entendido!',
              style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniInfo({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColors.mangroveGreen),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.rubik(fontSize: 12, color: AppColors.darkBrown),
                children: [
                  TextSpan(
                    text: '$title: ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openViewerAtScene(StoryboardScene scene) {
    final allScenes = StoryboardData.allAvailableScenes;
    final index = allScenes.indexWhere((s) => s.id == scene.id);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StoryboardViewerScreen(
          scenes: allScenes,
          initialIndex: index >= 0 ? index : 0,
        ),
      ),
    );
  }

  void _openViewerForChapter(StoryboardChapter chapter) {
    if (!chapter.isAvailable || chapter.scenes.isEmpty) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StoryboardViewerScreen(
          scenes: chapter.scenes,
          initialIndex: 0,
          chapterTitle: chapter.title,
        ),
      ),
    );
  }

  void _openViewerFromStart() {
    final allScenes = StoryboardData.allAvailableScenes;
    if (allScenes.isEmpty) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StoryboardViewerScreen(
          scenes: allScenes,
          initialIndex: 0,
        ),
      ),
    );
  }

  List<StoryboardChapter> get _filteredChapters {
    if (_selectedFilter == 'all') {
      return StoryboardData.chapters;
    }
    return StoryboardData.chapters
        .where((c) => c.id == _selectedFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: Column(
        children: [
          // 1. TOP BAR PERSONALIZADA (Exactamente como las otras: [← Flecha volver]  Título 100% centrado  [ⓘ])
          // Sin texto en el botón volver: únicamente la flecha Material Design
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: topPadding + 10,
              bottom: 12,
            ),
            decoration: const BoxDecoration(
              color: AppColors.topBarBeige,
              border: Border(
                bottom: BorderSide(color: AppColors.doughBeige, width: 1.5),
              ),
            ),
            child: SizedBox(
              height: 44,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Título 100% centrado en la pantalla
                  Text(
                    'Storyboard',
                    style: GoogleFonts.outfit(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBrown,
                    ),
                  ),

                  // Botón volver a la izquierda: SOLO flecha de volver, SIN TEXTO
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: AppColors.darkBrown,
                        size: 24,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                      tooltip: 'Volver',
                      onPressed: () {
                        if (widget.onBack != null) {
                          widget.onBack!();
                        } else if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),

                  // Botón circular amarillo de información "ⓘ" a la derecha
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: _showStoryboardInfoDialog,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.primaryYellow,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.darkBrown, width: 1.8),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.darkBrown.withValues(alpha: 0.12),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.info_outline_rounded,
                            size: 19,
                            color: AppColors.darkBrown,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. CONTENIDO PRINCIPAL DEL STORYBOARD
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Banner superior de bienvenida al Storyboard
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.topBarBeige,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.darkBrown, width: 1.8),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.darkBrown.withValues(alpha: 0.08),
                          offset: const Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.primaryYellow,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: AppColors.darkBrown, width: 1.5),
                              ),
                              child: const Icon(
                                Icons.movie_filter_rounded,
                                color: AppColors.darkBrown,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    StoryboardData.overviewTitle,
                                    style: GoogleFonts.outfit(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.darkBrown,
                                    ),
                                  ),
                                  Text(
                                    '17 viñetas en orden de la historia',
                                    style: GoogleFonts.rubik(
                                      fontSize: 12,
                                      color: AppColors.mangroveGreen,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          StoryboardData.overviewSubtitle,
                          style: GoogleFonts.rubik(
                            fontSize: 12.5,
                            color: AppColors.darkBrown.withValues(alpha: 0.8),
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Botón de acción principal: Reproducir todas en el visor
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryYellow,
                              foregroundColor: AppColors.darkBrown,
                              elevation: 0,
                              side: const BorderSide(
                                  color: AppColors.darkBrown, width: 1.5),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: _openViewerFromStart,
                            icon: const Icon(Icons.play_circle_fill_rounded,
                                size: 20),
                            label: Text(
                              'Ver Storyboard Completo (17 Viñetas)',
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Filtros por capítulo / acto
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        _buildFilterChip('all', 'Todos los Actos (17)'),
                        const SizedBox(width: 8),
                        _buildFilterChip('prologo', 'Prólogo (8)'),
                        const SizedBox(width: 8),
                        _buildFilterChip('acto_1_mercado', 'Acto I: Mercado (6)'),
                        const SizedBox(width: 8),
                        _buildFilterChip('mercado_salida', 'Salida Mercado (3)'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Lista de Secciones de Capítulos en orden cronológico
                  ..._filteredChapters.map(
                    (chapter) => StoryboardChapterSection(
                      chapter: chapter,
                      onSceneTap: _openViewerAtScene,
                      onPlayAllTap: () => _openViewerForChapter(chapter),
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String key, String label) {
    final isSelected = _selectedFilter == key;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = key;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.darkBrown : AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.darkBrown : AppColors.doughBeige,
            width: 1.5,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: AppColors.darkBrown.withValues(alpha: 0.15),
                offset: const Offset(0, 2),
                blurRadius: 4,
              ),
          ],
        ),
        child: Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
            color: isSelected ? AppColors.primaryYellow : AppColors.darkBrown,
          ),
        ),
      ),
    );
  }
}
