import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import 'story_data.dart';
import 'widgets/story_placeholder_banner.dart';

class StoryDetailScreen extends StatefulWidget {
  final StoryPart part;

  const StoryDetailScreen({
    super.key,
    required this.part,
  });

  @override
  State<StoryDetailScreen> createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends State<StoryDetailScreen> {
  late StoryPart _currentPart;

  @override
  void initState() {
    super.initState();
    _currentPart = widget.part;
  }

  void _navigateToPart(StoryPart part) {
    setState(() {
      _currentPart = part;
    });
  }

  void _showPartInfoDialog() {
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
              child: Icon(
                _currentPart.icon,
                color: AppColors.darkBrown,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _currentPart.actNumber,
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
                _currentPart.title,
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBrown,
                ),
              ),
              const SizedBox(height: 10),
              _buildDialogInfoRow(
                icon: Icons.place_outlined,
                label: 'Ubicación',
                value: _currentPart.location,
              ),
              const SizedBox(height: 8),
              _buildDialogInfoRow(
                icon: Icons.groups_outlined,
                label: 'Personajes',
                value: _currentPart.keyCharacters.join(', '),
              ),
              const SizedBox(height: 8),
              _buildDialogInfoRow(
                icon: Icons.timer_outlined,
                label: 'Duración',
                value: _currentPart.estimatedReadTime,
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

  Widget _buildDialogInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.mangroveGreen),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.rubik(fontSize: 12.5, color: AppColors.darkBrown),
              children: [
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final nextPart = StoryData.getNextPart(_currentPart.id);
    final prevPart = StoryData.getPreviousPart(_currentPart.id);

    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: Column(
        children: [
          // 1. TOP BAR PERSONALIZADA (Exactamente como las otras: [← Flecha volver]  Título 100% centrado  [ⓘ])
          // Sin texto en el botón de volver, únicamente la flecha Material Design
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
                    _currentPart.actNumber,
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

                  // Botón circular amarillo de información "ⓘ" a la derecha
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: _showPartInfoDialog,
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

          // 2. CONTENIDO COMPLETO DE LA PARTE DE LA HISTORIA
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badge superior con el número de acto
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _currentPart.badgeColor == AppColors.primaryYellow
                          ? AppColors.primaryYellow
                          : _currentPart.badgeColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _currentPart.badgeColor == AppColors.primaryYellow
                            ? AppColors.darkBrown
                            : _currentPart.badgeColor,
                        width: 1.2,
                      ),
                    ),
                    child: Text(
                      _currentPart.actNumber.toUpperCase(),
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.darkBrown,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Título principal del Acto
                  Text(
                    _currentPart.title,
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.darkBrown,
                      height: 1.2,
                      letterSpacing: -0.4,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Fila de metadatos (Ubicación y Duración)
                  Wrap(
                    spacing: 12,
                    runSpacing: 6,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.place_rounded,
                            size: 15,
                            color: AppColors.mangroveGreen,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _currentPart.location,
                            style: GoogleFonts.rubik(
                              fontSize: 12,
                              color: AppColors.darkBrown.withValues(alpha: 0.75),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 15,
                            color: AppColors.darkBrown.withValues(alpha: 0.6),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _currentPart.estimatedReadTime,
                            style: GoogleFonts.rubik(
                              fontSize: 12,
                              color: AppColors.darkBrown.withValues(alpha: 0.75),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // Placeholder de Imagen / Ilustración para esta escena específica
                  StoryPlaceholderBanner(
                    height: 160,
                    title: _currentPart.title,
                    subtitle: 'Boceto de Escena: ${_currentPart.actNumber}',
                  ),

                  const SizedBox(height: 20),

                  // Cita destacada / Frase clave de este acto
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.doughBeige.withValues(alpha: 0.45),
                      borderRadius: BorderRadius.circular(12),
                      border: const Border(
                        left: BorderSide(
                          color: AppColors.primaryYellow,
                          width: 4,
                        ),
                      ),
                    ),
                    child: Text(
                      _currentPart.highlightQuote,
                      style: GoogleFonts.rubik(
                        fontSize: 13.5,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkBrown.withValues(alpha: 0.9),
                        height: 1.45,
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  // Párrafos completos del texto original
                  ..._currentPart.paragraphs.map(
                    (p) => Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        p,
                        style: GoogleFonts.rubik(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: AppColors.darkBrown,
                          height: 1.65,
                          letterSpacing: 0.1,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Separador ornamental temático
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 40,
                          height: 1.5,
                          color: AppColors.doughBeige,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(
                            _currentPart.icon,
                            size: 18,
                            color: AppColors.primaryYellow,
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 1.5,
                          color: AppColors.doughBeige,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Botones de navegación entre actos (Anterior / Siguiente)
                  Row(
                    children: [
                      if (prevPart != null)
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.darkBrown,
                              side: const BorderSide(
                                color: AppColors.darkBrown,
                                width: 1.5,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => _navigateToPart(prevPart),
                            icon: const Icon(Icons.arrow_back_rounded, size: 18),
                            label: Text(
                              prevPart.actNumber,
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        )
                      else
                        const Spacer(),

                      const SizedBox(width: 12),

                      if (nextPart != null)
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryYellow,
                              foregroundColor: AppColors.darkBrown,
                              elevation: 0,
                              side: const BorderSide(
                                color: AppColors.darkBrown,
                                width: 1.5,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => _navigateToPart(nextPart),
                            iconAlignment: IconAlignment.end,
                            label: Text(
                              nextPart.actNumber,
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                          ),
                        )
                      else
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.mangroveGreen,
                              foregroundColor: AppColors.white,
                              elevation: 0,
                              side: const BorderSide(
                                color: AppColors.darkBrown,
                                width: 1.5,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => Navigator.pop(context),
                            label: Text(
                              'Fin de la Odisea',
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            icon: const Icon(Icons.check_circle_rounded, size: 18),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
