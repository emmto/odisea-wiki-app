import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import 'story_data.dart';
import 'story_detail_screen.dart';
import 'widgets/story_part_card.dart';
import 'widgets/story_placeholder_banner.dart';

class StoryScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const StoryScreen({super.key, this.onBack});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  void _showStoryInfoDialog() {
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
                Icons.menu_book_rounded,
                color: AppColors.darkBrown,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Guía de la Historia',
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
                'La Odisea del Pan de Plátano',
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBrown,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Acompaña a Ulises en su travesía por San Blas y la Riviera Nayarit. Selecciona cualquier capítulo para leer la crónica completa:',
                style: GoogleFonts.rubik(
                  fontSize: 13,
                  color: AppColors.darkBrown.withValues(alpha: 0.8),
                ),
              ),
              const SizedBox(height: 12),
              _buildMiniInfo(
                icon: Icons.fireplace_rounded,
                title: 'Prólogo',
                description: 'El ultimátum de Don Lupe y el desafío de Madame Circe.',
              ),
              _buildMiniInfo(
                icon: Icons.storefront_rounded,
                title: 'Acto I',
                description: 'La cueva del mercado y la cosecha del plátano macho.',
              ),
              _buildMiniInfo(
                icon: Icons.outdoor_grill_rounded,
                title: 'Acto II',
                description: 'El asedio al horno de piedra contra plagas e intrusos.',
              ),
              _buildMiniInfo(
                icon: Icons.water_rounded,
                title: 'Acto III',
                description: 'La carrera contrarreloj por los manglares de La Tovara.',
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

  void _onPartSelected(StoryPart part) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StoryDetailScreen(part: part),
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
                  // Título 100% centrado en la pantalla (Historia)
                  Text(
                    'Historia',
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
                      onTap: _showStoryInfoDialog,
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

          // 2. CONTENIDO PRINCIPAL SEGÚN EL MOCKUP
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título de la sección del mockup: "El Llamado a la Cocina"
                  Text(
                    StoryData.mainArcTitle,
                    style: GoogleFonts.outfit(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBrown,
                      letterSpacing: -0.3,
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Placeholder de Imagen con 'X' cruzada (Fiel al Wireframe Mockup)
                  StoryPlaceholderBanner(
                    height: 190,
                    title: StoryData.mainArcTitle,
                    subtitle: 'Boceto de Arte • Escena Principal',
                  ),

                  const SizedBox(height: 20),

                  // Lista de tarjetas que agrupan las partes de la historia
                  ...StoryData.parts.map(
                    (part) => StoryPartCard(
                      part: part,
                      onTap: () => _onPartSelected(part),
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
