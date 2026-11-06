import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import 'storyboard_data.dart';

class StoryboardViewerScreen extends StatefulWidget {
  final List<StoryboardScene> scenes;
  final int initialIndex;
  final String? chapterTitle;

  const StoryboardViewerScreen({
    super.key,
    required this.scenes,
    this.initialIndex = 0,
    this.chapterTitle,
  });

  @override
  State<StoryboardViewerScreen> createState() => _StoryboardViewerScreenState();
}

class _StoryboardViewerScreenState extends State<StoryboardViewerScreen> {
  late final PageController _pageController;
  late int _currentIndex;
  bool _showCaptions = true;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, widget.scenes.length - 1);
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPrevious() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _goToNext() {
    if (_currentIndex < widget.scenes.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final currentScene = widget.scenes[_currentIndex];
    final chapter = StoryboardData.getChapterForScene(currentScene.id);

    return Scaffold(
      backgroundColor: const Color(0xFF1B1511), // Fondo cinematográfico oscuro para cómic
      body: Column(
        children: [
          // 1. TOP BAR PERSONALIZADA (Solo flecha de volver, sin texto)
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
                  // Título centrado: Viñeta actual y total
                  Text(
                    'Viñeta ${_currentIndex + 1} de ${widget.scenes.length}',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBrown,
                    ),
                  ),

                  // Botón volver a la izquierda: SOLO flecha, SIN TEXTO
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
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),

                  // Botón para alternar visibilidad de textos explicativos
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        _showCaptions
                            ? Icons.subtitles_rounded
                            : Icons.subtitles_off_rounded,
                        color: _showCaptions
                            ? AppColors.darkBrown
                            : AppColors.darkBrown.withValues(alpha: 0.5),
                        size: 22,
                      ),
                      tooltip: _showCaptions ? 'Ocultar guión' : 'Mostrar guión',
                      onPressed: () {
                        setState(() {
                          _showCaptions = !_showCaptions;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. VISOR INTERACTIVO DE VIÑETAS (Con zoom y swipe táctil)
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.scenes.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final scene = widget.scenes[index];
                return Center(
                  child: InteractiveViewer(
                    minScale: 1.0,
                    maxScale: 3.5,
                    clipBehavior: Clip.none,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            offset: const Offset(0, 4),
                            blurRadius: 14,
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        scene.imagePath,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 220,
                          color: AppColors.doughBeige,
                          child: const Center(
                            child: Icon(Icons.broken_image_rounded, size: 48),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // 3. PANEL INFERIOR DE GUIÓN Y NAVEGACIÓN
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.topBarBeige,
              border: const Border(
                top: BorderSide(color: AppColors.doughBeige, width: 1.5),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  offset: const Offset(0, -3),
                  blurRadius: 8,
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_showCaptions) ...[
                    // Fila de metadatos del acto / nivel
                    Row(
                      children: [
                        if (chapter != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            margin: const EdgeInsets.only(right: 8),
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
                              ),
                            ),
                          ),
                        if (currentScene.characterFocus != null)
                          Text(
                            currentScene.characterFocus!,
                            style: GoogleFonts.rubik(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkBrown.withValues(alpha: 0.7),
                            ),
                          ),
                        const Spacer(),
                        Text(
                          'Pellizca para zoom',
                          style: GoogleFonts.rubik(
                            fontSize: 10.5,
                            color: AppColors.darkBrown.withValues(alpha: 0.5),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Título de la viñeta
                    Text(
                      currentScene.title,
                      style: GoogleFonts.outfit(
                        fontSize: 16.5,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBrown,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Texto narrativo del guión
                    Text(
                      currentScene.description,
                      style: GoogleFonts.rubik(
                        fontSize: 13,
                        color: AppColors.darkBrown.withValues(alpha: 0.85),
                        height: 1.35,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                  ],

                  // Botones de navegación Anterior / Siguiente
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Botón Anterior
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.darkBrown,
                          side: BorderSide(
                            color: _currentIndex > 0
                                ? AppColors.darkBrown
                                : AppColors.darkBrown.withValues(alpha: 0.2),
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                        ),
                        onPressed: _currentIndex > 0 ? _goToPrevious : null,
                        icon: const Icon(Icons.arrow_back_rounded, size: 16),
                        label: Text(
                          'Anterior',
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.5,
                          ),
                        ),
                      ),

                      // Contador de puntos / progreso
                      Text(
                        '${_currentIndex + 1} / ${widget.scenes.length}',
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.darkBrown,
                        ),
                      ),

                      // Botón Siguiente
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryYellow,
                          foregroundColor: AppColors.darkBrown,
                          elevation: 0,
                          side: BorderSide(
                            color: _currentIndex < widget.scenes.length - 1
                                ? AppColors.darkBrown
                                : AppColors.darkBrown.withValues(alpha: 0.2),
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                        ),
                        onPressed: _currentIndex < widget.scenes.length - 1
                            ? _goToNext
                            : () => Navigator.pop(context),
                        iconAlignment: IconAlignment.end,
                        label: Text(
                          _currentIndex < widget.scenes.length - 1
                              ? 'Siguiente'
                              : 'Finalizar',
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.5,
                          ),
                        ),
                        icon: Icon(
                          _currentIndex < widget.scenes.length - 1
                              ? Icons.arrow_forward_rounded
                              : Icons.check_circle_rounded,
                          size: 16,
                        ),
                      ),
                    ],
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
