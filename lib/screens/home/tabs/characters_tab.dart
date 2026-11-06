import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';

class CharacterCharacteristic {
  final String label;
  final int? rating;
  final String? text;

  const CharacterCharacteristic.stars(this.label, this.rating) : text = null;
  const CharacterCharacteristic.text(this.label, this.text) : rating = null;
}

class CharacterData {
  final String name;
  final String alias;
  final String role;
  final Color roleColor;
  final String imagePath;
  final String lore;
  final List<CharacterCharacteristic> characteristics;

  const CharacterData({
    required this.name,
    required this.alias,
    required this.role,
    required this.roleColor,
    required this.imagePath,
    required this.lore,
    required this.characteristics,
  });
}

class CharactersTab extends StatefulWidget {
  final VoidCallback? onBack;
  final int initialIndex;

  const CharactersTab({
    super.key,
    this.onBack,
    this.initialIndex = 0,
  });

  @override
  State<CharactersTab> createState() => _CharactersTabState();
}

class _CharactersTabState extends State<CharactersTab> {
  late final PageController _pageController;
  late int _currentIndex;

  static const List<CharacterData> characters = [
    CharacterData(
      name: 'Ulises',
      alias: 'El Panadero',
      role: 'PROTAGONISTA',
      roleColor: AppColors.mangroveGreen,
      imagePath: 'assets/images/characters/ulises.jpg',
      lore:
          'Joven artesano de San Blas con un talento nato para las masas y una terquedad inquebrantable. Decidido a honrar la receta tradicional de su pueblo, no descansará hasta demostrar que el verdadero sabor nace del corazón y la leña.',
      characteristics: [
        CharacterCharacteristic.stars('Velocidad', 4),
        CharacterCharacteristic.stars('Resistencia', 5),
        CharacterCharacteristic.text('Arma favorita', 'Pala de madera'),
      ],
    ),
    CharacterData(
      name: 'Don Lupe',
      alias: 'El Maestro Panadero',
      role: 'ALIADO',
      roleColor: AppColors.mangroveGreen,
      imagePath: 'assets/images/characters/don_lupe.jpg',
      lore:
          'Veterano dueño de la panadería tradicional y guardián del horno de barro más antiguo del puerto. Cansado pero sabio, busca a un sucesor digno que mantenga viva la esencia culinaria de la costa frente a la invasión industrial.',
      characteristics: [
        CharacterCharacteristic.stars('Sabiduría', 5),
        CharacterCharacteristic.stars('Paciencia', 4),
        CharacterCharacteristic.text('Puesto', 'Maestro Hornero'),
      ],
    ),
    CharacterData(
      name: 'Madame Circe',
      alias: 'La Chef Rival',
      role: 'ENEMIGA',
      roleColor: AppColors.darkBrown,
      imagePath: 'assets/images/characters/madame_circe.jpg',
      lore:
          'Cocinera corporativa y pretenciosa que busca conquistar la Riviera Nayarit usando atajos químicos y maquinaria importada. Arrogante y calculadora, recurre al sabotaje constante para aplastar el talento local antes de que le haga sombra.',
      characteristics: [
        CharacterCharacteristic.stars('Astucia', 5),
        CharacterCharacteristic.stars('Tecnología', 5),
        CharacterCharacteristic.text('Debilidad', 'Sabor artesanal'),
      ],
    ),
    CharacterData(
      name: 'Polifemo',
      alias: 'El Estibador del Mercado',
      role: 'ANTAGONISTA',
      roleColor: AppColors.darkBrown,
      imagePath: 'assets/images/characters/polifemo.jpg',
      lore:
          'Gigantesco y malhumorado comerciante que vigila con celo la cima de los huacales en el mercado municipal. Aunque parece una fiera intratable que cuida los plátanos machos reales, su debilidad por las distracciones lo hace vulnerable al ingenio.',
      characteristics: [
        CharacterCharacteristic.stars('Fuerza', 5),
        CharacterCharacteristic.stars('Atención', 2),
        CharacterCharacteristic.text('Peligro', 'Lanzamiento de huacales'),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, characters.length - 1);
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int page) {
    if (page < 0 || page >= characters.length) return;
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeInOutCubic,
    );
  }

  void _showCharacterInfoDialog() {
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
                Icons.groups_rounded,
                color: AppColors.darkBrown,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Guía de Personajes',
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
                'Elenco de San Blas & Nayarit',
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBrown,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Desliza horizontalmente o presiona las flechas para explorar cada ficha técnica:',
                style: GoogleFonts.rubik(
                  fontSize: 13,
                  color: AppColors.darkBrown.withValues(alpha: 0.8),
                ),
              ),
              const SizedBox(height: 12),
              _buildMiniInfo(
                icon: Icons.person_pin_rounded,
                title: 'Ulises (El Panadero)',
                description: 'Joven artesano decidido a honrar la receta tradicional de su pueblo.',
              ),
              _buildMiniInfo(
                icon: Icons.shield_rounded,
                title: 'Don Lupe (El Maestro Panadero)',
                description: 'Veterano guardián del horno de barro más antiguo del puerto.',
              ),
              _buildMiniInfo(
                icon: Icons.science_rounded,
                title: 'Madame Circe (La Chef Rival)',
                description: 'Cocinera corporativa que busca conquistar la costa con atajos químicos.',
              ),
              _buildMiniInfo(
                icon: Icons.front_hand_rounded,
                title: 'Polifemo (El Estibador del Mercado)',
                description: 'Gigantesco comerciante custodio de los plátanos machos reales.',
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

  Widget _buildArrowButton({
    required IconData icon,
    required VoidCallback onTap,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.95),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.doughBeige, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: AppColors.darkBrown.withValues(alpha: 0.12),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Icon(icon, color: AppColors.darkBrown, size: 22),
          ),
        ),
      ),
    );
  }

  Widget _buildCharacteristicRow(CharacterCharacteristic c) {
    if (c.rating != null) {
      return Row(
        children: [
          Text(
            '${c.label}: ',
            style: GoogleFonts.rubik(
              fontSize: 13.5,
              color: AppColors.darkBrown,
            ),
          ),
          Text(
            '★' * c.rating! + '☆' * (5 - c.rating!),
            style: GoogleFonts.rubik(
              fontSize: 13.5,
              color: AppColors.darkBrown,
              letterSpacing: 2,
            ),
          ),
        ],
      );
    } else {
      return Text.rich(
        TextSpan(
          style: GoogleFonts.rubik(
            fontSize: 13.5,
            color: AppColors.darkBrown,
          ),
          children: [
            TextSpan(text: '${c.label}: '),
            TextSpan(
              text: c.text ?? '',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final currentCharacter = characters[_currentIndex];

    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: Column(
        children: [
          // 1. TOP BAR PERSONALIZADA (Exactamente como MapTab: [← Flecha volver]  Título 100% centrado  [ⓘ])
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
                  // Título 100% centrado en la pantalla independientemente del ancho de los botones
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      currentCharacter.name,
                      key: ValueKey<String>(currentCharacter.name),
                      style: GoogleFonts.outfit(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBrown,
                      ),
                    ),
                  ),

                  // Botón volver a la izquierda: exactamente la misma flecha que en el mapa
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
                      onTap: _showCharacterInfoDialog,
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

          // 2. CONTENIDO DESLIZABLE (PageView para navegar entre los 4 personajes)
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: characters.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final character = characters[index];

                return Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 580),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(top: 14, bottom: 20),
                      child: Column(
                    children: [
                      // BADGE DEL ROL (PROTAGONISTA, ALIADO, ENEMIGA, ANTAGONISTA)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                        decoration: BoxDecoration(
                          color: character.roleColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          character.role,
                          style: GoogleFonts.outfit(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: AppColors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // RECUADRO CON IMAGEN DEL PERSONAJE Y FLECHAS DE NAVEGACIÓN
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 230,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: AppColors.doughBeige, width: 1.8),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.darkBrown.withValues(alpha: 0.06),
                                    offset: const Offset(0, 3),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.asset(
                                    character.imagePath,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),

                            // Flecha flotante anterior
                            if (index > 0)
                              Positioned(
                                left: 8,
                                child: _buildArrowButton(
                                  icon: Icons.chevron_left_rounded,
                                  onTap: () => _goToPage(index - 1),
                                  tooltip: 'Anterior',
                                ),
                              ),

                            // Flecha flotante siguiente
                            if (index < characters.length - 1)
                              Positioned(
                                right: 8,
                                child: _buildArrowButton(
                                  icon: Icons.chevron_right_rounded,
                                  onTap: () => _goToPage(index + 1),
                                  tooltip: 'Siguiente',
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // INDICADOR DE PÁGINAS (Puntos interactivos)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          characters.length,
                          (dotIndex) => GestureDetector(
                            onTap: () => _goToPage(dotIndex),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              margin: const EdgeInsets.symmetric(horizontal: 3.5),
                              width: _currentIndex == dotIndex ? 20 : 7,
                              height: 7,
                              decoration: BoxDecoration(
                                color: _currentIndex == dotIndex
                                    ? AppColors.primaryYellow
                                    : AppColors.doughBeige,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: _currentIndex == dotIndex
                                      ? AppColors.darkBrown
                                      : Colors.transparent,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // TARJETA DE LORE (Exactamente como el Mockup)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.doughBeige, width: 1.8),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.darkBrown.withValues(alpha: 0.05),
                                offset: const Offset(0, 2),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    'LORE',
                                    style: GoogleFonts.outfit(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.darkBrown,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  Text(
                                    character.alias,
                                    style: GoogleFonts.outfit(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.darkBrown.withValues(alpha: 0.65),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                character.lore,
                                style: GoogleFonts.rubik(
                                  fontSize: 13.5,
                                  height: 1.45,
                                  color: AppColors.darkBrown.withValues(alpha: 0.85),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // TARJETA DE CARACTERÍSTICAS (Exactamente como el Mockup)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.doughBeige, width: 1.8),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.darkBrown.withValues(alpha: 0.05),
                                offset: const Offset(0, 2),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Características',
                                style: GoogleFonts.outfit(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkBrown,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ...character.characteristics.map(
                                (c) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: _buildCharacteristicRow(c),
                                ),
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
          },
            ),
          ),
        ],
      ),
    );
  }
}
