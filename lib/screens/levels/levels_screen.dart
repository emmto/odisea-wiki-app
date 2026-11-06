import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import 'level_data.dart';
import 'level_model.dart';
import 'level_detail_screen.dart';
import 'widgets/level_card.dart';
import 'widgets/level_placeholder_banner.dart';

class LevelsScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const LevelsScreen({super.key, this.onBack});

  @override
  State<LevelsScreen> createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  void _onLevelSelected(LevelItem level) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LevelDetailScreen(level: level),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

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
                  // Título 100% centrado en la pantalla (Niveles)
                  Text(
                    'Niveles',
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
                ],
              ),
            ),
          ),

          // -----------------------------------------------------------
          // 2. CONTENIDO PRINCIPAL: LISTA DE NIVELES EN CARDS
          // -----------------------------------------------------------
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título principal de la sección
                  Text(
                    LevelData.levelsOverviewTitle,
                    style: GoogleFonts.outfit(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBrown,
                      letterSpacing: -0.3,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Subtítulo explicativo
                  Text(
                    LevelData.levelsSubtitle,
                    style: GoogleFonts.rubik(
                      fontSize: 13,
                      color: AppColors.darkBrown.withValues(alpha: 0.75),
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Placeholder de Imagen con 'X' cruzada (Fiel al Wireframe Mockup)
                  const LevelPlaceholderBanner(
                    height: 180,
                    levelName: 'Etapas del Videojuego',
                    subtitle: 'Arte Conceptual • Mapa y Escenarios',
                  ),

                  const SizedBox(height: 20),

                  // Las 3 tarjetas de niveles (igual que las partes de la historia)
                  ...LevelData.levels.map(
                    (level) => LevelCard(
                      level: level,
                      onTap: () => _onLevelSelected(level),
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
}
