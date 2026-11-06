import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import 'level_model.dart';
import 'level_data.dart';
import 'widgets/level_placeholder_banner.dart';

class LevelDetailScreen extends StatefulWidget {
  final LevelItem level;

  const LevelDetailScreen({
    super.key,
    required this.level,
  });

  @override
  State<LevelDetailScreen> createState() => _LevelDetailScreenState();
}

class _LevelDetailScreenState extends State<LevelDetailScreen> {
  late LevelItem _currentLevel;
  bool _showGameDesignDetails = true;

  @override
  void initState() {
    super.initState();
    _currentLevel = widget.level;
  }

  void _navigateToLevel(LevelItem level) {
    setState(() {
      _currentLevel = level;
    });
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final prevLevel = LevelData.getPreviousLevel(_currentLevel.number);
    final nextLevel = LevelData.getNextLevel(_currentLevel.number);

    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: Column(
        children: [
          // -----------------------------------------------------------
          // 1. TOP BAR PERSONALIZADA (Solo flecha de volver y título centrado)
          // -----------------------------------------------------------
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
                  // Título 100% centrado en la pantalla (e.g. "Nivel 1")
                  Text(
                    _currentLevel.displayName,
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
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // -----------------------------------------------------------
          // 2. CONTENIDO PRINCIPAL SCROLLABLE
          // -----------------------------------------------------------
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Placeholder visual del nivel (Caja con 'X' idéntica al mockup)
                  LevelPlaceholderBanner(
                    imagePath: _currentLevel.imagePath,
                    levelName: _currentLevel.name,
                    subtitle: '${_currentLevel.displayName}: ${_currentLevel.name}',
                  ),

                  const SizedBox(height: 12),

                  // Etiqueta del nombre del escenario y zona del mapa
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryYellow.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.primaryYellow, width: 1.2),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(_currentLevel.icon, size: 14, color: AppColors.darkBrown),
                            const SizedBox(width: 6),
                            Text(
                              _currentLevel.name,
                              style: GoogleFonts.outfit(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkBrown,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '•  ${_currentLevel.locationZone}',
                          style: GoogleFonts.rubik(
                            fontSize: 12,
                            color: AppColors.darkBrown.withValues(alpha: 0.65),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // ---------------------------------------------------------
                  // TARJETA 1: RETOS (Fiel al mockup)
                  // ---------------------------------------------------------
                  _buildSectionCard(
                    title: 'Retos',
                    icon: Icons.flag_rounded,
                    child: Text(
                      _currentLevel.challenge,
                      style: GoogleFonts.rubik(
                        fontSize: 14,
                        color: AppColors.darkBrown.withValues(alpha: 0.9),
                        height: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // ---------------------------------------------------------
                  // TARJETA 2: CARACTERÍSTICAS (Fiel al mockup)
                  // ---------------------------------------------------------
                  _buildSectionCard(
                    title: 'Características',
                    icon: Icons.tune_rounded,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _currentLevel.characteristics.map((char) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 2),
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryYellow.withValues(alpha: 0.3),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  char.icon,
                                  size: 13,
                                  color: AppColors.darkBrown,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${char.label}: ',
                                      style: GoogleFonts.rubik(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.darkBrown,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        char.value,
                                        style: GoogleFonts.rubik(
                                          fontSize: 13.5,
                                          color: AppColors.darkBrown.withValues(alpha: 0.85),
                                          height: 1.35,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // ---------------------------------------------------------
                  // TARJETA 3: DETALLES DE GAME DESIGN (Extraído de niveles.txt)
                  // ---------------------------------------------------------
                  _buildExpandableGameDesignCard(),

                  const SizedBox(height: 20),

                  // ---------------------------------------------------------
                  // BOTONES DE NAVEGACIÓN ANTERIOR / SIGUIENTE NIVEL
                  // ---------------------------------------------------------
                  Row(
                    children: [
                      // Botón Nivel Anterior
                      if (prevLevel != null)
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              foregroundColor: AppColors.darkBrown,
                              side: const BorderSide(color: AppColors.doughBeige, width: 1.5),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: const Icon(Icons.arrow_back_rounded, size: 16),
                            label: Text(
                              prevLevel.displayName,
                              style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            onPressed: () => _navigateToLevel(prevLevel),
                          ),
                        )
                      else
                        const Spacer(),

                      const SizedBox(width: 12),

                      // Botón Siguiente Nivel
                      if (nextLevel != null)
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryYellow,
                              foregroundColor: AppColors.darkBrown,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(color: AppColors.darkBrown, width: 1.5),
                              ),
                              elevation: 2,
                            ),
                            label: Text(
                              nextLevel.displayName,
                              style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                            onPressed: () => _navigateToLevel(nextLevel),
                          ),
                        )
                      else
                        const Spacer(),
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

  /// Tarjeta contenedora con la estética visual del mockup y la app
  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.doughBeige,
          width: 1.8,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkBrown.withValues(alpha: 0.05),
            offset: const Offset(0, 3),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.darkBrown,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  /// Tarjeta enriquecida con la información exhaustiva de niveles.txt
  Widget _buildExpandableGameDesignCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.doughBeige,
          width: 1.8,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkBrown.withValues(alpha: 0.04),
            offset: const Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Material(
        color: const Color(0xFFF9F5EC), // Crema suave diferenciado
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            initiallyExpanded: _showGameDesignDetails,
            onExpansionChanged: (expanded) {
              setState(() {
                _showGameDesignDetails = expanded;
              });
            },
            tilePadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
            leading: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: AppColors.mangroveGreen.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.auto_stories_rounded,
                size: 20,
                color: AppColors.mangroveGreen,
              ),
            ),
            title: Text(
              'Ficha Técnica & Diseño',
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.darkBrown,
              ),
            ),
            subtitle: Text(
              'Storyboard, mecánicas y enemigos (niveles.txt)',
              style: GoogleFonts.rubik(
                fontSize: 11.5,
                color: AppColors.darkBrown.withValues(alpha: 0.65),
              ),
            ),
            childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
            children: [
              const Divider(color: AppColors.doughBeige, thickness: 1),
              const SizedBox(height: 8),

              // 1. Diseño Espacial
              _buildDetailSubSection(
                title: 'Diseño Espacial (Storyboard)',
                icon: Icons.architecture_rounded,
                content: _currentLevel.spatialDesign,
              ),

              const SizedBox(height: 12),

              // 2. Mecánicas
              _buildDetailSubSection(
                title: 'Mecánicas de Juego',
                icon: Icons.sports_esports_rounded,
                content: _currentLevel.mechanics,
              ),

              const SizedBox(height: 12),

              // 3. Obstáculos y Enemigos
              _buildDetailSubSection(
                title: 'Obstáculos y Enemigos',
                icon: Icons.warning_amber_rounded,
                content: _currentLevel.obstaclesAndEnemies,
              ),

              const SizedBox(height: 12),

              // 4. Ítems y Clímax
              _buildDetailSubSection(
                title: 'Ítems y Recompensas',
                icon: Icons.stars_rounded,
                content: _currentLevel.itemsAndClimax,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSubSection({
    required String title,
    required IconData icon,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: AppColors.mangroveGreen),
            const SizedBox(width: 8),
            Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.darkBrown,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            content,
            style: GoogleFonts.rubik(
              fontSize: 13,
              color: AppColors.darkBrown.withValues(alpha: 0.85),
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }
}
