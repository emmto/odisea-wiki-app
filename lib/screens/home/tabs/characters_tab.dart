import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';

class CharactersTab extends StatelessWidget {
  const CharactersTab({super.key});

  final List<Map<String, dynamic>> characters = const [
    {
      'name': 'Ulises',
      'role': 'PROTAGONISTA',
      'roleColor': AppColors.mangroveGreen,
      'lore': 'Joven artesano de San Blas con un talento nato para las masas y una terquedad inquebrantable frente al fuego tradicional.',
      'vel': 5,
      'res': 5,
      'extra': 'Arma favorita: Pala de madera',
    },
    {
      'name': 'Madame Circe',
      'role': 'ENEMIGA',
      'roleColor': AppColors.darkBrown,
      'lore': 'Chef de repostería especializada con atajos químicos y producción en serie. Arrogante y calculadora.',
      'vel': 4,
      'res': 3,
      'extra': 'Debilidad: Sabor artesanal',
    },
    {
      'name': 'Don Lope',
      'role': 'ALIADO',
      'roleColor': AppColors.mangroveGreen,
      'lore': 'Maestro panadero custodio del horno más antiguo de Nayarit. Busca un heredero digno de la receta.',
      'vel': 3,
      'res': 4,
      'extra': 'Puesto: Maestro Hornero',
    },
    {
      'name': 'Polifemo',
      'role': 'ANTAGONISTA',
      'roleColor': AppColors.darkBrown,
      'lore': 'Gigante del mercado que acapara los plátanos reales. Intimidante pero susceptible a las distracciones.',
      'vel': 2,
      'res': 5,
      'extra': 'Peligro: Lanzamiento de huacales',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      appBar: AppBar(
        backgroundColor: AppColors.topBarBeige,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Personajes',
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBrown,
          ),
        ),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        itemCount: characters.length,
        itemBuilder: (context, index) {
          final c = characters[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.darkBrown, width: 2),
              boxShadow: [
                BoxShadow(
                  color: AppColors.darkBrown.withValues(alpha: 0.08),
                  offset: const Offset(0, 4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: AppColors.doughBeige,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.darkBrown, width: 1.5),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.person_rounded,
                      color: AppColors.primaryYellow,
                      size: 34,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c['name'] as String,
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkBrown,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        c['extra'] as String,
                        style: GoogleFonts.rubik(
                          fontSize: 12,
                          color: AppColors.darkBrown.withValues(alpha: 0.65),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: c['roleColor'] as Color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    c['role'] as String,
                    style: GoogleFonts.outfit(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: AppColors.white,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
