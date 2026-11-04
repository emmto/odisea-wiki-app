import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';

class MapTab extends StatefulWidget {
  final VoidCallback? onBack;

  const MapTab({super.key, this.onBack});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  final ScrollController _scrollController = ScrollController();
  double _scrollProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    if (maxScroll > 0) {
      final progress = (_scrollController.offset / maxScroll).clamp(0.0, 1.0);
      if ((progress - _scrollProgress).abs() > 0.005) {
        setState(() {
          _scrollProgress = progress;
        });
      }
    }
  }

  void _scrollBy(double offsetDelta) {
    if (!_scrollController.hasClients) return;
    final target = (_scrollController.offset + offsetDelta).clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );
    _scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }

  void _showMapInfoDialog() {
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
              child: const Icon(Icons.map_rounded, color: AppColors.darkBrown, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Guía del Mapa',
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
                'Tierras de Nayarit & San Blas',
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBrown,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Desliza horizontalmente para recorrer toda la isla y sus parajes clave:',
                style: GoogleFonts.rubik(
                  fontSize: 13,
                  color: AppColors.darkBrown.withValues(alpha: 0.8),
                ),
              ),
              const SizedBox(height: 12),
              _buildZoneInfo(
                icon: Icons.cottage_rounded,
                title: 'Casa de Ulises',
                description: 'Taller inicial y punto de partida de la aventura culinaria.',
              ),
              _buildZoneInfo(
                icon: Icons.storefront_rounded,
                title: 'El Mercado Central',
                description: 'Puestos de frutas custodiados por el gigante Polifemo.',
              ),
              _buildZoneInfo(
                icon: Icons.fireplace_rounded,
                title: 'El Horno de Piedra',
                description: 'El legendario horno de leña custodiado por Don Lope.',
              ),
              _buildZoneInfo(
                icon: Icons.water_rounded,
                title: 'Manglares de La Tovara',
                description: 'Muelle sinuoso entre raíces acuáticas rumbo a la costa.',
              ),
              _buildZoneInfo(
                icon: Icons.festival_rounded,
                title: 'Feria Costera',
                description: 'Campamento de carpas donde compite la química Madame Circe.',
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

  Widget _buildZoneInfo({
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

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: Column(
        children: [
          // 1. TOP BAR PERSONALIZADA (Fiel al Mockup: [← Volver]   Mapa   [ⓘ])
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
                    'Mapa',
                    style: GoogleFonts.outfit(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBrown,
                    ),
                  ),

                  // Botón volver a la izquierda: flecha Material Design
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
                      onTap: _showMapInfoDialog,
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

          // 2. CONTENEDOR DEL MAPA (Ocupa todo el espacio vertical disponible)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEFE7D8),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.darkBrown, width: 2.0),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.darkBrown.withValues(alpha: 0.1),
                      offset: const Offset(0, 4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Image.asset(
                          'assets/images/mapa_juego.jpg',
                          height: constraints.maxHeight,
                          fit: BoxFit.fitHeight,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          // 3. BARRA DESLIZADORA HORIZONTAL DEL MOCKUP: [ ◀  |====|  ▶ ]
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
            child: Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.doughBeige, width: 1.8),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.darkBrown.withValues(alpha: 0.05),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Flecha izquierda amarilla (apuntando a la izquierda)
                  InkWell(
                    onTap: () => _scrollBy(-180),
                    borderRadius: BorderRadius.circular(6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Transform.flip(
                        flipX: true,
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: AppColors.primaryYellow,
                          size: 20,
                        ),
                      ),
                    ),
                  ),

                  // Pista con el indicador deslizante proporcional al scroll
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, trackConstraints) {
                        final totalWidth = trackConstraints.maxWidth;
                        const thumbWidth = 75.0;
                        final maxOffset = (totalWidth - thumbWidth).clamp(0.0, totalWidth);
                        final currentOffset = _scrollProgress * maxOffset;

                        return GestureDetector(
                          onHorizontalDragUpdate: (details) {
                            if (maxOffset > 0 && _scrollController.hasClients) {
                              final newOffset = (_scrollController.offset +
                                      (details.delta.dx / maxOffset) *
                                          _scrollController.position.maxScrollExtent)
                                  .clamp(0.0, _scrollController.position.maxScrollExtent);
                              _scrollController.jumpTo(newOffset);
                            }
                          },
                          child: Container(
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF6F2EA),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Positioned(
                                  left: currentOffset,
                                  child: Container(
                                    width: thumbWidth,
                                    height: 18,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryYellow,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: AppColors.darkBrown,
                                        width: 1.2,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.darkBrown.withValues(alpha: 0.15),
                                          offset: const Offset(0, 1),
                                          blurRadius: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Flecha derecha amarilla
                  InkWell(
                    onTap: () => _scrollBy(180),
                    borderRadius: BorderRadius.circular(6),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: AppColors.primaryYellow,
                        size: 20,
                      ),
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
